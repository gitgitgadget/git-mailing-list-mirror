From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-am foreign patch support: format autodetection
Date: Mon, 25 May 2009 15:23:54 -0700
Message-ID: <7vk544u8hx.fsf@alter.siamese.dyndns.org>
References: <1243278846-14120-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1243278846-14120-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 26 00:24:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8iay-0000Z1-Cn
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbZEYWYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbZEYWYG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 18:24:06 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51940 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbZEYWXx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2009 18:23:53 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090525222355.FIPH2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Mon, 25 May 2009 18:23:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id vyPu1b00J4aMwMQ04yPuuA; Mon, 25 May 2009 18:23:54 -0400
X-Authority-Analysis: v=1.0 c=1 a=0Luffpz0gjoA:10 a=LA67rPVIN-4A:10
 a=pGLkceISAAAA:8 a=Nrmhf0f4Z_ep8n1QG7wA:9 a=kygzmiMLYNvSoz5rqsLLSlcuvx8A:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119978>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> This patch is the first step towards the introduction of a framework to
> allow git-am to import patches not in mailbox format.
>
> Currently detected formats are
>   * the mailbox format itself, which is assumed by default if input is
>     form stdin
>   * Mercurial's output from 'hg export'
>   * Stacked Git's output from 'stg export' with the default export
>     template; StGIT patch series are also detected and expanded.

I personally do not trust "autodetection" (especially done by others ;-),
and prefer to have an explicit override by the users, but that aside...

> +	# from stdin we only accept mboxes, because peeking at stdin
> +	# to detect the format is destructive
> +	case $# in
> +	0)
> +		patch_format=mbox
> +		;;
> +	1)
> +		if test x"$1" = x"-"
> +		then
> +			# stdin, so assume mbox
> +			patch_format=mbox
> +		else

	# have parseopt to set explicit patch_format before this part...

	if test -z "$patch_format" && {
           test $# = 0 || test "x$1" = x-
        }
        then
        	patch_format=mbox
	else
        	patch_format=$(guess_patch_format)
	fi

Having this extra logic inside the main codeflow makes it extremely harder
to read; have it in a separate shell function.

> +# a single non-stdin argument was passed, check if it's a StGit patch series
> +# index by checking if the first line begins with '# This series'
> +			{
> +				read l1
> +				case "$l1" in
> +				'# This series '*)
> +# replace the argument list with the files listed in the series index,
> +# prefixing them with the series index dirname, skipping comment lines

Can the "series-index-name" file begin with '-' (which would affect the
way how 'set "@"' works in the loop below)?  A standard trick would be to
do something like this.

	series_index="$1"
	shift ;# discard
        set x
        while ...
	do
        	set "$@" another
	done
        shift ;# discard 'x' protection

> +	# (which is not stdin) to try to understand the format.
> +	if test $patch_format = none

I do not understand this duplication and inconsistency.  Why have the
detection in two places?

> +	case "$patch_format" in
> +	mbox)
> +		git mailsplit -d"$prec" -o"$dotest" -b -- "$@" > "$dotest/last" ||  {
> +			rm -fr "$dotest"
> +			exit 1
> +		}
> +		;;
> +	*)
> +		echo "Patch format $patch_format is not currently handled, sorry"
>  		exit 1

No fixing broken "Subject:" line for your format here?
