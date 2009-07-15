From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-am: fix maildir support regression for unordered
 headers in emails
Date: Wed, 15 Jul 2009 00:27:05 -0700
Message-ID: <7vljmqflti.fsf@alter.siamese.dyndns.org>
References: <20090714122354.GA13806@vidovic>
 <2433101adeafddeab78815083446552ff3ea9f49.1247636959.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Jul 15 09:27:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQytl-0002wD-6v
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 09:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbZGOH1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 03:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbZGOH1V
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 03:27:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbZGOH1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 03:27:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1DCA64F0;
	Wed, 15 Jul 2009 03:27:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C2B8964EF; Wed, 15 Jul 2009
 03:27:12 -0400 (EDT)
In-Reply-To: <2433101adeafddeab78815083446552ff3ea9f49.1247636959.git.nicolas.s.dev@gmx.fr> (Nicolas Sebrecht's message of "Wed\, 15 Jul 2009 07\:52\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EEC47494-7110-11DE-B73B-9AE02FB70C38-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123291>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> Patch format detection introduced by a5a6755a1d4707bf2fab7752e5c974ebf63d086a
> may refuse valid patches from verbatim emails.

It is unclear what you meant by "verbatim email".  A verbatim e-mail
in mbox begins with "From " header that is already covered in the existing
code long before support for stgit/hg was added.

> +		# Keep maildir workflows support.
> +		# Verbatim emails may have header fields in random order.
> +		is_verbatim_email='true'

We do not fold lines like this,

> +		for line in "$l1" "$l2" "$l3"; do

Instead, we write like this:

	for x in a b c
	do
		cmd ...

> +			printf "$line" | grep --quiet --extended-regexp '^([^\ ])+: +.*' ||

We use GNUism spelling --extended-regexp nowhere in scripted Porcelains;
just say -E here, and do not omit -e before the pattern.

Likewise for --quiet.  Just say -q.  When in doubt, be conservative and
stick to POSIX for portability.

    http://www.opengroup.org/onlinepubs/9699919799/utilities/grep.html#tag_20_55

Your regexp has too many issues.

 - It is too loose and too strict at the same time.  RFC 2822 section 2.2
   and 3.6.8 specify that a field name must be composed of printable
   US-ASCII characters except colon and space, so if you really want to be
   lenient, it should instead begin with [^: ]+: (and you do not need any
   capture).

 - I think however starting the regexp with "^[A-Za-z]+(-[A-Za-z]+)*:"
   would be more appropriate in practice, though.

 - You do not need to end the expression with ".*"; omitting that would
   match the same set of lines anyway.

 - I thought you were advocating for not requiring SP after the colon?

 - What happens if $l2 or $l3 is a subsequent folded line?  For example,
   in my MUA edit buffer, this message begins with:

       To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
       Cc: <git@vger.kernel.org>,
           Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
           Johannes Sixt <j.sixt@viscovery.net>
       Subject: Re: [PATCH v2] git-am: fix maildir support ...

   The third line would not match your regexp.

> +				is_verbatim_email='false'
> +		done
> +		# next treatments don't differ from mailbox format
> +		[[ $is_verbatim_email == 'true' ]] && patch_format=mbox

We do not use non-portable [[ ]] anywhere in our shell script.  Write

	if test true = "$is_verbatim_email"
        then
        	patch_format=mbox
	fi

if you really want to keep this code structure.

I actually do not think you would even need an extra is_verbatim_email
variable, though.  Assuming that I understand what you are trying to do,
this is probably how I would write it:

	sed -e '/^$/q' -e '/^[ 	]/d' "$1" |
        grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
        patch_format=mbox

But I am not convinced that I understand what _problem_ you are trying to
solve in the first place.
