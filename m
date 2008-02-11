From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Technical details about the index file format.
Date: Mon, 11 Feb 2008 07:28:55 +0100
Message-ID: <1202711335-12026-1-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 11 07:29:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOSAZ-0001Xo-Tk
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 07:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751839AbYBKG27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 01:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbYBKG26
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 01:28:58 -0500
Received: from [83.140.172.130] ([83.140.172.130]:16701 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbYBKG25 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 01:28:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 58A9D8006AA;
	Mon, 11 Feb 2008 07:28:56 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MmEcpnsT4dbM; Mon, 11 Feb 2008 07:28:55 +0100 (CET)
Received: from lathund.dewire.com (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id B9C90800690;
	Mon, 11 Feb 2008 07:28:55 +0100 (CET)
Received: by lathund.dewire.com (Postfix, from userid 500)
	id A063028D53; Mon, 11 Feb 2008 07:28:55 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc4.25.g81cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73471>

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/technical/index-format.txt |   91 ++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/index-format.txt

I believe the main index details are accurate. Anything else to explain. The
TREE section probably needs more details.

-- robin

diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
new file mode 100644
index 0000000..c57b382
--- /dev/null
+++ b/Documentation/technical/index-format.txt
@@ -0,0 +1,91 @@
+GIT index format
+================
+
+= The git index file has the following format
+
+  All binary numbers are in network byte order.
+
+   - A twelve byte header consisting of
+
+     4 byte signature:
+	The signature is { 'D', 'I', 'R', 'C' }
+
+     4 byte version number:
+	The current version is 2
+
+     32-bit number of index entries.
+
+   - An entry consists of
+
+     32-bit ctime seconds, the last time a file's metadata changed
+	this is stat(2) data
+
+     32-bit ctime nanoseconds (modulo 1G)
+	this is stat(2) data
+
+     32-bit mtime seconds, the last time a file's data changed
+	this is stat(2) data
+
+     32-bit mtime nanoseconds (modulo 1G)
+	this is stat(2) data
+
+     32-bit dev
+	this is stat(2) data
+
+     32-bit uid
+	this is stat(2) data
+
+     32-bit gid
+	this is stat(2) data
+
+     32-bit file size
+	This is the on-disk size from stat(2)
+
+     160-bit SHA-1 for the represented blob
+
+     A 16-bit field split into (high to low bits)
+
+	1-bit assume-valid flag
+
+	1-bit update-needed flag
+
+	2-bit stage (during merge)
+
+	12-bit name length
+
+     Name (variable length) - encoding is undefined
+
+     1-8 nul bytes as necessary to pad the entry to a multiple ot eight bytes
+     while keeping the name NUL-terminated.
+
+  - Extensions
+
+    The only know index extension today is a tree cache. It contains
+    pre-computes hashes for all trees that can be derived from the index
+
+    4 byte extension signature. If the first byte is 'A'..'Z' the
+    extension is optional and can be ignored.
+
+    32-bit size of the extension
+
+    Extension data
+
+  - 160-bit SHA-1 over the content of the index file before this checksum.
+
+
+== Tree cache
+
+  - Extension tag { 'T', 'R', 'E', 'E' }
+
+  - 32-bit size
+
+  - A number of entries
+
+     NUL-terminated tree name
+
+     Blank-terminated ASCII decimal number of entries in this tree
+
+     Newline-terminated position of this tree in the parent tree. 0 for
+     the root tree
+
+     160-bit SHA-1 for this tree and it's children
-- 
1.5.4.rc4.25.g81cc
