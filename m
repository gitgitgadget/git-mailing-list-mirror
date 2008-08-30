From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git apply: do not match beginning in special
 unidiff-zero case
Date: Sat, 30 Aug 2008 12:54:39 -0700
Message-ID: <7vfxomgtxc.fsf@gitster.siamese.dyndns.org>
References: <20080830164527.GA25370@localhost>
 <20080830165600.GB25370@localhost>
 <7vhc92ie44.fsf@gitster.siamese.dyndns.org>
 <20080830190302.GA29851@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat Aug 30 21:55:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWY8-0007SM-Eq
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 21:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbYH3Tys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 15:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbYH3Tyr
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 15:54:47 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbYH3Tyr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 15:54:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 844F86D467;
	Sat, 30 Aug 2008 15:54:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9B2416D466; Sat, 30 Aug 2008 15:54:41 -0400 (EDT)
In-Reply-To: <20080830190302.GA29851@localhost> (Clemens Buchacher's message
 of "Sat, 30 Aug 2008 21:03:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E99227A-76CD-11DD-BEFB-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94412>

Clemens Buchacher <drizzd@aon.at> writes:

> If a unidiff patch without any context modifies the second line, it does
> not match the beginning, even though oldpos == 1.

Heh, it seems we independently reached the same patch, so I'll squash in
your new test.

Having did all this, I have to warn you, git-gui, and anybody who is
tempted to use --unidiff-zero in "add -i [e]dit" that the -U0 format is
inherently unreliable _unless the patch you are feeding is perfect_.

By reducing the context, especially when you have only addition without
deletion next to it (iow, "modification to an existing line"), the only
information as to where that line needs to be inserted that you are
telling "apply" is the postimage offset, so you have to be absolutely sure
that the hunk header "@@ -K,L +M,N @@" you are feeding has the correct
value for "M".

For git-gui's "pick and apply", you should be able to, but once you start
allowing random manual editing of hunks, by definition the patch is _not_
perfect ("add -i [e]dit" even admits that it does not know what it is
doing by passing --recount to "apply").

So try to avoid --unidiff-zero.  git-gui should have _enough_ information
to add surrounding context back to the lines the user picked from the UI,
and I do not see a reason other than sheer lazyness for it to be using the
option.
