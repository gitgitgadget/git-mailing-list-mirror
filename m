From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some git performance measurements..
Date: Thu, 29 Nov 2007 21:00:21 -0800
Message-ID: <7v3auos4yi.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0711281747450.8458@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711281852160.8458@woody.linux-foundation.org>
	<alpine.LFD.0.99999.0711282244190.9605@xanadu.home>
	<alpine.LFD.0.9999.0711282022470.8458@woody.linux-foundation.org>
	<alpine.LFD.0.99999.0711291208060.9605@xanadu.home>
	<alpine.LFD.0.9999.0711290945060.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 06:00:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixxze-0007qm-Lq
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 06:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbXK3FA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 00:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbXK3FA2
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 00:00:28 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44787 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbXK3FA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 00:00:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 674252FA;
	Fri, 30 Nov 2007 00:00:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CC3FF95C55;
	Fri, 30 Nov 2007 00:00:44 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711290945060.8458@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 29 Nov 2007 09:48:19 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66613>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Umm. See my earlier numbers. For "git checkout" with cold cache, the 
> *bulk* of the time is actually the ".gitignore" file lookups, so if you 
> see a three-second improvement out of 17s, it may not look spectacular, 
> but considering that probably 10s of those 17s were something *else* going 
> on, I suspect that if you really did just a plain "git checkout", you 
> actually *do* have a spectacular improvement of roughly 7s -> 4s!

I am hoping that "probably 10s of those 17s" can actually be measured
with the patch I sent out last night.  Has anybody took a look at it?

Partitioning the pack data by object type shifts the tradeoffs from the
current "the data in the same tree are mostly together, except commits
are treated differently because rev walk is done quite often" layout.
Because we do not ever look at blob objects while pruning the history
(unless the -Spickaxe option is used, I think), partitioned layout would
optimize ancestry walking even more than the current packfile layout.

On the other hand, any operation that wants to look at the contents are
penalized.  A two-tree diff that inspects the contents (e.g. fuzzy
renames and pickaxe) needs to read from the tree section to find which
blob to compare with which other blob, and and then needs to seek to the
blob section to actually read the contents, while the current layout
tends to group both trees and blobs that belong to the same tree
together.  It is natural that blame is penalized by the new layout,
mostly because it needs to grab two blobs to compare from parent-child
pair, but also because it needs to find two-tree diffs for parent-child
pair it traverses whenever it needs to follow across renames (that is,
when it sees there is no corresponding path in the parent).  I would
expect to see similar slowdown from grep which wants to inspect blobs
that are in the same tree.

When I do archaeology, I think I often run blame first to see which
change made the block of text into the current shape first, and then run
a path limited "git log -p" either starting or ending at that revision.
In that workflow, the initial blame may get slower with the new layout,
but I suspect it would help by speeding up the latter "git log -p" step.
