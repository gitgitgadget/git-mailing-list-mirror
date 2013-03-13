From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 3/3] git-merge-one-file: revise merge error reporting
Date: Wed, 13 Mar 2013 02:03:47 -0700
Message-ID: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
	<1363137142-18606-1-git-send-email-kevin@bracey.fi>
	<1363137142-18606-3-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Wed Mar 13 10:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFhbc-0002Pi-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 10:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754870Ab3CMJDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 05:03:50 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:62390 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab3CMJDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 05:03:48 -0400
Received: by mail-wg0-f51.google.com with SMTP id 8so708549wgl.18
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 02:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rleU6D+Ui3Ovd6NTGAr2x76CVv5+aY7a6Usdu2xfNV4=;
        b=DJMyNUlLrDu+QU7vjv3mamjdiYX5fw2nuR2fENx0MW+G8qzmYGnRO1VNfN19UUd9zR
         gkdQ3I8MJfc1qVXEI8MixLa/GLJKJVarRFl0oIK2QU0fxm5Gjetgr4qIguLLd46t2mLi
         4S9/6o79b2ESfBdxM2esGiieWmrde6YLp9SjA+CqbMisA8K0yZdzIooPvlea6Cx6q2W8
         SKI5X3Kc3C0swM6UXPo+S9GUSgJ/XczC6QXRiJKpiTEsrGGNW8jxnhZWNNTCF6xoheY+
         PtSuEWUC6JcBoC7uBeQA9lwSZg7y/wkKovdwCHQY+dOpgNTfBZmhAVe4nP53b1UPKTgR
         d8FQ==
X-Received: by 10.180.84.8 with SMTP id u8mr25158848wiy.1.1363165427209; Wed,
 13 Mar 2013 02:03:47 -0700 (PDT)
Received: by 10.194.13.129 with HTTP; Wed, 13 Mar 2013 02:03:47 -0700 (PDT)
In-Reply-To: <1363137142-18606-3-git-send-email-kevin@bracey.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218042>

On Tue, Mar 12, 2013 at 6:12 PM, Kevin Bracey <kevin@bracey.fi> wrote:
> Commit 718135e improved the merge error reporting for the resolve
> strategy's merge conflict and permission conflict cases, but led to a
> malformed "ERROR:  in myfile.c" message in the case of a file added
> differently.
>
> This commit reverts that change, and uses an alternative approach without
> this flaw.
>
> Signed-off-by: Kevin Bracey <kevin@bracey.fi>
> ---

I wonder whether before these changes we should
update the style in this file to follow Documentation/CodingGuidelines.

Not in this patch, but in the file right now there's
this part that stands out:

	if [ "$2" ]; then
		echo "Removing $4"

I think that expression would read more clearly as:

	if test -n "$2"
	then
		echo "Removing $4"

Ditto `if [ "$1" = '' ]` is better written as `test -z "$1"`.

Can you please send a patch to true these up?

It'd be especially nice if the style patch could come
first, followed by the fixes/features ;-)


>  git-merge-one-file.sh | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
> index 0f164e5..78b07a8 100755
> --- a/git-merge-one-file.sh
> +++ b/git-merge-one-file.sh
> @@ -104,11 +104,13 @@ case "${1:-.}${2:-.}${3:-.}" in
>                 ;;
>         esac
>
> +       ret=0
>         src1=$(git-unpack-file $2)
>         src2=$(git-unpack-file $3)
>         case "$1" in
>         '')
> -               echo "Added $4 in both, but differently."
> +               echo "ERROR: Added $4 in both, but differently."
> +               ret=1
>                 orig=$(git-unpack-file $2)
>                 create_virtual_base "$orig" "$src2"
>                 ;;
> @@ -121,10 +123,9 @@ case "${1:-.}${2:-.}${3:-.}" in
>         # Be careful for funny filename such as "-L" in "$4", which
>         # would confuse "merge" greatly.
>         git merge-file "$src1" "$orig" "$src2"
> -       ret=$?
> -       msg=
> -       if [ $ret -ne 0 ]; then
> -               msg='content conflict'
> +       if [ $? -ne 0 ]; then
> +               echo "ERROR: Content conflict in $4"
> +               ret=1

if test $? != 0
then

Also.. should this error not go to stderr?
I guess the existing script was not doing that,
but it seems like anything that says "ERROR" should go there.

>         fi
>
>         # Create the working tree file, using "our tree" version from the
> @@ -133,18 +134,11 @@ case "${1:-.}${2:-.}${3:-.}" in
>         rm -f -- "$orig" "$src1" "$src2"
>
>         if [ "$6" != "$7" ]; then
> -               if [ -n "$msg" ]; then
> -                       msg="$msg, "
> -               fi
> -               msg="${msg}permissions conflict: $5->$6,$7"
> -               ret=1
> -       fi
> -       if [ "$1" = '' ]; then
> +               echo "ERROR: Permissions conflict: $5->$6,$7"
>                 ret=1
>         fi
>
>         if [ $ret -ne 0 ]; then
> -               echo "ERROR: $msg in $4"
>                 exit 1
>         fi
>         exec git update-index -- "$4"

same notes as above.  I think a style patch should come first.
-- 
David
