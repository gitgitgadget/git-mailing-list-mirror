From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Thu, 06 Aug 2009 22:25:39 -0700
Message-ID: <7vtz0k5h64.fsf@alter.siamese.dyndns.org>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil> <20090807015238.GF12924@vidovic> <20090807015628.GG12924@vidovic> <4Frzb2o8m7o4sjOhlZiN-mXQHUAsXYeImlNxZ8ANJZ5I3_S_JjSsoA@cipher.nrlssc.navy.mil> <20090807023126.GH12924@vidovic> <7GvFnE4br-8WnXmtoea9V1LPY-qshCw6arPr6H40SRG59-b7YcpTsw@cipher.nrlssc.navy.mil> <20090807043929.GJ12924@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Aug 07 07:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZHxz-0001r1-FI
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 07:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbZHGFZx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 01:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbZHGFZx
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 01:25:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51219 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZHGFZw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 01:25:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BE26420548;
	Fri,  7 Aug 2009 01:25:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9124A20547; Fri,  7 Aug 2009
 01:25:41 -0400 (EDT)
In-Reply-To: <20090807043929.GJ12924@vidovic> (Nicolas Sebrecht's message of
 "Fri\, 7 Aug 2009 06\:39\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C51EC266-8312-11DE-9656-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125180>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> It really seems like the argument has precedence to the redirection
> I couldn't find any reference to this case in POSIX and I guess that the
> behaviour may differ between implementations of sed.
> Perhaps somebody could tell us if our hesitation is justified (or not)?

If you give file arguments, standard input is irrelevant to sed.  I bet you
do:

	$ sed -e something file

all the time, and you rely on the command not to get stuck after reading
the file because now it wants to continue reading from its stdin, which is
connected to your terminal.  Have you ever worried about having to type ^D
after every such invocation of sed?  I bet you never have ;-)

Also, your _preferred_ alternative

	{ read l1; read l2; read l3;
          ( echo "$l1"; echo "$l2"; echo "$l3"; cat | sed )
	} <"$1"

is not just simply inefficient, but is actively wrong.  The "read" can
butcher your input.  For example, try:

	$ echo "a b " | ( read l1; echo "<$l1>" )
