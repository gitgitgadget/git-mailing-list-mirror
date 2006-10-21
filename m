From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] make cg-commit --review restore original tree state afterwards
Date: Sat, 21 Oct 2006 22:40:37 +1300
Message-ID: <4539EB15.3050405@vilain.net>
References: <20061021014723.B8E9C13810D@magnus.utsl.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 11:41:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbDLo-0002ex-CQ
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 11:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992896AbWJUJk5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 05:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992887AbWJUJk5
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 05:40:57 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:27615 "EHLO
	magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1030388AbWJUJk4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 05:40:56 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 1A5A313810F; Sat, 21 Oct 2006 22:40:53 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 6DA9813810B;
	Sat, 21 Oct 2006 22:40:48 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061021014723.B8E9C13810D@magnus.utsl.gen.nz>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29596>

Ok, I ruined the error message.

This could also do with some enhancement; if you edit hunks of the
patch, then the numbers in the hunks could be updated so as to not make
the patch abort.  Also, if it does abort you should get the option of
undoing everything, or editing the patch again...

Will try again with this another time.

Sam.

Sam Vilain wrote:
> If you delete hunks from the patch that 'cg-commit -p' shows you, then
> they are lost 'forever'.  Let's put back everything how it was
> beforehand instead.
> ---
>  cg-commit |   25 +++++++++++++++++--------
>  1 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/cg-commit b/cg-commit
> index 01a4eb7..81b3619 100755
> --- a/cg-commit
> +++ b/cg-commit
> @@ -568,18 +568,16 @@ else
>  fi
>  rm "$LOGMSG2"
>  
> +pine_for_darcs() {
> +	die "unable to revert the new patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in ten minutes, have a nice day"
> +}
> +
>  if [ "$review" ]; then
>  	if ! cmp -s "$PATCH" "$PATCH2"; then
>  		echo "Reverting the original patch..."
> -		if ! cg-patch -R < "$PATCH"; then
> -			die "unable to revert the original patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in ten minutes, have a nice day"
> -		fi
> +		cg-patch -R < "$PATCH" || pine_for_darcs
>  		echo "Applying the edited patch..."
> -		if ! cg-patch < "$PATCH2"; then
> -			# FIXME: Do something better to alleviate this situation.
> -			# At least restore the tree to the original state.
> -			die "unable to apply the edited patch; the original patch is available in $PATCH, your edited patch is available in $PATCH2, your log message is in $LOGMSG, your working copy is in undefined state now and the world is about to end in five minutes, have a nice day"
> -		fi
> +		cg-patch < "$PATCH2" || pine_for_darcs
>  	fi
>  fi
>  
> @@ -625,6 +623,17 @@ if [ "$amend" ]; then
>  fi
>  
>  treeid="$(git-write-tree ${missingok})"
> +
> +if [ "$review" ]; then
> +        if ! cmp -s "$PATCH" "$PATCH2"; then
> +                echo "Reverting the new patch..."
> +                cg-patch -R < "$PATCH2" || pine_for_darcs
> +                echo "Applying the old patch..."
> +                cg-patch < "$PATCH" || pine_for_darcs
> +        fi
> +fi
> +
> +
>  [ "$treeid" ] || die "git-write-tree failed"
>  if [ ! "$force" ] && [ ! "$merging" ] && [ "$oldhead" ] &&
>     [ "$treeid" = "$(cg-object-id -t)" ]; then
