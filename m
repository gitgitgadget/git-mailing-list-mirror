From: Junio C Hamano <gitster@pobox.com>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Tue, 05 May 2009 23:16:15 -0700
Message-ID: <7vljpaycwg.fsf@alter.siamese.dyndns.org>
References: <20090506055913.GA9701@dektop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 08:16:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1aQf-0003mD-Cc
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 08:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbZEFGQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 02:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbZEFGQV
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 02:16:21 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:34220 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbZEFGQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 02:16:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090506061620.KXFG17135.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 6 May 2009 02:16:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id o6GL1b0034aMwMQ036GLBb; Wed, 06 May 2009 02:16:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=1YscXhk2imAA:10 a=4gGF0mQB7hoA:10
 a=pGLkceISAAAA:8 a=YlfXyZOJ2_0ZyyrTawYA:9 a=E4DKKb05MtV8Qt9wRRhyvJmlPUoA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090506055913.GA9701@dektop> (Nguyen Thai Ngoc Duy's message of "Wed\, 6 May 2009 15\:59\:13 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118325>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> diff --git a/git-am.sh b/git-am.sh
> index 6d1848b..5a91d52 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -46,7 +46,7 @@ fi
>  sq () {
>  	for sqarg
>  	do
> -		printf "%s" "$sqarg" |
> +		printf "%s\n" "$sqarg" |
>  		sed -e 's/'\''/'\''\\'\'''\''/g' -e 's/.*/ '\''&'\''/'

I think this is a correct fix; according to POSIX sed is required only to
work on text files, so we should terminate its input with a newline.

> diff --git a/t/t2019-checkout-sparse.sh b/t/t2019-checkout-sparse.sh
> index 4ea1ee6..6949a59 100755
> --- a/t/t2019-checkout-sparse.sh
> +++ b/t/t2019-checkout-sparse.sh
> @@ -68,13 +68,13 @@ test_expect_success 'update narrow prefix with modification' '
> -	grep -q modified work2/two &&
> +	grep modified work2/two &&

Looks harmless (-q is in POSIX by the way), but you may want to redirect
the standard output to /dev/null instead (applies to your other rewrites
to "grep -q" as well).

> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index b68ab11..61ccdee 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
>  	test_must_fail git merge first
>  '
>  
> -sha1=$(sed -e 's/	.*//' .git/MERGE_RR)
> +sha1=$(cut -f 1 .git/MERGE_RR)

I do not know why you need this one.  It shouldn't hurt, though.

> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
> index e2aa254..9a916d3 100755
> --- a/t/t5300-pack-object.sh
> +++ b/t/t5300-pack-object.sh
> @@ -315,7 +315,7 @@ test_expect_success 'unpacking with --strict' '
>  	head -n 10 LIST | git update-index --index-info &&
>  	LI=$(git write-tree) &&
>  	rm -f .git/index &&
> -	tail -n 10 LIST | git update-index --index-info &&
> +	tail -10 LIST | git update-index --index-info &&

I do not know why your "head" apparently accepts -n (see the context) but
not your "tail"; as POSIX frowns upon head/tail -$number, this one is a
regression.
