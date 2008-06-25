From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] update-hook-example: optionally allow
 non-fast-forward
Date: Wed, 25 Jun 2008 13:04:56 -0700
Message-ID: <7vtzfhz3fb.fsf@gitster.siamese.dyndns.org>
References: <1214382416-6687-1-git-send-email-dpotapov@gmail.com>
 <1214382416-6687-2-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 22:06:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBbFu-0002lm-PY
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 22:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbYFYUFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbYFYUFL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 16:05:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbYFYUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 16:05:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D9A1921B4;
	Wed, 25 Jun 2008 16:05:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 142FB21AF; Wed, 25 Jun 2008 16:05:05 -0400 (EDT)
In-Reply-To: <1214382416-6687-2-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Wed, 25 Jun 2008 12:26:56 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 02E0B6B6-42F2-11DD-98A6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86334>

Dmitry Potapov <dpotapov@gmail.com> writes:

> Sometimes it is desirable to have non-fast-forward branches in a
> shared repository. A typical example of that is the 'pu' branch.
> This patch extends the format of allowed-users and allow-groups
> files by using the '+' sign at the beginning as the mark that
> non-fast-forward pushes are permitted to the branch.

Thanks.  1/2 queued for 'maint' (as it was an obvious fix) to be included
in 1.5.6.1, but not this one that is a feature enhancement even though it
is in docs.

> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>

>    rc=$(cat $allowed_users_file | grep -v '^#' | grep -v '^$' |
>      while read head_pattern user_patterns; do
> -      matchlen=$(expr "$1" : "$head_pattern")
> -      if [ "$matchlen" == "${#1}" ]; then
> +      matchlen=$(expr "$1" : "${head_pattern#+}")
> +      allow_noff=$(expr substr "$head_pattern" 1 1)
> +      if [ "$matchlen" = "${#1}" -a \( -z "$noff" -o "$allow_noff" = '+' \) ]; then

"expr substr"?  Please don't.

    cf. http://www.opengroup.org/onlinepubs/000095399/utilities/expr.html

I'd probably write this part like so:

	... pipe ... |
	while read heads users
        do
        	# does this rule apply to us?
        	head_pattern=${heads#+}
                matchlen=$(expr "$1" : "$head_pattern")
                test "$matchlen" = ${#1} || continue

                # if non-ff, $heads must be with the '+' prefix
                test -n "$noff" &&
                test "z$head_pattern" = "z$heads" && continue

                ... Ok this is good.
