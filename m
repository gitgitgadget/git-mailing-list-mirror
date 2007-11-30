From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix a pathological case in git detecting proper renames
Date: Thu, 29 Nov 2007 16:40:21 -0800
Message-ID: <7v4pf4tvka.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net>
	<alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org>
	<28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org>
	<alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
	<41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org>
	<alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:40:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ixtvy-0003wy-VK
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:40:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbXK3Ak2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761644AbXK3Ak2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:40:28 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40395 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761539AbXK3Ak1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 19:40:27 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3F0A92F0;
	Thu, 29 Nov 2007 19:40:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A202E9B075;
	Thu, 29 Nov 2007 19:40:44 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 29 Nov 2007 15:03:06 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66578>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> For the fuzzy rename detection, we generate the full score matrix, and 
> sort it by the score, up front. So all the scoring - and more importantly, 
> all the sorting - has actually been done before we actually start looking 
> at *any* renames at all, so we cannot easily do the same thing I did for 
> the exact renames, namely to take into account _earlier_ renames in the 
> scoring. Because those earlier renames have simply not been done when the 
> score is calculated.

I think I've mentioned this before, but another thing we may want to do
is to give similarity boost to a src-dst pair if other files in the same
src directory are found to be renamed to the same dst directory.  That
is, if you have the same contents in the preimage at A/init.S and B/init.S,
and a similar contents appear in C/init.S in the postimage, instead of
randomly picking A/init.S over B/init.S as the source, we can notice
that A/Makefile was moved to C/Makefile (but B/Makefile was sufficiently
different from A/Makefile in the preimage), and favor A/init.S over
B/init.S as the rename source of C/init.S.

About the code structure, I think the very early draft of rename
detector did not do the full matrix, but iterated over dst to see if
there is a good src for it, picked the best src that is above the
threshold, and went on to next dst, like this:

	for (dst in dst candidates) {
        	best_src = NULL;
                best_score = minimum_score;
                for (src in src candidates) {
                	score = similarity(dst, src);
                        if (score > best_score)
                            best_src = src;
		}
		if (best_src) {
			match dst with src;
		}
	}

This was restructured in the current "full matrix first" form before the
rename detection logic first hit your tree, and I do not think it was
shown in the field to perform worse than the full matrix version.

We could do the current full matrix that does not take basename
similarity nor what other renames were detected first, and then use that
matrix result in order to primarily define the order of dst candidates
to process and run the above loop.  At that point, similarity between
dst and src does not need to be recomputed fully (the matrix would
record it).  Instead, we can tweak it to take other renames that already
have been detected (this includes "this src has already been used", and
"somebody nearby moved to the same directory") and basename similarity
to affect which possible src candidate to choose for each dst.
