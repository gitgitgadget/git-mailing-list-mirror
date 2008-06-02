From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [JGIT PATCH 11/12] Entries iterator in PackIndex and indirectly PackFile
Date: Mon,  2 Jun 2008 23:24:42 +0200
Message-ID: <1212441883-12990-12-git-send-email-marek.zawirski@gmail.com>
References: <1212441883-12990-1-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-2-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-3-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-4-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-5-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-6-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-7-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-8-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-9-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-10-git-send-email-marek.zawirski@gmail.com>
 <1212441883-12990-11-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jun 02 23:26:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3HXt-0006g0-NJ
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 23:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbYFBVZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 17:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYFBVZZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 17:25:25 -0400
Received: from mu-out-0910.google.com ([209.85.134.188]:45136 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752124AbYFBVZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 17:25:21 -0400
Received: by mu-out-0910.google.com with SMTP id w8so1247612mue.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Qry3xixfqnc8NiGuWlJ5TB89JD02Q+BwIirDYqZTIf4=;
        b=IIhDTUFc7HLd72nNp2NmoCZOwQ9tiLq/5QH/gfYk0LxqO2lQ5tO2ESTp5Y8HrrJESbGynxjM3EU9VS0iOECF5coX7z+P7lXkoQfBBiBTuX6zpSAu6n0PeOIPMb1W3+XaV2nRw4ZYq8NdlMCcg/X4MoUml96pOMcL0LB7BoFARok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YNNDVCDZmZTZVvEaTCDm2JVfk5Srj5x4gtlPvZ9u8TYva+EIn5L7CKFWAhuJhhpBKocvyPI8ukRKn3CpGG1A0Or9cwzBZZpkAksz9nj7DvB0oFjNvwR8yqCBg1ZXxn37E7UvSZXGtancrRZyJp3UFEUONoLgopS85Ju6f5/mJjY=
Received: by 10.103.249.19 with SMTP id b19mr5770289mus.50.1212441920846;
        Mon, 02 Jun 2008 14:25:20 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id s10sm7542068mue.16.2008.06.02.14.25.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Jun 2008 14:25:20 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1212441883-12990-11-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83575>

New iterators operate on MutableEntry to achieve high performance.
Information about objects (and its offset) in pack is needed in several
places in original git, and it will be also useful here.

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/lib/PackFile.java         |   19 +++++-
 .../src/org/spearce/jgit/lib/PackIndex.java        |   80 +++++++++++++++++++-
 .../src/org/spearce/jgit/lib/PackIndexV1.java      |   31 ++++++++
 .../src/org/spearce/jgit/lib/PackIndexV2.java      |   36 +++++++++
 4 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
index 84562aa..1b2c167 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackFile.java
@@ -40,6 +40,7 @@ package org.spearce.jgit.lib;
 
 import java.io.File;
 import java.io.IOException;
+import java.util.Iterator;
 import java.util.zip.DataFormatException;
 
 import org.spearce.jgit.util.NB;
@@ -49,7 +50,7 @@ import org.spearce.jgit.util.NB;
  * delta packed format yielding high compression of lots of object where some
  * objects are similar.
  */
-public class PackFile {
+public class PackFile implements Iterable<PackIndex.MutableEntry> {
 	private final WindowedFile pack;
 
 	private final PackIndex idx;
@@ -146,6 +147,22 @@ public class PackFile {
 	}
 
 	/**
+	 * Provide iterator over entries in associated pack index, that should also
+	 * exist in this pack file. Objects returned by such iterator are mutable
+	 * during iteration.
+	 * <p>
+	 * Iterator returns objects in SHA-1 lexicographical order.
+	 * </p>
+	 * 
+	 * @return iterator over entries of associated pack index
+	 * 
+	 * @see PackIndex#iterator()
+	 */
+	public Iterator<PackIndex.MutableEntry> iterator() {
+		return idx.iterator();
+	}
+
+	/**
 	 * Obtain the total number of objects available in this pack. This method
 	 * relies on pack index, giving number of effectively available objects.
 	 * 
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
index 104c361..3935d4f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndex.java
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
+ * Copyright (C) 2008, Marek Zawirski <marek.zawirski@gmail.com>
  *
  * All rights reserved.
  *
@@ -41,6 +42,7 @@ import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
+import java.util.Iterator;
 
 import org.spearce.jgit.util.NB;
 
@@ -53,7 +55,7 @@ import org.spearce.jgit.util.NB;
  * by ObjectId.
  * </p>
  */
-public abstract class PackIndex {
+public abstract class PackIndex implements Iterable<PackIndex.MutableEntry> {
 	/**
 	 * Open an existing pack <code>.idx</code> file for reading.
 	 * <p>
@@ -117,6 +119,19 @@ public abstract class PackIndex {
 	}
 
 	/**
+	 * Provide iterator that gives access to index entries. Note, that iterator
+	 * returns reference to mutable object, the same reference in each call -
+	 * for performance reason. If client needs immutable objects, it must copy
+	 * returned object on its own.
+	 * <p>
+	 * Iterator returns objects in SHA-1 lexicographical order.
+	 * </p>
+	 * 
+	 * @return iterator over pack index entries
+	 */
+	public abstract Iterator<MutableEntry> iterator();
+
+	/**
 	 * Obtain the total number of objects described by this index.
 	 * 
 	 * @return number of objects in this index, and likewise in the associated
@@ -134,4 +149,67 @@ public abstract class PackIndex {
 	 *         associated pack.
 	 */
 	abstract long findOffset(AnyObjectId objId);
+
+	/**
+	 * Represent mutable entry of pack index consisting of object id and offset
+	 * in pack (both mutable).
+	 * 
+	 */
+	public static class MutableEntry extends MutableObjectId {
+		private long offset;
+
+		/**
+		 * Empty constructor. Object fields should be filled in later.
+		 */
+		public MutableEntry() {
+			super();
+		}
+
+		/**
+		 * Returns offset for this index object entry
+		 * 
+		 * @return offset of this object in a pack file
+		 */
+		public long getOffset() {
+			return offset;
+		}
+
+		void setOffset(long offset) {
+			this.offset = offset;
+		}
+
+		private MutableEntry(MutableEntry src) {
+			super(src);
+			this.offset = src.offset;
+		}
+
+		/**
+		 * Returns mutable copy of this mutable entry.
+		 * 
+		 * @return copy of this mutable entry
+		 */
+		public MutableEntry cloneEntry() {
+			return new MutableEntry(this);
+		}
+	}
+
+	protected abstract class EntriesIterator implements Iterator<MutableEntry> {
+		protected MutableEntry objectId = new MutableEntry();
+
+		protected long returnedNumber = 0;
+
+		public boolean hasNext() {
+			return returnedNumber < getObjectCount();
+		}
+
+		/**
+		 * Implementation must update {@link #returnedNumber} before returning
+		 * element.
+		 */
+		public abstract MutableEntry next();
+
+		public void remove() {
+			throw new UnsupportedOperationException();
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
index cfd18da..b8d9de3 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV1.java
@@ -40,6 +40,8 @@ package org.spearce.jgit.lib;
 
 import java.io.IOException;
 import java.io.InputStream;
+import java.util.Iterator;
+import java.util.NoSuchElementException;
 
 import org.spearce.jgit.errors.CorruptObjectException;
 import org.spearce.jgit.util.NB;
@@ -104,4 +106,33 @@ class PackIndexV1 extends PackIndex {
 		} while (low < high);
 		return -1;
 	}
+
+	public Iterator<MutableEntry> iterator() {
+		return new IndexV1Iterator();
+	}
+
+	private class IndexV1Iterator extends EntriesIterator {
+		private int levelOne;
+
+		private int levelTwo;
+
+		public MutableEntry next() {
+			for (; levelOne < idxdata.length; levelOne++) {
+				if (idxdata[levelOne] == null)
+					continue;
+
+				if (levelTwo < idxdata[levelOne].length) {
+					long offset = NB.decodeUInt32(idxdata[levelOne], levelTwo);
+					objectId.setOffset(offset);
+					objectId.fromRaw(idxdata[levelOne], levelTwo + 4);
+					levelTwo += Constants.OBJECT_ID_LENGTH + 4;
+					returnedNumber++;
+					return objectId;
+				} else {
+					levelTwo = 0;
+				}
+			}
+			throw new NoSuchElementException();
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
index b1b4d73..9a695ef 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/PackIndexV2.java
@@ -40,6 +40,8 @@ package org.spearce.jgit.lib;
 import java.io.EOFException;
 import java.io.IOException;
 import java.io.InputStream;
+import java.util.Iterator;
+import java.util.NoSuchElementException;
 
 import org.spearce.jgit.util.NB;
 
@@ -174,4 +176,38 @@ class PackIndexV2 extends PackIndex {
 		} while (low < high);
 		return -1;
 	}
+
+	public Iterator<MutableEntry> iterator() {
+		return new EntriesIteratorV2();
+	}
+
+	private class EntriesIteratorV2 extends EntriesIterator {
+		private int levelOne;
+
+		private int levelTWo;
+
+		public MutableEntry next() {
+			for (; levelOne < names.length; levelOne++) {
+				if (levelTWo < names[levelOne].length) {
+					objectId.fromRaw(names[levelOne], levelTWo);
+					int arrayIdx = levelTWo / (Constants.OBJECT_ID_LENGTH / 4)
+							* 4;
+					long offset = NB.decodeUInt32(offset32[levelOne], arrayIdx);
+					if ((offset & IS_O64) != 0) {
+						arrayIdx = (8 * (int) (offset & ~IS_O64));
+						offset = NB.decodeUInt64(offset64, arrayIdx);
+					}
+					objectId.setOffset(offset);
+
+					levelTWo += Constants.OBJECT_ID_LENGTH / 4;
+					returnedNumber++;
+					return objectId;
+				} else {
+					levelTWo = 0;
+				}
+			}
+			throw new NoSuchElementException();
+		}
+	}
+
 }
-- 
1.5.5.1
