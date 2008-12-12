From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH 09/15] Parse "GIT binary patch" style patch metadata
Date: Thu, 11 Dec 2008 18:46:15 -0800
Message-ID: <1229049981-14152-10-git-send-email-spearce@spearce.org>
References: <1229049981-14152-1-git-send-email-spearce@spearce.org>
 <1229049981-14152-2-git-send-email-spearce@spearce.org>
 <1229049981-14152-3-git-send-email-spearce@spearce.org>
 <1229049981-14152-4-git-send-email-spearce@spearce.org>
 <1229049981-14152-5-git-send-email-spearce@spearce.org>
 <1229049981-14152-6-git-send-email-spearce@spearce.org>
 <1229049981-14152-7-git-send-email-spearce@spearce.org>
 <1229049981-14152-8-git-send-email-spearce@spearce.org>
 <1229049981-14152-9-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 03:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAy51-00057A-6H
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 03:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436AbYLLCqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 21:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757375AbYLLCqq
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 21:46:46 -0500
Received: from george.spearce.org ([209.20.77.23]:41591 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226AbYLLCqb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 21:46:31 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id D93AA38222; Fri, 12 Dec 2008 02:46:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	OBSCURED_EMAIL autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id C211C38239;
	Fri, 12 Dec 2008 02:46:24 +0000 (UTC)
X-Mailer: git-send-email 1.6.1.rc2.306.ge5d5e
In-Reply-To: <1229049981-14152-9-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102869>

Git can produce binary patches that carry the full content or
delta information encoded in a base-85 text payload.  We parse
the headers out and produce a BinaryHunk wrapper for these so
applications can identify that the hunk exists, but we do not
attempt to decode the binary information.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/patch/PatchTest.java      |   42 ++++++
 .../spearce/jgit/patch/testParse_GitBinary.patch   |  135 ++++++++++++++++++++
 .../src/org/spearce/jgit/patch/BinaryHunk.java     |  128 +++++++++++++++++++
 .../src/org/spearce/jgit/patch/FileHeader.java     |   16 +++
 .../src/org/spearce/jgit/patch/Patch.java          |   32 +++++
 5 files changed, 353 insertions(+), 0 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinary.patch
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
index bf37063..453d88e 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/PatchTest.java
@@ -43,6 +43,7 @@
 import junit.framework.TestCase;
 
 import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.ObjectId;
 
 public class PatchTest extends TestCase {
 	public void testEmpty() {
@@ -157,6 +158,45 @@ assertTrue(fh.getNewName().startsWith(
 			assertSame(FileHeader.PatchType.BINARY, fh.getPatchType());
 			assertTrue(fh.getHunks().isEmpty());
 			assertTrue(fh.hasMetaDataChanges());
+
+			assertNull(fh.getForwardBinaryHunk());
+			assertNull(fh.getReverseBinaryHunk());
+		}
+
+		final FileHeader fh = p.getFiles().get(4);
+		assertEquals("org.spearce.egit.ui/plugin.xml", fh.getNewName());
+		assertSame(FileHeader.ChangeType.MODIFY, fh.getChangeType());
+		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
+		assertFalse(fh.hasMetaDataChanges());
+		assertEquals("ee8a5a0", fh.getNewId().name());
+		assertNull(fh.getForwardBinaryHunk());
+		assertNull(fh.getReverseBinaryHunk());
+		assertEquals(1, fh.getHunks().size());
+		assertEquals(272, fh.getHunks().get(0).getOldStartLine());
+	}
+
+	public void testParse_GitBinary() throws IOException {
+		final Patch p = parseTestPatchFile();
+		final int[] binsizes = { 359, 393, 372, 404 };
+		assertEquals(5, p.getFiles().size());
+
+		for (int i = 0; i < 4; i++) {
+			final FileHeader fh = p.getFiles().get(i);
+			assertSame(FileHeader.ChangeType.ADD, fh.getChangeType());
+			assertNotNull(fh.getOldId());
+			assertNotNull(fh.getNewId());
+			assertEquals(ObjectId.zeroId().name(), fh.getOldId().name());
+			assertSame(FileMode.REGULAR_FILE, fh.getNewMode());
+			assertTrue(fh.getNewName().startsWith(
+					"org.spearce.egit.ui/icons/toolbar/"));
+			assertSame(FileHeader.PatchType.GIT_BINARY, fh.getPatchType());
+			assertTrue(fh.getHunks().isEmpty());
+			assertTrue(fh.hasMetaDataChanges());
+
+			assertNotNull(fh.getForwardBinaryHunk());
+			assertNotNull(fh.getReverseBinaryHunk());
+			assertEquals(binsizes[i], fh.getForwardBinaryHunk().getSize());
+			assertEquals(0, fh.getReverseBinaryHunk().getSize());
 		}
 
 		final FileHeader fh = p.getFiles().get(4);
@@ -165,6 +205,8 @@ assertTrue(fh.getNewName().startsWith(
 		assertSame(FileHeader.PatchType.UNIFIED, fh.getPatchType());
 		assertFalse(fh.hasMetaDataChanges());
 		assertEquals("ee8a5a0", fh.getNewId().name());
+		assertNull(fh.getForwardBinaryHunk());
+		assertNull(fh.getReverseBinaryHunk());
 		assertEquals(1, fh.getHunks().size());
 		assertEquals(272, fh.getHunks().get(0).getOldStartLine());
 	}
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinary.patch b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinary.patch
new file mode 100644
index 0000000..ab7b235
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/patch/testParse_GitBinary.patch
@@ -0,0 +1,135 @@
+From 8363f12135a7d0ff0b5fea7d5a35d294c0479518 Mon Sep 17 00:00:00 2001
+From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
+Date: Tue, 23 Sep 2008 22:19:19 +0200
+Subject: [PATCH] Push and fetch icons for the toolbar
+
+Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
+Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
+---
+ org.spearce.egit.ui/icons/toolbar/fetchd.png |  Bin 0 -> 359 bytes
+ org.spearce.egit.ui/icons/toolbar/fetche.png |  Bin 0 -> 393 bytes
+ org.spearce.egit.ui/icons/toolbar/pushd.png  |  Bin 0 -> 372 bytes
+ org.spearce.egit.ui/icons/toolbar/pushe.png  |  Bin 0 -> 404 bytes
+ org.spearce.egit.ui/plugin.xml               |   32 ++++++++++++++-----------
+ 5 files changed, 18 insertions(+), 14 deletions(-)
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/fetchd.png
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/fetche.png
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/pushd.png
+ create mode 100644 org.spearce.egit.ui/icons/toolbar/pushe.png
+
+diff --git a/org.spearce.egit.ui/icons/toolbar/fetchd.png b/org.spearce.egit.ui/icons/toolbar/fetchd.png
+new file mode 100644
+index 0000000000000000000000000000000000000000..4433c543f2a52b586a3ed5e31b138244107bc239
+GIT binary patch
+literal 359
+zcmV-t0hs=YP)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003lNkl<ZIE|%~
+zF{;8q6h+U7BBn4qm_`dxuy6}@!NzsCfLTKp;5yPsN=p|I(rKe&p~M74Bq5ObRRW{%
+zje4sYc=ybGk2gYV%`a+{hvjnl6{!Lo4hNJ{A44jDl#(C_K2BmJ09dV7A3>VW2}+n!
+zO1rKr0DRxqm&=7b&q>piUayDaIKlvw2}+e_&-3(PFkmzq(Q380-|r+zg6Da9KA(#Q
+zPa2QMl^Gz*GK3HmMPby1VQ9_(U^bf>W`H=3+3)uhMZxuY<#al++wJIfyXFi47K?>p
+z2GCj~rNp*vI-L&fb{osGh@!|$@ci;S2_arv_(sil1xb<+1Odb0kjLY}`F!ShJaW6;
+z>Lr*?r);;|7ihoV2SC*MjhoFzuh;A9KAB9aMXCk(Pk$Loi}X0uxcmSB002ovPDHLk
+FV1lxPoI3yj
+
+literal 0
+HcmV?d00001
+
+diff --git a/org.spearce.egit.ui/icons/toolbar/fetche.png b/org.spearce.egit.ui/icons/toolbar/fetche.png
+new file mode 100644
+index 0000000000000000000000000000000000000000..0ffeb419e6ab302caa5e58661854b33853dc43dc
+GIT binary patch
+literal 393
+zcmV;40e1e0P)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003{Nkl<ZIE|%}
+z%Su8~6o$WjJd|h&)kLg8qatclklHDbhzOh%4SI>*L3{^aqJcvRqCsRQ6~SndH7ExK
+zk=KcyE?#y6(aupYt$(ujUi|ChXYD1Vl>A3Z=W-tL|B2KE=%pm#uoxNA1!yxqxEMW&
+zB>{jQO^yT+ogtn_{8Ep$Aq3h-C?o|y>g-6?-!e46K4}{7I2X6^?w$w$wKqXWo#uE<
+zlN$@u$mIiCW0N$hIYc2#Jf_L5pe_`875HfeP>nhW1zLv1R!iSvNdTZ7`q(*62#YbV
+zQhB;#V#z_Hl;tD;jPm%3!!_Fv=xqj&EpW_lqPo^m>_wFE9KxQ3t1@8v1#@h(gk?2k
+zU%h_@BTD_vVB{6b=^Lij^3<ya#!DI7eU*yg9xg#(&qL<HX{n_QH=dOmU|OU>Dkk>j
+n^=YB|UiI3T3toz$0fY1nZ1068v8@+b00000NkvXXu0mjfWwNMg
+
+literal 0
+HcmV?d00001
+
+diff --git a/org.spearce.egit.ui/icons/toolbar/pushd.png b/org.spearce.egit.ui/icons/toolbar/pushd.png
+new file mode 100644
+index 0000000000000000000000000000000000000000..22c3f7bf17b8b5a931c7527d768af13607b03bce
+GIT binary patch
+literal 372
+zcmV-)0gL{LP)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003yNkl<ZIE|%~
+zF{%PF6h%)&8w)Kgg)~~o6c%=-wG$iH;R0NP3veAG$Sh>A(?&%>K?5S92zkHxGyeyN
+zQSnxRymxZ%OQJ-CZ<LQ0VHnEcaNzNHaJ${8)oOIRUG)l}M1;v?B8^6aVzEe}P~dX8
+zV6A1h+tKg$Ga)&E`~8km3g?`+IiJs8M#ur2PA68Y70x-1$0OVAmgRCusZ@FoAR=h3
+zDVNJsDix~LD)oBZD;$r<sngD7(Utm(zh18y4u?;WOu&C>t%;)O$w?l-T1yl~1VO;{
+zdS$=gv)ODopU<8HfZ1#YAcMg`B@Q~B4vWRYJJDL}%|UCO8Yd6XZnu?)$aFeQidwCf
+z_mE--u|}hjN&o=H7-fukIg4hqnKXNVchu|kh_lCf`xbzwX88RJ-{>O;Y5D>6^@Sy#
+SDlMe|0000<MNUMnLSTZnn4{zX
+
+literal 0
+HcmV?d00001
+
+diff --git a/org.spearce.egit.ui/icons/toolbar/pushe.png b/org.spearce.egit.ui/icons/toolbar/pushe.png
+new file mode 100644
+index 0000000000000000000000000000000000000000..1f99f0a702983d674f15eedae5f1218f0a30b5a0
+GIT binary patch
+literal 404
+zcmV;F0c-w=P)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV00047Nkl<ZIE|%~
+z%Su8~6o$WjJO~|4C>w|sG%6%VHSk(UL<B+v4SI>*L41dvA&3Z?G>L*BB*n0rWDTl8
+zL8Pb?Jzc!)CSJ}#$rF8}#a?Uu`(JCbg_M&2pmu`H$+oP&=V*R^(bPY1%&ibu+ZV$G
+zgp`tt<A@B;jw3Z6E&C{q>NBF4=c=f%6i@vsq5!CR9fSfc-IT0lZ>^0`E2vbS?r{1v
+z8l^m+g%^~^H#FDePyq!%wm_SSqPmu`yJKk6QAXzdroz+R(7<gg074jZz1Vo3Dy2y#
+zMW2W=)MJ~7I|%3fPE-KBpis_UGqzZuUe(cG%h>L#RCJHY0YK_74TR+C&ZX!&h^>3c
+zJvdA^W^@l;f6eS*z&I*^D|{frVpE>&7273F76LY=;y1$BWF(Q0qALI}5jqkZAq&fh
+y^_oorR)}l`>CE22@+$y+&Cvb}|KU##2Jr)k?t0Dap2#Es0000<MNUMnLSTZgH?cGT
+
+literal 0
+HcmV?d00001
+
+diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
+index 7c98688..ee8a5a0 100644
+--- a/org.spearce.egit.ui/plugin.xml
++++ b/org.spearce.egit.ui/plugin.xml
+@@ -272,22 +272,26 @@
+         </separator>
+ 	    </menu>
+ 		<action
+-		       class="org.spearce.egit.ui.internal.actions.FetchAction"
+-		       id="org.spearce.egit.ui.actionfetch"
+-		       label="%FetchAction_label"
+-		       style="push"
+-		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
+-		       toolbarPath="org.spearce.egit.ui"
+-		       tooltip="%FetchAction_tooltip">
++        class="org.spearce.egit.ui.internal.actions.FetchAction"
++        disabledIcon="icons/toolbar/fetchd.png"
++        icon="icons/toolbar/fetche.png"
++        id="org.spearce.egit.ui.actionfetch"
++        label="%FetchAction_label"
++        menubarPath="org.spearce.egit.ui.gitmenu/repo"
++        style="push"
++        toolbarPath="org.spearce.egit.ui"
++        tooltip="%FetchAction_tooltip">
+ 		</action>
+ 		<action
+-		       class="org.spearce.egit.ui.internal.actions.PushAction"
+-		       id="org.spearce.egit.ui.actionpush"
+-		       label="%PushAction_label"
+-		       style="push"
+-		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
+-		       toolbarPath="org.spearce.egit.ui"
+-		       tooltip="%PushAction_tooltip">
++        class="org.spearce.egit.ui.internal.actions.PushAction"
++        disabledIcon="icons/toolbar/pushd.png"
++        icon="icons/toolbar/pushe.png"
++        id="org.spearce.egit.ui.actionpush"
++        label="%PushAction_label"
++        menubarPath="org.spearce.egit.ui.gitmenu/repo"
++        style="push"
++        toolbarPath="org.spearce.egit.ui"
++        tooltip="%PushAction_tooltip">
+ 		</action>
+ 		<action
+ 		       class="org.spearce.egit.ui.internal.actions.BranchAction"
+-- 
+1.6.1.rc2.306.ge5d5e
+
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
new file mode 100644
index 0000000..ce35286
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/BinaryHunk.java
@@ -0,0 +1,128 @@
+/*
+ * Copyright (C) 2008, Google Inc.
+ *
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or
+ * without modification, are permitted provided that the following
+ * conditions are met:
+ *
+ * - Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *
+ * - Redistributions in binary form must reproduce the above
+ *   copyright notice, this list of conditions and the following
+ *   disclaimer in the documentation and/or other materials provided
+ *   with the distribution.
+ *
+ * - Neither the name of the Git Development Community nor the
+ *   names of its contributors may be used to endorse or promote
+ *   products derived from this software without specific prior
+ *   written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
+ * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
+ * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
+ * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
+ * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
+ * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+package org.spearce.jgit.patch;
+
+import static org.spearce.jgit.lib.Constants.encodeASCII;
+import static org.spearce.jgit.util.RawParseUtils.match;
+import static org.spearce.jgit.util.RawParseUtils.nextLF;
+import static org.spearce.jgit.util.RawParseUtils.parseBase10;
+
+/** Part of a "GIT binary patch" to describe the pre-image or post-image */
+public class BinaryHunk {
+	private static final byte[] LITERAL = encodeASCII("literal ");
+
+	private static final byte[] DELTA = encodeASCII("delta ");
+
+	/** Type of information stored in a binary hunk. */
+	public static enum Type {
+		/** The full content is stored, deflated. */
+		LITERAL_DEFLATED,
+
+		/** A Git pack-style delta is stored, deflated. */
+		DELTA_DEFLATED;
+	}
+
+	private final FileHeader file;
+
+	/** Offset within {@link #file}.buf to the "literal" or "delta " line. */
+	final int startOffset;
+
+	/** Position 1 past the end of this hunk within {@link #file}'s buf. */
+	int endOffset;
+
+	/** Type of the data meaning. */
+	private Type type;
+
+	/** Inflated length of the data. */
+	private int length;
+
+	BinaryHunk(final FileHeader fh, final int offset) {
+		file = fh;
+		startOffset = offset;
+	}
+
+	/** @return header for the file this hunk applies to */
+	public FileHeader getFileHeader() {
+		return file;
+	}
+
+	/** @return type of this binary hunk */
+	public Type getType() {
+		return type;
+	}
+
+	/** @return inflated size of this hunk's data */
+	public int getSize() {
+		return length;
+	}
+
+	int parseHunk(int ptr) {
+		final byte[] buf = file.buf;
+
+		if (match(buf, ptr, LITERAL) >= 0) {
+			type = Type.LITERAL_DEFLATED;
+			length = parseBase10(buf, ptr + LITERAL.length, null);
+
+		} else if (match(buf, ptr, DELTA) >= 0) {
+			type = Type.DELTA_DEFLATED;
+			length = parseBase10(buf, ptr + LITERAL.length, null);
+
+		} else {
+			// Not a valid binary hunk. Signal to the caller that
+			// we cannot parse any further and that this line should
+			// be treated otherwise.
+			//
+			return -1;
+		}
+		ptr = nextLF(buf, ptr);
+
+		// Skip until the first blank line; that is the end of the binary
+		// encoded information in this hunk. To save time we don't do a
+		// validation of the binary data at this point.
+		//
+		final int sz = buf.length;
+		while (ptr < sz) {
+			final boolean empty = buf[ptr] == '\n';
+			ptr = nextLF(buf, ptr);
+			if (empty)
+				break;
+		}
+
+		return ptr;
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
index bf8d23a..a6ff4a6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/FileHeader.java
@@ -158,6 +158,12 @@
 	/** The hunks of this file */
 	private List<HunkHeader> hunks;
 
+	/** If {@link #patchType} is {@link PatchType#GIT_BINARY}, the new image */
+	BinaryHunk forwardBinaryHunk;
+
+	/** If {@link #patchType} is {@link PatchType#GIT_BINARY}, the old image */
+	BinaryHunk reverseBinaryHunk;
+
 	FileHeader(final byte[] b, final int offset) {
 		buf = b;
 		startOffset = offset;
@@ -270,6 +276,16 @@ void addHunk(final HunkHeader h) {
 		hunks.add(h);
 	}
 
+	/** @return if a {@link PatchType#GIT_BINARY}, the new-image delta/literal */
+	public BinaryHunk getForwardBinaryHunk() {
+		return forwardBinaryHunk;
+	}
+
+	/** @return if a {@link PatchType#GIT_BINARY}, the old-image delta/literal */
+	public BinaryHunk getReverseBinaryHunk() {
+		return reverseBinaryHunk;
+	}
+
 	/**
 	 * Parse a "diff --git" or "diff --cc" line.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
index 164ad96..56eb327 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/patch/Patch.java
@@ -62,6 +62,8 @@
 
 	private static final byte[] BIN_TRAILER = encodeASCII(" differ\n");
 
+	private static final byte[] GIT_BINARY = encodeASCII("GIT binary patch\n");
+
 	static final byte[] SIG_FOOTER = encodeASCII("-- \n");
 
 	/** The files, in the order they were parsed out of the input. */
@@ -268,6 +270,11 @@ private int parseHunks(final FileHeader fh, int c) {
 			}
 
 			final int eol = nextLF(buf, c);
+			if (fh.getHunks().isEmpty() && match(buf, c, GIT_BINARY) >= 0) {
+				fh.patchType = FileHeader.PatchType.GIT_BINARY;
+				return parseGitBinary(fh, eol);
+			}
+
 			if (fh.getHunks().isEmpty() && BIN_TRAILER.length < eol - c
 					&& match(buf, eol - BIN_TRAILER.length, BIN_TRAILER) >= 0
 					&& matchAny(buf, c, BIN_HEADERS)) {
@@ -295,6 +302,31 @@ private int parseHunks(final FileHeader fh, int c) {
 		return c;
 	}
 
+	private int parseGitBinary(final FileHeader fh, int c) {
+		final BinaryHunk postImage = new BinaryHunk(fh, c);
+		final int nEnd = postImage.parseHunk(c);
+		if (nEnd < 0) {
+			// Not a binary hunk.
+			//
+
+			// TODO handle invalid binary hunks
+			return c;
+		}
+		c = nEnd;
+		postImage.endOffset = c;
+		fh.forwardBinaryHunk = postImage;
+
+		final BinaryHunk preImage = new BinaryHunk(fh, c);
+		final int oEnd = preImage.parseHunk(c);
+		if (oEnd >= 0) {
+			c = oEnd;
+			preImage.endOffset = c;
+			fh.reverseBinaryHunk = preImage;
+		}
+
+		return c;
+	}
+
 	private static boolean matchAny(final byte[] buf, final int c,
 			final byte[][] srcs) {
 		for (final byte[] s : srcs) {
-- 
1.6.1.rc2.306.ge5d5e
