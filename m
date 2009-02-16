From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: [JGIT PATCH] 1/2 : (reworked) Externalizable/Serializable Items
Date: Mon, 16 Feb 2009 20:12:29 +0000
Message-ID: <320075ff0902161212s1980cd70r8cdc4c21550333ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 21:14:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ9qq-00006t-MH
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 21:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbZBPUMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 15:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbZBPUMd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 15:12:33 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:13367 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbZBPUMc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 15:12:32 -0500
Received: by mu-out-0910.google.com with SMTP id i10so939000mue.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=7it2Vh6/zUEBZtjpC7lKCWHmdh+NOdpN8VD4+h4uQkc=;
        b=LXJ0SEQoZBb03BLyKD5u4bPU3zOkdSOkdDqOFE9kXhTzOIp7nZr7jZIVGNPqItnsf7
         GYi0uCXOOUKNJINiVjghQJ2rETv5J2WF4NE+SRFQ29LNqJrLArmudCt/hI26Aec0MGl9
         f3FWL2/cEHRDs8yIypY8ATMUaBrQGlQYpTz5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Kal0gieFUjoodRoc1ntxRA0GX4fE4HL4E/F0jCKgXT4zOhnGrxBhMEwoqisARk3FiI
         Y0VkhvO06mweGXYUzDGRyFxAUUwyRiwrGZr7dc2FaRzSAwSR0V+3UZoi+E8dq2srN2Ah
         adVvhMC7YtOg8+anapD/+AD1EErBhsY+/3+NM=
Received: by 10.103.229.12 with SMTP id g12mr3174133mur.16.1234815149706; Mon, 
	16 Feb 2009 12:12:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110233>

JGit is used as a library in external projects such as build tools.
Some of the representations of git data structures are useful
in these external tools - but - it is often desirable to be able to
either persist these objects, or serialize them across the wire.

Apply Externalizable to URIish and RefSpec, and Serializable to
ObjectId and RemoteConfig (in order to avoid the undesirable
requirement of a public, no-args constructor needed for Externalizable).

 Signed-off-by: Nigel Magnay <nigel.magnay@gmail.com>

---
 .../src/org/spearce/jgit/lib/ObjectId.java         |   22 +++++-
 .../src/org/spearce/jgit/transport/RefSpec.java    |   77 +++++++++++++------
 .../org/spearce/jgit/transport/RemoteConfig.java   |   79 +++++++++++++++++++-
 .../src/org/spearce/jgit/transport/URIish.java     |   29 +++++++-
 4 files changed, 179 insertions(+), 28 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 52ce0d4..7c3b922 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -38,6 +38,10 @@

 package org.spearce.jgit.lib;

+import java.io.IOException;
+import java.io.ObjectInputStream;
+import java.io.ObjectOutputStream;
+import java.io.Serializable;
 import java.io.UnsupportedEncodingException;

 import org.spearce.jgit.util.NB;
@@ -45,7 +49,7 @@
 /**
  * A SHA-1 abstraction.
  */
-public class ObjectId extends AnyObjectId {
+public class ObjectId extends AnyObjectId implements Serializable {
 	private static final ObjectId ZEROID;

 	private static final String ZEROID_STR;
@@ -269,4 +273,20 @@ protected ObjectId(final AnyObjectId src) {
 	public ObjectId toObjectId() {
 		return this;
 	}
+
+	private void writeObject(ObjectOutputStream os)  throws IOException {
+		os.writeInt(w1);
+		os.writeInt(w2);
+		os.writeInt(w3);
+		os.writeInt(w4);
+		os.writeInt(w5);
+	}
+	
+	private void readObject(ObjectInputStream ois)  throws IOException {
+		w1 = ois.readInt();
+		w2 = ois.readInt();
+		w3 = ois.readInt();
+		w4 = ois.readInt();
+		w5 = ois.readInt();
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
index 521110b..0ee89b0 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RefSpec.java
@@ -37,6 +37,11 @@

 package org.spearce.jgit.transport;

+import java.io.Externalizable;
+import java.io.IOException;
+import java.io.ObjectInput;
+import java.io.ObjectOutput;
+
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.Ref;

@@ -46,7 +51,7 @@
  * A ref specification provides matching support and limited rules to rewrite a
  * reference in one repository to another reference in another repository.
  */
-public class RefSpec {
+public class RefSpec implements Externalizable {
 	/**
 	 * Suffix for wildcard ref spec component, that indicate matching all refs
 	 * with specified prefix.
@@ -109,30 +114,7 @@ public RefSpec() {
 	 *             the specification is invalid.
 	 */
 	public RefSpec(final String spec) {
-		String s = spec;
-		if (s.startsWith("+")) {
-			force = true;
-			s = s.substring(1);
-		}
-
-		final int c = s.indexOf(':');
-		if (c == 0) {
-			s = s.substring(1);
-			if (isWildcard(s))
-				throw new IllegalArgumentException("Invalid wildcards " + spec);
-			dstName = s;
-		} else if (c > 0) {
-			srcName = s.substring(0, c);
-			dstName = s.substring(c + 1);
-			if (isWildcard(srcName) && isWildcard(dstName))
-				wildcard = true;
-			else if (isWildcard(srcName) || isWildcard(dstName))
-				throw new IllegalArgumentException("Invalid wildcards " + spec);
-		} else {
-			if (isWildcard(s))
-				throw new IllegalArgumentException("Invalid wildcards " + spec);
-			srcName = s;
-		}
+		initializeFromString(spec);
 	}

 	/**
@@ -161,6 +143,42 @@ private RefSpec(final RefSpec p) {
 	}

 	/**
+	 * Initialize the ref specification from a string.
+	 *
+	 * @param spec
+	 *            string describing the specification.
+	 * @throws IllegalArgumentException
+	 *             the specification is invalid.
+	 */
+	private void initializeFromString(final String spec) {
+		srcName = null;
+		String s = spec;
+		if (s.startsWith("+")) {
+			force = true;
+			s = s.substring(1);
+		}
+
+		final int c = s.indexOf(':');
+		if (c == 0) {
+			s = s.substring(1);
+			if (isWildcard(s))
+				throw new IllegalArgumentException("Invalid wildcards " + spec);
+			dstName = s;
+		} else if (c > 0) {
+			srcName = s.substring(0, c);
+			dstName = s.substring(c + 1);
+			if (isWildcard(srcName) && isWildcard(dstName))
+				wildcard = true;
+			else if (isWildcard(srcName) || isWildcard(dstName))
+				throw new IllegalArgumentException("Invalid wildcards " + spec);
+		} else {
+			if (isWildcard(s))
+				throw new IllegalArgumentException("Invalid wildcards " + spec);
+			srcName = s;
+		}
+	}
+	
+	/**
 	 * Check if this specification wants to forcefully update the destination.
 	 *
 	 * @return true if this specification asks for updates without merge tests.
@@ -421,4 +439,13 @@ public String toString() {
 		}
 		return r.toString();
 	}
+
+	public void readExternal(ObjectInput in) throws IOException,
+			ClassNotFoundException {
+		initializeFromString(in.readUTF());	
+	}
+
+	public void writeExternal(ObjectOutput out) throws IOException {
+		out.writeUTF(toString());
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
index 5bbf664..899f73f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -38,6 +38,10 @@

 package org.spearce.jgit.transport;

+import java.io.IOException;
+import java.io.ObjectInputStream;
+import java.io.ObjectOutputStream;
+import java.io.Serializable;
 import java.net.URISyntaxException;
 import java.util.ArrayList;
 import java.util.Collections;
@@ -53,7 +57,7 @@
  * describing how refs should be transferred between this repository and the
  * remote repository.
  */
-public class RemoteConfig {
+public class RemoteConfig implements Serializable {
 	private static final String SECTION = "remote";

 	private static final String KEY_URL = "url";
@@ -382,4 +386,77 @@ public TagOpt getTagOpt() {
 	public void setTagOpt(final TagOpt option) {
 		tagopt = option != null ? option : TagOpt.AUTO_FOLLOW;
 	}
+	
+	private void writeObject(ObjectOutputStream os) throws IOException {
+
+	    // Name
+	    os.writeUTF(name);
+	
+	    // Key, Value pairs
+	    for (URIish uri : uris) {
+            os.writeUTF(KEY_URL);
+            os.writeUTF(uri.toPrivateString());
+        }
+
+        for (RefSpec refspec : fetch) {
+            os.writeUTF(KEY_FETCH);
+            os.writeUTF(refspec.toString());
+        }
+
+        for (RefSpec refspec : push) {
+        	os.writeUTF(KEY_PUSH);
+            os.writeUTF(refspec.toString());
+        }
+
+        os.writeUTF(KEY_UPLOADPACK);
+        os.writeUTF(uploadpack);
+
+        os.writeUTF(KEY_RECEIVEPACK);
+        os.writeUTF(receivepack);
+
+        os.writeUTF(KEY_TAGOPT);
+        os.writeUTF(tagopt.option());
+
+        // End marker
+        os.writeUTF("");
+    }
+
+    private void readObject(ObjectInputStream ois) throws IOException {
+		uris = new ArrayList<URIish>();
+        fetch = new ArrayList<RefSpec>();
+        push = new ArrayList<RefSpec>();
+        uploadpack = DEFAULT_UPLOAD_PACK;
+        receivepack = DEFAULT_RECEIVE_PACK;
+
+        name = ois.readUTF();
+
+		for (String key = ois.readUTF(); key.length() > 0; key = ois.readUTF()) {
+			String value = ois.readUTF();
+
+			if (key.equals(KEY_URL)) {
+				try {
+					uris.add(new URIish(value));
+				} catch (URISyntaxException e) {
+					throw new IOException("Invalid URI in RemoteConfig : "
+							+ value);
+				}
+			} else if (key.equals(KEY_FETCH)) {
+				fetch.add(new RefSpec(value));
+
+			} else if (key.equals(KEY_PUSH)) {
+				push.add(new RefSpec(value));
+
+			} else if (key.equals(KEY_UPLOADPACK)) {
+				uploadpack = value;
+
+			} else if (key.equals(KEY_RECEIVEPACK)) {
+				receivepack = value;
+
+			} else if (key.equals(KEY_TAGOPT)) {
+				tagopt = TagOpt.fromOption(value);
+			}
+
+		}
+
+    }
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
index b86e00c..6b85f45 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
@@ -38,6 +38,10 @@

 package org.spearce.jgit.transport;

+import java.io.Externalizable;
+import java.io.IOException;
+import java.io.ObjectInput;
+import java.io.ObjectOutput;
 import java.net.URISyntaxException;
 import java.net.URL;
 import java.util.regex.Matcher;
@@ -49,7 +53,7 @@
  * RFC 2396 URI's is that no URI encoding/decoding ever takes place. A space or
  * any special character is written as-is.
  */
-public class URIish {
+public class URIish implements Externalizable {
 	private static final Pattern FULL_URI = Pattern
 			.compile("^(?:([a-z][a-z0-9+-]+)://(?:([^/]+?)(?::([^/]+?))?@)?(?:([^/]+?))?(?::(\\d+))?)?((?:[A-Za-z]:)?/.+)$");

@@ -75,6 +79,16 @@
 	 * @throws URISyntaxException
 	 */
 	public URIish(String s) throws URISyntaxException {
+		initializeFromString(s);
+	}
+	
+	/**
+	 * Set fields from string based URI.
+	 *
+	 * @param s
+	 * @throws URISyntaxException
+	 */
+	private void initializeFromString(String s)  throws URISyntaxException {
 		s = s.replace('\\', '/');
 		Matcher matcher = FULL_URI.matcher(s);
 		if (matcher.matches()) {
@@ -357,4 +371,17 @@ private String format(final boolean includePassword) {

 		return r.toString();
 	}
+
+	public void readExternal(ObjectInput in) throws IOException,
+			ClassNotFoundException {
+	    try {
+			initializeFromString(in.readUTF());
+		} catch (URISyntaxException e) {
+			throw new IOException("Incorrect format URI");
+		}
+	}
+
+	public void writeExternal(ObjectOutput out) throws IOException {
+		out.writeUTF(format(true));
+	}
 }
-- 
1.6.0.2
