From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [JGIT PATCH v2] FindBugs: don't use new String(String) in
	RefDatabase
Date: Mon, 13 Jul 2009 07:53:08 -0700
Message-ID: <20090713145308.GI11191@spearce.org>
References: <49C20D4E.5020203@gmail.com> <20090319160102.GQ23521@spearce.org> <551f769b0907090147x9b78604i77a095441f232703@mail.gmail.com> <20090710153441.GF11191@spearce.org> <551f769b0907130107j51d32e4er54e125f9dc61dd80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 16:53:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQMuk-0006d3-6N
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 16:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbZGMOxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 10:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846AbZGMOxL
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 10:53:11 -0400
Received: from george.spearce.org ([209.20.77.23]:33078 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbZGMOxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 10:53:09 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 89DD73819F; Mon, 13 Jul 2009 14:53:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <551f769b0907130107j51d32e4er54e125f9dc61dd80@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123195>

>From FindBugs:
  Using the java.lang.String(String) constructor wastes memory
  because the object so constructed will be functionally
  indistinguishable from the String passed as a parameter. Just
  use the argument String directly.

Actually, here we want to get a new String object that covers only
the portion of the source string that we are selected out.

The line in question, p, is from the packed-refs file and contains
the entire SHA-1 in hex form at the beginning of it.  We have already
converted that into binary as an ObjectId, which uses 1/4 the space
of the string portion.

The Ref object, its ObjectId, and its name string, are going to be
cached in a Map, probably long-term, as the packed-refs file does
not change frequently.  We are better off shedding the 80 bytes of
memory used to hold the hex SHA-1 then risk substring() deciding its
"better" to reuse the same char[] internally.

By creating a new StringBuilder of the exact required capacity for
the name, and then copying in the region of characters we really
want, we defeat the reuse substring() would normally perform, at
the tiny cost of an extra StringBuilder temporary.  Some JITs are
able to stack allocate that here, making it a trivial cost.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Yann Simon <yann.simon.fr@gmail.com>
---
 Yann Simon <yann.simon.fr@gmail.com> wrote:
 > This method is quite clear.
 > One line javadoc would make it even clearer... :p (and maybe make Robin happy)
 
 Javadoc is overrated.  Private utility methods like this that are one
 line long don't need documentation.  The rationale for why this line
 does what it does is something that `git blame` can answer better.
  
 > And you're right: by using a StringBuilder, we need one less arraycopy.
 > 
 > After committing your change, we can remove the entry to silent FindBugs.
 > (commit 21c3d82824075cd1f140b3bcf252dfaffe0fc96c)
 
 My patch is updated (below).  Thanks, I forgot about that filter.

 .../findBugs/FindBugsExcludeFilter.xml             |    7 -------
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    6 +++++-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml b/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
index 2af9348..a553170 100644
--- a/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
+++ b/org.spearce.jgit/findBugs/FindBugsExcludeFilter.xml
@@ -1,12 +1,5 @@
 <?xml version="1.0" encoding="UTF-8" ?>
 <FindBugsFilter>
-     <!-- Silence inefficient new String(String) constructor warning, see http://thread.gmane.org/gmane.comp.version-control.git/117831/focus=117937 -->
-     <Match>
-       <Class name="org.spearce.jgit.lib.RefDatabase" />
-       <Method name="refreshPackedRefs" />
-       <Bug pattern="DM_STRING_CTOR" />
-     </Match>
-
      <!-- Silence PackFile.mmap calls GC, we need to force it to remove stale
           memory mapped segments if the JVM heap is out of address space.
        -->
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
index 6d4f374..383877f 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/RefDatabase.java
@@ -438,7 +438,7 @@ private synchronized void refreshPackedRefs() {
 
 					final int sp = p.indexOf(' ');
 					final ObjectId id = ObjectId.fromString(p.substring(0, sp));
-					final String name = new String(p.substring(sp + 1));
+					final String name = copy(p, sp + 1, p.length());
 					last = new Ref(Ref.Storage.PACKED, name, name, id);
 					newPackedRefs.put(last.getName(), last);
 				}
@@ -460,6 +460,10 @@ private synchronized void refreshPackedRefs() {
 		}
 	}
 
+	private static String copy(final String src, final int off, final int end) {
+		return new StringBuilder(end - off).append(src, off, end).toString();
+	}
+
 	private void lockAndWriteFile(File file, byte[] content) throws IOException {
 		String name = file.getName();
 		final LockFile lck = new LockFile(file);
-- 
1.6.4.rc0.117.g28cb
