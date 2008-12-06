From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/6] Reusing "checkout [-m]" logic for "reset --merge"
Date: Fri,  5 Dec 2008 17:54:09 -0800
Message-ID: <1228528455-3089-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:55:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mOa-0005h5-01
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754399AbYLFByZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbYLFByZ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:54:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbYLFByY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:54:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 68E411830E;
	Fri,  5 Dec 2008 20:54:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 68BDC182CB; Fri, 
 5 Dec 2008 20:54:17 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.72.ga5ce6
X-Pobox-Relay-ID: CBB47A98-C338-11DD-981D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102433>

"checkout" that switches the branches, and "reset" that updates the HEAD,
have some similarities.  Their major difference is that "checkout" affects
which branch HEAD symref points at, while "reset" affects what commit such
a branch pointed at by the HEAD symref points at.  Interestingly, when
your HEAD is detached, they operate on the same thing.

They both change the commit pointed at by your HEAD from one commit to
another.  And what "checkout" and "reset --merge" do to the index and the
work tree while doing so are exactly the same.  Keep your local changes,
while updating everything else from what is in the current commit to the
one we are switching to.

There is one difference, though.

"reset --merge" does not have an equivalent of "checkout -m" that falls
back to three-way merge to resolve the conflicts at the content level.
This series, which is still a WIP, is an attempt to do so.

There are few things to notice that this series doesn't do:

 - What "reset --hard" and "checkout -f HEAD" do to the index and work
   tree (at least in naive thinking) ought to be the same.  This series
   does not attempt to unify these.

 - "reset --merge" is left as posted by Linus, and it does only "git
   checkout" equivalent, without "-m" (yet).

The latter can be enabled by changing a single line (see comment in
reset_index_file() in [Patch 6/6]), but I haven't done so yet.

While investigating for the former possibility, I noticed one interesting
thing what "checkout -f" does *NOT* do.  Starting with an index with
conflicts, "git checkout -f HEAD" keeps higher stage entries.

For example, you can insert "exit" before the "D/F resolve" test in t1004,
run the test (this leaves a handful higher stages in the index), go to the
trash directory and say "git checkout -f HEAD".

It leaves a single stage #1 entry (subdir/file2).  It probably is a bug in
unpack-trees, but I didn't take a very deep look at it.

Junio C Hamano (6):
  builtin-checkout.c: check error return from read_cache()
  read-cache.c: typofix in comment
  Make reset_tree() in builtin-checkout.c a bit more library-ish
  builtin-checkout.c: refactor merge_working_tree()
  builtin-commit.c: further refactor branch switching
  builtin-reset.c: use reset_index_and_worktree()

 builtin-checkout.c |  193 +++++++++++++++++++++++++++++-----------------------
 builtin-reset.c    |   66 +++++++++++++++++-
 read-cache.c       |    2 +-
 reset.h            |   11 +++
 4 files changed, 183 insertions(+), 89 deletions(-)
 create mode 100644 reset.h
