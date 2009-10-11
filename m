From: imyousuf@gmail.com
Subject: [JGit-io-RFC-PATCH v2 3/4] Incorporate current FileSystem Util implementations to the SPI
Date: Sun, 11 Oct 2009 21:07:52 +0700
Message-ID: <1255270073-14205-3-git-send-email-imyousuf@gmail.com>
References: <1255270073-14205-1-git-send-email-imyousuf@gmail.com>
 <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
Cc: spearce@spearce.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 11 16:10:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwz7k-0008An-SF
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 16:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbZJKOJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 10:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbZJKOJK
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 10:09:10 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:49818 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbZJKOJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 10:09:09 -0400
Received: by ewy4 with SMTP id 4so1831458ewy.37
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=D1rc9IDpTnpUPiiOcwkWTxlOCrKhodhwMR/KVNaOdaA=;
        b=YA4uZmzBJfUkr9FgDk90oBUg7lX+RetmOiBAu/YSoC3UfIi/lJzHfmKjVpRJZHfuNf
         UsixWwBfrRhd0moj7b7JGvbXT89iulUib0ZDY4VgzPt1fLHsUQ9epd2WJ/je+/myBsBu
         M1gmW7PFUN8MLTFKoNIL/BsaJ6kUlkQVZepno=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B1wtwYrIL9o7FZNh7dZbOAzOzay2fy22pJz3OSUFOpw2CGMfd3AJTMuH9azq30LFbV
         IoTjMbzRv0YkRjz1F9RTx00m/yNa6sYk3F5Hz5TIavF3bZDiDMNSSKFpNRNEewWAPrv3
         3R70xi/ilXmObsVfmAGwDM+6qE1w1gVC39lUQ=
Received: by 10.210.7.11 with SMTP id 11mr2936853ebg.5.1255270110063;
        Sun, 11 Oct 2009 07:08:30 -0700 (PDT)
Received: from localhost.localdomain ([119.30.36.8])
        by mx.google.com with ESMTPS id 23sm2698205eya.42.2009.10.11.07.08.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Oct 2009 07:08:28 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129930>

From: Imran M Yousuf <imyousuf@smartitengineering.com>

Operations such as setting executable bits if supported and resolving
relative path is incorporated with this change, as a result now it should
be possible to completely replace the currently being used util FS and
java.io.File.

Signed-off-by: Imran M Yousuf <imyousuf@smartitengineering.com>
---
 .../src/org/eclipse/jgit/io/Entry.java             |   35 ++++-
 .../src/org/eclipse/jgit/io/StorageSystem.java     |   16 ++
 .../eclipse/jgit/io/localfs/LocalFileEntry.java    |   52 ++++++-
 .../eclipse/jgit/io/localfs/LocalFileSystem.java   |  159 ++++++++++++++++++++
 4 files changed, 257 insertions(+), 5 deletions(-)

diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
index cd69172..5256815 100644
--- a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/Entry.java
@@ -78,6 +78,24 @@
   public boolean isExists();
 
   /**
+   * Does this operating system and JRE support the execute flag on entries?
+   *
+   * @return true if this implementation can provide reasonably accurate
+   *         executable bit information; false otherwise.
+   */
+  public boolean isExecutableSupported();
+
+  /**
+   * Determine if the entry is executable (or not).
+   * <p>
+   * Not all platforms and JREs support executable flags on entries. If the
+   * feature is unsupported this method will always return false.
+   *
+   * @return true if the entry is believed to be executable by the user.
+   */
+  public boolean isExecutable();
+
+  /**
    * Make directories upto the entry represented by this instance, provided
    * that this instance itself is a directory.
    * @return True if directories were created.
@@ -85,6 +103,19 @@
   public boolean mkdirs();
 
   /**
+   * Set an entry to be executable by the user.
+   * <p>
+   * Not all platforms and JREs support executable flags on entries. If the
+   * feature is unsupported this method will always return false and no
+   * changes will be made to the entry specified.
+   *
+   * @param executable
+   *            true to enable execution; false to disable it.
+   * @return true if the change succeeded; false otherwise.
+   */
+  public boolean setExecutable(boolean executable);
+
+  /**
    * Retrieves the URI of this entry. URI in this case acts as a primary key
    * to identify an entry.
    * @return URI to identify this entry instance
@@ -101,7 +132,7 @@
   /**
    * Retrieves the InputStream for reading the content of the entry
    * @return Input stream to read entry content
-   * @throws IOException If no such file exists or there is any other error
+   * @throws IOException If no such entry exists or there is any other error
    */
   public InputStream getInputStream()
           throws IOException;
@@ -111,7 +142,7 @@ public InputStream getInputStream()
    * opened to either overwrite it or append to it.
    * @param overwrite False if to write in append mode else true
    * @return Output stream to write content to
-   * @throws IOException If no such file exists in append mode or there is any
+   * @throws IOException If no such entry exists in append mode or there is any
    *                     error in retrieving it.
    */
   public OutputStream getOutputStream(boolean overwrite)
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
index 9f45cb3..15af614 100644
--- a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/StorageSystem.java
@@ -65,4 +65,20 @@
    * @return Entry for current working directory.
    */
   public Entry getWorkingDirectory();
+
+  /**
+   * Retrieve the home directory of the current user
+   * @return Home directory
+   */
+  public Entry getHomeDirectory();
+
+  /**
+   * Resolve relative path with respect to a path and return the absolute
+   * entry representing the relative path.
+   * @param entry The point of reference for the relative path
+   * @param path The relative path
+   * @return The absolute entry representing the relative path entry
+   */
+  public Entry resolve(Entry entry,
+                       String path);
 }
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
index 99df831..4ef3076 100644
--- a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileEntry.java
@@ -43,6 +43,7 @@
 import java.io.IOException;
 import java.io.InputStream;
 import java.io.OutputStream;
+import java.lang.reflect.InvocationTargetException;
 import java.net.URI;
 import org.eclipse.jgit.io.Entry;
 import org.eclipse.jgit.io.StorageSystem;
@@ -60,7 +61,7 @@
         implements Entry {
 
   private File localFile;
-  private StorageSystem storageSystem;
+  private LocalFileSystem storageSystem;
 
   /**
    * Contructs an entry based of on the local file system storage and a file
@@ -70,7 +71,7 @@
    * @throws IllegalArgumentException If either argument is NULL
    */
   protected LocalFileEntry(File localFile,
-                           StorageSystem storageSystem)
+                           LocalFileSystem storageSystem)
           throws IllegalArgumentException {
     setLocalFile(localFile);
     setStorageSystem(storageSystem);
@@ -81,7 +82,7 @@ protected LocalFileEntry(File localFile,
    * @param storageSystem Storage system
    * @throws IllegalArgumentException IF storageSystem is null
    */
-  protected void setStorageSystem(StorageSystem storageSystem)
+  protected void setStorageSystem(LocalFileSystem storageSystem)
           throws IllegalArgumentException {
     if (storageSystem == null) {
       throw new IllegalArgumentException("Storage system can't be NULL!");
@@ -216,4 +217,49 @@ public StorageSystem getStorageSystem() {
   public long length() {
     return getLocalFile().length();
   }
+
+  public boolean isExecutableSupported() {
+    return LocalFileSystem.platform.isExecutableSupproted();
+  }
+
+  public boolean isExecutable() {
+    if (LocalFileSystem.platform.isExecutableSupproted()) {
+      try {
+        final Object r = LocalFileSystem.canExecute.invoke(
+                getLocalFile(),
+                (Object[]) null);
+        return ((Boolean) r).booleanValue();
+      }
+      catch (IllegalArgumentException e) {
+        throw new Error(e);
+      }
+      catch (IllegalAccessException e) {
+        throw new Error(e);
+      }
+      catch (InvocationTargetException e) {
+        throw new Error(e);
+      }
+    }
+    else {
+      return false;
+    }
+  }
+
+  public boolean setExecutable(boolean executable) {
+    try {
+      final Object r;
+      r = LocalFileSystem.setExecute.invoke(getLocalFile(), new Object[] {
+                Boolean.valueOf(executable)});
+      return ((Boolean) r).booleanValue();
+    }
+    catch (IllegalArgumentException e) {
+      throw new Error(e);
+    }
+    catch (IllegalAccessException e) {
+      throw new Error(e);
+    }
+    catch (InvocationTargetException e) {
+      throw new Error(e);
+    }
+  }
 }
diff --git a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java
index d0cb536..7cef2d8 100644
--- a/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java
+++ b/org.eclipse.jgit.io/src/org/eclipse/jgit/io/localfs/LocalFileSystem.java
@@ -36,8 +36,14 @@
  */
 package org.eclipse.jgit.io.localfs;
 
+import java.io.BufferedReader;
 import java.io.File;
+import java.io.IOException;
+import java.io.InputStreamReader;
+import java.lang.reflect.Method;
 import java.net.URI;
+import java.security.AccessController;
+import java.security.PrivilegedAction;
 import org.eclipse.jgit.io.Entry;
 import org.eclipse.jgit.io.StorageSystem;
 
@@ -50,6 +56,14 @@
         implements StorageSystem {
 
   public static final String PROTOCOL_FILE = "file";
+  public static final Platform platform;
+  public static Method canExecute;
+  public static Method setExecute;
+  public static String cygpath;
+
+  static {
+    platform = Platform.detect();
+  }
 
   public String getURIScheme() {
     return PROTOCOL_FILE;
@@ -68,4 +82,149 @@ public Entry getWorkingDirectory() {
     String curDir = System.getProperty("user.dir");
     return new LocalFileEntry(new File(curDir), this);
   }
+
+  public Entry resolve(Entry entry,
+                       String path) {
+    if (!(entry instanceof LocalFileEntry)) {
+      return null;
+    }
+    LocalFileEntry fileEntry = (LocalFileEntry) entry;
+    File localFile = fileEntry.getLocalFile();
+    if (platform.equals(Platform.WIN32_CYGWIN)) {
+      try {
+        final Process p;
+
+        p = Runtime.getRuntime().exec(
+                new String[] {cygpath, "--windows", "--absolute", path},
+                null, localFile);
+        p.getOutputStream().close();
+
+        final BufferedReader lineRead = new BufferedReader(
+                new InputStreamReader(p.getInputStream(), "UTF-8"));
+        String r = null;
+        try {
+          r = lineRead.readLine();
+        }
+        finally {
+          lineRead.close();
+        }
+
+        for (;;) {
+          try {
+            if (p.waitFor() == 0 && r != null && r.length() > 0) {
+              return new LocalFileEntry(new File(r), this);
+            }
+            break;
+          }
+          catch (InterruptedException ie) {
+            // Stop bothering me, I have a zombie to reap.
+          }
+        }
+      }
+      catch (IOException ioe) {
+        // Fall through and use the default return.
+      }
+
+    }
+    final File abspn = new File(path);
+    if (abspn.isAbsolute()) {
+      return new LocalFileEntry(abspn, this);
+    }
+    return new LocalFileEntry(new File(localFile, path), this);
+  }
+
+  public Entry getHomeDirectory() {
+    if (platform.equals(Platform.WIN32_CYGWIN)) {
+      final String home = AccessController.doPrivileged(new PrivilegedAction<String>() {
+
+        public String run() {
+          return System.getenv("HOME");
+        }
+      });
+      if (!(home == null || home.length() == 0)) {
+        return resolve(new LocalFileEntry(new File("."), this), home);
+      }
+    }
+    final String home = AccessController.doPrivileged(new PrivilegedAction<String>() {
+
+      public String run() {
+        return System.getProperty("user.home");
+      }
+    });
+    if (home == null || home.length() == 0) {
+      return null;
+    }
+    return new LocalFileEntry(new File(home).getAbsoluteFile(), this);
+  }
+
+  public enum Platform {
+
+    WIN32_CYGWIN(false),
+    WIN32(false),
+    POSIX_JAVA5(false),
+    POSIX_JAVA6(true);
+    private boolean executableSupproted;
+
+    private Platform(boolean executableSupproted) {
+      this.executableSupproted = executableSupproted;
+    }
+
+    public boolean isExecutableSupproted() {
+      return executableSupproted;
+    }
+
+    public static Platform detect() {
+      final String osDotName = AccessController.doPrivileged(new PrivilegedAction<String>() {
+
+        public String run() {
+          return System.getProperty("os.name");
+        }
+      });
+      if (osDotName != null &&
+          osDotName.toLowerCase().indexOf("windows") != -1) {
+        final String path = AccessController.doPrivileged(new PrivilegedAction<String>() {
+
+          public String run() {
+            return System.getProperty("java.library.path");
+          }
+        });
+        if (path == null) {
+          return WIN32;
+        }
+        for (final String p : path.split(";")) {
+          final File e = new File(p, "cygpath.exe");
+          if (e.isFile()) {
+            cygpath = e.getAbsolutePath();
+            return WIN32_CYGWIN;
+          }
+        }
+        return WIN32;
+      }
+      else {
+        canExecute = needMethod(File.class, "canExecute");
+        setExecute = needMethod(File.class, "setExecutable",
+                Boolean.TYPE);
+        if (canExecute != null && setExecute != null) {
+          return POSIX_JAVA6;
+        }
+        else {
+          return POSIX_JAVA5;
+        }
+      }
+    }
+
+    private static Method needMethod(final Class<?> on,
+                                     final String name,
+                                     final Class<?>... args) {
+      try {
+        return on.getMethod(name, args);
+      }
+      catch (SecurityException e) {
+        return null;
+      }
+      catch (NoSuchMethodException e) {
+        return null;
+      }
+    }
+  }
 }
-- 
1.6.2.1
