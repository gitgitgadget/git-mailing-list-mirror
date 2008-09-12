From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH 3/3] Tests and fixes for dereferencing tags in
	Repository.resolve()
Date: Fri, 12 Sep 2008 12:57:50 +0200
Message-ID: <20080912105750.GC7945@diku.dk>
References: <20080911213927.GA20238@diku.dk> <200809120047.58484.robin.rosenberg.lists@dewire.com> <20080912000007.GA31931@diku.dk> <200809120847.13541.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 12:59:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6NH-0004X0-Tq
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbYILK5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYILK5z
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:57:55 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:46536 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750871AbYILK5w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 06:57:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 8399D19BBDB;
	Fri, 12 Sep 2008 12:57:51 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15261-19; Fri, 12 Sep 2008 12:57:50 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 39D9119BBD8;
	Fri, 12 Sep 2008 12:57:50 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 773C36DF845; Fri, 12 Sep 2008 12:57:36 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 1965D1A4001; Fri, 12 Sep 2008 12:57:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809120847.13541.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95708>

Fix Repository.resolve("tag^0") failing with "not a commit" (issue 23).
Add test for resolving "tag^{tree}" where "tag" points to a tag

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../spearce/jgit/test/resources/create-second-pack |    8 +++++
 ...ck-546ff360fe3488adb20860ce3436a2d6373d2796.idx |  Bin 0 -> 1324 bytes
 ...k-546ff360fe3488adb20860ce3436a2d6373d2796.pack |  Bin 0 -> 1265 bytes
 .../org/spearce/jgit/test/resources/packed-refs    |   18 ++++++++++++
 .../org/spearce/jgit/lib/RepositoryTestCase.java   |    1 +
 .../org/spearce/jgit/lib/T0008_testparserev.java   |   24 +++++++++++++---
 .../src/org/spearce/jgit/lib/Repository.java       |   29 ++++++++++++++++---
 7 files changed, 71 insertions(+), 9 deletions(-)
 create mode 100755 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.idx
 create mode 100755 org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.pack

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
index 03f83dc..052877d 100755
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/create-second-pack
@@ -130,6 +130,14 @@ git tag -a -m "An annotated tag" B a^
 
 git repack -d
 
+Bnth=B
+for nth in 2nd 3rd 4th 5th 6th 7th 8th 9th 10th; do
+	git tag -a -m "An $nth level annotated tag" "B$nth" "$Bnth"
+	Bnth="B$nth"
+done
+
+git repack -d
+
 git pack-refs --all
 
 
diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.idx b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.idx
new file mode 100755
index 0000000000000000000000000000000000000000..60331335d9bfa0a1830b707a36648bef5c434de9
GIT binary patch
literal 1324
zcmexg;-AdGz`z8=$bb>ZAqRuZp#(Dn^^fAA69z26_@W191=>SP%my@{7MLAqE<Vfw
zl&1#f1e!w;X4YY|dF;|=I?wL$m7h-!sqTEZ<d9&&_9~CduXH0eIHz>W9kWfyv-_p!
zv#wIbI9*p`^SYhiW29dAUv<;y{p*xDuUg<~#xJ>b`&8x`zwBKhx4ihQ?%X{KcsVL<
z*YFlFEt$`vabSO-^6v8ETNhV;zc)u{a%i8O%KaTz{TT9gzn`-G^3t<m7ehWi`_T7$
z%3Tq!Pi?N+f3xHkX!Dx8?ztTrH~0O!2|ktHQ>@q~%ak20yBn$`^kUD!HJ!YI+u~xG
z#9o?rd|dq5SNQJQ6X*6S#cq>&Bkj`oHC|ie7cg9SfZ6FZFqwt|X-8nOwhV~nfyI;o
zP;MHK-r4$UqjsNj$nyU7-?sZdXU_VTp1EB`)i!yC7FVXKnZSo5`dp8Uf9ZS%0H$+^
A0RR91

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.pack b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/pack-546ff360fe3488adb20860ce3436a2d6373d2796.pack
new file mode 100755
index 0000000000000000000000000000000000000000..203c157657b7f48faaaf23b794ce68264f3fd6a8
GIT binary patch
literal 1265
zcmV<N1P=R9K|@Ob00062000Td33!|x%uNo0Kny_P{hXo~kWA+XBr!xhgC3wm3&a3J
zNHuzU!Np6y)ywHAodPq4K)pMcA-dFaNhoApvh1r6Q^zUBC^Z}Xt^!Jf*@GKe9S;q%
zK?@JKk9mU&6|X{fUFAdbI!V#xxdB9UHG1?OPPVevn0A3<0F%6B0$P@=q{9FG57Q|w
z8^#HEoE?l?4#FT10RK6~UO)m}2_-ScdImiJkEM;F&@`*j+lzioGCwmdJSZ}RZ1jL3
zSQ~9H9<9qZk&Ak8Xv|1R!!hMB3jS;a>}Sz|tK;P-Gwm?J9d1k8;pF90a<>b;{kj#B
zv8`v&y1z7PL^vp`ln_&e-b0}m74Wq-_DtzN{{n1~EsMqpc$^)KK?=e!5CHFa#eTrD
zNeXE|#QFw(z&5+KNSc(givHf{VPGyZb$Uorpb&gw$C0N*h>Syso+%**L`QwRWABE9
zMn9W?(rg-V8Fcx{EIW*FgX>avI8yiQwAoqSv~F3tRM!(&YhAS7dJhL|Q)9*gt%ocx
z$v~x4B^Cb9zhPJ{V8#h}oE?lo4uUWg1@}G0zksCQwjhZi;u-V+Eq#R;XbJfmy}jsS
zlG)6Z@W3DxorTslLO^P5Xrl3Mh^~(8Y+}?&pO8Xpm3&r^_)+c9wUOy3BR1;kPPeIS
zboSM=lHD$N`(>R`4Q1(wnU5_SHiizm(ORiK)85mJ7iRJ~7x9AlpML?Z4lWGF33!|x
zj9UuAFc1L$bBeuyA)BWGDb_RS0n&7Bkv1u16}`RDkAeA_sl$UZ1Ko+DvN=RML~D}r
z(O?cfyWq#sIjvFCama!{8v&<DG~nWS{>el;^l*dgTz5Dn`IOx3Oz*UA3&~v94iHgC
zG-wPQR8UHYzCi0?p%*QXN~xTf#{c{aKCmqy#tC?w9gJNLf-n#U-+PL^fTT<LX%j=l
zGw1;p`T;RO30aNaUi4v-d6`Mw1HF=uLoD(t1k@c{l$9TZA?T170nQ=#D4t>Tvw>7b
zb3oTpr=N`2siiyJrnJ*pvS+4;UGSD=o00WtX^5Hgz>b}xldY{ard{diX~qjP$+{*L
zMf}gdnE5T|#tC?w9gRT_!XOYu_ncxbAb}1-O^mUgK@Tv%*v7QbG^5emi!NUBHt+u$
zADjfN4JL*_uFuHS<$WKGL+|=%IeE<9ct*aHlF!N@G^z$%oJ>C%d4mCNaGmM~N77F%
z&CdL$Wt~~4x}4gB?G6?#BJ4~sMya7d>tW^>&p@SAA>sTV{{lSeEjGppc$^)KK@P$o
z5CHGIVm}~ZSy~`5#`*?*z!tVOrY%i_Mt^VhFv(nIO8<~l!J<nnK3YfAdYf(NiKUN&
zZxXTuH{`~(HmLep1uBnf2QIYbpNz6W2RFFh%LYf*PhEFA%bVwQ5}nF?0z|YC35nof
zyfI333+z2i@{$R7SxV(9`9J>xFz+o1#tC?w9gIN=!Y~j3?|H?3z_OcEvjq|B8}tF2
zWT{A-loCaMZ}c!QmzfeC8Y__Z2S!G*jyNVBLXbXkV9&1ak<{X__vlRhtO`{o(}0W3
z=_iwJFv1P4_p-rJx@T9Lo%JotI%^lpasnc<137XIcIXj}88fsVW_{@ll5?q2HT~yb
by>=`Kh3c^@jzd(ZkB9p`zw>FD_Gf9gVWLq?

literal 0
HcmV?d00001

diff --git a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
index f67a3ef..746bd6b 100644
--- a/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
+++ b/org.spearce.jgit.test/tst-rsrc/org/spearce/jgit/test/resources/packed-refs
@@ -9,5 +9,23 @@ d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864 refs/heads/pa
 6db9c2ebf75590eef973081736730a9ea169a0c4 refs/tags/A
 17768080a2318cd89bba4c8b87834401e2095703 refs/tags/B
 ^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+032c063ce34486359e3ee3d4f9e5c225b9e1a4c2 refs/tags/B10th
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+214cae792433672d28b3aeb9f75c1ae84fd54628 refs/tags/B2nd
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+1170b77a48d3ea2d58b043648b1ec63d606e3efa refs/tags/B3rd
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+8dfd42699e7b10e568fa1eaebe249e33e98da81e refs/tags/B4th
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+efee904c794b943a06931c76c576dd552212e8bc refs/tags/B5th
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+d54e006ebbef94b7d3a5cd56d154f1e6f08efb94 refs/tags/B6th
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+a773cd2d9dbca00d08793dac0d7002a49f0428c0 refs/tags/B7th
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+bf5123bb77c7b5a379f7de9c1293558e3e24dfb8 refs/tags/B8th
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
+dd144af286452bfd6a1ea02b0d3745bcdb555e9d refs/tags/B9th
+^d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864
 8bbde7aacf771a9afb6992434f1ae413e010c6d8 refs/tags/spearce-gpg-pub
 ^fd608fbe625a2b456d9f15c2b1dc41f252057dd7
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
index 270b90a..9d7d133 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/RepositoryTestCase.java
@@ -141,6 +141,7 @@ public void run() {
 				"pack-34be9032ac282b11fa9babdc2b2a93ca996c9c2f",
 				"pack-df2982f284bbabb6bdb59ee3fcc6eb0983e20371",
 				"pack-9fb5b411fe6dfa89cc2e6b89d2bd8e5de02b5745",
+				"pack-546ff360fe3488adb20860ce3436a2d6373d2796",
 				"pack-e6d07037cbcf13376308a0a995d1fa48f8f76aaa"
 		};
 		final File packDir = new File(db.getObjectsDirectory(), "pack");
diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
index 506f51f..47105cf 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/lib/T0008_testparserev.java
@@ -106,14 +106,30 @@ public void testDerefCommit() throws IOException {
 	}
 
 	public void testDerefTag() throws IOException {
-		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{}").name());
-		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{blob}").name());
+		assertEquals("17768080a2318cd89bba4c8b87834401e2095703",db.resolve("refs/tags/B").name());
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B^{commit}").name());
+		assertEquals("032c063ce34486359e3ee3d4f9e5c225b9e1a4c2",db.resolve("refs/tags/B10th").name());
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B10th^{commit}").name());
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B10th^{}").name());
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B10th^0").name());
+		assertEquals("d86a2aada2f5e7ccf6f11880bfb9ab404e8a8864",db.resolve("refs/tags/B10th~0").name());
+		assertEquals("0966a434eb1a025db6b71485ab63a3bfbea520b6",db.resolve("refs/tags/B10th^").name());
+		assertEquals("0966a434eb1a025db6b71485ab63a3bfbea520b6",db.resolve("refs/tags/B10th^1").name());
+		assertEquals("0966a434eb1a025db6b71485ab63a3bfbea520b6",db.resolve("refs/tags/B10th~1").name());
+		assertEquals("2c349335b7f797072cf729c4f3bb0914ecb6dec9",db.resolve("refs/tags/B10th~2").name());
 	}
 
 	public void testDerefBlob() throws IOException {
+		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{}").name());
+		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("spearce-gpg-pub^{blob}").name());
 		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{}").name());
 		assertEquals("fd608fbe625a2b456d9f15c2b1dc41f252057dd7",db.resolve("fd608fbe625a2b456d9f15c2b1dc41f252057dd7^{blob}").name());
 	}
-	
-	// TODO: ^{tree} for a tag pointing to a tag
+
+	public void testDerefTree() throws IOException {
+		assertEquals("032c063ce34486359e3ee3d4f9e5c225b9e1a4c2",db.resolve("refs/tags/B10th").name());
+		assertEquals("856ec208ae6cadac25a6d74f19b12bb27a24fe24",db.resolve("032c063ce34486359e3ee3d4f9e5c225b9e1a4c2^{tree}").name());
+		assertEquals("856ec208ae6cadac25a6d74f19b12bb27a24fe24",db.resolve("refs/tags/B10th^{tree}").name());
+	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 894fe3b..dfce1b8 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -562,6 +562,11 @@ public ObjectId resolve(final String revstr) throws IOException {
 					case '9':
 						int j;
 						ref = mapObject(refId, null);
+						while (ref instanceof Tag) {
+							Tag tag = (Tag)ref;
+							refId = tag.getObjId();
+							ref = mapObject(refId, null);
+						}
 						if (!(ref instanceof Commit))
 							throw new IncorrectObjectTypeException(refId, Constants.TYPE_COMMIT);
 						for (j=i+1; j<rev.length; ++j) {
@@ -632,10 +637,10 @@ else if (item.equals("blob")) {
 							}
 							else if (item.equals("")) {
 								ref = mapObject(refId, null);
-								if (ref instanceof Tag)
-									refId = ((Tag)ref).getObjId();
-								else {
-									// self
+								while (ref instanceof Tag) {
+									Tag t = (Tag)ref;
+									refId = t.getObjId();
+									ref = mapObject(refId, null);
 								}
 							}
 							else
@@ -658,6 +663,11 @@ else if (item.equals("")) {
 					}
 				} else {
 					ref = mapObject(refId, null);
+					while (ref instanceof Tag) {
+						Tag tag = (Tag)ref;
+						refId = tag.getObjId();
+						ref = mapObject(refId, null);
+					}
 					if (ref instanceof Commit) {
 						final ObjectId parents[] = ((Commit) ref)
 								.getParentIds();
@@ -673,8 +683,17 @@ else if (item.equals("")) {
 				if (ref == null) {
 					String refstr = new String(rev,0,i);
 					refId = resolveSimple(refstr);
-					ref = mapCommit(refId);
+					if (refId == null)
+						return null;
+					ref = mapObject(refId, null);
+				}
+				while (ref instanceof Tag) {
+					Tag tag = (Tag)ref;
+					refId = tag.getObjId();
+					ref = mapObject(refId, null);
 				}
+				if (!(ref instanceof Commit))
+					throw new IncorrectObjectTypeException(refId, Constants.TYPE_COMMIT);
 				int l;
 				for (l = i + 1; l < rev.length; ++l) {
 					if (!Character.isDigit(rev[l]))
-- 
1.6.0.1.451.gc8d31

-- 
Jonas Fonseca
