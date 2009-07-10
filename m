From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] FindBugs: don't use new String(String) in RefDatabase
Date: Fri, 10 Jul 2009 08:34:41 -0700
Message-ID: <20090710153441.GF11191@spearce.org>
References: <49C20D4E.5020203@gmail.com> <20090319160102.GQ23521@spearce.org> <551f769b0907090147x9b78604i77a095441f232703@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 17:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPI7d-0000mS-NF
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 17:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbZGJPeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 11:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbZGJPen
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 11:34:43 -0400
Received: from george.spearce.org ([209.20.77.23]:44146 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZGJPem (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 11:34:42 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BA76F3819F; Fri, 10 Jul 2009 15:34:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <551f769b0907090147x9b78604i77a095441f232703@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123058>

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
 > 2009/3/19 Shawn O. Pearce <spearce@spearce.org>:
 > > Yann Simon <yann.simon.fr@gmail.com> wrote:
 > >> From FindBugs:
 > >> Using the java.lang.String(String) constructor wastes [...]
 > 
 > However, using the trick newString = new String(aString.substring(),
 > i) does not work on all JVM.
 > With an IBM JVM, the newString will still contain the original array of chars.
 > 
 > Another solution that work on all JVM could be:
 > newString = new String(aString.substring(i).toCharArray())
 > Or
 > newString = new String(aString.toCharArray(), i, aString.length() - i)
 > 
 > I like the latter one.

 I prefer this.  It should always do what we want, and at a lower
 temporary memory footprint (one less copy of the name).  IIRC Robin
 rejected it earlier because it wasn't obvious what we were doing. I
 say hogwash, its clear as mud.
 
 .../src/org/spearce/jgit/lib/RefDatabase.java      |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

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
1.6.3.3.507.gc6b5a
