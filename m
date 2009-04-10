From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: [JGIT PATCH] Added support for StrictHostKeyChecking property in SSH 
	config
Date: Fri, 10 Apr 2009 20:27:31 +0400
Message-ID: <85647ef50904100927k11d36945h1c5b2c63b4f35e26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 18:29:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsJbM-00012z-Iq
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 18:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935636AbZDJQ1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 12:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935474AbZDJQ1g
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 12:27:36 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:55814 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934147AbZDJQ1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 12:27:34 -0400
Received: by fk-out-0910.google.com with SMTP id 18so516671fkq.5
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=l4MyATlrsrFg6O3WxqPB9EGRBsRGGJkUIswZzDWWhxQ=;
        b=Hrhe9RK89SsbWNO6zjeXPuUW+Cq+FsfBMEOX+BtUFWI2PUrK4j/0U7LK5hLQ3NnxZP
         Gn/SXT+CoIcuqjbozU8k8D3cVOdw6OQF2x+YY1Chh0qU0XERzs7Ij/EPcJnVDxseiILY
         2pUBNSltX41/5v++0XFXwnHx/0kgN/NqOBibw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=DId3e+PTzthzOGsqh0Yaf9NBhAPlPtvFS1hU0+JaObicv5yPilSY68W8Oz33dkJL8D
         6ND2gIyLJTynBncVMo3UIyaYWxWrD3D06wmoMujgxfXlpc6U+4r+I7BPz+hAWTxq4S49
         E7lf6Jl/cVRYVFzPb8B29pj0Txtl7EEhavw54=
Received: by 10.204.56.4 with SMTP id w4mr3459999bkg.25.1239380851262; Fri, 10 
	Apr 2009 09:27:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116264>

StrictHostKeyChecking property allows to specify ssh behavior
when ssh client encounters a new host or a change of the host key.
Thus in addition to the default policy "ask", it is now possible to specify
"yes" and "no" policies that automatically reject and accept new host
keys.

Signed-off-by: Constantine Plotnikov <constantine.plotnikov@gmail.com>
---
This patch is needed for running JGit in the application server context.
The property allows suppressing appearance of known hosts message box
that does not makes sense in this context.

I'm working on more extensive patch that allows more flexible
configuration of SSH, but this is a minimal change required.

 .../jgit/transport/DefaultSshSessionFactory.java   |    4 +++-
 .../org/spearce/jgit/transport/OpenSshConfig.java  |   19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
index 0d522df..c9050fa 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/DefaultSshSessionFactory.java
@@ -103,7 +103,9 @@ public synchronized Session getSession(String
user, String pass,
 			session.setPassword(pass);
 		else if (!hc.isBatchMode())
 			session.setUserInfo(new AWT_UserInfo());
-
+		final String strictHostKeyCheckingPolicy = hc.getStrictHostKeyChecking();
+		if (strictHostKeyCheckingPolicy != null)
+			session.setConfig("StrictHostKeyChecking", strictHostKeyCheckingPolicy);
 		final String pauth = hc.getPreferredAuthentications();
 		if (pauth != null)
 			session.setConfig("PreferredAuthentications", pauth);
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
index 0d9f12f..eadcfd0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/OpenSshConfig.java
@@ -221,6 +221,11 @@ public Host lookup(final String hostName) {
 				for (final Host c : current)
 					if (c.batchMode == null)
 						c.batchMode = yesno(dequote(argValue));
+			} else if ("StrictHostKeyChecking".equalsIgnoreCase(keyword)) {
+				String value = dequote(argValue);
+				for (final Host c : current)
+					if (c.strictHostKeyChecking == null)
+						c.strictHostKeyChecking = value;
 			}
 		}

@@ -298,6 +303,8 @@ private File toFile(final String path) {

 		Boolean batchMode;

+		String strictHostKeyChecking;
+
 		void copyFrom(final Host src) {
 			if (hostName == null)
 				hostName = src.hostName;
@@ -311,9 +318,21 @@ void copyFrom(final Host src) {
 				preferredAuthentications = src.preferredAuthentications;
 			if (batchMode == null)
 				batchMode = src.batchMode;
+			if (strictHostKeyChecking == null)
+				strictHostKeyChecking = src.strictHostKeyChecking;
 		}

 		/**
+		 * @return the value StrictHostKeyChecking property, the valid values
+		 *         are "yes" (unknown hosts are not accepted), "no" (unknown
+		 *         hosts are always accepted), and "ask" (user should be asked
+		 *         before accepting the host)
+		 */
+		public String getStrictHostKeyChecking() {
+			return strictHostKeyChecking;
+		}
+		
+		/**
 		 * @return the real IP address or host name to connect to; never null.
 		 */
 		public String getHostName() {
-- 
1.6.0.2.1172.ga5ed0
