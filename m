From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Pass the --directory option through to git-apply
Date: Sat, 30 Aug 2008 23:30:30 -0700
Message-ID: <7vfxold7cp.fsf@gitster.siamese.dyndns.org>
References: <1220048870-97641-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Aug 31 08:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZgdq-00063V-IT
	for gcvg-git-2@gmane.org; Sun, 31 Aug 2008 08:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbYHaGai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 02:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbYHaGai
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 02:30:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63911 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbYHaGah (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 02:30:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4DD0E5859A;
	Sun, 31 Aug 2008 02:30:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6FB0E58598; Sun, 31 Aug 2008 02:30:32 -0400 (EDT)
In-Reply-To: <1220048870-97641-1-git-send-email-kevin@sb.org> (Kevin
 Ballard's message of "Fri, 29 Aug 2008 15:27:50 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 523B2AD0-7726-11DD-8A74-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94456>

Kevin Ballard <kevin@sb.org> writes:

> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index b9c6fac..64c8178 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -66,6 +66,7 @@ default.   You could use `--no-utf8` to override this.
>  
>  -C<n>::
>  -p<n>::
> +--directory=<root>::
>  	These flags are passed to the 'git-apply' (see linkgit:git-apply[1])
>  	program that applies
>  	the patch.
> diff --git a/git-am.sh b/git-am.sh
> index aa60261..7e7a86f 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -18,6 +18,7 @@ k,keep          pass -k flag to git-mailinfo
>  whitespace=     pass it through git-apply
>  C=              pass it through git-apply
>  p=              pass it through git-apply
> +directory=      pass it through git-apply
>  resolvemsg=     override error message when patch failure occurs
>  r,resolved      to be used after a patch failure
>  skip            skip the current patch
> @@ -155,7 +156,7 @@ do
>  		;;
>  	--resolvemsg)
>  		shift; resolvemsg=$1 ;;
> -	--whitespace)
> +	--whitespace|--directory)
>  		git_apply_opt="$git_apply_opt $1=$2"; shift ;;
>  	-C|-p)
>  		git_apply_opt="$git_apply_opt $1$2"; shift ;;

Thanks, will queue.

This inherits an ancient breakage that was introduced to the --whitespace
option by 67dad68 (add -C[NUM] to git-am, 2007-02-08), in that you need to
give the next "git am" session the same option when you get a conflict and
need to restart.  We should fix this ancient breakage by recording the
miscellaneous options that we append to $git_apply_opt variable (we should
remove the use of "$dotest/whitespace" that is now a no-op but 67dad68 did
not remove).  That is a separate topic anyway, but the end result should:

 * Save the options in effect in $dotest/, just like "sign", "utf8" and
   "keep" are kept;

 * Upon command startup, read the saved options, and then let the command
   line options override them (which is not what the current code does, by
   the way);

so that you can give necessary --directory, --whitespace, -C etc. options
when you feed your series to "git-am", and after fixing up a rejected
patch, you can continue without typing the same set of options again.
