From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH] Add test for OpenSshConfig separator parsing
Date: Sat, 20 Sep 2008 23:48:08 +0200
Message-ID: <20080920214808.GA7426@diku.dk>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Gilion Goudsmit <ggoudsmit@shebang.nl>
X-From: git-owner@vger.kernel.org Sat Sep 20 23:49:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhAKq-0003Bp-Jl
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 23:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754025AbYITVsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 17:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754105AbYITVsh
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 17:48:37 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:36108 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbYITVsM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 17:48:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id D19BB19BCBB;
	Sat, 20 Sep 2008 23:48:09 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28370-08; Sat, 20 Sep 2008 23:48:08 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 748AE19BC5F;
	Sat, 20 Sep 2008 23:48:08 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D20296DF823; Sat, 20 Sep 2008 23:47:41 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 5B7351DE6D9; Sat, 20 Sep 2008 23:48:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <12219428213749-git-send-email-ggoudsmit@shebang.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96368>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../spearce/jgit/transport/OpenSshConfigTest.java  |   22 ++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

 Gilion Goudsmit <ggoudsmit@shebang.nl> wrote Sat, Sep 20, 2008:
 > Having only tab-characters separating a key and value in the
 > users ~/.ssh/config would cause the config-parser to fail with
 > a "String index out of range: -1" exception. Also simplified
 > the line parsing code my using a two argument split.
 > 
 > Signed-off-by: Gilion Goudsmit <ggoudsmit@shebang.nl>

 A small test for this bug and FWIW:

 Tested-by: Jonas Fonseca <fonseca@diku.dk>

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
index 959b6b7..927c350 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -81,6 +81,28 @@ public void testNoConfig() {
 		assertNull(h.getIdentityFile());
 	}
 
+	public void testSeparatorParsing() throws Exception {
+		config("Host\tfirst\n" +
+		       "\tHostName\tfirst.tld\n" +
+		       "\n" +
+		       "Host second\n" +
+		       " HostName\tsecond.tld\n" +
+		       "Host=third\n" +
+		       "HostName=third.tld\n\n\n" +
+		       "\t Host = fourth\n\n\n" +
+		       " \t HostName\t=fourth.tld\n" +
+		       "Host\t =     last\n" +
+		       "HostName  \t    last.tld");
+		assertNotNull(osc.lookup("first"));
+		assertEquals("first.tld", osc.lookup("first").getHostName());
+		assertNotNull(osc.lookup("second"));
+		assertEquals("second.tld", osc.lookup("second").getHostName());
+		assertNotNull(osc.lookup("third"));
+		assertEquals("third.tld", osc.lookup("third").getHostName());
+		assertNotNull(osc.lookup("last"));
+		assertEquals("last.tld", osc.lookup("last").getHostName());
+	}
+
 	public void testAlias_DoesNotMatch() throws Exception {
 		config("Host orcz\n" + "\tHostName repo.or.cz\n");
 		final Host h = osc.lookup("repo.or.cz");
-- 
1.6.0.1.451.gc8d31


-- 
Jonas Fonseca
