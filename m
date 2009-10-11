From: imyousuf@gmail.com
Subject: [Sample-Conversion-PATCH 2/2] Introduce IO SPI usage in RepositoryConfig
Date: Sun, 11 Oct 2009 21:10:13 +0700
Message-ID: <1255270213-14514-2-git-send-email-imyousuf@gmail.com>
References: <1255270213-14514-1-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 16:13:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwzAO-00016h-CX
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbZJKOL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 10:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755221AbZJKOL1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:11:27 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:61025 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146AbZJKOLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:11:25 -0400
Received: by ewy4 with SMTP id 4so1832388ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l1dm9U1u5aDyCuReYiGvOFwy9JvmyEThMIFi9A/S0io=;
        b=Knk7DtdJa3ApAzJCLjRI0imPcai4eRCqRVsitBtcVYTlYNaKRl2ZSp266jfycIiU7Y
         /6szB+6TpvVBgfHOUT5LbD4lZDv0ZWByMP+HxUwIeaFEQSKHdroAKc501je/Gz1A68Wr
         VPZUQOYEvWHnS6BoyhLTA1CXCfrPoBo+YIDSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O2dIXEQGWrz//8u8ED67iFkrVfsFGPeyWAwHbb4j6yHNqRq2wYpffmPxlYmDAFv0IP
         rdYDcEiZNXyB/gPbEp/KbSjc1MvaCfvqHVRfHuqSl5bkPTozXddcxC49y+t10b7dSMTQ
         9g9qZhZyaSUTreXVqKIO1NAtRWoctwbKhrgI8=
Received: by 10.210.96.23 with SMTP id t23mr2837695ebb.11.1255270248373;
        Sun, 11 Oct 2009 07:10:48 -0700 (PDT)
Received: from localhost.localdomain ([119.30.36.8])
        by mx.google.com with ESMTPS id 5sm37635eyh.10.2009.10.11.07.10.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 07:10:47 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1255270213-14514-1-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129932>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

In order to introduce IO SPI in repository config class file based config,
file lock and NB is converted to use the IO SPI instead of java.io.File

Next is object directory.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../src/org/eclipse/jgit/lib/FileBasedConfig.java  |   12 +-
 .../src/org/eclipse/jgit/lib/LockFile.java         |  839 ++++++++++----------
 .../src/org/eclipse/jgit/lib/RepositoryConfig.java |    4 +-
 org.eclipse.jgit/src/org/eclipse/jgit/util/NB.java |   54 ++-
 4 files changed, 495 insertions(+), 414 deletions(-)
 rewrite org.eclipse.jgit/src/org/eclipse/jgit/lib/LockFile.java (78%)

diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/FileBasedConfig.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/FileBasedConfig.java
index 1300d85..a952be5 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/FileBasedConfig.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/FileBasedConfig.java
@@ -40,11 +40,11 @@
  */
 package org.eclipse.jgit.lib;
 
-import java.io.File;
 import java.io.FileNotFoundException;
 import java.io.IOException;
 
 import org.eclipse.jgit.errors.ConfigInvalidException;
+import org.eclipse.jgit.io.Entry;
 import org.eclipse.jgit.util.NB;
 import org.eclipse.jgit.util.RawParseUtils;
 
@@ -52,7 +52,7 @@
  * The configuration file that is stored in the file of the file system.
  */
 public class FileBasedConfig extends Config {
-	private final File configFile;
+	private final Entry configFile;
 
 	/**
 	 * Create a configuration with no default fallback.
@@ -60,7 +60,7 @@
 	 * @param cfgLocation
 	 *            the location of the configuration file on the file system
 	 */
-	public FileBasedConfig(File cfgLocation) {
+	public FileBasedConfig(Entry cfgLocation) {
 		this(null, cfgLocation);
 	}
 
@@ -72,13 +72,13 @@ public FileBasedConfig(File cfgLocation) {
 	 * @param cfgLocation
 	 *            the location of the configuration file on the file system
 	 */
-	public FileBasedConfig(Config base, File cfgLocation) {
+	public FileBasedConfig(Config base, Entry cfgLocation) {
 		super(base);
 		configFile = cfgLocation;
 	}
 
 	/** @return location of the configuration file on disk */
-	public final File getFile() {
+	public final Entry getFile() {
 		return configFile;
 	}
 
@@ -135,6 +135,6 @@ public void save() throws IOException {
 
 	@Override
 	public String toString() {
-		return getClass().getSimpleName() + "[" + getFile().getPath() + "]";
+		return getClass().getSimpleName() + "[" + getFile().getName() + "]";
 	}
 }
\ No newline at end of file
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/LockFile.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/LockFile.java
dissimilarity index 78%
index a2d8469..b852ddf 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/LockFile.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/LockFile.java
@@ -1,405 +1,434 @@
-/*
- * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
- * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
- *
- * All rights reserved.
- *
- * Redistribution and use in source and binary forms, with or
- * without modification, are permitted provided that the following
- * conditions are met:
- *
- * - Redistributions of source code must retain the above copyright
- *   notice, this list of conditions and the following disclaimer.
- *
- * - Redistributions in binary form must reproduce the above
- *   copyright notice, this list of conditions and the following
- *   disclaimer in the documentation and/or other materials provided
- *   with the distribution.
- *
- * - Neither the name of the Eclipse Foundation, Inc. nor the
- *   names of its contributors may be used to endorse or promote
- *   products derived from this software without specific prior
- *   written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
- * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
- * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
- * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
- * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
- * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
- * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
- * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
- * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- */
-
-package org.eclipse.jgit.lib;
-
-import java.io.BufferedOutputStream;
-import java.io.File;
-import java.io.FileInputStream;
-import java.io.FileNotFoundException;
-import java.io.FileOutputStream;
-import java.io.IOException;
-import java.io.OutputStream;
-import java.nio.channels.FileLock;
-import java.nio.channels.OverlappingFileLockException;
-
-/**
- * Git style file locking and replacement.
- * <p>
- * To modify a ref file Git tries to use an atomic update approach: we write the
- * new data into a brand new file, then rename it in place over the old name.
- * This way we can just delete the temporary file if anything goes wrong, and
- * nothing has been damaged. To coordinate access from multiple processes at
- * once Git tries to atomically create the new temporary file under a well-known
- * name.
- */
-public class LockFile {
-	private final File ref;
-
-	private final File lck;
-
-	private FileLock fLck;
-
-	private boolean haveLck;
-
-	private FileOutputStream os;
-
-	private boolean needStatInformation;
-
-	private long commitLastModified;
-
-	/**
-	 * Create a new lock for any file.
-	 * 
-	 * @param f
-	 *            the file that will be locked.
-	 */
-	public LockFile(final File f) {
-		ref = f;
-		lck = new File(ref.getParentFile(), ref.getName() + ".lock");
-	}
-
-	/**
-	 * Try to establish the lock.
-	 * 
-	 * @return true if the lock is now held by the caller; false if it is held
-	 *         by someone else.
-	 * @throws IOException
-	 *             the temporary output file could not be created. The caller
-	 *             does not hold the lock.
-	 */
-	public boolean lock() throws IOException {
-		lck.getParentFile().mkdirs();
-		if (lck.createNewFile()) {
-			haveLck = true;
-			try {
-				os = new FileOutputStream(lck);
-				try {
-					fLck = os.getChannel().tryLock();
-					if (fLck == null)
-						throw new OverlappingFileLockException();
-				} catch (OverlappingFileLockException ofle) {
-					// We cannot use unlock() here as this file is not
-					// held by us, but we thought we created it. We must
-					// not delete it, as it belongs to some other process.
-					//
-					haveLck = false;
-					try {
-						os.close();
-					} catch (IOException ioe) {
-						// Fail by returning haveLck = false.
-					}
-					os = null;
-				}
-			} catch (IOException ioe) {
-				unlock();
-				throw ioe;
-			}
-		}
-		return haveLck;
-	}
-
-	/**
-	 * Try to establish the lock for appending.
-	 * 
-	 * @return true if the lock is now held by the caller; false if it is held
-	 *         by someone else.
-	 * @throws IOException
-	 *             the temporary output file could not be created. The caller
-	 *             does not hold the lock.
-	 */
-	public boolean lockForAppend() throws IOException {
-		if (!lock())
-			return false;
-		copyCurrentContent();
-		return true;
-	}
-
-	/**
-	 * Copy the current file content into the temporary file.
-	 * <p>
-	 * This method saves the current file content by inserting it into the
-	 * temporary file, so that the caller can safely append rather than replace
-	 * the primary file.
-	 * <p>
-	 * This method does nothing if the current file does not exist, or exists
-	 * but is empty.
-	 * 
-	 * @throws IOException
-	 *             the temporary file could not be written, or a read error
-	 *             occurred while reading from the current file. The lock is
-	 *             released before throwing the underlying IO exception to the
-	 *             caller.
-	 * @throws RuntimeException
-	 *             the temporary file could not be written. The lock is released
-	 *             before throwing the underlying exception to the caller.
-	 */
-	public void copyCurrentContent() throws IOException {
-		requireLock();
-		try {
-			final FileInputStream fis = new FileInputStream(ref);
-			try {
-				final byte[] buf = new byte[2048];
-				int r;
-				while ((r = fis.read(buf)) >= 0)
-					os.write(buf, 0, r);
-			} finally {
-				fis.close();
-			}
-		} catch (FileNotFoundException fnfe) {
-			// Don't worry about a file that doesn't exist yet, it
-			// conceptually has no current content to copy.
-			//
-		} catch (IOException ioe) {
-			unlock();
-			throw ioe;
-		} catch (RuntimeException ioe) {
-			unlock();
-			throw ioe;
-		} catch (Error ioe) {
-			unlock();
-			throw ioe;
-		}
-	}
-
-	/**
-	 * Write an ObjectId and LF to the temporary file.
-	 * 
-	 * @param id
-	 *            the id to store in the file. The id will be written in hex,
-	 *            followed by a sole LF.
-	 * @throws IOException
-	 *             the temporary file could not be written. The lock is released
-	 *             before throwing the underlying IO exception to the caller.
-	 * @throws RuntimeException
-	 *             the temporary file could not be written. The lock is released
-	 *             before throwing the underlying exception to the caller.
-	 */
-	public void write(final ObjectId id) throws IOException {
-		requireLock();
-		try {
-			final BufferedOutputStream b;
-			b = new BufferedOutputStream(os, Constants.OBJECT_ID_LENGTH * 2 + 1);
-			id.copyTo(b);
-			b.write('\n');
-			b.flush();
-			fLck.release();
-			b.close();
-			os = null;
-		} catch (IOException ioe) {
-			unlock();
-			throw ioe;
-		} catch (RuntimeException ioe) {
-			unlock();
-			throw ioe;
-		} catch (Error ioe) {
-			unlock();
-			throw ioe;
-		}
-	}
-
-	/**
-	 * Write arbitrary data to the temporary file.
-	 * 
-	 * @param content
-	 *            the bytes to store in the temporary file. No additional bytes
-	 *            are added, so if the file must end with an LF it must appear
-	 *            at the end of the byte array.
-	 * @throws IOException
-	 *             the temporary file could not be written. The lock is released
-	 *             before throwing the underlying IO exception to the caller.
-	 * @throws RuntimeException
-	 *             the temporary file could not be written. The lock is released
-	 *             before throwing the underlying exception to the caller.
-	 */
-	public void write(final byte[] content) throws IOException {
-		requireLock();
-		try {
-			os.write(content);
-			os.flush();
-			fLck.release();
-			os.close();
-			os = null;
-		} catch (IOException ioe) {
-			unlock();
-			throw ioe;
-		} catch (RuntimeException ioe) {
-			unlock();
-			throw ioe;
-		} catch (Error ioe) {
-			unlock();
-			throw ioe;
-		}
-	}
-
-	/**
-	 * Obtain the direct output stream for this lock.
-	 * <p>
-	 * The stream may only be accessed once, and only after {@link #lock()} has
-	 * been successfully invoked and returned true. Callers must close the
-	 * stream prior to calling {@link #commit()} to commit the change.
-	 * 
-	 * @return a stream to write to the new file. The stream is unbuffered.
-	 */
-	public OutputStream getOutputStream() {
-		requireLock();
-		return new OutputStream() {
-			@Override
-			public void write(final byte[] b, final int o, final int n)
-					throws IOException {
-				os.write(b, o, n);
-			}
-
-			@Override
-			public void write(final byte[] b) throws IOException {
-				os.write(b);
-			}
-
-			@Override
-			public void write(final int b) throws IOException {
-				os.write(b);
-			}
-
-			@Override
-			public void flush() throws IOException {
-				os.flush();
-			}
-
-			@Override
-			public void close() throws IOException {
-				try {
-					os.flush();
-					fLck.release();
-					os.close();
-					os = null;
-				} catch (IOException ioe) {
-					unlock();
-					throw ioe;
-				} catch (RuntimeException ioe) {
-					unlock();
-					throw ioe;
-				} catch (Error ioe) {
-					unlock();
-					throw ioe;
-				}
-			}
-		};
-	}
-
-	private void requireLock() {
-		if (os == null) {
-			unlock();
-			throw new IllegalStateException("Lock on " + ref + " not held.");
-		}
-	}
-
-	/**
-	 * Request that {@link #commit()} remember modification time.
-	 * 
-	 * @param on
-	 *            true if the commit method must remember the modification time.
-	 */
-	public void setNeedStatInformation(final boolean on) {
-		needStatInformation = on;
-	}
-
-	/**
-	 * Commit this change and release the lock.
-	 * <p>
-	 * If this method fails (returns false) the lock is still released.
-	 * 
-	 * @return true if the commit was successful and the file contains the new
-	 *         data; false if the commit failed and the file remains with the
-	 *         old data.
-	 * @throws IllegalStateException
-	 *             the lock is not held.
-	 */
-	public boolean commit() {
-		if (os != null) {
-			unlock();
-			throw new IllegalStateException("Lock on " + ref + " not closed.");
-		}
-
-		saveStatInformation();
-		if (lck.renameTo(ref))
-			return true;
-		if (!ref.exists() || ref.delete())
-			if (lck.renameTo(ref))
-				return true;
-		unlock();
-		return false;
-	}
-
-	private void saveStatInformation() {
-		if (needStatInformation)
-			commitLastModified = lck.lastModified();
-	}
-
-	/**
-	 * Get the modification time of the output file when it was committed.
-	 * 
-	 * @return modification time of the lock file right before we committed it.
-	 */
-	public long getCommitLastModified() {
-		return commitLastModified;
-	}
-
-	/**
-	 * Unlock this file and abort this change.
-	 * <p>
-	 * The temporary file (if created) is deleted before returning.
-	 */
-	public void unlock() {
-		if (os != null) {
-			if (fLck != null) {
-				try {
-					fLck.release();
-				} catch (IOException ioe) {
-					// Huh?
-				}
-				fLck = null;
-			}
-			try {
-				os.close();
-			} catch (IOException ioe) {
-				// Ignore this
-			}
-			os = null;
-		}
-
-		if (haveLck) {
-			haveLck = false;
-			lck.delete();
-		}
-	}
-
-	@Override
-	public String toString() {
-		return "LockFile[" + lck + ", haveLck=" + haveLck + "]";
-	}
-}
+/*
+ * Copyright (C) 2007, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2008, Shawn O. Pearce <spearce@spearce.org>
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
+ * - Neither the name of the Eclipse Foundation, Inc. nor the
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
+package org.eclipse.jgit.lib;
+
+import java.io.BufferedOutputStream;
+import java.io.FileNotFoundException;
+import java.io.IOException;
+import java.io.InputStream;
+import java.io.OutputStream;
+import java.nio.channels.OverlappingFileLockException;
+import org.eclipse.jgit.io.Entry;
+
+/**
+ * Git style file locking and replacement.
+ * <p>
+ * To modify a ref file Git tries to use an atomic update approach: we write the
+ * new data into a brand new file, then rename it in place over the old name.
+ * This way we can just delete the temporary file if anything goes wrong, and
+ * nothing has been damaged. To coordinate access from multiple processes at
+ * once Git tries to atomically create the new temporary file under a well-known
+ * name.
+ */
+public class LockFile {
+
+  public static final int DEFAULT_BUFFER_SIZE = 500;
+
+  private final Entry ref;
+  private Entry lck;
+  private boolean haveLck;
+  private OutputStream os;
+  private boolean needStatInformation;
+  private long commitLastModified;
+
+  /**
+   * Create a new lock for any file.
+   *
+   * @param f
+   *            the file that will be locked.
+   */
+  public LockFile(final Entry f) {
+    ref = f;
+    lck = null;
+  }
+
+  /**
+   * Try to establish the lock.
+   *
+   * @return true if the lock is now held by the caller; false if it is held
+   *         by someone else.
+   * @throws IOException
+   *             the temporary output file could not be created. The caller
+   *             does not hold the lock.
+   */
+  public boolean lock()
+          throws IOException {
+    boolean locked = ref.tryLock();
+    if (locked) {
+      haveLck = true;
+      try {
+        lck = ref.getLockEntry();
+        try {
+          os = lck.getOutputStream(false, true);
+        }
+        catch (OverlappingFileLockException ofle) {
+          // We cannot use unlock() here as this file is not
+          // held by us, but we thought we created it. We must
+          // not delete it, as it belongs to some other process.
+          //
+          haveLck = false;
+          os = null;
+        }
+      }
+      catch (IOException ioe) {
+        unlock();
+        throw ioe;
+      }
+    }
+    return haveLck;
+  }
+
+  /**
+   * Try to establish the lock for appending.
+   *
+   * @return true if the lock is now held by the caller; false if it is held
+   *         by someone else.
+   * @throws IOException
+   *             the temporary output file could not be created. The caller
+   *             does not hold the lock.
+   */
+  public boolean lockForAppend()
+          throws IOException {
+    if (!lock()) {
+      return false;
+    }
+    copyCurrentContent();
+    return true;
+  }
+
+  /**
+   * Copy the current file content into the temporary file.
+   * <p>
+   * This method saves the current file content by inserting it into the
+   * temporary file, so that the caller can safely append rather than replace
+   * the primary file.
+   * <p>
+   * This method does nothing if the current file does not exist, or exists
+   * but is empty.
+   *
+   * @throws IOException
+   *             the temporary file could not be written, or a read error
+   *             occurred while reading from the current file. The lock is
+   *             released before throwing the underlying IO exception to the
+   *             caller.
+   * @throws RuntimeException
+   *             the temporary file could not be written. The lock is released
+   *             before throwing the underlying exception to the caller.
+   */
+  public void copyCurrentContent()
+          throws IOException {
+    requireLock();
+    try {
+      final InputStream fis = ref.getInputStream();
+      try {
+        final byte[] buf = new byte[2048];
+        int r;
+        while ((r = fis.read(buf)) >= 0) {
+          os.write(buf, 0, r);
+        }
+      }
+      finally {
+        fis.close();
+      }
+    }
+    catch (FileNotFoundException fnfe) {
+      // Don't worry about a file that doesn't exist yet, it
+      // conceptually has no current content to copy.
+      //
+    }
+    catch (IOException ioe) {
+      unlock();
+      throw ioe;
+    }
+    catch (RuntimeException ioe) {
+      unlock();
+      throw ioe;
+    }
+    catch (Error ioe) {
+      unlock();
+      throw ioe;
+    }
+  }
+
+  /**
+   * Write an ObjectId and LF to the temporary file.
+   *
+   * @param id
+   *            the id to store in the file. The id will be written in hex,
+   *            followed by a sole LF.
+   * @throws IOException
+   *             the temporary file could not be written. The lock is released
+   *             before throwing the underlying IO exception to the caller.
+   * @throws RuntimeException
+   *             the temporary file could not be written. The lock is released
+   *             before throwing the underlying exception to the caller.
+   */
+  public void write(final ObjectId id)
+          throws IOException {
+    requireLock();
+    try {
+      final BufferedOutputStream b;
+      b = new BufferedOutputStream(os, Constants.OBJECT_ID_LENGTH * 2 + 1);
+      id.copyTo(b);
+      b.write('\n');
+      b.flush();
+      b.close();
+      os = null;
+    }
+    catch (IOException ioe) {
+      unlock();
+      throw ioe;
+    }
+    catch (RuntimeException ioe) {
+      unlock();
+      throw ioe;
+    }
+    catch (Error ioe) {
+      unlock();
+      throw ioe;
+    }
+  }
+
+  /**
+   * Write arbitrary data to the temporary file.
+   *
+   * @param content
+   *            the bytes to store in the temporary file. No additional bytes
+   *            are added, so if the file must end with an LF it must appear
+   *            at the end of the byte array.
+   * @throws IOException
+   *             the temporary file could not be written. The lock is released
+   *             before throwing the underlying IO exception to the caller.
+   * @throws RuntimeException
+   *             the temporary file could not be written. The lock is released
+   *             before throwing the underlying exception to the caller.
+   */
+  public void write(final byte[] content)
+          throws IOException {
+    requireLock();
+    try {
+      os.write(content);
+      os.flush();
+      os.close();
+      os = null;
+    }
+    catch (IOException ioe) {
+      unlock();
+      throw ioe;
+    }
+    catch (RuntimeException ioe) {
+      unlock();
+      throw ioe;
+    }
+    catch (Error ioe) {
+      unlock();
+      throw ioe;
+    }
+  }
+
+  /**
+   * Obtain the direct output stream for this lock.
+   * <p>
+   * The stream may only be accessed once, and only after {@link #lock()} has
+   * been successfully invoked and returned true. Callers must close the
+   * stream prior to calling {@link #commit()} to commit the change.
+   *
+   * @return a stream to write to the new file. The stream is unbuffered.
+   */
+  public OutputStream getOutputStream() {
+    requireLock();
+    return new OutputStream() {
+
+      @Override
+      public void write(final byte[] b,
+                        final int o,
+                        final int n)
+              throws IOException {
+        os.write(b, o, n);
+      }
+
+      @Override
+      public void write(final byte[] b)
+              throws IOException {
+        os.write(b);
+      }
+
+      @Override
+      public void write(final int b)
+              throws IOException {
+        os.write(b);
+      }
+
+      @Override
+      public void flush()
+              throws IOException {
+        os.flush();
+      }
+
+      @Override
+      public void close()
+              throws IOException {
+        try {
+          os.flush();
+          os.close();
+          os = null;
+        }
+        catch (IOException ioe) {
+          unlock();
+          throw ioe;
+        }
+        catch (RuntimeException ioe) {
+          unlock();
+          throw ioe;
+        }
+        catch (Error ioe) {
+          unlock();
+          throw ioe;
+        }
+      }
+    };
+  }
+
+  private void requireLock() {
+    if (os == null) {
+      unlock();
+      throw new IllegalStateException("Lock on " + ref + " not held.");
+    }
+  }
+
+  /**
+   * Request that {@link #commit()} remember modification time.
+   *
+   * @param on
+   *            true if the commit method must remember the modification time.
+   */
+  public void setNeedStatInformation(final boolean on) {
+    needStatInformation = on;
+  }
+
+  /**
+   * Commit this change and release the lock.
+   * <p>
+   * If this method fails (returns false) the lock is still released.
+   *
+   * @return true if the commit was successful and the file contains the new
+   *         data; false if the commit failed and the file remains with the
+   *         old data.
+   * @throws IllegalStateException
+   *             the lock is not held.
+   */
+  public boolean commit() {
+    if (os != null) {
+      unlock();
+      throw new IllegalStateException("Lock on " + ref + " not closed.");
+    }
+
+    saveStatInformation();
+    try {
+      if (!ref.isExists()) {
+        ref.createNew();
+      }
+      OutputStream contentWriter = ref.getOutputStream(true, false);
+      InputStream contentReader = lck.getInputStream();
+      copy(contentReader, contentWriter);
+      contentReader.close();
+      contentWriter.close();
+      unlock();
+      return true;
+    }
+    catch (Exception ex) {
+      //ignore
+    }
+    return false;
+  }
+
+  public static int copy(
+          InputStream input,
+          OutputStream output)
+          throws IOException {
+    byte[] buffer = new byte[DEFAULT_BUFFER_SIZE];
+    int count = 0;
+    int n = 0;
+    while (-1 != (n = input.read(buffer))) {
+      output.write(buffer, 0, n);
+      count += n;
+    }
+    return count;
+  }
+
+  private void saveStatInformation() {
+    if (needStatInformation) {
+      commitLastModified = System.currentTimeMillis();
+    }
+  }
+
+  /**
+   * Get the modification time of the output file when it was committed.
+   *
+   * @return modification time of the lock file right before we committed it.
+   */
+  public long getCommitLastModified() {
+    return commitLastModified;
+  }
+
+  /**
+   * Unlock this file and abort this change.
+   * <p>
+   * The temporary file (if created) is deleted before returning.
+   */
+  public void unlock() {
+    if (os != null) {
+      try {
+        os.close();
+      }
+      catch (IOException ioe) {
+        // Ignore this
+      }
+      os = null;
+    }
+    if (haveLck) {
+      haveLck = false;
+      ref.unlock();
+    }
+  }
+
+  @Override
+  public String toString() {
+    return "LockFile[" + lck + ", haveLck=" + haveLck + "]";
+  }
+}
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryConfig.java b/org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryConfig.java
index 117e44a..851998e 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryConfig.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryConfig.java
@@ -41,7 +41,7 @@
 
 package org.eclipse.jgit.lib;
 
-import java.io.File;
+import org.eclipse.jgit.io.Entry;
 
 /**
  * An object representing the Git config file.
@@ -63,7 +63,7 @@
 	 * @param cfgLocation
 	 *            path of the file to load (or save).
 	 */
-	public RepositoryConfig(final Config base, final File cfgLocation) {
+	public RepositoryConfig(final Config base, final Entry cfgLocation) {
 		super(base, cfgLocation);
 	}
 
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/util/NB.java b/org.eclipse.jgit/src/org/eclipse/jgit/util/NB.java
index 261e3d1..a8c0758 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/util/NB.java
+++ b/org.eclipse.jgit/src/org/eclipse/jgit/util/NB.java
@@ -37,14 +37,17 @@
 
 package org.eclipse.jgit.util;
 
+import java.io.ByteArrayOutputStream;
 import java.io.EOFException;
 import java.io.File;
 import java.io.FileInputStream;
 import java.io.FileNotFoundException;
 import java.io.IOException;
 import java.io.InputStream;
+import java.io.OutputStream;
 import java.nio.ByteBuffer;
 import java.nio.channels.FileChannel;
+import org.eclipse.jgit.io.Entry;
 
 /** Conversion utilities for network byte order handling. */
 public final class NB {
@@ -97,6 +100,38 @@
 		}
 	}
 
+  public static final byte[] readFully(final Entry path)
+			throws IOException {
+    return readFully(path, Integer.MAX_VALUE);
+  }
+
+	public static final byte[] readFully(final Entry path, final int max)
+			throws IOException {
+		final InputStream in = path.getInputStream();
+		try {
+			final long sz = path.length();
+      byte[] buf;
+      if(sz > -1) {
+        if (sz > max)
+          throw new IOException("File is too large: " + path);
+        buf = new byte[(int) sz];
+        readFully(in, buf, 0, buf.length);
+      }
+      else {
+        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
+        read(in, outputStream);
+        buf = outputStream.toByteArray();
+      }
+			return buf;
+		} finally {
+			try {
+				in.close();
+			} catch (IOException ignored) {
+				// ignore any close errors, this was a read only stream
+			}
+		}
+	}
+
 	/**
 	 * Read the entire byte array into memory, or throw an exception.
 	 * 
@@ -113,8 +148,9 @@
 	 * @throws IOException
 	 *             there was an error reading from the stream.
 	 */
-	public static void readFully(final InputStream fd, final byte[] dst,
+	public static int readFully(final InputStream fd, final byte[] dst,
 			int off, int len) throws IOException {
+    int initOff = off;
 		while (len > 0) {
 			final int r = fd.read(dst, off, len);
 			if (r <= 0)
@@ -122,6 +158,22 @@ public static void readFully(final InputStream fd, final byte[] dst,
 			off += r;
 			len -= r;
 		}
+    return off - initOff;
+	}
+
+	public static int read(final InputStream fd, final OutputStream dst)
+          throws IOException {
+    int size = 0;
+    int r = 1;
+    byte[] bytes = new byte[1000];
+		while (r > 0) {
+			r = fd.read(bytes, 0, 1000);
+      if(r > 0) {
+        dst.write(bytes, 0, r);
+        size += r;
+      }
+		}
+    return size;
 	}
 
 	/**
-- 
1.6.2.1
