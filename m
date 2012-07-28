From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] null sha1 in trees
Date: Sat, 28 Jul 2012 11:01:32 -0400
Message-ID: <20120728150132.GA25042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 17:02:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv8XC-0000TR-Lm
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 17:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642Ab2G1PBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 11:01:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40013 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401Ab2G1PBl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 11:01:41 -0400
Received: (qmail 31187 invoked by uid 107); 28 Jul 2012 15:01:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Jul 2012 11:01:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Jul 2012 11:01:32 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202440>

I recently came across a tree in the wild that had a submodule entry
whose sha1 was the null sha1 (i.e., all-zeros). It triggered an
interesting bug in the diff code, which is fixed by patch 1.

Unfortunately, I have no clue how this tree came about. I'm assuming it
was simply a bug somewhere in git, where the entry should have had
another sha1, or possibly been removed from the tree entirely.. Patches
2 and 3 tighten up our checks for null sha1s in a few places, which
might help detect such a bug earlier.

I assume I have never seen this with a non-submodule entry because such
a tree would fail the usual connectivity checks during fsck or during a
transfer. However, since we don't enforce connectivity on submodule
entries, nothing blocked the creation and propagation of such an entry.

I'm not at liberty to share the repository in question, but if anybody
has specific things to look for, I'd be happy to investigate further.

The patches are:

  [1/3]: diff: do not use null sha1 as a sentinel value

This is the actual bug-fix, and I hope is obviously a good thing to do.

  [2/3]: do not write null sha1s to on-disk index

This one tries to tighten our writing a bit. There are unfortunately a
lot of different code paths that create trees in git. I hope by catching
the index write as a choke-point, we can prevent bugs from spreading.
However, there are a lot of tree-writers that update an index in-core
and then write a tree out directly. I would not be surprised if this
does not catch the bug by itself, but I think it is a step in the right
direction.

  [3/3]: fsck: detect null sha1 in tree entries

And this one will at least let us notice the bug once it has happened.
And if transfer.fsckObjects is set, it will prevent bogus trees from
passing between repositories, containing any damage.

-Peff
