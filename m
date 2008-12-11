From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal output from git-show really wants a terminal
Date: Thu, 11 Dec 2008 15:03:29 -0800
Message-ID: <7vr64eb9ha.fsf@gitster.siamese.dyndns.org>
References: <ghop5d$qud$1@ger.gmane.org>
 <200812111051.20322.bss03@volumehost.net>
 <20081211215554.GA11565@sigill.intra.peff.net>
 <200812111645.10067.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:05:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAuaY-0000f8-Cu
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 00:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758421AbYLKXDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 18:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758297AbYLKXDk
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 18:03:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496AbYLKXDj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 18:03:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C85041A18C;
	Thu, 11 Dec 2008 18:03:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6F81E1A182; Thu,
 11 Dec 2008 18:03:31 -0500 (EST)
In-Reply-To: <200812111645.10067.bss03@volumehost.net> (Boyd Stephen Smith,
 Jr.'s message of "Thu, 11 Dec 2008 16:45:05 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1B569A2-C7D7-11DD-9F0F-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102838>

"Boyd Stephen Smith Jr." <bss03@volumehost.net> writes:

>>  $ git log >foo.out
>>
>>and start a pager, which makes no sense.
>
> Good point, I'll try and consider that while I investgate the history of the 
> issue.

Isn't the issue about 61b8050 (sending errors to stdout under $PAGER,
2008-02-16)?  With that commit, we changed things so that when we send the
standard output to the $PAGER, we dup stderr to the $PAGER as well,
because otherwise any output to stderr will be wiped out by whatever the
pager does and the user will not notice the breakage.  E.g.

	$ git log

will just show reams of output, and you won't see any errors and warnings
even if there were any encountered during the process.

Unfortunately we did it unconditionally.  There is no reason to dup stderr
to the $PAGER if the command line was:

	$ git log 2>error.log

in which case you would want to view the normal output in your $PAGER and
you are keeping the log of the error output in a separate file.
