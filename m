From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [[TIG][PATCH] 2/3] Display correct diff the context in split log view
Date: Mon, 5 Aug 2013 23:50:05 -0400
Message-ID: <CAFuPQ1JbX77=KdzFnPXYH5+=2+E1mxS+r8C1VsXYkpYJfMG7_A@mail.gmail.com>
References: <1375489399-11618-1-git-send-email-a.kumar@alumni.iitm.ac.in> <1375489399-11618-3-git-send-email-a.kumar@alumni.iitm.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
X-From: git-owner@vger.kernel.org Tue Aug 06 05:50:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6YIK-00057d-Sx
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 05:50:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab3HFDu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 23:50:26 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:61579 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753734Ab3HFDu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 23:50:26 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so8112915oag.31
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 20:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=heQqp08gf0tU/C19+6gcyUmCWxHcu24O2W5cBdYgJ3A=;
        b=wiO/UNbA4Z4o0/wkvvOeyJZQsDHkXhSFpFGbZmcg7l3w9I/HjjR6T0xaKPy2fFYc4a
         oafEg2sXxRrOyGjWT0wMGvxbNWb8+IiC5UKEwmdCc8bMF7Iyt3jrLB76H9a3Nr9yRKk8
         nGtofiRCeQMwuwW2mTmyqilMl+YY3oa9n9A0WpK9DhUcT5Dn2kHtmfZSKG8v7Wr5MF2t
         9JA5PFoOyl7YSdMb2rvrh6RczDEsikSppqWwM5M26tqZnncWR2gKMd3xB9Xq4WQeg5LX
         J1lbYf1FZpjXxmchkIDuB+nHYVgI8nr7ego+AJRnrLpaWIYcT4KW2W87irlYKkXYOaDA
         yEoQ==
X-Received: by 10.182.72.137 with SMTP id d9mr16522970obv.99.1375761025326;
 Mon, 05 Aug 2013 20:50:25 -0700 (PDT)
Received: by 10.76.69.169 with HTTP; Mon, 5 Aug 2013 20:50:05 -0700 (PDT)
In-Reply-To: <1375489399-11618-3-git-send-email-a.kumar@alumni.iitm.ac.in>
X-Google-Sender-Auth: w5zo02oRYQM3tfm5oXxOTTVfpGc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231714>

On Fri, Aug 2, 2013 at 8:23 PM, Kumar Appaiah <a.kumar@alumni.iitm.ac.in> wrote:
> In the log view, when scrolling across a commit, the diff view should
> automatically switch to the commit whose context the cursor is on in
> the log view. This commit changes things to catch the REQ_ENTER in the
> log view and handle recalculation of the commit and diff display from
> log_request, rather than delegating it to pager_request. In addition,
> it also gets rid of unexpected upward scrolling of the log view.
>
> Fixes GH #155
>
> Signed-Off-By: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
> ---
>  NEWS  |  1 +
>  tig.c | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/NEWS b/NEWS
> index 0394407..f59e517 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -46,6 +46,7 @@ Bug fixes:
>   - Fix rendering glitch for branch names.
>   - Do not apply diff styling to untracked files in the stage view. (GH #153)
>   - Fix tree indentation for entries containing combining characters. (GH #170)
> + - Introduce a more natural context-sensitive log display. (GH #155)
>
>  tig-1.1
>  -------
> diff --git a/tig.c b/tig.c
> index dd4b0f4..53947b7 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -4478,6 +4478,18 @@ log_request(struct view *view, enum request request, struct line *line)
>                 state->update_commit_ref = TRUE;
>                 return pager_request(view, request, line);
>
> +       case REQ_ENTER:
> +               /* Recalculate the correct commit for the context. */

See my dislike for this type of comments. ;)

> +               state->update_commit_ref = TRUE;
> +
> +               open_view(view, REQ_VIEW_DIFF, OPEN_SPLIT);

This is called every time the user presses up/down. There should be a
check that compares the VIEW(REQ_VIEW_DIFF)->ref to ref_commit.

> +               update_view_title(view);

This can be deleted. pager_request require this hack due to the
automatic scrolling (if I recall correctly).

> +
> +               /* We don't want to delegate this to pager_request,
> +                  since we don't want the extra scrolling of the log
> +                  view. */

This explanation should IMO go into the commit message and not a
comment since it is somewhat confusing unless you are familiar with
the previous behaviour.

> +               return REQ_NONE;
> +
>         default:
>                 return pager_request(view, request, line);

This line can be changed to `return request;`

>         }
> --
> 1.8.3.2
>

-- 
Jonas Fonseca
