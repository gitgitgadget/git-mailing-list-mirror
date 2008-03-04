From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/2] Overly simplistic fix for issue with sha1_file_name() and
 switching repos
Date: Tue, 04 Mar 2008 04:05:04 +0100
Message-ID: <200803040405.04537.johan@herland.net>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org>
 <alpine.LNX.1.00.0803031318000.19665@iabervon.org>
 <200803040402.57993.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-1?q?H=F8gsberg?= <krh@redhat.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <sbejar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 04:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNTT-0004he-9d
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbYCDDFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYCDDFO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:05:14 -0500
Received: from smtp.getmail.no ([84.208.20.33]:41294 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbYCDDFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:05:13 -0500
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JX600L07R8OCV00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:05:12 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX6008DVR8GLO40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:05:04 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JX600FM6R8GMIA0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 04 Mar 2008 04:05:04 +0100 (CET)
In-reply-to: <200803040402.57993.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76021>

This is not a final fix, just an illustration of how synchronizing the
"char *base" holding the object directory does in fact fix the test
added by the previous patch. A real fix will explicitly reset "base"
when needed, without comparing with get_object_directory() on every
invocation. A real fix will also have to deal with the other similar
issue in this (and possibly other) file(s).

Signed-off-by: Johan Herland <johan@herland.net>
---
 sha1_file.c                |    5 +++--
 t/t5700-clone-reference.sh |    2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4ce4d9d..909226e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -161,9 +161,10 @@ char *sha1_file_name(const unsigned char *sha1)
 {
 	static char *name, *base;
 
-	if (!base) {
-		const char *sha1_file_directory = get_object_directory();
+	const char *sha1_file_directory = get_object_directory();
+	if (!base || prefixcmp(base, sha1_file_directory) != 0) {
 		int len = strlen(sha1_file_directory);
+		free(base);
 		base = xmalloc(len + 60);
 		memcpy(base, sha1_file_directory, len);
 		memset(base+len, 0, 60);
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index 40826ac..0c42d9f 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -134,7 +134,7 @@ git commit -m addition'
 
 cd "$base_dir"
 
-test_expect_failure 'cloning alternate repo #1, using #2 as reference' \
+test_expect_success 'cloning alternate repo #1, using #2 as reference' \
 'git clone --reference G F H'
 
 cd "$base_dir"
-- 
1.5.4.3.328.gcaed

