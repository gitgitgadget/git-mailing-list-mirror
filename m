From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: [JGIT PATCH] 1/2: Externalizable items
Date: Mon, 16 Feb 2009 16:45:55 +0000
Message-ID: <320075ff0902160845m264f78cdh8dc5307b24f4c3ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 16 17:47:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6dG-0005Eg-Jj
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZBPQqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbZBPQqS
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:46:18 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:45532 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZBPQqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:46:16 -0500
Received: by fxm13 with SMTP id 13so6101375fxm.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=C3PVr39Xc8M94A5MlhL3/36dBLaM6whaemsHXZ/2bqw=;
        b=wnX2ljH+CK/P1DOnKGfq0eQMgrQCuDcVE2wAs93K0No8RhLPE6VNArNkuRJcJBu7Xr
         PggWb3vepBETocFfKrYU0yHt8VRo3JCFQj3sfAkGBBhkt6UysvUdwLBuQLtjzWSxIvY/
         TZn3Vta2UfVXa6x07twWAz8+Cvc8aB3PR9ZWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ETVtM75P2jD6X1Dzh4Y4mOVbGWniuFiG3+Z3Q5KGBPBWG58WnpZRMsO84qRDaNWchq
         LY8vGxE81CE8NJUb1+IemUU/atgu/tLdzlYPj6q5Bj7b5Q8IxJHrdCKzSagGrKlrvz20
         fg/dVDV8Q6xERRsmVf+S9FYKocispJoCb4Xb4=
Received: by 10.103.119.19 with SMTP id w19mr3043178mum.80.1234802755474; Mon, 
	16 Feb 2009 08:45:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110207>

Make parts of jgit externalizable, so that they can be marshalled over
the wire or onto disk,
using formats from git mailing list.

Signed-off-by: Nigel Magnay <nigel.magnay@gmail.com>
---
 .../src/org/spearce/jgit/lib/ObjectId.java         |   31 ++++-
 .../src/org/spearce/jgit/transport/RefSpec.java    |   77 +++++++----
 .../org/spearce/jgit/transport/RemoteConfig.java   |  142 +++++++++++++++++++-
 .../src/org/spearce/jgit/transport/URIish.java     |   31 ++++-
 4 files changed, 252 insertions(+), 29 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
index 52ce0d4..1385325 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/ObjectId.java
@@ -38,6 +38,10 @@

 package org.spearce.jgit.lib;

+import java.io.Externalizable;
+import java.io.IOException;
+import java.io.ObjectInput;
+import java.io.ObjectOutput;
 import java.io.UnsupportedEncodingException;

 import org.spearce.jgit.util.NB;
@@ -45,7 +49,7 @@
 /**
  * A SHA-1 abstraction.
  */
-public class ObjectId extends AnyObjectId {
+public class ObjectId extends AnyObjectId implements Externalizable {
 	private static final ObjectId ZEROID;

 	private static final String ZEROID_STR;
@@ -56,6 +60,13 @@
 	}

 	/**
+	 * Empty constructor, for Externalizable.
+	 */
+	public ObjectId() {
+		// For Externalizable
+	}
+	
+	/**
 	 * Get the special all-null ObjectId.
 	 *
 	 * @return the all-null ObjectId, often used to stand-in for no object.
@@ -269,4 +280,22 @@ protected ObjectId(final AnyObjectId src) {
 	public ObjectId toObjectId() {
 		return this;
 	}
+
+	public void readExternal(ObjectInput in) throws IOException,
+			ClassNotFoundException {
+		byte[] sha1 = new byte[20];
+		in.read(sha1);
+		
+		w1 = NB.decodeInt32(sha1, 0);
+		w2 = NB.decodeInt32(sha1, 4);
+		w3 = NB.decodeInt32(sha1, 8);
+		w4 = NB.decodeInt32(sha1, 12);
+		w5 = NB.decodeInt32(sha1, 16);
+	}
+
+	public void writeExternal(ObjectOutput out) throws IOException {
+		byte[] sha1 = new byte[20];
+		copyRawTo(sha1, 0);
+		out.write(sha1);
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
index 5bbf664..22443b4 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/transport/RemoteConfig.java
@@ -38,10 +38,17 @@

 package org.spearce.jgit.transport;

+import java.io.Externalizable;
+import java.io.IOException;
+import java.io.ObjectInput;
+import java.io.ObjectOutput;
 import java.net.URISyntaxException;
 import java.util.ArrayList;
+import java.util.Collection;
 import java.util.Collections;
+import java.util.HashMap;
 import java.util.List;
+import java.util.Map;

 import org.spearce.jgit.lib.RepositoryConfig;

@@ -53,7 +60,7 @@
  * describing how refs should be transferred between this repository and the
  * remote repository.
  */
-public class RemoteConfig {
+public class RemoteConfig implements Externalizable {
 	private static final String SECTION = "remote";

 	private static final String KEY_URL = "url";
@@ -166,6 +173,17 @@ public RemoteConfig(final RepositoryConfig rc,
final String remoteName)
 	}

 	/**
+	 * Construct an empty remote config.
+	 */
+	public RemoteConfig() {
+		uris = new ArrayList<URIish>();
+		fetch = new ArrayList<RefSpec>();
+		push = new ArrayList<RefSpec>();
+		uploadpack = DEFAULT_UPLOAD_PACK;
+		receivepack = DEFAULT_RECEIVE_PACK;
+	}
+	
+	/**
 	 * Update this remote's definition within the configuration.
 	 *
 	 * @param rc
@@ -382,4 +400,126 @@ public TagOpt getTagOpt() {
 	public void setTagOpt(final TagOpt option) {
 		tagopt = option != null ? option : TagOpt.AUTO_FOLLOW;
 	}
+
+	private Map<String, Collection<String>> toMap() {
+		Map<String, Collection<String>> map = new HashMap<String,
Collection<String>>();
+		
+		if (uris.size() > 0) {
+			Collection<String> values = new ArrayList<String>();
+			for (URIish uri : uris) {
+				values.add(uri.toPrivateString());
+			}
+			map.put(KEY_URL, values);
+		}
+		
+		if (fetch.size() > 0) {
+			Collection<String> values = new ArrayList<String>();
+			for (RefSpec refspec : fetch) {
+				values.add(refspec.toString());
+			}
+			map.put(KEY_FETCH, values);
+		}
+		
+		if (push.size() > 0) {
+			Collection<String> values = new ArrayList<String>();
+			for (RefSpec refspec : push) {
+				values.add(refspec.toString());
+			}
+			map.put(KEY_PUSH, values);
+		}
+		
+		Collection<String> uploads = new ArrayList<String>(1);
+		uploads.add(uploadpack);
+		map.put(KEY_UPLOADPACK, uploads);
+		
+		Collection<String> receives = new ArrayList<String>(1);
+		receives.add(uploadpack);
+		map.put(KEY_RECEIVEPACK, receives);
+		
+		Collection<String> tag = new ArrayList<String>(1);
+		tag.add(tagopt.option());
+		map.put(KEY_TAGOPT, tag);
+		
+		
+		return map;
+	}
+
+	private void fromMap(Map<String, Collection<String>> map)
+			throws URISyntaxException {
+		for (Map.Entry<String, Collection<String>> entry : map.entrySet()) {
+			String key = entry.getKey();
+
+			if (key.equals(KEY_URL)) {
+				for (String value : entry.getValue()) {
+					uris.add(new URIish(value));
+				}
+			} else if (key.equals(KEY_FETCH)) {
+				for (String value : entry.getValue()) {
+					fetch.add(new RefSpec(value));
+				}
+			} else if (key.equals(KEY_PUSH)) {
+				for (String value : entry.getValue()) {
+					push.add(new RefSpec(value));
+				}
+			} else if (key.equals(KEY_UPLOADPACK)) {
+				for (String value : entry.getValue()) {
+					uploadpack = value;
+				}
+			} else if (key.equals(KEY_RECEIVEPACK)) {
+				for (String value : entry.getValue()) {
+					receivepack = value;
+				}
+			} else if (key.equals(KEY_TAGOPT)) {
+				for (String value : entry.getValue()) {
+					tagopt = TagOpt.fromOption(value);
+				}
+			}
+		}
+	}
+
+	public void readExternal(ObjectInput in) throws IOException,
+			ClassNotFoundException {
+		name = in.readUTF();
+		int items = in.readInt();
+
+		Map<String, Collection<String>> map = new HashMap<String,
Collection<String>>();
+		for (int i = 0; i < items; i++) {
+			String key = in.readUTF();
+			String value = in.readUTF();
+
+			Collection<String> values = map.get(key);
+			if (values == null) {
+				values = new ArrayList<String>();
+				map.put(key, values);
+			}
+
+			values.add(value);
+		}
+
+		try {
+			fromMap(map);
+		} catch (URISyntaxException ex) {
+			throw new IOException("Problem reading RemoteConfig map");
+		}
+	}
+
+	public void writeExternal(ObjectOutput out) throws IOException {
+		Map<String, Collection<String>> map = toMap();
+		
+		int size = 0;
+		
+		for (Map.Entry<String, Collection<String>> entry : map.entrySet()) {
+			size += entry.getValue().size();
+		}
+		
+		out.writeUTF(name);
+		out.writeInt(size);
+
+		for (Map.Entry<String, Collection<String>> entry : map.entrySet()) {
+			for (String value : entry.getValue()) {
+				out.writeUTF(entry.getKey());
+				out.writeUTF(value);
+			}
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
b/org.spearce.jgit/src/org/spearce/jgit/transport/URIish.java
index b86e00c..05e24b2 100644
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

@@ -75,7 +79,17 @@
 	 * @throws URISyntaxException
 	 */
 	public URIish(String s) throws URISyntaxException {
-		s = s.replace('\\', '/');
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
+	    s = s.replace('\\', '/');
 		Matcher matcher = FULL_URI.matcher(s);
 		if (matcher.matches()) {
 			scheme = matcher.group(1);
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
