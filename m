From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/3] update-index: allow --index-info to add higher stages.
Date: Wed, 07 Dec 2005 02:01:41 -0800
Message-ID: <7vr78pted6.fsf@assigned-by-dhcp.cox.net>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
	<20051201085433.GA7866@c165.ib.student.liu.se>
	<7vmzjljgwo.fsf@assigned-by-dhcp.cox.net>
	<20051202083652.GA4824@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Wed Dec 07 11:03:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ejw7W-0006Rg-Mh
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 11:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVLGKBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 05:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVLGKBn
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 05:01:43 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:6336 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750768AbVLGKBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 05:01:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207100011.DJYW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 05:00:11 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13322>

The new merge world order tells the merge strategies to leave
the cache unmerged and store the automerge result in the working
tree if automerge is not clean.  This was done for the resolve
strategy and recursive strategy when no rename is involved, but
recording a conflicting merge in the rename case could not
easily be done by the recursive strategy.

This commit adds a new input format, in addition to the exsting
two, to "update-index --index-info".

    (1) mode         SP sha1          TAB path
    The first format is what "git-apply --index-info"
    reports, and used to reconstruct a partial tree
    that is used for phony merge base tree when falling
    back on 3-way merge.

    (2) mode SP type SP sha1          TAB path
    The second format is to stuff git-ls-tree output
    into the index file.

    (3) mode         SP sha1 SP stage TAB path
    This format is to put higher order stages into the
    index file and matches git-ls-files --stage output.

To place a higher stage entry to the index, the path should
first be removed by feeding a mode=0 entry for the path, and
then feeding necessary input lines in the (3) format.

For example, starting with this index:

$ git ls-files -s
100644 8a1218a1024a212bb3db30becd860315f9f3ac52 0       frotz

$ git update-index --index-info ;# interactive session -- input follows...

0 0000000000000000000000000000000000000000	frotz
100644 8a1218a1024a212bb3db30becd860315f9f3ac52 1	frotz
100755 8a1218a1024a212bb3db30becd860315f9f3ac52 2	frotz

The first line of the input feeds 0 as the mode to remove the
path; the SHA1 does not matter as long as it is well formatted.
Then the second and third line feeds stage 1 and stage 2 entries
for that path.  After the above, we would end up with this:

$ git ls-files -s
100644 8a1218a1024a212bb3db30becd860315f9f3ac52 1	frotz
100755 8a1218a1024a212bb3db30becd860315f9f3ac52 2	frotz

This completes the groundwork for the new merge world order.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/git-update-index.txt |   57 +++++++++++++++++++++++++++++++++
 update-index.c                     |   63 ++++++++++++++++++++++++++----------
 2 files changed, 103 insertions(+), 17 deletions(-)

d23748a6af3e3db2b239090553f92c3a779b3578
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index e4678cd..c74311d 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -136,6 +136,63 @@ in the database but the file isn't avail
 useful when the file is available, but you do not wish to update the
 object database.
 
+
+Using --index-info
+------------------
+
+`--index-info` is a more powerful mechanism that lets you feed
+multiple entry definitions from the standard input, and designed
+specifically for scripts.  It can take inputs of three formats:
+
+    . mode         SP sha1          TAB path
++
+The first format is what "git-apply --index-info"
+reports, and used to reconstruct a partial tree
+that is used for phony merge base tree when falling
+back on 3-way merge.
+
+    . mode SP type SP sha1          TAB path
++
+The second format is to stuff git-ls-tree output
+into the index file.
+
+    . mode         SP sha1 SP stage TAB path
++
+This format is to put higher order stages into the
+index file and matches git-ls-files --stage output.
+
+To place a higher stage entry to the index, the path should
+first be removed by feeding a mode=0 entry for the path, and
+then feeding necessary input lines in the third format.
+
+For example, starting with this index:
+
+------------
+$ git ls-files -s
+100644 8a1218a1024a212bb3db30becd860315f9f3ac52 0       frotz
+------------
+
+you can feed the following input to `--index-info`:
+
+------------
+$ git update-index --index-info
+0 0000000000000000000000000000000000000000	frotz
+100644 8a1218a1024a212bb3db30becd860315f9f3ac52 1	frotz
+100755 8a1218a1024a212bb3db30becd860315f9f3ac52 2	frotz
+------------
+
+The first line of the input feeds 0 as the mode to remove the
+path; the SHA1 does not matter as long as it is well formatted.
+Then the second and third line feeds stage 1 and stage 2 entries
+for that path.  After the above, we would end up with this:
+
+------------
+$ git ls-files -s
+100644 8a1218a1024a212bb3db30becd860315f9f3ac52 1	frotz
+100755 8a1218a1024a212bb3db30becd860315f9f3ac52 2	frotz
+------------
+
+
 Examples
 --------
 To update and refresh only the files already checked out:
diff --git a/update-index.c b/update-index.c
index 11b7f6a..be87b99 100644
--- a/update-index.c
+++ b/update-index.c
@@ -256,35 +256,30 @@ inside:
 	}
 }
 
-static int add_cacheinfo(const char *arg1, const char *arg2, const char *arg3)
+static int add_cacheinfo(unsigned int mode, const unsigned char *sha1,
+			 const char *path, int stage)
 {
 	int size, len, option;
-	unsigned int mode;
-	unsigned char sha1[20];
 	struct cache_entry *ce;
 
-	if (sscanf(arg1, "%o", &mode) != 1)
-		return -1;
-	if (get_sha1_hex(arg2, sha1))
-		return -1;
-	if (!verify_path(arg3))
+	if (!verify_path(path))
 		return -1;
 
-	len = strlen(arg3);
+	len = strlen(path);
 	size = cache_entry_size(len);
 	ce = xmalloc(size);
 	memset(ce, 0, size);
 
 	memcpy(ce->sha1, sha1, 20);
-	memcpy(ce->name, arg3, len);
-	ce->ce_flags = htons(len);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(len, stage);
 	ce->ce_mode = create_ce_mode(mode);
 	option = allow_add ? ADD_CACHE_OK_TO_ADD : 0;
 	option |= allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
 	if (add_cache_entry(ce, option))
 		return error("%s: cannot add to the index - missing --add option?",
-			     arg3);
-	report("add '%s'", arg3);
+			     path);
+	report("add '%s'", path);
 	return 0;
 }
 
@@ -342,7 +337,24 @@ static void read_index_info(int line_ter
 		char *path_name;
 		unsigned char sha1[20];
 		unsigned int mode;
+		int stage;
 
+		/* This reads lines formatted in one of three formats:
+		 *
+		 * (1) mode         SP sha1          TAB path
+		 * The first format is what "git-apply --index-info"
+		 * reports, and used to reconstruct a partial tree
+		 * that is used for phony merge base tree when falling
+		 * back on 3-way merge.
+		 *
+		 * (2) mode SP type SP sha1          TAB path
+		 * The second format is to stuff git-ls-tree output
+		 * into the index file.
+		 * 
+		 * (3) mode         SP sha1 SP stage TAB path
+		 * This format is to put higher order stages into the
+		 * index file and matches git-ls-files --stage output.
+		 */
 		read_line(&buf, stdin, line_termination);
 		if (buf.eof)
 			break;
@@ -354,9 +366,19 @@ static void read_index_info(int line_ter
 		tab = strchr(ptr, '\t');
 		if (!tab || tab - ptr < 41)
 			goto bad_line;
+
+		if (tab[-2] == ' ' && '1' <= tab[-1] && tab[-1] <= '3') {
+			stage = tab[-1] - '0';
+			ptr = tab + 1; /* point at the head of path */
+			tab = tab - 2; /* point at tail of sha1 */
+		}
+		else {
+			stage = 0;
+			ptr = tab + 1; /* point at the head of path */
+		}
+
 		if (get_sha1_hex(tab - 40, sha1) || tab[-41] != ' ')
 			goto bad_line;
-		ptr = tab + 1;
 
 		if (line_termination && ptr[0] == '"')
 			path_name = unquote_c_style(ptr, NULL);
@@ -382,7 +404,7 @@ static void read_index_info(int line_ter
 			 * ptr[-41] is at the beginning of sha1
 			 */
 			ptr[-42] = ptr[-1] = 0;
-			if (add_cacheinfo(buf.buf, ptr-41, path_name))
+			if (add_cacheinfo(mode, sha1, path_name, stage))
 				die("git-update-index: unable to update %s",
 				    path_name);
 		}
@@ -449,10 +471,17 @@ int main(int argc, const char **argv)
 				continue;
 			}
 			if (!strcmp(path, "--cacheinfo")) {
+				unsigned char sha1[20];
+				unsigned int mode;
+
 				if (i+3 >= argc)
 					die("git-update-index: --cacheinfo <mode> <sha1> <path>");
-				if (add_cacheinfo(argv[i+1], argv[i+2], argv[i+3]))
-					die("git-update-index: --cacheinfo cannot add %s", argv[i+3]);
+
+				if ((sscanf(argv[i+1], "%o", &mode) != 1) ||
+				    get_sha1_hex(argv[i+2], sha1) ||
+				    add_cacheinfo(mode, sha1, argv[i+3], 0))
+					die("git-update-index: --cacheinfo"
+					    " cannot add %s", argv[i+3]);
 				i += 3;
 				continue;
 			}
-- 
0.99.9.GIT
