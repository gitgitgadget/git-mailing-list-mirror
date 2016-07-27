Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CE8203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 12:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbcG0Mjj (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 08:39:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:54489 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754421AbcG0Mji (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 08:39:38 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MeQ43-1bfOIr1kRb-00QF4A; Wed, 27 Jul 2016 14:39:34
 +0200
Date:	Wed, 27 Jul 2016 14:39:28 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t4130: work around Windows limitation
Message-ID: <5bd59ca2f87e388350f3c8fb17c9a287661cd055.1469623136.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:reSgsBLOz2ZPjCyuGpzNl8VGFJ/F+6S/FTndOL8gnToMkEAZn7M
 xK8r+JMFy3t0HOtLfPne+BMA2hqNMryNTlb/OayC40CwR7Tg6IrbqWamsh32WetcM4JcMsf
 a1t2peYFdWXcAAkGjt3GnV7Sk0eyiRa0dt71hxjz8pfqFsTGKuk4VrfgudBQ5hQNGWt6qAa
 nRUg1n9uWCbXl7FaaPzHQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:uk324qkpbjo=:9B9p7khSQeNWpmcSP1JPRE
 9i0uUdqN1jFTfnpDST8+wUzwKsQuVmxDrROesBhjMRZSLo4kHGUXoTJugG81h7KjcasUq+AKV
 DojkIX/vle/ofYznWLBjxbdrhBa1UFxgTbhpVAS2OOQg/SaB6h33g8sL6hIiebTsdEMY4dFSk
 eaabqfnSLUSoYLkBXI9Z6kNZNc0BF3ZGuHSZDuR2hrd6vMSsu47uYyBXwvbYqb0Eh1Ea0CxU2
 OVmMYpLUswtaG2X8RARyReSfMIobmm0is0r/ZP+/v708qZYq3DMCCLXOL2hLPfbHlZd+YBfX2
 GHbahUYavV0jZ1IOneFJ/VaVhB3RwmyGRL2A1FFGGqTeY0zq9kpTPSbZpuJACtsNzpIlcAbzW
 uahUOKdUW6PdfLdFeLNEfqJWpyewpQGZnlDslMHtfctVXqooMcejYb3MpWiaQ/pPBmnXh9TuK
 Tz8J045sD0ioznuGOIwNg5J5JAWdd+2zjVRlVy03jiqipDE7j5osUpzHnbDawFhJiOnqmGuKq
 9TKABhc7EdOzEAySqvXdtAy0izuKaXAsiweMy+1nP8AxucrYxM+RgyD5Z7L43xHZ595rH1DBg
 lfX+OUsGZthz0WHxwxa19dqCTQCEDXShwLklBCqO2RHT1M0rdSXBy8qiid1aMwAK17LIkyqFg
 /oeYRN6WZ000LK1bIrYG5XOKqycdd87i80VLsQMaMsOUdk+IpMqdXoI0DHxvRZ0K3kyq9Gv0/
 lrHC5XS92sE4itPyj6lvz2Wj0qNd37CR2U1ZgzY0hvkk1S7c2JL7qZUmRUYpcEERaGaJrcsHC
 wNOg23V
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Windows, it is already pretty expensive to try to recreate the stat()
data that Git assumes is cheap to obtain. To make things halfway decent
in performance, we even have to skip emulating the inode and to
determine the number of hard links.

This is not a huge problem, usually, as either the size or the mtime or
the ctime are tell-tale enough to say when a file has changed, and even
if not, those changes are typically made after the index file was
written, triggering a rehashing of the files' contents.

The t4130-apply-criss-cross-rename test case, however, requires the
inode to determine that files of equal size were swapped, as renaming
files does not update their mtime. And even if we use
nanosecond-precision mtimes on Windows, the file system's time
granularity is typically much coarser (100ms for NTFS, 2s for FAT).

That means that every once in a while, t4130 fails on Windows.

This patch provides the work-around by pretending that the index file
was written earlier than it actually was.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/t4130-mingw-v1
 t/t4130-apply-criss-cross-rename.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index d173acd..ee91af8 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -29,6 +29,14 @@ test_expect_success 'criss-cross rename' '
 '
 
 test_expect_success 'diff -M -B' '
+	if test_have_prereq MINGW
+	then
+		# On Windows it is prohbitively expensive to retrieve the
+		# equivalent of an "inode" when calling stat(), therefore we
+		# rely on mtime/ctime/size changes to let us know whether a
+		# file has changed, including the mtime relative to the index.
+		test-chmtime -1 .git/index
+	fi &&
 	git diff -M -B > diff &&
 	git reset --hard
 
@@ -52,6 +60,14 @@ test_expect_success 'criss-cross rename' '
 '
 
 test_expect_success 'diff -M -B' '
+	if test_have_prereq MINGW
+	then
+		# On Windows it is prohbitively expensive to retrieve the
+		# equivalent of an "inode" when calling stat(), therefore we
+		# rely on mtime/ctime/size changes to let us know whether a
+		# file has changed, including the mtime relative to the index.
+		test-chmtime -1 .git/index
+	fi &&
 	git diff -M -B > diff &&
 	git reset --hard
 '
-- 
2.9.0.281.g286a8d9

base-commit: 8c6d1f9807c67532e7fb545a944b064faff0f70b
