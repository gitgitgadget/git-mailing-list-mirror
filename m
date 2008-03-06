From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] git-submodule: New subcommand 'summary' (3) -
 limit summary size
Date: Wed, 05 Mar 2008 16:24:18 -0800
Message-ID: <7v7iggitsd.fsf@gitster.siamese.dyndns.org>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
 <1204481710-29791-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 01:25:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX3uy-0003ZQ-AZ
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 01:25:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173AbYCFAYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 19:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbYCFAYZ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 19:24:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61584 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbYCFAYY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 19:24:24 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 64DEE31DE;
	Wed,  5 Mar 2008 19:24:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 983C131DD; Wed,  5 Mar 2008 19:24:20 -0500 (EST)
In-Reply-To: <1204481710-29791-3-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Mon, 3 Mar 2008 02:15:09 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76298>

Ping Yin <pkufranky@gmail.com> writes:

> This patch teaches git-submodule an option '--summary-limit|-n <number>'
> to limit number of commits in total for the summary. Number 0 will disable
> summary and minus number means unlimted (the default).

I really doubt showing the bottom one specially makes sense.

Why not just read from

	git log '--pretty=%m %h %s' --left-right --topo-order A...B

and show N top commits from each?

I've already said that I do not think applying the same limit to
new/deleted/modified cases makes sense, so commenting on this
part might be a moot point, though.

-- >8 --

#!/bin/sh

limit=10
A=cc/run-command
B=jc/test

lf='
'
git log --pretty=format:%m\ %h\ %s --left-right $A...$B |
(
	left=0 right=0 l= r= llast= rlast=
	ilimit=$(( $limit - 1 ))
	while read leftright commit name
	do
		it="$leftright$commit $name"
		case "$leftright" in
		'<')
			if test $left -eq $ilimit
			then
				llast=$it
			elif test $left -le $ilimit
			then
				l="$l$it$lf"
			fi
			left=$(( $left + 1 ))
			;;
		'>')
			if test $right -eq $ilimit
			then
				rlast=$it
			elif test $right -le $ilimit
			then
				r="$r$it$lf"
			fi
			right=$(( $right + 1 ))
			;;
		esac
	done

	printf %s "$l"
	if test $left -eq $limit
	then
		echo "$llast"
	elif test $left -gt $limit
	then
		echo "< ("$(( $left - $limit ))" more...)"
	fi
	printf %s "$r"
	if test $right -eq $limit
	then
		echo "$rlast"
	elif test $right -gt $limit
	then
		echo "> ("$(( $right - $limit ))" more...)"
	fi
)
