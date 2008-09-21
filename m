From: Jonas Fonseca <fonseca@diku.dk>
Subject: [JGIT PATCH]  Test and fix handling of quotes in ~/.ssh/config
Date: Sun, 21 Sep 2008 13:25:19 +0200
Message-ID: <20080921112519.GA24200@diku.dk>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <20080920222958.GA18981@diku.dk> <bd6139dc0809201819o5d6eb5b1r7bf0e46702c711d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Sun Sep 21 13:34:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhNCP-0008CT-3K
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 13:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbYIULZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 07:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYIULZX
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 07:25:23 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:38302 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996AbYIULZW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 07:25:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0E64452C319;
	Sun, 21 Sep 2008 13:25:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gqty8-dNrj4p; Sun, 21 Sep 2008 13:25:19 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 5BEC152C2FE;
	Sun, 21 Sep 2008 13:25:19 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id C94B06DF823; Sun, 21 Sep 2008 13:24:51 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 3178C1DE6F3; Sun, 21 Sep 2008 13:25:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd6139dc0809201819o5d6eb5b1r7bf0e46702c711d7@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96391>

Removal of quoting had an off-by-one error, and was not handled for the
patterns used for the Host entry.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 .../spearce/jgit/transport/OpenSshConfigTest.java  |   26 ++++++++++++++++++++
 .../org/spearce/jgit/transport/OpenSshConfig.java  |    5 ++-
 2 files changed, 29 insertions(+), 2 deletions(-)

 Sverre Rabbelier <alturin@gmail.com> wrote Sun, Sep 21, 2008:
 > Heya,
 
 Allo, 
 
 > I'm not involved with JGit, so feel free to discared this mail :).
 
 Thanks, it made me dig a bit further, and find a bug.
 
 > On Sun, Sep 21, 2008 at 00:29, Jonas Fonseca <fonseca@diku.dk> wrote:
 > > -                       final String[] parts = line.split("[ \t=]", 2);
 > > +                       final String[] parts = line.split("[ \t]*[= \t]", 2);
 > 
 > Unless I'm guessing the purpose of this split wrong, wouldn't it be
 > even better to go for "[ \t]*=[ \t]+", or something like that (e.g.,
 > to allow for multiple tabs/spaces at the end as well).
 
 The code using the split result trims tabs and spaces at the end, so the
 main purpose of the regex is to find something that splits. This
 something can be tabs/spaces or _optionally_ one '='. 

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
index 8c1133d..ad6e79c 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/OpenSshConfigTest.java
@@ -105,6 +105,32 @@ config("Host\tfirst\n" +
 		assertEquals("last.tld", osc.lookup("last").getHostName());
 	}
 
+	public void testQuoteParsing() throws Exception {
+		config("Host \"good\"\n" +
+			" HostName=\"good.tld\"\n" +
+			" Port=\"6007\"\n" +
+			" User=\"gooduser\"\n" +
+			"Host multiple unquoted and \"quoted\" \"hosts\"\n" +
+			" Port=\"2222\"\n" +
+			"Host \"spaced\"\n" +
+			"# Bad host name, but testing preservation of spaces\n" +
+			" HostName=\" spaced\ttld \"\n" +
+			"# Misbalanced quotes\n" +
+			"Host \"bad\"\n" +
+			"# OpenSSH doesn't allow this but ...\n" +
+			" HostName=bad.tld\"\n");
+		assertEquals("good.tld", osc.lookup("good").getHostName());
+		assertEquals("gooduser", osc.lookup("good").getUser());
+		assertEquals(6007, osc.lookup("good").getPort());
+		assertEquals(2222, osc.lookup("multiple").getPort());
+		assertEquals(2222, osc.lookup("quoted").getPort());
+		assertEquals(2222, osc.lookup("and").getPort());
+		assertEquals(2222, osc.lookup("unquoted").getPort());
+		assertEquals(2222, osc.lookup("hosts").getPort());
+		assertEquals(" spaced\ttld ", osc.lookup("spaced").getHostName());
+		assertEquals("bad.tld\"", osc.lookup("bad").getHostName());
+	}
+
 	public void testAlias_DoesNotMatch() throws Exception {
 		config("Host orcz\n" + "\tHostName repo.or.cz\n");
 		final Host h = osc.lookup("repo.or.cz");
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index a9c6c12..b08d5c6 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -173,7 +173,8 @@ public Host lookup(final String hostName) {
 
 			if ("Host".equalsIgnoreCase(keyword)) {
 				current.clear();
-				for (final String name : argValue.split("[ \t]")) {
+				for (final String pattern : argValue.split("[ \t]")) {
+					final String name = dequote(pattern);
 					Host c = m.get(name);
 					if (c == null) {
 						c = new Host();
@@ -243,7 +244,7 @@ private static boolean isHostMatch(final String pattern, final String name) {
 
 	private static String dequote(final String value) {
 		if (value.startsWith("\"") && value.endsWith("\""))
-			return value.substring(1, value.length() - 2);
+			return value.substring(1, value.length() - 1);
 		return value;
 	}
 
-- 
1.6.0.2.444.gf2494


-- 
Jonas Fonseca
