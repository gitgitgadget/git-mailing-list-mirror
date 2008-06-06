From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Allow git-apply to ignore the hunk headers (AKA
 recountdiff)
Date: Fri, 06 Jun 2008 08:34:12 -0700
Message-ID: <7v63smwpaj.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0806051115570.21190@racer>
 <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer>
 <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer>
 <4847F49F.8090004@viscovery.net> <alpine.DEB.1.00.0806051548140.21190@racer>
 <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer>
 <alpine.DEB.1.00.0806051720070.21190@racer>
 <7vabhz1t2f.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer>
 <alpine.DEB.1.00.0806060006370.21190@racer>
 <7vve0nw4b7.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806061441120.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 17:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4dyE-0002mi-C6
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 17:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760867AbYFFPeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 11:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760882AbYFFPeX
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 11:34:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39079 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454AbYFFPeW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 11:34:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 877485B39;
	Fri,  6 Jun 2008 11:34:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C0D9A5B34; Fri,  6 Jun 2008 11:34:15 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806061441120.1783@racer> (Johannes
 Schindelin's message of "Fri, 6 Jun 2008 14:58:17 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 07AB98B4-33DE-11DD-8720-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84079>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Then I understood you not correctly at all when you complained about the 
> "Probably a diff" part.

The wish was this.

When recounting this hunk:

	@@ -l,m +n,o @@$
         preimage$
        -deleted$
        -deleted$
        Some other text

I want you to say "three and one", and not error out.  Reading "Some other
text" and deciding that the stream of fragments for the current patch has
ended is the job for parse_single_patch().

If on the other hand the input were:

	@@ -l,m +n,o @@$
         preimage$
        -deleted$
        -deleted$
	-- $
        This space intentionally left blank.
	perhaps a few more lines of sig
	<<EOF>>

I do not want you to say "four and one" silently.  It is more likely that
the answer is "three and one", and the last line that begins with a '-' is
not part of the diff, but for the sake of robustness, I do not want to
hear "three and one" without warning either.  Erroring out, because you
cannot recount reliably, would be prudent.  We do not have a clever tool
that sometimes does a wrong thing silently.

I was fooled by the "where does the line begin when we come to this
function", so I need to re-read the code and see what you are doing.
