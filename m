From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Wed, 14 May 2008 10:03:07 -0700
Message-ID: <7vd4noq0ms.fsf@gitster.siamese.dyndns.org>
References: <20080512122900.GA13050@mithlond.arda.local>
 <20080512155243.GA3592@mithlond.arda.local>
 <alpine.DEB.1.00.0805121810501.30431@racer>
 <20080512184334.GB5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121453250.23581@xanadu.home>
 <20080512190946.GC5160@mithlond.arda.local>
 <alpine.LFD.1.10.0805121527550.23581@xanadu.home>
 <20080512202414.GA8620@mithlond.arda.local>
 <20080512210304.GA17352@glandium.org> <20080512210807.GA22221@glandium.org>
 <20080513001252.GB29038@spearce.org>
 <alpine.LFD.1.10.0805132005550.23581@xanadu.home>
 <7vy76dperf.fsf@gitster.siamese.dyndns.org>
 <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Juergen Ruehle <j.ruehle@bmiag.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 14 19:04:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwKOo-0007pN-Qp
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 19:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304AbYENRDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 13:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbYENRDZ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 13:03:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbYENRDY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 13:03:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 20CB4433E;
	Wed, 14 May 2008 13:03:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B8E794335; Wed, 14 May 2008 13:03:10 -0400 (EDT)
In-Reply-To: <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
 (Juergen Ruehle's message of "Wed, 14 May 2008 11:10:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8981FC2-21D7-11DD-A336-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82113>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> Previously --unpacked would filter on the commit level, ignoring whether the
> objects comprising the commit actually were packed or unpacked.
>
> This makes it impossible to store e.g. excessively large blobs in
> different packs from the commits referencing them, since the next repack of
> such a commit will suck all referenced blobs into the same pack.

Doesn't this patch essentially make the --unpacked option to rev-list and
the --incremental option to pack-objects the same thing?

The semantics of the --unpacked has been defined that way from the very
beginning, and I've always wondered how the option and --incremental
should interact with each other.  I think the approach your patch takes
makes sense.

> This change moves the unpacked check to the output stage and no longer checks
> the flag during commit traversal and adds a trivial test demonstrating the
> problem.

Sign-off?

> diff --git a/t/t6009-rev-list-unpacked.sh b/t/t6009-rev-list-unpacked.sh
> new file mode 100644
> index 0000000..6b65e83
> --- /dev/null
> +++ b/t/t6009-rev-list-unpacked.sh
> @@ -0,0 +1,32 @@
> ...
> +test_expect_success \
> +    'unpacked object list should not contain foo' '
> +    test_must_fail "git rev-list --all --unpacked --objects | grep -q \"foo\""
> +'

Ahhh.  Ugly but don't you mean "! (rev-list | grep)"?
