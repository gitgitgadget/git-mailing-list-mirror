From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] - git-read-tree segfaults
Date: Thu, 12 Mar 2009 00:01:13 -0700
Message-ID: <7vfxhjjkcm.fsf@gitster.siamese.dyndns.org>
References: <35476bd20903101234q71bc520fh18828d7170a4a2f5@mail.gmail.com>
 <alpine.DEB.1.00.0903102120290.14295@intel-tinevez-2-302>
 <35476bd20903110059v7d6d8aa0g93af17a940c91919@mail.gmail.com>
 <alpine.DEB.1.00.0903111300330.10279@pacific.mpi-cbg.de>
 <7vtz5zjnai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiri Olsa <olsajiri@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 12 08:03:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhewQ-0003Wh-2j
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 08:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbZCLHB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 03:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752302AbZCLHBZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 03:01:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47926 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbZCLHBY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 03:01:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3675D51C2;
	Thu, 12 Mar 2009 03:01:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6A6AF51BE; Thu,
 12 Mar 2009 03:01:17 -0400 (EDT)
In-Reply-To: <7vtz5zjnai.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 11 Mar 2009 22:57:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 98CCBF32-0ED3-11DE-BFC7-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113008>

Junio C Hamano <gitster@pobox.com> writes:

> I suspect that the reason add_entry() passed SKIP_DFCHECK was to work
> around an old bug in add_index_entry() that considered it a D/F conflict
> if you have a file D at stage N and a file D/F at stage M when N and M are
> different.  I think such a bug has been fixed long time ago, and there is
> no reason for such a workaround.  Besides, OK_TO_REPLACE only makes sense
> when you do check D/F conflict ("replace" in the name of the flag means
> "If you want to add 'xxx/zzz' when the index has 'xxx', it is Ok to drop
> the existing 'xxx' in order to add your 'xxx/zzz''); it makes no sense to
> give it if you are giving SKIP_DFCHECK at the same time.

The ancient D/F conflict detection bug in add_cache_entry() I had in mind
was fixed by b155725 ([PATCH] Fix oversimplified optimization for
add_cache_entry()., 2005-06-25).  The use of SKIP_DFCHECK turns out to
have nothing to do with working that ancient bug around.

The real culprit seems to be 34110cd (Make 'unpack_trees()' have a
separate source and destination index, 2008-03-06).

Before that commit:

 * merge_entry() that records the final tree-level 3-way merge decision
   used to pass OK_TO_REPLACE without SKIP_DFCHECK.

 * unpack_nondirectories() codepath for non-merge multi-tree read-tree
   (the one under discussion in this thread) used to pass SKIP_DFCHECK but
   did not pass OK_TO_REPLACE.

The fact that even merge_entry() side passes SKIP_DFCHECK these days does
not appear to be a workaround for an old bug in D/F conflict detection
code after all; it simply is a bug in the refactoring done with the said
commit.

The unpack_nondirectories() codepath passed SKIP_DFCHECK from ee6566e
(Rewrite read-tree, 2005-09-05), which is the very original implementation
of the modern "read-tree A B C" code.  The ancient bug in the D/F conflict
detection code was killed way before that commit, and SKIP_DFCHECK in the
commit is not a workaround either; it also simply is a bug.

	Side note: I was somewhat surprised that "make test" of that old
	commit dates from September 2005 runs _much_ faster than the test
	suite we have these days.

The only sane use of SKIP_DFCHECK is when the caller knows the addition is
not introducing D/F conflict in the index to avoid the overhead.
