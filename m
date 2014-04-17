From: Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: Re: [tig] [PATCHv2 3/3] log: Colour the diff stat
Date: Wed, 16 Apr 2014 20:44:41 -0400
Message-ID: <CAFuPQ1JbpNcun3hGps=hwaM14wOjF+iU9bsm9+ZmJvJV_Fea4Q@mail.gmail.com>
References: <1397218805-2560-1-git-send-email-a.kumar@alumni.iitm.ac.in>
 <1397426068-17439-1-git-send-email-a.kumar@alumni.iitm.ac.in> <1397426068-17439-4-git-send-email-a.kumar@alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Thu Apr 17 02:45:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaaRy-0005wf-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 02:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbaDQApE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 20:45:04 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:61059 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbaDQApC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 20:45:02 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so3350760obb.40
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Bde1Pcia43mD4a8/8uCeJsaCfpoKK5A7x9W8KtJOYsg=;
        b=lHEBKaNKS/CrhZTCYsrvhSGoJBSOKSE6RUWO4aoVFAzOaxS0SbWIyEIqoO3b8PeZdC
         dCagV2xDtCjz+rxvCE10wJu46SkovUnofNpwj2y6VYXJnRBx1nAVoe/jeDpnYENrmZ9K
         RvorRqvf/Ooik8tSab7zn/7jep/yHwqxD5CB69yOpndHdx/iBAKbUy6TYUoaDZ8Xqwo8
         GpJOKpypbjdoX27OPwCbhjAotLPXG8A3h5K35GbAxGS+KIiAIjD+CgE+iKKW6Zl8H3o1
         b7oh7PtMKFKQByyKz6f/9Hn1jBiFsDIYbG6Vu8OsircWHOuNTZ8MwTJBFgbYMTMDdP+3
         Ymeg==
X-Received: by 10.182.120.40 with SMTP id kz8mr9320070obb.6.1397695501869;
 Wed, 16 Apr 2014 17:45:01 -0700 (PDT)
Received: by 10.76.8.3 with HTTP; Wed, 16 Apr 2014 17:44:41 -0700 (PDT)
In-Reply-To: <1397426068-17439-4-git-send-email-a.kumar@alumni.iitm.ac.in>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246395>

On Sun, Apr 13, 2014 at 5:54 PM, Kumar Appaiah
<a.kumar@alumni.iitm.ac.in> wrote:
>
> This commit adds custom log_read and log_draw functions that utilize
> the diff stat drawing functions from the diff module. The absence of
> the triple hyphen separator prevents direct usage of the diff drawing
> functions directly.

See my comments below.

> ---
>  src/log.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
>
> diff --git a/src/log.c b/src/log.c
> index 40c9a21..468f7c3 100644
> --- a/src/log.c
> +++ b/src/log.c
> @@ -23,6 +23,9 @@ struct log_state {
>          * up/down in the log view. */
>         int last_lineno;
>         enum line_type last_type;
> +       bool commit_title_read;
> +       bool after_commit_header;
> +       bool reading_diff_stat;
>  };
>
>  static void
> @@ -78,14 +81,62 @@ log_request(struct view *view, enum request request, struct line *line)
>         }
>  }
>
> +static bool
> +log_read(struct view *view, char *data)
> +{
> +       enum line_type type;
> +       struct log_state *state = view->private;
> +       size_t len;
> +
> +       if (!data)
> +               return TRUE;
> +
> +       type = get_line_type(data);
> +       len = strlen(data);
> +
> +       if (type == LINE_COMMIT)
> +               state->commit_title_read = TRUE;
> +       else if (state->commit_title_read && len < 1) {
> +               state->commit_title_read = FALSE;
> +               state->after_commit_header = TRUE;
> +       } else if (state->after_commit_header && len < 1) {
> +               state->after_commit_header = FALSE;
> +               state->reading_diff_stat = TRUE;
> +       } else if (state->reading_diff_stat) {
> +               bool ret = diff_common_add_diff_stat(view, data);
> +               if (ret) {
> +                       return TRUE;
> +               } else {
> +                       state->reading_diff_stat = FALSE;
> +               }
> +       }
> +
> +       return pager_common_read(view, data, type);
> +}
> +
> +static bool
> +log_draw(struct view *view, struct line *line, unsigned int lineno)
> +{
> +       char *text = line->data;
> +       enum line_type type = line->type;
> +

This is missing a call to draw_lineno(...)

> +       if (type == LINE_DIFF_STAT) {
> +               diff_common_draw_diff_stat(view, &type, &text);
> +               draw_text(view, type, text);

I had to #include "tig/draw.h" for this to compile.

> +               return TRUE;
> +       }
> +
> +       return pager_draw(view, line, lineno);
> +}
> +
>  static struct view_ops log_ops = {
>         "line",
>         argv_env.head,
>         VIEW_ADD_PAGER_REFS | VIEW_OPEN_DIFF | VIEW_SEND_CHILD_ENTER | VIEW_LOG_LIKE | VIEW_REFRESH,
>         sizeof(struct log_state),
>         log_open,
> -       pager_read,
> -       pager_draw,
> +       log_read,
> +       log_draw,
>         log_request,
>         pager_grep,
>         log_select,
> --
> 1.9.1
>



-- 
Jonas Fonseca
