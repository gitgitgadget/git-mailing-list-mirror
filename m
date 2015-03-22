From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] align D/F handling of "diff --no-index" with that of
 normal Git
Date: Sun, 22 Mar 2015 03:01:12 -0400
Message-ID: <CAPig+cRQ1i+VJRUKJCqnvh3He9fgvU5FVLCUAGirFVQKjmWa7A@mail.gmail.com>
References: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 08:09:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZa0U-0004t9-U5
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 08:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbbCVHBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 03:01:13 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:34891 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135AbbCVHBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 03:01:13 -0400
Received: by ykfs63 with SMTP id s63so59539790ykf.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RxCJ/gxrnzVPc5lSrsO2nN1Idsw+WCtD9UBXR6YzPx4=;
        b=YnFSd1aKppRh3+MjXErOrxWZFWI7H4hrniDGGLqgv0uY7t+jufgi4d2VqpE2fU2kjY
         kJOGG8ok4IPybQtaNwBxVLMZdpzjrXj2ih+TgYyREXulCZ8ZDlhQaDaB+3EzptxfmxU1
         KOB5ObM4PkoIPBf6/+SQMG6MzI0kSfflmvEUebJkM7R5n6FKtbVuaLlr7akfe25L8Iaf
         laDGyJNhxbxZCR3bADgHeREjxK0VWhk7p9DrZWjxuujiW3HUzN3xi+b32GOQIlzbKynv
         A2ev6JmZFZ3SwcpVQd8HM6zT2gFbyK+kT+o7/Bp/BUUAAVo7Ii4x/Lf4TRtEUzOwR4IB
         6xUQ==
X-Received: by 10.170.194.7 with SMTP id l7mr65945821yke.91.1427007672193;
 Sun, 22 Mar 2015 00:01:12 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 00:01:12 -0700 (PDT)
In-Reply-To: <xmqqiodtd3b4.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: qX7w6GxeUv0_1_BVgctCU4fnhaw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266053>

On Sun, Mar 22, 2015 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> When a commit changes a path P that used to be a file to a directory
> and create a new path P/X in it, "git show" would say that file P

s/create/creates/

More below...

> was removed and file P/X was created for such a commit.
>
> However, if we compare two directories, D1 and D2, where D1 has a
> file D1/P in it and D2 has a directory D2/P under which there is a
> file D2/P/X, and ask "git diff --no-index D1 D2" to show their
> differences, we simply get a refusal "file/directory conflict".
>
> The "diff --no-index" implementation has an underlying machinery
> that can make it more in line with the normal Git if it wanted to,
> but somehow it is not being exercised.  The only thing we need to
> do, when we see a file P and a directory P/ (or the other way
> around) is to show the removal of a file P and then pretend as if we
> are comparing nothing with a whole directory P/, as the code is
> fully prepared to express a creation of everything in a directory
> (and if the comparison is between a directory P/ and a file P, then
> show the creation of the file and then let the existing code remove
> everything in P/).
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  diff-no-index.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 265709b..52e9546 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,27 @@ static int queue_diff(struct diff_options *o,
>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>                 return -1;
>
> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -               return error("file/directory conflict: %s, %s", name1, name2);
> +       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> +               struct diff_filespec *d1, *d2;
> +
> +               if (S_ISDIR(mode1)) {
> +                       /* 2 is file that is created */
> +                       d1 = noindex_filespec(NULL, 0);
> +                       d2 = noindex_filespec(name2, mode2);
> +                       name2 = NULL;
> +                       mode2 = 0;
> +               } else {
> +                       /* 1 is file that is deleted */
> +                       d1 = noindex_filespec(name1, mode2);
> +                       d2 = noindex_filespec(NULL, 0);
> +                       name1 = NULL;
> +                       mode1 = 0;
> +               }
> +               /* emit that file */
> +               diff_queue(&diff_queued_diff, d1, d2);
> +
> +               /* and then let the entire directory created or deleted */

s/created/be created/

> +       }
>
>         if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
>                 struct strbuf buffer1 = STRBUF_INIT;
> --
