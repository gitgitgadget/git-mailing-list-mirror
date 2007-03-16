From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug in read-tree -m on A -> A/A
Date: Thu, 15 Mar 2007 23:25:22 -0700
Message-ID: <7v6491yab1.fsf@assigned-by-dhcp.cox.net>
References: <20070316041932.GA31606@spearce.org>
	<7v4polzsrn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 07:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS5sW-0007y1-Tb
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 07:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436AbXCPGZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 02:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752468AbXCPGZY
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 02:25:24 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53620 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbXCPGZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 02:25:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070316062523.GJUR18070.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Mar 2007 02:25:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id bJRN1W00d1kojtg0000000; Fri, 16 Mar 2007 02:25:23 -0400
In-Reply-To: <7v4polzsrn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 15 Mar 2007 22:01:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42329>

Junio C Hamano <junkio@cox.net> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> ....  The following test appears to
>> trigger the same failure,...
>
> You have file "A" on one branch, and file "A/A" on another
> branch.  You are on the latter branch and switching to the
> former one.
>
> The following patch illustrates where you need to implement an
> alternate, loosened check, but should not be applied to your
> tree as-is.  If you have local modification to path "A/A", this
> will lose it.

This does not do the bottom-up merge, but tries to catch the
lossy case within the limit of the current framework.

Only lightly tested, and I won't be applying it as-is yet as I
am not thinking very clearly tonight (no, I am not drunk, just
under the weather a bit).

Testing and improvements are very much appreciated.

---
 unpack-trees.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 74 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 2e2232c..2288762 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -468,6 +468,60 @@ static void invalidate_ce_path(struct cache_entry *ce)
 		cache_tree_invalidate_path(active_cache_tree, ce->name);
 }
 
+static void verify_clean_subdirectory(const char *path, const char *action,
+				      struct unpack_trees_options *o)
+{
+	/*
+	 * we are about to extract "path"; we would not want to lose
+	 * anything in the existing directory there.
+	 */
+	int namelen;
+	int pos, i;
+	struct dir_struct d;
+	char *pathbuf;
+
+	/*
+	 * First let's make sure we do not have a local modification
+	 * in that directory.
+	 */
+	namelen = strlen(path);
+	pos = cache_name_pos(path, namelen);
+	if (0 <= pos)
+		return; /* we have it as nondirectory */
+	pos = -pos - 1;
+	for (i = pos; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		int len = ce_namelen(ce);
+		if (len < namelen ||
+		    strncmp(path, ce->name, namelen) ||
+		    ce->name[namelen] != '/')
+			break;
+		/*
+		 * ce->name is an entry in the subdirectory.
+		 */
+		verify_uptodate(ce, o);
+	}
+
+	/*
+	 * Then we need to make sure that we do not lose a locally
+	 * present file that is not ignored.
+	 */
+	if (!o->dir)
+		return;
+
+	pathbuf = xmalloc(namelen + 2);
+	memcpy(pathbuf, path, namelen);
+	strcpy(pathbuf+namelen, "/");
+
+	memset(&d, 0, sizeof(d));
+	d.exclude_per_dir = o->dir->exclude_per_dir;
+	i = read_directory(&d, path, pathbuf, namelen+1);
+	if (i)
+		die("Updating '%s' would lose untracked files in it",
+		    path);
+	free(pathbuf);
+}
+
 /*
  * We do not want to remove or overwrite a working tree file that
  * is not tracked, unless it is ignored.
@@ -479,9 +533,28 @@ static void verify_absent(const char *path, const char *action,
 
 	if (o->index_only || o->reset || !o->update)
 		return;
-	if (!lstat(path, &st) && !(o->dir && excluded(o->dir, path)))
+
+	if (!lstat(path, &st)) {
+		if (o->dir && excluded(o->dir, path))
+			/*
+			 * path is explicitly excluded, so it is Ok to
+			 * overwrite it.
+			 */
+			return;
+		if (S_ISDIR(st.st_mode))
+			/*
+			 * We are checking out path "foo" and
+			 * found "foo/." in the working tree.
+			 * This is tricky -- if we have modified
+			 * files that are in "foo/" we would lose
+			 * it.
+			 */
+			verify_clean_subdirectory(path, action, o);
+			return;
+
 		die("Untracked working tree file '%s' "
 		    "would be %s by merge.", path, action);
+	}
 }
 
 static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
