From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Wed, 14 May 2008 11:10:19 +0200
Message-ID: <18474.44155.823000.368851@lapjr.intranet.kiel.bmiag.de>
References: <20080512122900.GA13050@mithlond.arda.local>
	<20080512155243.GA3592@mithlond.arda.local>
	<alpine.DEB.1.00.0805121810501.30431@racer>
	<20080512184334.GB5160@mithlond.arda.local>
	<alpine.LFD.1.10.0805121453250.23581@xanadu.home>
	<20080512190946.GC5160@mithlond.arda.local>
	<alpine.LFD.1.10.0805121527550.23581@xanadu.home>
	<20080512202414.GA8620@mithlond.arda.local>
	<20080512210304.GA17352@glandium.org>
	<20080512210807.GA22221@glandium.org>
	<20080513001252.GB29038@spearce.org>
	<alpine.LFD.1.10.0805132005550.23581@xanadu.home>
	<7vy76dperf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Mike Hommey <mh@glandium.org>, Teemu Likonen <tlikonen@iki.fi>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 11:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwDPe-0004as-2L
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 11:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688AbYENJfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 05:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757385AbYENJfi
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 05:35:38 -0400
Received: from bilbo.bmiag.de ([62.154.210.131]:34502 "EHLO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756688AbYENJfg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 05:35:36 -0400
X-Greylist: delayed 1466 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 May 2008 05:35:36 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bilbo.bmiag.de (Postfix) with ESMTP id 165C83B61E;
	Wed, 14 May 2008 11:11:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at bilbo.bmiag.de
Received: from bilbo.bmiag.de ([127.0.0.1])
	by localhost (bilbo.bmiag.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Widv0Ymy4k7w; Wed, 14 May 2008 11:10:57 +0200 (CEST)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.bmiag.de (Postfix) with ESMTP id 0A6BF3B61A;
	Wed, 14 May 2008 11:10:39 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 9EC403B787;
	Wed, 14 May 2008 11:10:39 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at
	eorl.intranet.kiel.bmiag.de
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl.intranet.kiel.bmiag.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S0hfA3ey1WVc; Wed, 14 May 2008 11:10:27 +0200 (CEST)
Received: from LAPJR (client174.vpn3.kiel.bmiag.de [10.1.3.174])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 870273B7F2;
	Wed, 14 May 2008 11:10:20 +0200 (CEST)
In-Reply-To: <7vy76dperf.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82092>

Junio C Hamano writes:
 > The output from rev-list is not surprising.  --unpacked=$this.pack implies
 > the usual --unpacked behaviour (i.e. only show unpacked objects by not
 > traversing into commits that are packed)

The problem is unconditional traversing into commits that are
unpacked. This behavior is immediately obvious if the packed blob in
the .keep pack is large. I've been using the following since the large
object discussion with Dana, but it might be completely broken (though
the test case is probably correct).

--

Previously --unpacked would filter on the commit level, ignoring whether the
objects comprising the commit actually were packed or unpacked.

This makes it impossible to store e.g. excessively large blobs in
different packs from the commits referencing them, since the next repack of
such a commit will suck all referenced blobs into the same pack.

This change moves the unpacked check to the output stage and no longer checks
the flag during commit traversal and adds a trivial test demonstrating the
problem.
---
 Note that t6009 is already taken, so it might be better to merge the test
 into one of the other rev-list tests.

 list-objects.c               |    6 ++++--
 revision.c                   |    2 --
 t/t6009-rev-list-unpacked.sh |   32 ++++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 4 deletions(-)
 create mode 100644 t/t6009-rev-list-unpacked.sh

diff --git a/list-objects.c b/list-objects.c
index c8b8375..b378c0f 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -146,7 +146,8 @@ void traverse_commit_list(struct rev_info *revs,
 
 	while ((commit = get_revision(revs)) != NULL) {
 		process_tree(revs, commit->tree, &objects, NULL, "");
-		show_commit(commit);
+		if (!revs->unpacked || !has_sha1_pack(commit->object.sha1, revs->ignore_packed))
+			show_commit(commit);
 	}
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object_array_entry *pending = revs->pending.objects + i;
@@ -173,7 +174,8 @@ void traverse_commit_list(struct rev_info *revs,
 		    sha1_to_hex(obj->sha1), name);
 	}
 	for (i = 0; i < objects.nr; i++)
-		show_object(&objects.objects[i]);
+		if (!revs->unpacked || !has_sha1_pack(objects.objects[i].item->sha1, revs->ignore_packed))
+			show_object(&objects.objects[i]);
 	free(objects.objects);
 	if (revs->pending.nr) {
 		free(revs->pending.objects);
diff --git a/revision.c b/revision.c
index 4231ea2..0e90d3b 100644
--- a/revision.c
+++ b/revision.c
@@ -1508,8 +1508,6 @@ enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked && has_sha1_pack(commit->object.sha1, revs->ignore_packed))
-		return commit_ignore;
 	if (revs->show_all)
 		return commit_show;
 	if (commit->object.flags & UNINTERESTING)
diff --git a/t/t6009-rev-list-unpacked.sh b/t/t6009-rev-list-unpacked.sh
new file mode 100644
index 0000000..6b65e83
--- /dev/null
+++ b/t/t6009-rev-list-unpacked.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='test git rev-list --unpacked --objects'
+
+. ./test-lib.sh
+
+# Create an unpacked commit that references a packed object.
+
+test_expect_success setup '
+	echo Hallo > foo &&
+	git add foo &&
+	test_tick &&
+	git commit -m "A" &&
+        git gc &&
+	echo Cello > bar &&
+	git add bar &&
+	test_tick &&
+	git commit -m "B"
+'
+
+test_expect_success \
+    'object list should contain foo' '
+    git rev-list --all --objects | grep -q "foo"
+'
+
+test_expect_success \
+    'unpacked object list should not contain foo' '
+    test_must_fail "git rev-list --all --unpacked --objects | grep -q \"foo\""
+'
+
+
+test_done
-- 
1.5.5.1.382.g7d84c
