From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rev-list.txt: rev stands for revision, not reverse.
Date: Fri, 02 Nov 2007 13:46:01 -0700
Message-ID: <7v8x5g1ily.fsf@gitster.siamese.dyndns.org>
References: <20071101084552.GA4934@ins.uni-bonn.de>
	<7vr6j9bv80.fsf@gitster.siamese.dyndns.org>
	<20071102185509.GA5242@ins.uni-bonn.de>
	<7vprys1k5m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 02 21:46:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io3PN-0005cY-RH
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 21:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852AbXKBUqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbXKBUqJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 16:46:09 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:51146 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbXKBUqI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 16:46:08 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 818232F0;
	Fri,  2 Nov 2007 16:46:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0F7CA9041C;
	Fri,  2 Nov 2007 16:46:24 -0400 (EDT)
In-Reply-To: <7vprys1k5m.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 02 Nov 2007 13:12:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63174>

Junio C Hamano <gitster@pobox.com> writes:

> Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:
>
>> Is the reverse chronological order the primary sorting key at all?
>
> It is mostly chrono but there is a topo element as well.  You
> would never see a parent none of whose child is shown.

To be precise...

Internally, it mainly works on topology with an additional logic
to tiebreak with commit timestamps.

 - We always have one or more "output candidates".

 - Initially, the set of output candidates are primed from the
   positive refs (e.g. "foo", foo in "bar..foo", foo and bar in
   "bar...foo") you give to rev-list and/or log family of
   commands, after reachability analysis with negative refs
   (e.g. "^foo", bar in "bar..foo", merge-base of foo and bar in
   "bar...foo") if present.

 - We output the latest one among output candidates.  The
   parents of the commit we output go through the reachability
   analysis and the ones that are reachable from any of the
   negative refs are removed.  The ones that survive this
   reachability analysis are added to the output candidates.
   And the process starts over.  The algorithm terminates when
   there is none.

In practice, because child commits tend to get later commit
timestamps than all of their parent commits, the output looks
mostly reverse chronological.
