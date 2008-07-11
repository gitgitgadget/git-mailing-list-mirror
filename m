From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] Create a listener structure for changes to refs and index
Date: Fri, 11 Jul 2008 11:27:21 +0200
Message-ID: <1215768441-599-1-git-send-email-robin.rosenberg@dewire.com>
References: <20080711042251.GB32633@spearce.org>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:35:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHF0P-0000zu-Sx
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 11:33:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbYGKJcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 05:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751731AbYGKJcf
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 05:32:35 -0400
Received: from [83.140.172.130] ([83.140.172.130]:15206 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbYGKJcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 05:32:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E9B05802846;
	Fri, 11 Jul 2008 11:32:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qn1YbEbv7Gw; Fri, 11 Jul 2008 11:32:30 +0200 (CEST)
Received: from localhost.localdomain (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 64D898006B7;
	Fri, 11 Jul 2008 11:32:30 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.2.220.g44701
In-Reply-To: <20080711042251.GB32633@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88101>

This version does not tell you which refs have changed, nor
what changes have happened. There is not scanning for externally
initiated changes either, though such changes can be found when
a JGit client wants to read index or refs information.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 .../egit/ui/internal/history/GitHistoryPage.java   |   31 +++++++++-
 .../src/org/spearce/jgit/lib/GitIndex.java         |    3 +
 .../org/spearce/jgit/lib/IndexChangedEvent.java    |   55 +++++++++++++++++
 .../src/org/spearce/jgit/lib/RefDatabase.java      |   19 ++++++
 .../src/org/spearce/jgit/lib/RefsChangedEvent.java |   55 +++++++++++++++++
 .../src/org/spearce/jgit/lib/Repository.java       |   41 +++++++++++++
 .../org/spearce/jgit/lib/RepositoryAdapter.java    |   54 ++++++++++++++++
 .../spearce/jgit/lib/RepositoryChangedEvent.java   |   64 ++++++++++++++++++++
 .../org/spearce/jgit/lib/RepositoryListener.java   |   63 +++++++++++++++++++
 9 files changed, 384 insertions(+), 1 deletions(-)
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/IndexChangedEvent.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RefsChangedEvent.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryAdapter.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryChangedEvent.java
 create mode 100644 org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryListener.java

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
index 6b55185..7e2f726 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/history/GitHistoryPage.java
@@ -61,7 +61,10 @@ import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIPreferences;
 import org.spearce.egit.ui.UIText;
 import org.spearce.jgit.lib.AnyObjectId;
+import org.spearce.jgit.lib.IndexChangedEvent;
+import org.spearce.jgit.lib.RefsChangedEvent;
 import org.spearce.jgit.lib.Repository;
+import org.spearce.jgit.lib.RepositoryListener;
 import org.spearce.jgit.revplot.PlotCommit;
 import org.spearce.jgit.revwalk.RevCommit;
 import org.spearce.jgit.revwalk.RevFlag;
@@ -73,7 +76,7 @@ import org.spearce.jgit.treewalk.filter.PathFilterGroup;
 import org.spearce.jgit.treewalk.filter.TreeFilter;
 
 /** Graphical commit history viewer. */
-public class GitHistoryPage extends HistoryPage {
+public class GitHistoryPage extends HistoryPage implements RepositoryListener {
 	private static final String PREF_COMMENT_WRAP = UIPreferences.RESOURCEHISTORY_SHOW_COMMENT_WRAP;
 
 	private static final String PREF_COMMENT_FILL = UIPreferences.RESOURCEHISTORY_SHOW_COMMENT_FILL;
@@ -230,6 +233,32 @@ public class GitHistoryPage extends HistoryPage {
 		layout();
 	}
 
+	private Runnable refschangedRunnable;
+
+	public void refsChanged(final RefsChangedEvent e) {
+		if (getControl().isDisposed())
+			return;
+
+		synchronized (this) {
+			if (refschangedRunnable == null) {
+				refschangedRunnable = new Runnable() {
+					public void run() {
+						if (!getControl().isDisposed()) {
+							Activator.trace("Executing async repository changed event");
+							refschangedRunnable = null;
+							inputSet();
+						}
+					}
+				};
+				getControl().getDisplay().asyncExec(refschangedRunnable);
+			}
+		}
+	}
+
+	public void indexChanged(final IndexChangedEvent e) {
+		// We do not use index information here now
+	}
+
 	private void finishContextMenu() {
 		popupMgr.add(new Separator());
 		popupMgr.add(new Separator(IWorkbenchActionConstants.MB_ADDITIONS));
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
index 5be404e..c7a4402 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/GitIndex.java
@@ -146,6 +146,7 @@ public class GitIndex {
 	public void rereadIfNecessary() throws IOException {
 		if (cacheFile.exists() && cacheFile.lastModified() != lastCacheTime) {
 			read();
+			db.fireIndexChanged();
 		}
 	}
 
@@ -269,6 +270,8 @@ public class GitIndex {
 						"Could not rename temporary index file to index");
 			changed = false;
 			statDirty = false;
+			lastCacheTime = cacheFile.lastModified();
+			db.fireIndexChanged();
 		} finally {
 			if (!lock.delete())
 				throw new IOException(
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/IndexChangedEvent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexChangedEvent.java
new file mode 100644
index 0000000..30a40d1
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/IndexChangedEvent.java
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+ * - Neither the name of the Git Development Community nor the
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
+
+package org.spearce.jgit.lib;
+
+/**
+ * This class passes information about a changed Git index to a
+ * {@link RepositoryListener}
+ *
+ * Currently only a reference to the repository is passed.
+ */
+public class IndexChangedEvent extends RepositoryChangedEvent {
+	IndexChangedEvent(final Repository repository) {
+		super(repository);
+	}
+
+	@Override
+	public String toString() {
+		return "IndexChangedEvent[" + getRepository() + "]";
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 9e3e020..ebfa7f5 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -81,6 +81,12 @@ class RefDatabase {
 
 	private long packedRefsLength;
 
+	long lastRefModification;
+
+	long lastNotifiedRefModification;
+
+	static int refModificationCounter;
+
 	RefDatabase(final Repository r) {
 		db = r;
 		gitDir = db.getDirectory();
@@ -132,6 +138,8 @@ class RefDatabase {
 
 	void stored(final String name, final ObjectId id, final long time) {
 		looseRefs.put(name, new CachedRef(Ref.Storage.LOOSE, name, id, time));
+		setModified();
+		db.fireRefsMaybeChanged();
 	}
 
 	/**
@@ -155,6 +163,12 @@ class RefDatabase {
 		}
 		if (!lck.commit())
 			throw new ObjectWritingException("Unable to write " + name);
+		setModified();
+		db.fireRefsMaybeChanged();
+	}
+
+	void setModified() {
+		lastRefModification = refModificationCounter++;
 	}
 
 	Ref readRef(final String partialName) throws IOException {
@@ -192,6 +206,7 @@ class RefDatabase {
 		readPackedRefs(avail);
 		readLooseRefs(avail, REFS_SLASH, refsDir);
 		readOneLooseRef(avail, Constants.HEAD, new File(gitDir, Constants.HEAD));
+		db.fireRefsMaybeChanged();
 		return avail;
 	}
 
@@ -321,6 +336,8 @@ class RefDatabase {
 			return r != null ? r : new Ref(Ref.Storage.LOOSE, target, null);
 		}
 
+		setModified();
+
 		final ObjectId id;
 		try {
 			id = ObjectId.fromString(line);
@@ -378,6 +395,7 @@ class RefDatabase {
 			packedRefsLastModified = currTime;
 			packedRefsLength = currLen;
 			packedRefs = newPackedRefs;
+			setModified();
 		} catch (FileNotFoundException noPackedRefs) {
 			// Ignore it and leave the new map empty.
 			//
@@ -414,4 +432,5 @@ class RefDatabase {
 			lastModified = mtime;
 		}
 	}
+
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefsChangedEvent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefsChangedEvent.java
new file mode 100644
index 0000000..c8936c7
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefsChangedEvent.java
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+ * - Neither the name of the Git Development Community nor the
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
+
+package org.spearce.jgit.lib;
+
+/**
+ * This class passes information about a changed Git index to a
+ * {@link RepositoryListener}
+ *
+ * Currently only a reference to the repository is passed.
+ */
+public class RefsChangedEvent extends RepositoryChangedEvent {
+	RefsChangedEvent(final Repository repository) {
+		super(repository);
+	}
+
+	@Override
+	public String toString() {
+		return "RefsChangedEvent[" + getRepository() + "]";
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
index 04d9b13..6f78652 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Repository.java
@@ -49,7 +49,9 @@ import java.util.ArrayList;
 import java.util.Collection;
 import java.util.HashMap;
 import java.util.LinkedList;
+import java.util.List;
 import java.util.Map;
+import java.util.Vector;
 
 import org.spearce.jgit.errors.IncorrectObjectTypeException;
 import org.spearce.jgit.errors.RevisionSyntaxException;
@@ -92,6 +94,8 @@ public class Repository {
 
 	private GitIndex index;
 
+	private List<RepositoryListener> listeners = new Vector<RepositoryListener>(); // thread safe
+
 	/**
 	 * Construct a representation of a Git repository.
 	 * 
@@ -1028,4 +1032,41 @@ public class Repository {
 	public File getWorkDir() {
 		return getDirectory().getParentFile();
 	}
+
+	/**
+	 * Register a {@link RepositoryListener} which will be notified
+	 * when ref changes are detected.
+	 *
+	 * @param l
+	 */
+	public void addRepositoryChangedListener(final RepositoryListener l) {
+		listeners.add(l);
+	}
+
+	/**
+	 * Remove a registered {@link RepositoryListener}
+	 * @param l
+	 */
+	public void removeRepositoryChangedListener(final RepositoryListener l) {
+		listeners.remove(l);
+	}
+
+	void fireRefsMaybeChanged() {
+		if (refs.lastRefModification != refs.lastNotifiedRefModification) {
+			refs.lastNotifiedRefModification = refs.lastRefModification;
+			final RefsChangedEvent event = new RefsChangedEvent(this);
+			for (final RepositoryListener l :
+				listeners.toArray(new RepositoryListener[listeners.size()])) {
+				l.refsChanged(event);
+			}
+		}
+	}
+
+	void fireIndexChanged() {
+		final IndexChangedEvent event = new IndexChangedEvent(this);
+		for (final RepositoryListener l :
+			listeners.toArray(new RepositoryListener[listeners.size()])) {
+			l.indexChanged(event);
+		}
+	}
 }
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryAdapter.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryAdapter.java
new file mode 100644
index 0000000..d1ff07d
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryAdapter.java
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+ * - Neither the name of the Git Development Community nor the
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
+
+package org.spearce.jgit.lib;
+
+/**
+ * A default {@link RepositoryListener} that does nothing except invoke an
+ * optional general method for any repository change.
+ */
+public class RepositoryAdapter implements RepositoryListener {
+
+	public void indexChanged(final IndexChangedEvent e) {
+		// Empty
+	}
+
+	public void refsChanged(final RefsChangedEvent e) {
+		// Empty
+	}
+
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryChangedEvent.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryChangedEvent.java
new file mode 100644
index 0000000..b58df87
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryChangedEvent.java
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+ * - Neither the name of the Git Development Community nor the
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
+
+package org.spearce.jgit.lib;
+
+/**
+ * This class passes information about changed refs to a
+ * {@link RepositoryListener}
+ *
+ * Currently only a reference to the repository is passed.
+ */
+public class RepositoryChangedEvent {
+	private final Repository repository;
+
+	RepositoryChangedEvent(final Repository repository) {
+		this.repository = repository;
+	}
+
+	/**
+	 * @return the repository that was changed
+	 */
+	public Repository getRepository() {
+		return repository;
+	}
+
+	@Override
+	public String toString() {
+		return "RepositoryChangedEvent[" + repository + "]";
+	}
+}
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryListener.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryListener.java
new file mode 100644
index 0000000..ceb14ce
--- /dev/null
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RepositoryListener.java
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2008, Robin Rosenberg <robin.rosenberg@dewire.com>
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
+ * - Neither the name of the Git Development Community nor the
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
+
+package org.spearce.jgit.lib;
+
+/**
+ * A RepositoryListener gets notification about changes in refs or repository.
+ * <p>
+ * It currently does <em>not</em> get notification about which items are
+ * changed.
+ */
+public interface RepositoryListener {
+	/**
+	 * Invoked when a ref changes
+	 *
+	 * @param e
+	 *            information about the changes.
+	 */
+	void refsChanged(RefsChangedEvent e);
+
+	/**
+	 * Invoked when the index changes
+	 *
+	 * @param e
+	 *            information about the changes.
+	 */
+	void indexChanged(IndexChangedEvent e);
+
+}
-- 
1.5.6.2.220.g44701
