From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <torarnv@gmail.com>
Subject: [JGIT PATCH] Fix AbstractTreeIterator path comparion betwen 'a' and 'a/b'
Date: Mon,  2 Feb 2009 21:13:37 +0100
Message-ID: <1233605617-14513-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 21:15:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU5C9-0006bK-1I
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 21:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbZBBUNf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2009 15:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbZBBUNf
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 15:13:35 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:50973 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753502AbZBBUNe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 15:13:34 -0500
Received: by fg-out-1718.google.com with SMTP id 16so701437fgg.17
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 12:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=TL8HQ+Pxj6I7RXJsRPBRjeum7CbPXXVSQCvP1RJYFdw=;
        b=w1AXQwFhRgy3WQtJBybysza1JU4fk6INkwrk4Hg1excnJV4M7vY7axU0o9pP5LNtkJ
         dsZanBfVrbzZATHGtdG75kEa4ZU45qVvBvE3IW80hSsoV0F32jvsV3OcwK2+IsUN/fYi
         qDPOAfz9I158X4iEaDzkuP7jkM01hwRKcKWGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=D/q8wh6Ga82aybBiygoVTf1x0/m4rEgzUpQEw9OE6IJ75gg+y1LjLh90xNkE8lcvu1
         Jy3ewjgtCN8g4aJZaIv4r4/hwS9U7idZf6ub61QJZrZQ+J1C1osap09zkILRksvwBuHx
         JiiJ3fuej9Rf2xotXbiKs1wfrZUcXkZGk3qSI=
Received: by 10.103.252.17 with SMTP id e17mr2073517mus.14.1233605611461;
        Mon, 02 Feb 2009 12:13:31 -0800 (PST)
Received: from monstre.mystifistisk.net (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id i5sm5546571mue.46.2009.02.02.12.13.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 12:13:30 -0800 (PST)
Received: by monstre.mystifistisk.net (Postfix, from userid 1000)
	id 4E36F468001; Mon,  2 Feb 2009 21:13:36 +0100 (CET)
X-Mailer: git-send-email 1.6.1.2.309.g2ea3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108115>

The occurance of a '/' as the next character in the longer path
does not neccecarily mean the two paths are equal, for example
when the longer path has more components following the '/'.

Signed-off-by: Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
---
 .../jgit/treewalk/AbstractTreeIteratorTest.java    |   93 ++++++++++++=
++++++++
 .../jgit/treewalk/AbstractTreeIterator.java        |    4 +-
 2 files changed, 95 insertions(+), 2 deletions(-)
 create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/treewalk=
/AbstractTreeIteratorTest.java

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/Abstra=
ctTreeIteratorTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/tr=
eewalk/AbstractTreeIteratorTest.java
new file mode 100644
index 0000000..4c74094
--- /dev/null
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/treewalk/AbstractTreeI=
teratorTest.java
@@ -0,0 +1,93 @@
+/*
+ * Copyright (C) 2009, Tor Arne Vestb=C3=B8 <torarnv@gmail.com>
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
+package org.spearce.jgit.treewalk;
+
+import java.io.IOException;
+
+import org.spearce.jgit.errors.IncorrectObjectTypeException;
+import org.spearce.jgit.lib.FileMode;
+import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryTestCase;
+
+
+public class AbstractTreeIteratorTest extends RepositoryTestCase {
+
+
+	public class FakeTreeIterator extends WorkingTreeIterator {
+		public FakeTreeIterator(String path, FileMode fileMode) {
+			super(path);
+			mode =3D fileMode.getBits();
+			pathLen -=3D 1; // Get rid of extra '/'
+		}
+
+		@Override
+		public AbstractTreeIterator createSubtreeIterator(Repository repo)
+				throws IncorrectObjectTypeException, IOException {
+			return null;
+		}
+
+	}
+
+	public void testPathCompare() throws Exception {
+
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a/b", FileMode.REGULAR_FILE)) < 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a//", FileMode.TREE)) =3D=3D 0);
+
+		assertTrue(new FakeTreeIterator("a/b", FileMode.REGULAR_FILE).pathCo=
mpare(
+				new FakeTreeIterator("a", FileMode.TREE)) > 0);
+
+		assertTrue(new FakeTreeIterator("a//", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a", FileMode.TREE)) =3D=3D 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathComp=
are(
+				new FakeTreeIterator("a", FileMode.TREE)) < 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) > 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.REGULAR_FILE).pathComp=
are(
+				new FakeTreeIterator("a", FileMode.REGULAR_FILE)) =3D=3D 0);
+
+		assertTrue(new FakeTreeIterator("a", FileMode.TREE).pathCompare(
+				new FakeTreeIterator("a", FileMode.TREE)) =3D=3D 0);
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTre=
eIterator.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/Abstrac=
tTreeIterator.java
index 2ff3b99..7dd3f38 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterat=
or.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/AbstractTreeIterat=
or.java
@@ -289,9 +289,9 @@ int pathCompare(final AbstractTreeIterator p, final=
 int pMode) {
 		}
=20
 		if (cPos < aLen)
-			return (a[cPos] & 0xff) - lastPathChar(pMode);
+			return ((a[cPos] & 0xff) - lastPathChar(pMode)) + (aLen - cPos - 1)=
;
 		if (cPos < bLen)
-			return lastPathChar(mode) - (b[cPos] & 0xff);
+			return (lastPathChar(mode) - (b[cPos] & 0xff)) - (bLen - cPos - 1);
 		return lastPathChar(mode) - lastPathChar(pMode);
 	}
=20
--=20
1.6.1.2.309.g2ea3
