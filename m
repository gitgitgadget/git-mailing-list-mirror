From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [[TIG][PATCH] 1/3] Add log_select function to find commit from
 context in log view
Date: Mon, 5 Aug 2013 23:27:44 -0400
Message-ID: <CAFuPQ1KkUn5t54BXLTnYUcH_jY-SiSEJx3dDVzQ3FpswhFg0Bw@mail.gmail.com>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in> <1375489399-11618-2-git-send-email-a.kumar@alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Tue Aug 06 05:28:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6XwS-0004nW-3K
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 05:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab3HFD2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 23:28:07 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:64063 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665Ab3HFD2G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 23:28:06 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so7017598obc.24
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 20:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=AJ7SBxyb2s2hGu/JPAizPin8N/YOSSnfUM1Dy+cwC8E=;
        b=HQ8S/L44KL1m6zh2uSrx/Wd3TQbIcMd5vFbEtQ8ki6/3lua7169JRMDma28T4eypCJ
         uUvAoVC8HekMDBQppDSH0Hx/+UbLjUklgebKJkkUE1xZ2e0NO8vTIwJYwGhnJC7YzUtA
         FosF2G/Nkuk5bIsuTVflT5qf8YSFky9v4R6PdfYb9Y6b055zdF3tUg+viZ/1PlZp/TXs
         cGiYWT0or5WvHfoIRVswuU66qNaaVLAEscsLRZl1am4E/ZQeq5/sKll5mlPDd1qfuoKB
         0B5XKHulsx2NWyYTzvwzwKb1qXkrezPJfBgh1NqVXcdNfWIxkzCagBD9LTWUgqumxcXe
         5rYA==
X-Received: by 10.60.94.210 with SMTP id de18mr16613054oeb.100.1375759684921;
 Mon, 05 Aug 2013 20:28:04 -0700 (PDT)
Received: by 10.76.69.169 with HTTP; Mon, 5 Aug 2013 20:27:44 -0700 (PDT)
In-Reply-To: <1375489399-11618-2-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Google-Sender-Auth: DznPO4L7ATrAYPjWTcNofBAUYSs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231713>

On Fri, Aug 2, 2013 at 8:23 PM, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> This commit introduces and uses the log_select function to find the
> correct commit in the unsplit log view. In the log view, if one
> scrolls down across a commit line, the current commit (as displayed in
> the status bar) gets updated, but not so when scrolling upward across
> a commit. The log_select function handles this scenario to to the

s/to to/to do/

> ``right thing''. In addition, it introduces the log_state structure as
> the private entry of the log view to hold a flag that decides whether
> to re-evaluate the current commit based on scrolling.
>
> Signed-off-by: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
> ---
>  tig.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/tig.c b/tig.c
> index 72f132a..dd4b0f4 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -4384,6 +4384,33 @@ pager_select(struct view *view, struct line *line)
>         }
>  }
>
> +struct log_state {
> +       bool update_commit_ref;
> +};
> +
> +static void
> +log_select(struct view *view, struct line *line)
> +{
> +       struct log_state *state = (struct log_state *) view->private;
> +
> +       if (state->update_commit_ref && line->lineno > 1) {
> +               /* We need to recalculate the previous commit,
> +                  since the user has likely scrolled up. */

I'd prefer that state->update_commit_ref is given another name so it
won't be necessary to have these comments everywhere the field is
used, for example recalculate_commit_context. The comment could be
moved to the declaration in struct log_state to explain its use.

Multi-line comments should start with '*' for each additonal line, e.g.

  /* bla bla
   * bla bla */

> +               const struct line *commit_line = find_prev_line_by_type(view, line, LINE_COMMIT);
> +
> +               if (commit_line)
> +                       string_copy_rev(view->ref, (char *) (commit_line->data + STRING_SIZE("commit ")));

You mentioned elsewhere that this looked funny, and I guess you are
right. I will extract this into a utility method so you can simply
call: string_copy_rev_from_line(view->ref, commit_line); ...

> +       }
> +       if (line->type == LINE_COMMIT) {
> +               char *text = (char *)line->data + STRING_SIZE("commit ");
> +
> +               if (!view_has_flags(view, VIEW_NO_REF))
> +                       string_copy_rev(view->ref, text);

... and: string_copy_rev_from_line(view->ref, line);

> +       }
> +       string_copy_rev(ref_commit, view->ref);
> +       state->update_commit_ref = FALSE;
> +}
> +
>  static bool
>  pager_open(struct view *view, enum open_flags flags)
>  {
> @@ -4427,11 +4454,30 @@ log_open(struct view *view, enum open_flags flags)
>  static enum request
>  log_request(struct view *view, enum request request, struct line *line)
>  {
> +       struct log_state *state = (struct log_state *) view->private;

There's no need to cast view->private here.

> +
>         switch (request) {
>         case REQ_REFRESH:
>                 load_refs();
>                 refresh_view(view);
>                 return REQ_NONE;
> +
> +       case REQ_MOVE_UP:
> +       case REQ_PREVIOUS:
> +               if (line->type == LINE_COMMIT && line->lineno > 1) {
> +                       /* We are at a commit, and heading upward. We
> +                          force log_select to find the previous
> +                          commit above, from the context. */

Please delete this comment.

> +                       state->update_commit_ref = TRUE;
> +               }
> +               return pager_request(view, request, line);

There's not really any reason to call pager_request here, since it
only handles REQ_ENTER.

> +
> +       case REQ_MOVE_PAGE_UP:
> +       case REQ_MOVE_PAGE_DOWN:
> +               /* We need to figure out the right commit again. */

Please delete this this comment.

> +               state->update_commit_ref = TRUE;
> +               return pager_request(view, request, line);

Calling pager_request again.

> +
>         default:
>                 return pager_request(view, request, line);
>         }
> @@ -4441,13 +4487,13 @@ static struct view_ops log_ops = {
>         "line",
>         { "log" },
>         VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER | VIEW_NO_PARENT_NAV,
> -       0,
> +       sizeof(struct log_state),
>         log_open,
>         pager_read,
>         pager_draw,
>         log_request,
>         pager_grep,
> -       pager_select,
> +       log_select,
>  };
>
>  struct diff_state {
> --
> 1.8.3.2
>

-- 
Jonas Fonseca
