From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [EGIT PATCH 3/6] Adapt Git team operations to non-resouce objects
Date: Fri, 11 Jul 2008 00:39:30 +0200
Message-ID: <1215729573-26536-4-git-send-email-robin.rosenberg@dewire.com>
References: <1215729573-26536-1-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-2-git-send-email-robin.rosenberg@dewire.com>
 <1215729573-26536-3-git-send-email-robin.rosenberg@dewire.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:46:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4tk-0003md-Nd
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbYGJWos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbYGJWoq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:44:46 -0400
Received: from [83.140.172.130] ([83.140.172.130]:13082 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbYGJWoo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:44:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9315B802C0D;
	Fri, 11 Jul 2008 00:44:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N29bWsgverum; Fri, 11 Jul 2008 00:44:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3EFF38030C5;
	Fri, 11 Jul 2008 00:44:39 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <1215729573-26536-3-git-send-email-robin.rosenberg@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88027>

Sometimes structures in the workbench, such as in the Project Explorer
in the Java EE perspective, are not represented directly as resources,
but connect to resources. We use the IAdaptable interface to ask for
the underlying resource and the proceed as usual.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../org/spearce/egit/core/internal/UpdateJob.java  |    2 ++
 .../egit/core/op/AssumeUnchangedOperation.java     |    6 +++---
 .../egit/core/op/DisconnectProviderOperation.java  |    7 +++----
 .../org/spearce/egit/core/op/TrackOperation.java   |    6 +++---
 .../org/spearce/egit/core/op/UntrackOperation.java |    6 +++---
 5 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java b/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java
index 9641529..be1c591 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/UpdateJob.java
@@ -21,6 +21,7 @@ import org.eclipse.core.resources.IResourceProxy;
 import org.eclipse.core.resources.IResourceProxyVisitor;
 import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.IStatus;
 import org.eclipse.core.runtime.NullProgressMonitor;
@@ -65,6 +66,7 @@ public class UpdateJob extends Job {
 				final int[] count=new int[1];
 				long t0=System.currentTimeMillis();
 				for (Object obj : rsrcList) {
+					obj = ((IAdaptable)obj).getAdapter(IResource.class);
 					if (obj instanceof IContainer) {
 						((IContainer)obj).accept(new IResourceProxyVisitor() {
 							public boolean visit(IResourceProxy rp) throws CoreException {
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java
index 856ef3f..78a84bb 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/AssumeUnchangedOperation.java
@@ -18,6 +18,7 @@ import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
 import org.spearce.egit.core.Activator;
@@ -51,9 +52,8 @@ public class AssumeUnchangedOperation implements IWorkspaceRunnable {
 		final IdentityHashMap<RepositoryMapping, Boolean> tomerge = new IdentityHashMap<RepositoryMapping, Boolean>();
 		m.beginTask(CoreText.AssumeUnchangedOperation_adding, rsrcList.size() * 200);
 		try {
-			final Iterator i = rsrcList.iterator();
-			while (i.hasNext()) {
-				final Object obj = i.next();
+			for (Object obj : rsrcList) {
+				obj = ((IAdaptable)obj).getAdapter(IResource.class);
 				if (obj instanceof IResource) {
 					final IResource toAssumeValid = (IResource)obj;
 					final RepositoryMapping rm = RepositoryMapping.getMapping(toAssumeValid);
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/DisconnectProviderOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/DisconnectProviderOperation.java
index 7fde335..b63c69b 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/DisconnectProviderOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/DisconnectProviderOperation.java
@@ -8,13 +8,13 @@
 package org.spearce.egit.core.op;
 
 import java.util.Collection;
-import java.util.Iterator;
 
 import org.eclipse.core.resources.IContainer;
 import org.eclipse.core.resources.IProject;
 import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
 import org.eclipse.core.runtime.SubProgressMonitor;
@@ -51,9 +51,8 @@ public class DisconnectProviderOperation implements IWorkspaceRunnable {
 		m.beginTask(CoreText.DisconnectProviderOperation_disconnecting,
 				projectList.size() * 200);
 		try {
-			final Iterator i = projectList.iterator();
-			while (i.hasNext()) {
-				final Object obj = i.next();
+			for (Object obj : projectList) {
+				obj = ((IAdaptable)obj).getAdapter(IResource.class);
 				if (obj instanceof IProject) {
 					final IProject p = (IProject) obj;
 
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
index af16cdb..29b4344 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/TrackOperation.java
@@ -21,6 +21,7 @@ import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
 import org.eclipse.team.core.Team;
@@ -65,9 +66,8 @@ public class TrackOperation implements IWorkspaceRunnable {
 		final IdentityHashMap<RepositoryMapping, Boolean> tomerge = new IdentityHashMap<RepositoryMapping, Boolean>();
 		m.beginTask(CoreText.AddOperation_adding, rsrcList.size() * 200);
 		try {
-			final Iterator i = rsrcList.iterator();
-			while (i.hasNext()) {
-				final Object obj = i.next();
+			for (Object obj : rsrcList) {
+				obj = ((IAdaptable)obj).getAdapter(IResource.class);
 				if (obj instanceof IResource) {
 					final IResource toAdd = (IResource)obj;
 					final RepositoryMapping rm = RepositoryMapping.getMapping(toAdd);
diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
index fdc9c2e..369ff38 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/op/UntrackOperation.java
@@ -20,6 +20,7 @@ import org.eclipse.core.resources.IResource;
 import org.eclipse.core.resources.IResourceVisitor;
 import org.eclipse.core.resources.IWorkspaceRunnable;
 import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.IAdaptable;
 import org.eclipse.core.runtime.IProgressMonitor;
 import org.eclipse.core.runtime.NullProgressMonitor;
 import org.spearce.egit.core.Activator;
@@ -62,9 +63,8 @@ public class UntrackOperation implements IWorkspaceRunnable {
 		final IdentityHashMap<RepositoryMapping, Boolean> tomerge = new IdentityHashMap<RepositoryMapping, Boolean>();
 		m.beginTask(CoreText.AddOperation_adding, rsrcList.size() * 200);
 		try {
-			final Iterator i = rsrcList.iterator();
-			while (i.hasNext()) {
-				final Object obj = i.next();
+			for (Object obj : rsrcList) {
+				obj = ((IAdaptable)obj).getAdapter(IResource.class);
 				if (obj instanceof IResource) {
 					final IResource toRemove = (IResource)obj;
 					final IProject p = toRemove.getProject();					
-- 
1.5.6.2.220.g44701
