From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange merge failure (would be overwritten by merge / cannot
 merge)
Date: Sun, 06 Sep 2009 01:21:56 -0700
Message-ID: <7vvdjwbhzv.fsf@alter.siamese.dyndns.org>
References: <4AA17874.7090905@debian.org>
 <7vr5ul99o2.fsf@alter.siamese.dyndns.org> <20090904234552.GA43797@gmail.com>
 <7vab191dz1.fsf@alter.siamese.dyndns.org>
 <7vzl98vrmt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 06 10:22:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkD0u-0000aO-Mt
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 10:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbZIFIWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 04:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbZIFIWE
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 04:22:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZIFIWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 04:22:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A380281C4;
	Sun,  6 Sep 2009 04:22:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ge2DPQe7+a1fWdXwKHs/XVhgPEE=; b=qPLOugQsPxRotJVC84X1gPj
	5vdT2/edbs2/b8j3JKUGIJmC4ZJqH4GV5zcLKByeIhivBCaqcTaBOQRCt0m0ZifF
	v9AyYFnSbDblPucfPrVOzxushGGVmCVUPovcO5My/WxN7VPbm8yIbzhj7y1zW0yN
	Uiep6ZQ5ajzT0Xbwono8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uumU3lBSVwtHnZz897vkqV/4/A6kc99F1iWa4HNtrRrlJB+JZ
	sOPT173GiARA64CaYEKDAZ3pgMyzI03p0wnnGrLls60L4sgcKEajJmg3umAsWt8x
	H1jlpYvCPoPLvBTbrOZIDVBNRE4EsDj7bVbZEx+9GZBwIMD5A5RU9KL+Ao=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C14D281C3;
	Sun,  6 Sep 2009 04:22:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ADA9F281C1; Sun,  6 Sep
 2009 04:21:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5986D0D4-9ABE-11DE-BF8C-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127848>

I was looking at this loop in traverse_trees() from tree-walk.c

	for (i = 0; i < n; i++) {
		if (!t[i].size)
			continue;
		entry_extract(t+i, entry+i);
		if (last >= 0) {
			int cmp = entry_compare(entry+i, entry+last);

			/*
			 * Is the new name bigger than the old one?
			 * Ignore it
			 */
			if (cmp > 0)
				continue;
			/*
			 * Is the new name smaller than the old one?
			 * Ignore all old ones
			 */
			if (cmp < 0)
				mask = 0;
		}
		mask |= 1ul << i;
		if (S_ISDIR(entry[i].mode))
			dirmask |= 1ul << i;
		last = i;
	}

The logic to update last breaks down while merging these three trees:

    Tree #1: tree "t"
    Tree #2: blob "t"
             blob "t-f"
    Tree #3: blob "t-f"
             tree "t"

When looking at Tree #3, "last" points at "t" (blob) from Tree #2
and we decide "t-f" comes later than that to ignore it because "cmp > 0".

We instead somehow need to look ahead and find "t", while remembering to
revisit "t-f" from it in the later rounds (of an outer loop that has this
loop inside).

Also the second comparison to update last breaks down while merging these:

    Tree #1: blob "t-f" 
             tree "t"
    Tree #2: blob "t"
    Tree #3: blob "t"
             blob "t-f"

When looking at Tree #2, "last" points at "t-f" (blob) from Tree #1 and we
decide to use "t" because it sorts earlier.  We will match "t" from Tree #3
but we somehow need to go back to Tree #1 and look beyond "t-f" to find
the matchig "t" from there as well, while remembering that we need to
revisit "t-f" from it in the later rounds..

I am thinking about changing the function this way.

 (0) take an optional "candidate for the earliest name" from the caller,
     in a new member in traverse_info structure. unpack_callback() would
     give the path of the index entry it is looking at after stripping the
     leading paths as necessary.

 (1) find the "earliest name" N among the given trees (and the optional
     additional candidate from the above).  The "earliest" is computed by
     comparing names as if everything were a blob;

 (2) for each tree t[i], if the current entry entry[i] compares
     differently with N between the cases where the N were a blob and
     where N were a tree, and if entry[i] is a blob, a tree with the name
     N might be hidden behind it.  remember the current position so we can
     come back, and scan forward to find such tree (this does not have to
     run to the end of the tree), and if we do find one, then instead of
     saying "we do not have an entry with that name", use that tree in
     entry[i].  This will collect entries with name N from all trees in
     the entry[] array;

 (3) make the callback as usual; unpack_callback(), after processing this
     round with entries with name N, may or may not advance o->pos but if
     it did so, it would also update the "candidate for the earliest name"
     field passed back in the traverse_info structure to prepare for the
     next round.

 (4) traverse_trees() will go back to step (0).

The tricky part is step (1) and the latter half of step (2) to skip,
rewind, and avoid re-processing what was processed already after
rewinding, and the progress is much slower than I would like.
