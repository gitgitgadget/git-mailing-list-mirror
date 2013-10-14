From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] diff.c: keep arrow(=>) on show_stats()'s shortened
 filename part to make rename visible.
Date: Tue, 15 Oct 2013 02:04:38 +0700
Message-ID: <CACsJy8Cg5M8dHSMW+giwYB2016jZhryyxET0kxkLDX7xk=B47w@mail.gmail.com>
References: <38848735-7CFA-404E-AE51-4F445F813266@gmail.com>
 <A15CCF08-83FD-4F3C-9773-C26DEE38FD33@gmail.com> <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Yoshioka Tsuneo <yoshiokatsuneo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 14 21:05:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVnS9-0005o5-PQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 21:05:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab3JNTFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 15:05:10 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:47364 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756607Ab3JNTFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 15:05:09 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so5119502obc.17
        for <git@vger.kernel.org>; Mon, 14 Oct 2013 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DDxQEIPQLQojuXGjdC/fj5/PGEw7Ue4nLANsfiPLdCk=;
        b=ywnFy+1vcDM6z98Y4Me1iQ7xkjf3W1u/ZVnMu+ZppwiLG2r4lfb4HX/zXdG9QLjces
         yCMpJqoFJfTbWoydqUK9+zgWFtGGu4N3zk/X+q3MNMHmtHoXFyCcw/4ktOFUzt27EqE6
         VRjo3du1mul/2LlooprnAktisgapQA29L2j+numyXmKo4BgwnXFYU/tIiVOAGy2/5nBA
         YJFb0e82vxxZ6D7caAymil9tkEBdCb6qDJdIO0PyyTFc5W4sQmuzeqD1y2zqsv8oLqiy
         bGgwVNhBawAR75jHebW72+Cg6TYiDazq2AlX5YEMt8JKCKCSwzpGK1QBOib2QRLG2nUv
         UjgA==
X-Received: by 10.60.44.9 with SMTP id a9mr1514825oem.67.1381777508591; Mon,
 14 Oct 2013 12:05:08 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Mon, 14 Oct 2013 12:04:38 -0700 (PDT)
In-Reply-To: <660A536D-9993-4B81-B6FF-A113F9111570@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236113>

On Sun, Oct 13, 2013 at 3:48 AM, Yoshioka Tsuneo
<yoshiokatsuneo@gmail.com> wrote:
> "git diff -M --stat" can detect rename and show renamed file name like
> "foofoofoo => barbarbar", but if destination filename is long the line
> is shortened like "...barbarbar" so there is no way to know whether the
> file is renamed or existed in the source commit.
> This commit makes it visible like "...foo => ...bar".
>
> Signed-off-by: Tsuneo Yoshioka <yoshiokatsuneo@gmail.com>
> ---
>  diff.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 51 insertions(+), 7 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index a04a34d..3aeaf3e 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1643,13 +1643,57 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>                 len = name_width;
>                 name_len = strlen(name);
>                 if (name_width < name_len) {
> -                       char *slash;
> -                       prefix = "...";
> -                       len -= 3;
> -                       name += name_len - len;
> -                       slash = strchr(name, '/');
> -                       if (slash)
> -                               name = slash;
> +                       char *arrow = strstr(name, " => ");
> +                       if (arrow) {

This looks iffy. What if " => " is part of the path name?
file->is_renamed would be a more reliable sign. In that case I think
you just need an ellipsis version of pprint_rename() (i.e. drop the
result of previous pprint_rename() on the floor and create a new
string with "..." and " => " in your pprint_ellipsis_rename or
something)

> +                               int prefix_len = (name_width - 4) / 2;
> +                               int f_omit;
> +                               int f_brace = 0;
> +                               char *pre_arrow = alloca(name_width + 10);
> +                               char *post_arrow = arrow + 4;
> +                               char *prefix_buf = alloca(name_width + 10);
> +                               char *pre_arrow_slash = NULL;
> +
> +                               if (arrow - name < prefix_len) {
> +                                       prefix_len = (int)(arrow - name);
> +                                       f_omit = 0;
> +                               } else {
> +                                       prefix_len -= 3;
> +                                       f_omit = 1;
> +                                       if (name[0] == '{') {
> +                                               prefix_len -= 1;
> +                                               f_brace = 1;
> +                                       }
> +                               }
> +                               prefix_len = ((prefix_len >= 0) ? prefix_len : 0);
> +                               strncpy(pre_arrow, arrow - prefix_len, prefix_len);
> +                               pre_arrow[prefix_len] = '\0';
> +                               pre_arrow_slash = strchr(pre_arrow, '/');
> +                               if (f_omit && pre_arrow_slash)
> +                                       pre_arrow = pre_arrow_slash;
> +                               sprintf(prefix_buf, "%s%s%s => ", (f_brace ? "{" : ""), (f_omit ? "..." : ""), pre_arrow);
> +                               prefix = prefix_buf;
> +
> +                               if (strlen(post_arrow) > name_width - strlen(prefix)) {
> +                                       char *post_arrow_slash = NULL;
> +
> +                                       post_arrow += strlen(post_arrow) - (name_width - strlen(prefix) - 3);
> +                                       strcat(prefix_buf, "...");
> +                                       post_arrow_slash = strchr(post_arrow, '/');
> +                                       if (post_arrow_slash)
> +                                               post_arrow = post_arrow_slash;
> +                                       name = post_arrow;
> +                                       name_len = (int) (name_width - strlen(prefix));
> +                               }
> +                               len -= strlen(prefix);
> +                       } else {
> +                               char *slash = NULL;
> +                               prefix = "...";
> +                               len -= 3;
> +                               name += name_len - len;
> +                               slash = strchr(name, '/');
> +                               if (slash)
> +                                       name = slash;
> +                       }
>                 }
>
>                 if (file->is_binary) {
> --
> 1.8.4.475.g867697c
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
