Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DF7C433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 07:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAD221744
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 07:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="c2C7Wvtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHEHQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:16:49 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33217 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgHEHQr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 5 Aug 2020 03:16:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596611805; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=ZI40KaUllZ+s36TprQkyAhoG5BeJw0UzXMAQIT6YI+k=; b=c2C7Wvtg+tjhdrOyvprP73lilwsfgZHS5EPTCka4B4jeaI9/9Ox8GMjrlLqISsAkWlMq3QwL
 5e9urnZGWHJRyrJIOB/e3QR5WRS9r99K07nWzdAM1tM/rLmfsQAXXIbqWnOxKplHm5NXc02f
 q5hfoA+SyLZg9jkNoXlCrIJHy1w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyJjNzk3NCIsICJnaXRAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f2a5cc514acd1952b76591b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 05 Aug 2020 07:16:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 462FCC433CA; Wed,  5 Aug 2020 07:16:20 +0000 (UTC)
Received: from achakila1-mac.qualcomm.com (c-76-107-114-73.hsd1.tn.comcast.net [76.107.114.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: achakila)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27DFBC433C9;
        Wed,  5 Aug 2020 07:16:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27DFBC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=achakila@codeaurora.org
From:   Adithya Chakilam <achakila@codeaurora.org>
To:     git@vger.kernel.org
Cc:     Nasser Grainawi <nasser@codeaurora.org>
Subject: [PATCH v1] TasksStorage: Remove delete() only used by tests
Date:   Wed,  5 Aug 2020 02:16:10 -0500
Message-Id: <20200805071610.12249-1-achakila@codeaurora.org>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nasser Grainawi <nasser@codeaurora.org>

In general we shouldn't have methods that provide behavior only for
tests. Callers of delete() in pre-3.1 code should move to start() and
finish() in 3.1. To facilitate that, update start(), reset(), and
finish() methods to not require a PushOne object. These methods can
instead use a new interface that PushOne already can implement without
functional changes.

Change-Id: Id82d2ec3125075832134c8dbe56b342e5a874bbc
---
 .../gerrit/plugins/replication/PushOne.java   |  8 ++-
 .../replication/ReplicationTasksStorage.java  | 52 +++++++-------
 .../plugins/replication/ReplicationIT.java    | 15 +++-
 .../ReplicationTasksStorageTest.java          | 68 ++++++++++++-------
 .../plugins/replication/TestUriUpdates.java   | 52 ++++++++++++++
 5 files changed, 139 insertions(+), 56 deletions(-)
 create mode 100644 src/test/java/com/googlesource/gerrit/plugins/replication/TestUriUpdates.java

diff --git a/src/main/java/com/googlesource/gerrit/plugins/replication/PushOne.java b/src/main/java/com/googlesource/gerrit/plugins/replication/PushOne.java
index 634f44d..3124940 100644
--- a/src/main/java/com/googlesource/gerrit/plugins/replication/PushOne.java
+++ b/src/main/java/com/googlesource/gerrit/plugins/replication/PushOne.java
@@ -84,7 +84,7 @@ import org.slf4j.MDC;
  * <p>Instance members are protected by the lock within PushQueue. Callers must take that lock to
  * ensure they are working with a current view of the object.
  */
-class PushOne implements ProjectRunnable, CanceledWhileRunning {
+class PushOne implements ProjectRunnable, CanceledWhileRunning, ReplicationTasksStorage.UriUpdates {
   private final ReplicationStateListener stateLog;
   static final String ALL_REFS = "..all..";
   static final String ID_MDC_KEY = "pushOneId";
@@ -230,7 +230,8 @@ class PushOne implements ProjectRunnable, CanceledWhileRunning {
     return canceled || canceledWhileRunning.get();
   }
 
-  URIish getURI() {
+  @Override
+  public URIish getURI() {
     return uri;
   }
 
@@ -244,7 +245,8 @@ class PushOne implements ProjectRunnable, CanceledWhileRunning {
     }
   }
 
-  Set<String> getRefs() {
+  @Override
+  public Set<String> getRefs() {
     return pushAllRefs ? Sets.newHashSet(ALL_REFS) : delta;
   }
 
diff --git a/src/main/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorage.java b/src/main/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorage.java
index 370d48b..8a5aba2 100644
--- a/src/main/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorage.java
+++ b/src/main/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorage.java
@@ -19,6 +19,7 @@ import static java.nio.charset.StandardCharsets.UTF_8;
 import com.google.common.annotations.VisibleForTesting;
 import com.google.common.flogger.FluentLogger;
 import com.google.common.hash.Hashing;
+import com.google.gerrit.entities.Project;
 import com.google.gson.Gson;
 import com.google.inject.Inject;
 import com.google.inject.ProvisionException;
@@ -32,6 +33,7 @@ import java.nio.file.Path;
 import java.nio.file.StandardCopyOption;
 import java.util.ArrayList;
 import java.util.List;
+import java.util.Set;
 import org.eclipse.jgit.lib.ObjectId;
 import org.eclipse.jgit.transport.URIish;
 
@@ -68,8 +70,12 @@ public class ReplicationTasksStorage {
     public final String uri;
     public final String remote;
 
-    public ReplicateRefUpdate(PushOne push, String ref) {
-      this(push.getProjectNameKey().get(), ref, push.getURI(), push.getRemoteName());
+    public ReplicateRefUpdate(UriUpdates uriUpdates, String ref) {
+      this(
+          uriUpdates.getProjectNameKey().get(),
+          ref,
+          uriUpdates.getURI(),
+          uriUpdates.getRemoteName());
     }
 
     public ReplicateRefUpdate(String project, String ref, URIish uri, String remote) {
@@ -85,6 +91,16 @@ public class ReplicationTasksStorage {
     }
   }
 
+  public interface UriUpdates {
+    Project.NameKey getProjectNameKey();
+
+    URIish getURI();
+
+    String getRemoteName();
+
+    Set<String> getRefs();
+  }
+
   private static final Gson GSON = new Gson();
 
   private final Path refUpdates;
@@ -114,20 +130,15 @@ public class ReplicationTasksStorage {
     this.disableDeleteForTesting = deleteDisabled;
   }
 
-  @VisibleForTesting
-  public void delete(ReplicateRefUpdate r) {
-    new Task(r).delete();
-  }
-
-  public synchronized void start(PushOne push) {
-    for (String ref : push.getRefs()) {
-      new Task(new ReplicateRefUpdate(push, ref)).start();
+  public synchronized void start(UriUpdates uriUpdates) {
+    for (String ref : uriUpdates.getRefs()) {
+      new Task(new ReplicateRefUpdate(uriUpdates, ref)).start();
     }
   }
 
-  public synchronized void reset(PushOne push) {
-    for (String ref : push.getRefs()) {
-      new Task(new ReplicateRefUpdate(push, ref)).reset();
+  public synchronized void reset(UriUpdates uriUpdates) {
+    for (String ref : uriUpdates.getRefs()) {
+      new Task(new ReplicateRefUpdate(uriUpdates, ref)).reset();
     }
   }
 
@@ -137,9 +148,9 @@ public class ReplicationTasksStorage {
     }
   }
 
-  public synchronized void finish(PushOne push) {
-    for (String ref : push.getRefs()) {
-      new Task(new ReplicateRefUpdate(push, ref)).finish();
+  public synchronized void finish(UriUpdates uriUpdates) {
+    for (String ref : uriUpdates.getRefs()) {
+      new Task(new ReplicateRefUpdate(uriUpdates, ref)).finish();
     }
   }
 
@@ -261,15 +272,6 @@ public class ReplicationTasksStorage {
       }
     }
 
-    public void delete() {
-      try {
-        Files.deleteIfExists(waiting);
-        Files.deleteIfExists(running);
-      } catch (IOException e) {
-        logger.atSevere().withCause(e).log("Error while deleting task %s", taskKey);
-      }
-    }
-
     private void rename(Path from, Path to) {
       try {
         logger.atFine().log("RENAME %s to %s %s", from, to, updateLog());
diff --git a/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationIT.java b/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationIT.java
index 31cd75d..bb0f283 100644
--- a/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationIT.java
+++ b/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationIT.java
@@ -36,7 +36,9 @@ import com.google.gerrit.server.config.SitePaths;
 import com.google.inject.Inject;
 import com.google.inject.Key;
 import com.googlesource.gerrit.plugins.replication.ReplicationTasksStorage.ReplicateRefUpdate;
+import com.googlesource.gerrit.plugins.replication.ReplicationTasksStorage.UriUpdates;
 import java.io.IOException;
+import java.net.URISyntaxException;
 import java.nio.file.DirectoryStream;
 import java.nio.file.Files;
 import java.nio.file.Path;
@@ -449,7 +451,7 @@ public class ReplicationIT extends LightweightPluginDaemonTest {
   }
 
   @Test
-  public void shouldFirePendingOnlyToStoredUri() throws Exception {
+  public void shouldFirePendingOnlyToRemainingUris() throws Exception {
     String suffix1 = "replica1";
     String suffix2 = "replica2";
     Project.NameKey target1 = createTestProject(project + suffix1);
@@ -463,7 +465,16 @@ public class ReplicationIT extends LightweightPluginDaemonTest {
     String changeRef = createChange().getPatchSet().refName();
 
     tasksStorage.disableDeleteForTesting(false);
-    changeReplicationTasksForRemote(changeRef, remote1).forEach(tasksStorage::delete);
+    changeReplicationTasksForRemote(changeRef, remote1)
+        .forEach(
+            (update) -> {
+              try {
+                UriUpdates uriUpdates = TestUriUpdates.create(update);
+                tasksStorage.start(uriUpdates);
+                tasksStorage.finish(uriUpdates);
+              } catch (URISyntaxException e) {
+              }
+            });
     tasksStorage.disableDeleteForTesting(true);
 
     setReplicationDestination(remote1, suffix1, ALL_PROJECTS);
diff --git a/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorageTest.java b/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorageTest.java
index 38d5421..c102e14 100644
--- a/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorageTest.java
+++ b/src/test/java/com/googlesource/gerrit/plugins/replication/ReplicationTasksStorageTest.java
@@ -22,6 +22,7 @@ import static org.junit.Assert.assertTrue;
 import com.google.common.jimfs.Configuration;
 import com.google.common.jimfs.Jimfs;
 import com.googlesource.gerrit.plugins.replication.ReplicationTasksStorage.ReplicateRefUpdate;
+import com.googlesource.gerrit.plugins.replication.ReplicationTasksStorage.UriUpdates;
 import java.net.URISyntaxException;
 import java.nio.file.FileSystem;
 import java.nio.file.Path;
@@ -42,12 +43,14 @@ public class ReplicationTasksStorageTest {
   protected ReplicationTasksStorage storage;
   protected FileSystem fileSystem;
   protected Path storageSite;
+  protected UriUpdates uriUpdates;
 
   @Before
   public void setUp() throws Exception {
     fileSystem = Jimfs.newFileSystem(Configuration.unix());
     storageSite = fileSystem.getPath("replication_site");
     storage = new ReplicationTasksStorage(storageSite);
+    uriUpdates = TestUriUpdates.create(REF_UPDATE);
   }
 
   @After
@@ -67,9 +70,10 @@ public class ReplicationTasksStorageTest {
   }
 
   @Test
-  public void canDeletePersistedUpdate() throws Exception {
+  public void canFinishPersistedUpdate() throws Exception {
     storage.create(REF_UPDATE);
-    storage.delete(REF_UPDATE);
+    storage.start(uriUpdates);
+    storage.finish(uriUpdates);
     assertThat(storage.list()).isEmpty();
   }
 
@@ -84,7 +88,8 @@ public class ReplicationTasksStorageTest {
     assertContainsExactly(storage, REF_UPDATE);
     assertContainsExactly(persistedView, REF_UPDATE);
 
-    storage.delete(REF_UPDATE);
+    storage.start(uriUpdates);
+    storage.finish(uriUpdates);
     assertThat(storage.list()).isEmpty();
     assertThat(persistedView.list()).isEmpty();
   }
@@ -113,20 +118,23 @@ public class ReplicationTasksStorageTest {
   }
 
   @Test
-  public void canDeleteDifferentUris() throws Exception {
+  public void canFinishDifferentUris() throws Exception {
     ReplicateRefUpdate updateB =
         new ReplicateRefUpdate(
             PROJECT,
             REF,
             getUrish("ssh://example.com/" + PROJECT + ".git"), // uses ssh not http
             REMOTE);
+    UriUpdates uriUpdatesB = TestUriUpdates.create(updateB);
     storage.create(REF_UPDATE);
     storage.create(updateB);
+    storage.start(uriUpdates);
+    storage.start(uriUpdatesB);
 
-    storage.delete(REF_UPDATE);
+    storage.finish(uriUpdates);
     assertContainsExactly(storage, updateB);
 
-    storage.delete(updateB);
+    storage.finish(uriUpdatesB);
     assertThat(storage.list()).isEmpty();
   }
 
@@ -158,47 +166,55 @@ public class ReplicationTasksStorageTest {
   }
 
   @Test
-  public void canDeleteMulipleRefsForSameUri() throws Exception {
-    ReplicateRefUpdate refA = new ReplicateRefUpdate(PROJECT, "refA", URISH, REMOTE);
-    ReplicateRefUpdate refB = new ReplicateRefUpdate(PROJECT, "refB", URISH, REMOTE);
-    storage.create(refA);
-    storage.create(refB);
-
-    storage.delete(refA);
-    assertContainsExactly(storage, refB);
-
-    storage.delete(refB);
+  public void canFinishMulipleRefsForSameUri() throws Exception {
+    ReplicateRefUpdate refUpdateA = new ReplicateRefUpdate(PROJECT, "refA", URISH, REMOTE);
+    ReplicateRefUpdate refUpdateB = new ReplicateRefUpdate(PROJECT, "refB", URISH, REMOTE);
+    UriUpdates uriUpdatesA = TestUriUpdates.create(refUpdateA);
+    UriUpdates uriUpdatesB = TestUriUpdates.create(refUpdateB);
+    storage.create(refUpdateA);
+    storage.create(refUpdateB);
+    storage.start(uriUpdatesA);
+    storage.start(uriUpdatesB);
+
+    storage.finish(uriUpdatesA);
+    assertContainsExactly(storage, refUpdateB);
+
+    storage.finish(uriUpdatesB);
     assertThat(storage.list()).isEmpty();
   }
 
   @Test(expected = Test.None.class /* no exception expected */)
-  public void illegalDeleteNonPersistedIsGraceful() throws Exception {
-    storage.delete(REF_UPDATE);
+  public void illegalFinishNonPersistedIsGraceful() throws Exception {
+    storage.finish(uriUpdates);
   }
 
   @Test(expected = Test.None.class /* no exception expected */)
-  public void illegalDoubleDeleteIsGraceful() throws Exception {
+  public void illegalDoubleFinishIsGraceful() throws Exception {
     storage.create(REF_UPDATE);
-    storage.delete(REF_UPDATE);
+    storage.start(uriUpdates);
+    storage.finish(uriUpdates);
 
-    storage.delete(REF_UPDATE);
+    storage.finish(uriUpdates);
   }
 
   @Test(expected = Test.None.class /* no exception expected */)
-  public void illegalDoubleDeleteDifferentUriIsGraceful() throws Exception {
+  public void illegalDoubleFinishDifferentUriIsGraceful() throws Exception {
     ReplicateRefUpdate updateB =
         new ReplicateRefUpdate(
             PROJECT,
             REF,
             getUrish("ssh://example.com/" + PROJECT + ".git"), // uses ssh not http
             REMOTE);
+    UriUpdates uriUpdatesB = TestUriUpdates.create(updateB);
     storage.create(REF_UPDATE);
     storage.create(updateB);
-    storage.delete(REF_UPDATE);
-    storage.delete(updateB);
+    storage.start(uriUpdates);
+    storage.start(uriUpdatesB);
+    storage.finish(uriUpdates);
+    storage.finish(uriUpdatesB);
 
-    storage.delete(REF_UPDATE);
-    storage.delete(updateB);
+    storage.finish(uriUpdates);
+    storage.finish(uriUpdatesB);
     assertThat(storage.list()).isEmpty();
   }
 
diff --git a/src/test/java/com/googlesource/gerrit/plugins/replication/TestUriUpdates.java b/src/test/java/com/googlesource/gerrit/plugins/replication/TestUriUpdates.java
new file mode 100644
index 0000000..b9e9701
--- /dev/null
+++ b/src/test/java/com/googlesource/gerrit/plugins/replication/TestUriUpdates.java
@@ -0,0 +1,52 @@
+// Copyright (C) 2020 The Android Open Source Project
+//
+// Licensed under the Apache License, Version 2.0 (the "License");
+// you may not use this file except in compliance with the License.
+// You may obtain a copy of the License at
+//
+// http://www.apache.org/licenses/LICENSE-2.0
+//
+// Unless required by applicable law or agreed to in writing, software
+// distributed under the License is distributed on an "AS IS" BASIS,
+// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+// See the License for the specific language governing permissions and
+// limitations under the License.
+
+package com.googlesource.gerrit.plugins.replication;
+
+import com.google.auto.value.AutoValue;
+import com.google.gerrit.entities.Project;
+import com.googlesource.gerrit.plugins.replication.ReplicationTasksStorage.ReplicateRefUpdate;
+import com.googlesource.gerrit.plugins.replication.ReplicationTasksStorage.UriUpdates;
+import java.net.URISyntaxException;
+import java.util.Collections;
+import java.util.Set;
+import org.eclipse.jgit.transport.URIish;
+
+@AutoValue
+public abstract class TestUriUpdates implements UriUpdates {
+  public static TestUriUpdates create(ReplicateRefUpdate update) throws URISyntaxException {
+    return create(
+        Project.nameKey(update.project),
+        new URIish(update.uri),
+        update.remote,
+        Collections.singleton(update.ref));
+  }
+
+  public static TestUriUpdates create(
+      Project.NameKey project, URIish uri, String remote, Set<String> refs) {
+    return new AutoValue_TestUriUpdates(project, uri, remote, refs);
+  }
+
+  @Override
+  public abstract Project.NameKey getProjectNameKey();
+
+  @Override
+  public abstract URIish getURI();
+
+  @Override
+  public abstract String getRemoteName();
+
+  @Override
+  public abstract Set<String> getRefs();
+}
-- 
2.24.3 (Apple Git-128)

