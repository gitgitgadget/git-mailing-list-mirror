From: imyousuf@gmail.com
Subject: [JGit-io-RFC-PATCH v2 4/4] Add locking capability to the IO SPI based on Java Concurrency Lock API
Date: Sun, 11 Oct 2009 21:07:53 +0700
Message-ID: <1255270073-14205-4-git-send-email-imyousuf@gmail.com>
References: <1255270073-14205-1-git-send-email-imyousuf@gmail.com>
 <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
 <1255270073-14205-3-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 16:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwz7l-0008An-D4
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbZJKOJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 10:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbZJKOJv
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:09:51 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:31194 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbZJKOJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:09:49 -0400
Received: by ey-out-2122.google.com with SMTP id 4so1759660eyf.19
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JjQzYO/FgBKUgXHcigblsCo+poBd3S99z8BKA/RkXOA=;
        b=cBfyaG8KrYWUGWkXXE6qjMC6cLn1DC9QyKk85OVnXmeUZfsBrieYGJ02eekB526XvG
         J/0miLAKj7KE5sTEEpIKiL5I587NvBVIRwIFWDfQyEm8jU+psYE0cBlAA7yt/mMsFxpk
         Ygi7J9I/QVbk7QjEEQwR6LaNjGqCHipgbM/rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QlFwYvCPyQqQirI0BqZCDjdrZfygx4oTAcpcNPriBsFKE0djKojKquQkF25YIdpNqR
         d5HC6LHdfRS+G7nWPLpL7BKUTPTJJImb6WdZYY8kdSToLmFBwRCNqxKqEp5m7MVRHsis
         FTpXn1p53O1+7BR8RvpB2VH4AiaF8wsb7Wjhc=
Received: by 10.211.128.15 with SMTP id f15mr5904810ebn.84.1255270120223;
        Sun, 11 Oct 2009 07:08:40 -0700 (PDT)
Received: from localhost.localdomain ([119.30.36.8])
        by mx.google.com with ESMTPS id 23sm2698205eya.42.2009.10.11.07.08.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 07:08:39 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1255270073-14205-3-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129928>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

The lock implementation for local FS has 2 layer for locking, first JVM
level using the Java Concurrency API and second level is in local FS and
its Git specific *.lock files.

This change basically replaces the LockFile implementation in JGit Lib.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../src/org/eclipse/jgit/io/Entry.java             |   44 ++++-
 .../eclipse/jgit/io/localfs/LocalFileEntry.java    |  177 +++++++++++++++++-
 .../org/eclipse/jgit/io/lock/AbstractLockable.java |  199 ++++++++++++++++++++
 .../{StorageSystem.java => lock/LockManager.java}  |   96 ++++++----
 .../src/org/eclipse/jgit/io/lock/Lockable.java     |   26 ++--
 5 files changed, 486 insertions(+), 56 deletions(-)
 create mode 100644 org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/AbstractLockable.java
 copy org.eclipse.jgit.io/src/org/eclipse/jgit/io/{StorageSystem.java => lock/LockManager.java} (53%)
 copy org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryAdapter.java => org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/Lockable.java (77%)

diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
index 5256815..4c264db 100644
--- a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
@@ -36,6 +36,7 @@
  */
 package org.eclipse.jgit.io;
 
+import org.eclipse.jgit.io.lock.Lockable;
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStream;
@@ -50,7 +51,8 @@
  * @author Imran M Yousuf (imyousuf at smartitengineering.com)
  * @since 0.6
  */
-public interface Entry {
+public interface Entry
+        extends Lockable {
 
   /**
    * Retrieves the name of the entry
@@ -138,12 +140,26 @@ public InputStream getInputStream()
           throws IOException;
 
   /**
-   * Retrieves the OutputStream for writing content into the entry. It can be
-   * opened to either overwrite it or append to it.
+   * Retrieves a locked channeled output stream. When the output stream is closed
+   * the channel is released automatically.
+   * @param overwrite False if to write in append mode else true
+   * @param lock Whether to attain lock or not
+   * @return Output stream to write content to
+   * @throws IOException If no such entry exists in append mode or there is any
+   *                     error in retrieving it or retrieving the lock.
+   */
+  public OutputStream getOutputStream(boolean overwrite,
+                                      boolean lock)
+          throws IOException;
+
+  /**
+   * Behaves in as if {@link Entry#getOutputStream(boolean, boolean)} is called
+   * with lock param as false.
    * @param overwrite False if to write in append mode else true
    * @return Output stream to write content to
    * @throws IOException If no such entry exists in append mode or there is any
    *                     error in retrieving it.
+   * @see Entry#getOutputStream(boolean, boolean) 
    */
   public OutputStream getOutputStream(boolean overwrite)
           throws IOException;
@@ -171,6 +187,28 @@ public OutputStream getOutputStream(boolean overwrite)
   public Entry getParent();
 
   /**
+   * Create this entry in the underlying system storage.
+   * @return True if created else false
+   * @throws IOException If any I/O during creation
+   */
+  public boolean createNew()
+          throws IOException;
+
+  /**
+   * Delete current entry
+   * @return True if deleted successfully else false
+   * @throws IOException If any error during writing
+   */
+  public boolean delete()
+          throws IOException;
+
+  /**
+   * Retrieve the entry for lock file
+   * @return Null if lock is attained else null
+   */
+  public Entry getLockEntry();
+
+  /**
    * Retrieve the storage system this entry either is from or will be
    * persisted to.
    * @return Storage system of the entry, will never be NULL.
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
index 4ef3076..f6c84c1 100644
--- a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
@@ -45,9 +45,13 @@
 import java.io.OutputStream;
 import java.lang.reflect.InvocationTargetException;
 import java.net.URI;
+import java.nio.channels.FileLock;
+import java.nio.channels.OverlappingFileLockException;
+import java.util.concurrent.TimeUnit;
 import org.eclipse.jgit.io.Entry;
 import org.eclipse.jgit.io.StorageSystem;
 import org.eclipse.jgit.io.StorageSystemManager;
+import org.eclipse.jgit.io.lock.AbstractLockable;
 
 /**
  * Entry implementation for local file system. This class should not be
@@ -58,10 +62,15 @@
  * @since 0.6
  */
 public class LocalFileEntry
+        extends AbstractLockable
         implements Entry {
 
+  public static final String LOCK_FILE_EXT = ".lock";
+  public static final long DEFAULT_WAIT_TIME_MS = 200;
   private File localFile;
   private LocalFileSystem storageSystem;
+  private File localLockFile;
+  private String lockFileName;
 
   /**
    * Contructs an entry based of on the local file system storage and a file
@@ -152,25 +161,86 @@ public InputStream getInputStream()
     }
   }
 
-  public OutputStream getOutputStream(boolean overwrite)
+  public OutputStream getOutputStream(boolean overwrite,
+                                      boolean lock)
           throws IOException {
+    final FileOutputStream fileOutputStream;
     try {
       if (!isExists()) {
-
-        return new FileOutputStream(getLocalFile());
+        fileOutputStream = new FileOutputStream(getLocalFile());
       }
       else {
         if (overwrite) {
-          return new FileOutputStream(getLocalFile());
+          fileOutputStream = new FileOutputStream(getLocalFile());
         }
         else {
-          return new FileOutputStream(getLocalFile(), true);
+          fileOutputStream = new FileOutputStream(getLocalFile(), true);
+        }
+      }
+      if (lock) {
+        final FileLock fileLock;
+        try {
+          fileLock = fileOutputStream.getChannel().lock();
+        }
+        catch (IOException ex) {
+          fileOutputStream.close();
+          throw ex;
+        }
+        catch (Exception ex) {
+          fileOutputStream.close();
+          throw new IOException(ex);
+        }
+        if (fileLock == null) {
+          fileOutputStream.close();
+          throw new OverlappingFileLockException();
         }
+        return new OutputStream() {
+
+          @Override
+          public void write(int b)
+                  throws IOException {
+            fileOutputStream.write(b);
+          }
+
+          @Override
+          public void close()
+                  throws IOException {
+            fileLock.release();
+            fileOutputStream.close();
+          }
+
+          @Override
+          public void flush()
+                  throws IOException {
+            fileOutputStream.flush();
+          }
+
+          @Override
+          public void write(byte[] b)
+                  throws IOException {
+            fileOutputStream.write(b);
+          }
+
+          @Override
+          public void write(byte[] b,
+                            int off,
+                            int len)
+                  throws IOException {
+            fileOutputStream.write(b, off, len);
+          }
+        };
       }
+      return fileOutputStream;
     }
     catch (FileNotFoundException ex) {
       throw ex;
     }
+
+  }
+
+  public OutputStream getOutputStream(boolean overwrite)
+          throws IOException {
+    return getOutputStream(overwrite, false);
   }
 
   public Entry[] getChildren() {
@@ -262,4 +332,101 @@ public boolean setExecutable(boolean executable) {
       throw new Error(e);
     }
   }
+
+  public boolean createNew()
+          throws IOException {
+    return getLocalFile().createNewFile();
+  }
+
+  public boolean delete()
+          throws IOException {
+    return getLocalFile().delete();
+  }
+
+  public Entry getLockEntry() {
+    if (localLockFile == null) {
+      return null;
+    }
+    else {
+      return getStorageSystem().getEntry(localLockFile.toURI());
+    }
+  }
+
+  @Override
+  protected void performLock()
+          throws Exception {
+    boolean lock = performTryLock(Long.MAX_VALUE, TimeUnit.MILLISECONDS);
+    if (!lock) {
+      throw new IOException("Could not attain lock!");
+    }
+  }
+
+  @Override
+  protected boolean performTryLock(long time,
+                                   TimeUnit unit) {
+    final long milliSecTime = TimeUnit.MILLISECONDS.convert(time, unit);
+    long waitLeft = milliSecTime;
+    boolean tryAgain = true;
+    do {
+      long nextWaitDuration = Math.min(waitLeft, DEFAULT_WAIT_TIME_MS);
+      waitLeft = waitLeft - nextWaitDuration;
+      boolean success = performTryLock();
+      if (success) {
+        return success;
+      }
+      else {
+        if (nextWaitDuration > 0) {
+          try {
+            Thread.sleep(nextWaitDuration);
+          }
+          catch (InterruptedException ex) {
+          }
+        }
+        else {
+          tryAgain = false;
+        }
+      }
+    }
+    while (tryAgain);
+    return false;
+  }
+
+  @Override
+  protected boolean performTryLock() {
+    StringBuilder lockFileNameBuilder = new StringBuilder();
+    if (this.lockFileName == null) {
+      lockFileNameBuilder.append(getLocalFile().getName());
+      lockFileNameBuilder.append(LOCK_FILE_EXT);
+      this.lockFileName = lockFileNameBuilder.toString();
+    }
+    final File parent = getLocalFile().getParentFile();
+    if (parent != null) {
+      parent.mkdirs();
+    }
+    localLockFile = new File(parent, this.lockFileName);
+    if (localLockFile.exists()) {
+      localLockFile = null;
+      return false;
+    }
+    else {
+      boolean createNewFile;
+      try {
+        createNewFile = localLockFile.createNewFile();
+      }
+      catch (IOException ex) {
+        createNewFile = false;
+      }
+      if (!createNewFile) {
+        localLockFile = null;
+      }
+      return createNewFile;
+    }
+  }
+
+  @Override
+  protected void performUnlock() {
+    if (localLockFile != null) {
+      localLockFile.delete();
+    }
+  }
 }
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/AbstractLockable.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/AbstractLockable.java
new file mode 100644
index 0000000..1e95494
--- /dev/null
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/AbstractLockable.java
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2009, Imran M Yousuf <imyousuf@smartitengineering.com>
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
+package org.eclipse.jgit.io.lock;
+
+import java.net.URI;
+import java.util.concurrent.TimeUnit;
+import java.util.concurrent.locks.Condition;
+import java.util.concurrent.locks.ReentrantLock;
+
+/**
+ * Abstract implementation of lockable
+ * @author Imran M Yousuf (imyousuf at smartitengineering.com)
+ * @since 0.6
+ */
+public abstract class AbstractLockable
+        implements Lockable {
+
+  private ReentrantLock lock;
+  private boolean attainedCompleteLock;
+
+  protected AbstractLockable() {
+  }
+
+  @Override
+  protected void finalize()
+          throws Throwable {
+    LockManager.getInstance().unregister(getURI());
+    super.finalize();
+  }
+
+  /**
+   * Retrieve the URI of this instance.
+   * @return The URI to identify this instance. Should never be NULL
+   */
+  public abstract URI getURI();
+
+  protected boolean isInternalLockHeldOnly() {
+    return getLock().isHeldByCurrentThread();
+  }
+
+  public boolean isHeldByCurrentThread() {
+    return isInternalLockHeldOnly() && attainedCompleteLock;
+  }
+
+  public void lock() {
+    getLock().lock();
+    childLock();
+  }
+
+  public void lockInterruptibly()
+          throws InterruptedException {
+    getLock().lockInterruptibly();
+    childLock();
+  }
+
+  public Condition newCondition() {
+    return getLock().newCondition();
+  }
+
+  public boolean tryLock() {
+    if (isHeldByCurrentThread()) {
+      return true;
+    }
+    final boolean tryLock = getLock().tryLock();
+    if (tryLock) {
+      final boolean performTryLock = performTryLock();
+      if (!performTryLock) {
+        unlock();
+      }
+      else {
+        attainedCompleteLock = true;
+      }
+    }
+    return tryLock;
+  }
+
+  public boolean tryLock(long time,
+                         TimeUnit unit)
+          throws InterruptedException {
+    if (isHeldByCurrentThread()) {
+      return true;
+    }
+    final boolean tryLock;
+    long currentTime = System.currentTimeMillis();
+    tryLock = getLock().tryLock(time, unit);
+    long duration = unit.convert(System.currentTimeMillis() - currentTime,
+            TimeUnit.MILLISECONDS);
+    if (tryLock) {
+      final boolean performTryLock = performTryLock(duration, unit);
+      if (!performTryLock) {
+        unlock();
+      }
+      else {
+        attainedCompleteLock = true;
+      }
+      return performTryLock;
+    }
+    return tryLock;
+  }
+
+  public void unlock() {
+    if (isInternalLockHeldOnly()) {
+      if (attainedCompleteLock) {
+        performUnlock();
+      }
+      attainedCompleteLock = false;
+      getLock().unlock();
+    }
+  }
+
+  /**
+   * Retrieves the {@link ReentrantLock lock} based on this instances URI. It is
+   * to be noted that all instances of this URI will share the same lock.
+   * @return The lock for this lockable instance
+   */
+  protected ReentrantLock getLock() {
+    if (lock == null) {
+      lock = LockManager.getInstance().register(getURI());
+    }
+    return lock;
+  }
+
+  /**
+   * Performs additional lock operations if required by children. It will wait
+   * until it can avail for lock, but it will not wait for ever and will then
+   * throw and exception.
+   * @throws Exception If lock could be attained
+   */
+  protected abstract void performLock()
+          throws Exception;
+
+  /**
+   * Performs additional lock operations if required by children, but it will
+   * not wait for lock until beyond the time unit specified.
+   * @param time Number to wait for lock
+   * @param unit Unit of the time number
+   * @return True if lock was attained else false
+   */
+  protected abstract boolean performTryLock(long time,
+                                            TimeUnit unit);
+
+  /**
+   * Performs additional lock operations if required by children, but it will
+   * not wait for lock at all.
+   * @return True if lock was attained else false
+   */
+  protected abstract boolean performTryLock();
+
+  /**
+   * Performs additional unlock operations if required by children.
+   */
+  protected abstract void performUnlock();
+
+  private void childLock() {
+    try {
+      performLock();
+      attainedCompleteLock = true;
+    }
+    catch (Exception ex) {
+      unlock();
+      attainedCompleteLock = false;
+      throw new RuntimeException("Could not attain lock!", ex);
+    }
+  }
+}
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/LockManager.java
similarity index 53%
copy from org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
copy to org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/LockManager.java
index 15af614..dfdcf21 100644
--- a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/LockManager.java
@@ -34,51 +34,77 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-package org.eclipse.jgit.io;
+package org.eclipse.jgit.io.lock;
 
 import java.net.URI;
+import java.util.Hashtable;
+import java.util.Map;
+import java.util.concurrent.locks.ReentrantLock;
 
 /**
- * SPI providing access to the underlying storage system. Each provider is
- * differentiated using their {@link StorageSystem#getURIProtocol() URI Protocol}.
+ * Manages reentrant lock per URI
  * @author Imran M Yousuf (imyousuf at smartitengineering.com)
  * @since 0.6
  */
-public interface StorageSystem {
+public final class LockManager {
 
-  /**
-   * Returns the supported scheme of this storage system.
-   * @return Scheme supported by this storage system.
-   * @see {@link http://tr.im/BiQ0 URI Scheme}
-   */
-  public String getURIScheme();
+  private static LockManager lockManager;
 
-  /**
-   * Retrieve an entry using its URI
-   * @param uri URI to retrieve the entry for.
-   * @return Entry representing the URI
-   */
-  public Entry getEntry(URI uri);
+  public static LockManager getInstance() {
+    if (lockManager == null) {
+      lockManager = new LockManager();
+    }
+    return lockManager;
+  }
+  private final Map<URI, LockProvider> locks;
 
-  /**
-   * Retrieve the current working directory from the file system if any.
-   * @return Entry for current working directory.
-   */
-  public Entry getWorkingDirectory();
+  private LockManager() {
+    locks = new Hashtable<URI, LockProvider>();
+  }
 
-  /**
-   * Retrieve the home directory of the current user
-   * @return Home directory
-   */
-  public Entry getHomeDirectory();
+  public synchronized ReentrantLock register(URI key) {
+    if (!locks.containsKey(key)) {
+      locks.put(key, new LockProvider(
+              new ReentrantLock()));
+    }
+    return locks.get(key).get();
+  }
 
-  /**
-   * Resolve relative path with respect to a path and return the absolute
-   * entry representing the relative path.
-   * @param entry The point of reference for the relative path
-   * @param path The relative path
-   * @return The absolute entry representing the relative path entry
-   */
-  public Entry resolve(Entry entry,
-                       String path);
+  public synchronized void unregister(URI key) {
+    if (locks.containsKey(key)) {
+      LockProvider provider = locks.get(key);
+      if (provider != null) {
+        provider.decreateCount();
+        if (provider.getRegisterCount() < 1) {
+          locks.remove(key);
+        }
+      }
+    }
+  }
+
+  private static class LockProvider {
+
+    private int registerCount = 0;
+    private ReentrantLock lock;
+
+    public LockProvider(ReentrantLock lock) {
+      this.lock = lock;
+    }
+
+    public ReentrantLock get() {
+      registerCount += 1;
+      return lock;
+    }
+
+    public void decreateCount() {
+      if (lock.isHeldByCurrentThread()) {
+        lock.unlock();
+      }
+      registerCount -= 1;
+    }
+
+    public int getRegisterCount() {
+      return registerCount;
+    }
+  }
 }
diff --git a/org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryAdapter.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/Lockable.java
similarity index 77%
copy from org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryAdapter.java
copy to org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/Lockable.java
index 008fef8..d2bb039 100644
--- a/org.eclipse.jgit/src/org/eclipse/jgit/lib/RepositoryAdapter.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/lock/Lockable.java
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
+ * Copyright (C) 2009, Imran M Yousuf <imyousuf@smartitengineering.com>
  *
  * All rights reserved.
  *
@@ -34,21 +34,21 @@
  * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
+package org.eclipse.jgit.io.lock;
 
-package org.eclipse.jgit.lib;
+import java.util.concurrent.locks.Lock;
 
 /**
- * A default {@link RepositoryListener} that does nothing except invoke an
- * optional general method for any repository change.
+ * For objects wanting to make themselves lockable.
+ * @author Imran M Yousuf (imyousuf at smartitengineering.com)
+ * @since 0.6
  */
-public class RepositoryAdapter implements RepositoryListener {
-
-	public void indexChanged(final IndexChangedEvent e) {
-		// Empty
-	}
-
-	public void refsChanged(final RefsChangedEvent e) {
-		// Empty
-	}
+public interface Lockable
+        extends Lock {
 
+  /**
+   * Retrieves whether the current thread owns the object lock or not.
+   * @return
+   */
+  public boolean isHeldByCurrentThread();
 }
-- 
1.6.2.1
