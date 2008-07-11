From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/5] Don't display passwords on the console in
	fetch/push output
Date: Fri, 11 Jul 2008 03:20:04 +0000
Message-ID: <20080711032004.GC32319@spearce.org>
References: <1215670403-19191-1-git-send-email-spearce@spearce.org> <1215670403-19191-3-git-send-email-spearce@spearce.org> <200807102056.43912.robin.rosenberg@dewire.com> <200807102217.38459.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 05:21:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH9C5-0004Ve-FB
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 05:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbYGKDUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 23:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbYGKDUG
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 23:20:06 -0400
Received: from george.spearce.org ([209.20.77.23]:49539 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbYGKDUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 23:20:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A5AD638222; Fri, 11 Jul 2008 03:20:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807102217.38459.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88075>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
> index e022e57..632c8ad 100644
> --- a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
> +++ b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
> @@ -318,7 +318,7 @@ public class URIish {
>  			r.append(getUser());
>  			if (getPass() != null) {
>  				r.append(':');
> -				r.append(getPass());
> +				r.append("PASSWORD");
>  			}
>  		}
>  

I agree in theory, but the implementation isn't quite correct.
How about this instead?

--8<--
Avoid password leak from URIIsh

The toString() method is commonly used for dumping information. We
never ever want to use toString when the password is needed. By
masking out the password we avoid unintentional password leaks.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .../tst/org/spearce/jgit/transport/URIishTest.java |    3 ++-
 .../org/spearce/jgit/transport/RemoteConfig.java   |    2 +-
 .../src/org/spearce/jgit/transport/URIish.java     |   15 ++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
index a460418..2e5e847 100644
--- a/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
+++ b/org.spearce.jgit.test/tst/org/spearce/jgit/transport/URIishTest.java
@@ -214,7 +214,8 @@ public class URIishTest extends TestCase {
 		assertEquals("user", u.getUser());
 		assertEquals("pass", u.getPass());
 		assertEquals(33, u.getPort());
-		assertEquals(str, u.toString());
+		assertEquals(str, u.toPrivateString());
+		assertEquals(u.setPass(null).toPrivateString(), u.toString());
 		assertEquals(u, new URIish(str));
 	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index b0fd5b4..bb21511 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -150,7 +150,7 @@ public class RemoteConfig {
 
 		vlst.clear();
 		for (final URIish u : getURIs())
-			vlst.add(u.toString());
+			vlst.add(u.toPrivateString());
 		rc.setStringList(SECTION, getName(), KEY_URL, vlst);
 
 		vlst.clear();
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
index e022e57..54a0811 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
@@ -307,7 +307,20 @@ public class URIish {
 		return a.equals(b);
 	}
 
+	/**
+	 * Obtain the string form of the URI, with the password included.
+	 * 
+	 * @return the URI, including its password field, if any.
+	 */
+	public String toPrivateString() {
+		return format(true);
+	}
+
 	public String toString() {
+		return format(false);
+	}
+
+	private String format(final boolean includePassword) {
 		final StringBuilder r = new StringBuilder();
 		if (getScheme() != null) {
 			r.append(getScheme());
@@ -316,7 +329,7 @@ public class URIish {
 
 		if (getUser() != null) {
 			r.append(getUser());
-			if (getPass() != null) {
+			if (includePassword && getPass() != null) {
 				r.append(':');
 				r.append(getPass());
 			}
-- 
1.5.6.2.393.g45096

-- 
Shawn.
