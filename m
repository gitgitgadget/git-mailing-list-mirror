From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
 cherry-picking an empty commit
Date: Sun, 08 Mar 2009 12:45:55 -0700
Message-ID: <7v8wnflrws.fsf@gitster.siamese.dyndns.org>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
 <20090308144240.GA30794@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Chris Johnsen <chris_johnsen@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 08 20:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgOyH-0007T2-W0
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 20:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbZCHTqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753294AbZCHTqJ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 15:46:09 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbZCHTqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 15:46:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6ABDE4819;
	Sun,  8 Mar 2009 15:46:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 88EFB4814; Sun, 
 8 Mar 2009 15:45:57 -0400 (EDT)
In-Reply-To: <20090308144240.GA30794@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 8 Mar 2009 10:42:40 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C3140B86-0C19-11DE-B48E-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112634>

Jeff King <peff@peff.net> writes:

>   1. Declare appended newline a forbidden style, fix all existing cases
>      in the test suite, and be on the lookout for new ones.
>
>      The biggest problem with this option is that we have no automated
>      way of policing. Such tests will just silently pass on the broken
>      platform.
>
>   2. Have test_run_ canonicalize the snippet by removing trailing
>      newlines.
>
>   3. Declare FreeBSD's /bin/sh unfit for git consumption, and require
>      bash for the test suite.
>
> I think (2) is the most reasonable option of those choices.
>
> We could also try to convince FreeBSD that it's a bug, but that doesn't
> change the fact that the tests are broken on every existing version.

If this part from your analysis is true for a shell:

> eval 'false
>
> '
> echo status is $?
>
> generates:
> ...
>   status is 0

I would be very tempted to declare that shell is unfit for any serious
use, not just for test suite.  Removing the empty line at the end of a
scriptlet that such a broken shell misinterprets as an empty command
that is equivalent to ":" (or "true") might hide breakages in the test
suite, but

 (1) eval "$string" is used outside of test suite, most notably "am" and
     "bisect".  I think "am"'s use is safe, but I wouldn't be surprised if
     the scriptlet "bisect" internally creates has empty lines if only for
     debuggability; and more importantly

 (2) who knows what _other_ things may be broken in such a shell?
