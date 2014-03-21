From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] Rewrite fsck.c:fsck_commit() replace memcmp() with starts_with()
Date: Fri, 21 Mar 2014 15:33:44 -0400
Message-ID: <CAPig+cRe-L5QHSVu=U9EWTeoCsjS++TGZvu9ZZSss7_mBVX0AA@mail.gmail.com>
References: <1395419838-25527-1-git-send-email-cengoguzhanunlu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>
To: blacksimit <cengoguzhanunlu@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 20:33:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR5CP-0008S8-VT
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 20:33:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbaCUTdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 15:33:45 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:48011 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751699AbaCUTdp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 15:33:45 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so2894601yhl.34
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 12:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=AbnftkOLB6AgwiDOJAYsTKbCDLrslQXY9Cf/3Mun47k=;
        b=tXawQiSEv3BSktU0hZOtD8H3N6DEyA5XApjo0ZL1UgH1C52RNFQdle/WjNwkj+oo54
         WWzRNIjltyWZPDLoXArCwdU50gZx0zTRTHc/O95sF0fNfT55GiFD5UI8jxXiWj/kYWH0
         lfUVlpiyNwawJB1QRxfRmDhhwG6LGK89V/zQVaDmrpFvgqPt8lYRGt1Qmr4gidnspUWY
         RJjyT56N4SOX9HGf4CGVdEp1+8aU/ic9zCh6AtZyro1Tok+D6FxrgFMBULuNQutB1+vm
         zxGNOO9KxbmEdlvU70VCEJEnzPtGyIVGyOLJJSx0GniTtbHyizYqvFnBYAP8WvUM0vUF
         o8CQ==
X-Received: by 10.236.122.99 with SMTP id s63mr45123899yhh.19.1395430424543;
 Fri, 21 Mar 2014 12:33:44 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Fri, 21 Mar 2014 12:33:44 -0700 (PDT)
In-Reply-To: <1395419838-25527-1-git-send-email-cengoguzhanunlu@gmail.com>
X-Google-Sender-Auth: BMk7Gxp8pYToFnSNjddvgt7Vj9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244729>

In addition to the valuable review comments by Junio and Matthieu, see
a few more below...

On Fri, Mar 21, 2014 at 12:37 PM, blacksimit <cengoguzhanunlu@gmail.com> wrote:
> From: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
>
> My solution to make lines containing buffer += a_number; clearer to anyone is following; I defined a new int, magic_num, then assigned lengths of used strings to magic_num and then changed assignment lines through using magic_num so that where the number which is added to buffer is known although I eliminated 3rd parameter of memcmp() when using starts_with().

The process you describe here is effectively what skip_prefix() does
except that you are doing the bookkeeping manually, whereas
skip_prefix() handles the details for you. This should be a good clue
that skip_prefix() is a better solution.

When writing a commit message, try to keep it impersonal; omit
statements like "My solution" and "I defined".

Use imperative mood, which means that the commit message should tell
the code how to change itself. For instance "replace X with Y" or
"retry operation X upon failure".

Let the code speak for itself. It's obvious that skip_prefix() takes
one less argument than memcmp(), so there is no need to talk about it
in the commit message.

Finally, explain why the change is a good thing.

> Signed-off-by: Oguzhan Unlu <cengoguzhanunlu@gmail.com>
> ---
>  I didn't use skip_prefix() in this microproject and I plan to apply for GSOC 2014. I expect your feedbacks!
>  fsck.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index d43be98..4e5ca30 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -289,14 +289,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>         struct commit_graft *graft;
>         int parents = 0;
>         int err;
> -
> +    int magic_num;
> +
> +    magic_num = strlen("tree "); /* magic_num is 5 */
>         if (!starts_with(buffer, "tree "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
> -       if (get_sha1_hex(buffer+5, tree_sha1) || buffer[45] != '\n')
> +       if (get_sha1_hex(buffer+magic_num, tree_sha1) || buffer[45] != '\n')
>                 return error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
>         buffer += 46;
> +    magic_num = strlen("parent "); /* magic_num is 7 */
>         while (starts_with(buffer, "parent ")) {
> -               if (get_sha1_hex(buffer+7, sha1) || buffer[47] != '\n')
> +               if (get_sha1_hex(buffer+magic_num, sha1) || buffer[47] != '\n')
>                         return error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
>                 buffer += 48;
>                 parents++;
> @@ -322,15 +325,17 @@ static int fsck_commit(struct commit *commit, fsck_error error_func)
>                 if (p || parents)
>                         return error_func(&commit->object, FSCK_ERROR, "parent objects missing");
>         }
> +    magic_num = strlen("author "); /* magic_num is 7 */
>         if (!starts_with(buffer, "author "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
> -       buffer += 7;
> +       buffer += magic_num;
>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> +    magic_num = strlen("committer"); /* magic_num is 7 */
>         if (!starts_with(buffer, "committer "))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
> -       buffer += strlen("committer ");
> +       buffer += magic_num;
>         err = fsck_ident(&buffer, &commit->object, error_func);
>         if (err)
>                 return err;
> --
> 1.9.1.286.g5172cb3
>
