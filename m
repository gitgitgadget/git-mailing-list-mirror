From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Thu, 29 May 2008 06:39:38 +0200
Message-ID: <200805290639.38134.chriscool@tuxfamily.org>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-15?q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 06:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Zrx-0003IE-6R
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 06:36:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYE2EfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 May 2008 00:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbYE2EfN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 00:35:13 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57580 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750913AbYE2EfL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 May 2008 00:35:11 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 52A841AB2C1;
	Thu, 29 May 2008 06:35:10 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 22FC81AB2BF;
	Thu, 29 May 2008 06:35:10 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83173>

Le mardi 27 mai 2008, Santi B=E9jar a =E9crit :
> In case you don't know the next step, if it is "git commit",
> "git commit --amend", "git rebase --continue" or something else.

[...]

> diff --git a/git-bisect.sh b/git-bisect.sh
> index 4bcbace..27d3946 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>
> -USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|r=
un]'
> +USAGE=3D'[help|start|bad|good|skip|next|reset|visualize|replay|log|r=
un|wha
>t]' LONG_USAGE=3D'git bisect help
>          print this long help message.
>  git bisect start [<bad> [<good>...]] [--] [<pathspec>...]
> @@ -23,6 +23,8 @@ git bisect log
>          show bisect log.
>  git bisect run <cmd>...
>          use <cmd>... to automatically bisect.
> +git bisect what...
> +        explain what to do if in the midle of a bisect.

Perhaps it's better to add something like this first:

git bisect status
	show the current bisect state

It could tell if we are currently bisecting and show the "good", "bad"=20
and "skip"ped revs and the content of the BISECT_START and BISECT_NAMES=
=20
(and perhaps BISECT_RUN) files.=20

>  Please use "git help bisect" to get the full man page.'
>
> @@ -206,6 +208,14 @@ bisect_next_check() {
>  	test -n "$(git for-each-ref "refs/bisect/good-*")" || missing_good=3D=
t
>
>  	case "$missing_good,$missing_bad,$1" in
> +	,,what)
> +		# have both good and bad - ok
> +		echo "Test the commit and mark it as"
> +		echo "bad)  $ git bisect bad"
> +		echo "good) $ git bisect good"
> +		echo "skip) $ git bisect skip"
> +		exit
> +		;;
>  	,,*)
>
>  		: have both good and bad - ok
>
>  		;;
> @@ -213,6 +223,16 @@ bisect_next_check() {
>  		# do not have both but not asked to fail - just report.
>  		false
>  		;;
> +	,t,what)
> +		# have good but not bad.
> +		echo "No bad commit, mark one with \"git bisect bad <rev>"\"
> +		exit
> +		;;
> +	t,,what)
> +		# have bad but not good.
> +		echo "No good commit, mark one with \"git bisect good <rev>\""
> +		exit
> +		;;
>  	t,,good)
>  		# have bad but not good.  we could bisect although
>  		# this is less optimum.
> @@ -224,6 +244,14 @@ bisect_next_check() {
>  		fi
>
>  		: bisect without good...
>
>  		;;
> +	t,t,what)
> +		# TODO: Reuse the text in the next case
> +		echo 'You need to give me at least one good' \
> +			'and one bad revisions.'
> +		echo '(You can use "git bisect bad" and' \
> +			'"git bisect good" for that.)'
> +		exit
> +		;;
>  	*)
>  		THEN=3D''
>  		test -f "$GIT_DIR/BISECT_NAMES" || {
> @@ -497,6 +525,11 @@ bisect_run () {
>      done
>  }
>
> +bisect_what () {
> +	test -s "$GIT_DIR/BISECT_START" || return 1

It seems not very friendly to just "return 1" when not bisecting.
And before my last patch to use BISECT_START to check if we are bisecti=
ng,=20
it would perhaps have been better to use 'test -f "$GIT_DIR/BISECT_NAME=
S"'.

Thanks,
Christian.
