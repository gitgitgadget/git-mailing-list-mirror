X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] xdl_merge(): fix and simplify conflict handling
Date: Tue, 05 Dec 2006 14:10:46 -0800
Message-ID: <7vvekqf0yh.fsf@assigned-by-dhcp.cox.net>
References: <456FD461.4080002@saville.com>
	<Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
	<456FDF24.1070001@saville.com>
	<Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
	<7vejri20mf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4575B32F.5060108@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
	<Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac22glzz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612052209030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 22:11:01 +0000 (UTC)
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612052209030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 5 Dec 2006 22:15:35 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33377>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GriV2-0004T2-3B for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:10:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757574AbWLEWKt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758542AbWLEWKt
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:10:49 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:60537 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1757574AbWLEWKs (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 17:10:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205221048.TQGF20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 17:10:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vAAx1V00F1kojtg0000000; Tue, 05 Dec 2006
 17:10:58 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Thanks.

Looking at some other cases after applying your patch, I noticed
that I really like one thing that your version does over what
RCS merge does.

With RCS merge, a run of lines that are modified the same way in
both branches appear twice, like this:

	<<< orig
        alpha
        bravo
        charlie
        ...
	x-ray
	yankee
        zulu
        ===
        alpha
        bravo
        charlie
        ...
        x-ray
        yankee
        zebra
        >>> new

The common part at the beginning (or at the end for that
matter) can be hoisted outside, to produce:

        alpha
        bravo
        charlie
        ...
	x-ray
	yankee
	<<< orig
        zulu
        ===
        zebra
        >>> new

and your version seems to get this right.

When I had to deal with this kind of conflicts, I ended up
splitting the buffer in two, and ran M-x compare-windows to find
the true differences between the choices.  It was frustrating.
(I admit a big reason is I do not normally work in X environment
and do not tend to use xdiff -U or Kompare).

This is especially noticeable when recreating diff-delta.c merge
conflict in commit b485db98.  It's fun to see this large hunk
reduced down to only two lines ;-).

<<<<<<< HEAD/diff-delta.c
	/*
	 * Determine a limit on the number of entries in the same hash
	 * bucket.  This guard us against patological data sets causing
	 * really bad hash distribution with most entries in the same hash
	 * bucket that would bring us to O(m*n) computing costs (m and n
	 * corresponding to reference and target buffer sizes).
	 *
	 * The more the target buffer is large, the more it is important to
	 * have small entry lists for each hash buckets.  With such a limit
	 * the cost is bounded to something more like O(m+n).
	 */
	hlimit = (1 << 26) / trg_bufsize;
	if (hlimit < 16)
		hlimit = 16;

	/*
	 * Now make sure none of the hash buckets has more entries than
	 * we're willing to test.  Otherwise we short-circuit the entry
	 * list uniformly to still preserve a good repartition across
	 * the reference buffer.
	 */
	for (i = 0; i < hsize; i++) {
		if (hash_count[i] < hlimit)
			continue;
		entry = hash[i];
		do {
			struct index *keep = entry;
			int skip = hash_count[i] / hlimit / 2;
			do {
				entry = entry->next;
			} while(--skip && entry);
			keep->next = entry;
		} while(entry);
	}
	free(hash_count);

	return hash;
=======
	/*
	 * Determine a limit on the number of entries in the same hash
	 * bucket.  This guard us against patological data sets causing
	 * really bad hash distribution with most entries in the same hash
	 * bucket that would bring us to O(m*n) computing costs (m and n
	 * corresponding to reference and target buffer sizes).
	 *
	 * The more the target buffer is large, the more it is important to
	 * have small entry lists for each hash buckets.  With such a limit
	 * the cost is bounded to something more like O(m+n).
	 */
	hlimit = (1 << 26) / trg_bufsize;
	if (hlimit < 16)
		hlimit = 16;

	/*
	 * Now make sure none of the hash buckets has more entries than
	 * we're willing to test.  Otherwise we short-circuit the entry
	 * list uniformly to still preserve a good repartition across
	 * the reference buffer.
	 */
	for (i = 0; i < hsize; i++) {
		if (hash_count[i] < hlimit)
			continue;
		entry = hash[i];
		do {
			struct index *keep = entry;
			int skip = hash_count[i] / hlimit / 2;
			do {
				entry = entry->next;
			} while(--skip && entry);
			keep->next = entry;
		} while(entry);
	}
	free(hash_count);

	return hash-1;
>>>>>>> 38fd0721d0a2a1a723bc28fc0817e3571987b1ef/diff-delta.c

