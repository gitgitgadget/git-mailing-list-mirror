From: Junio C Hamano <gitster@pobox.com>
Subject: [WIP PATCH 0/6] Merging with D/F conflicts
Date: Sat, 19 Sep 2009 22:06:09 -0700
Message-ID: <1253423175-6339-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 20 07:06:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpEdG-00044A-76
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 07:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbZITFGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 01:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbZITFGS
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 01:06:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZITFGR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 01:06:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F39B057554
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=+8/6Oy5RZCabGM4ME+ux+ug46YU
	=; b=l9Igr3nb0X957OXZmgfeLAo4//Wi94aUIHIdPZJmdeqiihcRf6A6gLAgpPZ
	wYCFgOAxRWyupu0B3qpEPQAff4ssxGBEVG3ztuz2PAoBv0i8GkiZjQB5xnYcw5lm
	3Y12BoCzM0NUrlOY8nPlblHG0RsF9hoA/kqosuQnsYD77Pso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=S5NChueQ65iOJRkov0yEMaZ1a0oZv
	cXJD3vvRz3CifUXm+wIWiMliD1WiHTXUT9NnrFcuyKSL6NwaOsSiRa9pyBxY11JX
	9LNwb2pEf5uiZwZ+g0Mtd5+tppIY3wQR7fDSxAYzGWwKRxyANLpkh/VIpetVLsao
	bW8tnY7lqqehgs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EEDDA57553
	for <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 649DB57552 for
 <git@vger.kernel.org>; Sun, 20 Sep 2009 01:06:19 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.90.ga3b1b
X-Pobox-Relay-ID: 556F92CA-A5A3-11DE-901B-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128836>

I have been working on this on-and-off and it still is not finished, but I
thought it would be a good place to stop, especially since this will not
be part of the upcoming 1.6.5 anyway.

The first three patches are preparatory clean-ups.

The fourth patch roughly corresponds to Linus's 880386c (Prepare
'traverse_trees()' for D/F conflict lookahead, 2009-09-06), but it does
implement multi-entry lookahead.  It reveals why lookahead on the tree
side alone is not sufficient by breaking a few tests.

The fifth one starts to compensate for the change in the tree side by
preparing the side that walks the index for a similar lookahead mechanism,
but it does not actually implement the lookahead yet.

The last one is a debugging patch.

This change has to break the output order (but not content) of the
diff-index somewhat.  If you had this:

    Index    Tree
    b        b-2/c
    b-2      b/d

the expected output order from diff-index is b, b-2, b-2/c, then b/d.  But
if you walk the tree and the index in parallel, we would end up showing b,
b/d, b-2 and then b-2/c.  A sad part of the story is that diff-index
always emits D/F conflicted entries as two independent records, so it is
rather a bad match to the unpack_trees() framework to begin with.

The patches are designed to apply on 79b4fde (Merge branch 'maint',
2009-09-03).

Junio C Hamano (6):
  diff-lib.c: fix misleading comments on oneway_diff()
  unpack-trees: typofix
  unpack_callback(): use unpack_failed() consistently
  traverse_trees(): handle D/F conflict case sanely
  unpack-trees.c: prepare for looking ahead in the index
  read-tree --debug-unpack

 builtin-read-tree.c |   36 +++++++
 cache.h             |    2 +
 diff-lib.c          |   20 +----
 tree-walk.c         |  277 +++++++++++++++++++++++++++++++++++++++++++--------
 unpack-trees.c      |  275 ++++++++++++++++++++++++++++++++++++++------------
 unpack-trees.h      |    3 +-
 6 files changed, 484 insertions(+), 129 deletions(-)
