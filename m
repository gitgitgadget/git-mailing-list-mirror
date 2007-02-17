From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Do not take mode bits from index after type change.
Date: Fri, 16 Feb 2007 22:56:48 -0800
Message-ID: <7vodntw9u7.fsf@assigned-by-dhcp.cox.net>
References: <200702170009.02500.johannes.sixt@telecom.at>
	<7vejop1ysu.fsf@assigned-by-dhcp.cox.net>
	<200702170030.04014.johannes.sixt@telecom.at>
	<7vodntzljb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Feb 17 07:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIJVG-0005RD-Bc
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 07:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946427AbXBQG4v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 01:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946429AbXBQG4v
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 01:56:51 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:58385 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946427AbXBQG4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 01:56:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217065649.OQRF22948.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 17 Feb 2007 01:56:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QWwp1W0091kojtg0000000; Sat, 17 Feb 2007 01:56:49 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39969>

When we do not trust executable bit from lstat(2), we copied
existing ce_mode bits without checking if the filesystem object
is a regular file (which is the only thing we apply the "trust
executable bit" business) nor if the blob in the index is a
regular file (otherwise, we should do the same as registering a
new regular file, which is to default non-executable).

Noticed by Johannes Sixt.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * Adds a test -- how about this as a replacement?

 builtin-apply.c        |    2 +-
 builtin-update-index.c |   13 +++++++------
 cache.h                |   10 ++++++++++
 diff-lib.c             |    4 +---
 read-cache.c           |   13 +++++++------
 t/t3700-add.sh         |   20 ++++++++++++++++++++
 6 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 3fefdac..abe3538 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1988,7 +1988,7 @@ static int check_patch(struct patch *patch, struct patch *prev_patch)
 			return error("%s: %s", old_name, strerror(errno));
 
 		if (!cached)
-			st_mode = ntohl(create_ce_mode(st.st_mode));
+			st_mode = ntohl(ce_mode_from_stat(ce, st.st_mode));
 
 		if (patch->is_new < 0)
 			patch->is_new = 0;
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 1ac613a..772aaba 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -109,16 +109,17 @@ static int add_file_to_cache(const char *path)
 	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
 
-	ce->ce_mode = create_ce_mode(st.st_mode);
-	if (!trust_executable_bit) {
+	if (trust_executable_bit)
+		ce->ce_mode = create_ce_mode(st.st_mode);
+	else {
 		/* If there is an existing entry, pick the mode bits
 		 * from it, otherwise assume unexecutable.
 		 */
+		struct cache_entry *ent;
 		int pos = cache_name_pos(path, namelen);
-		if (0 <= pos)
-			ce->ce_mode = active_cache[pos]->ce_mode;
-		else if (S_ISREG(st.st_mode))
-			ce->ce_mode = create_ce_mode(S_IFREG | 0666);
+
+		ent = (0 <= pos) ? active_cache[pos] : NULL;
+		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
 	}
 
 	if (index_path(ce->sha1, path, &st, !info_only))
diff --git a/cache.h b/cache.h
index c62b0b0..04f8e63 100644
--- a/cache.h
+++ b/cache.h
@@ -106,6 +106,16 @@ static inline unsigned int create_ce_mode(unsigned int mode)
 		return htonl(S_IFLNK);
 	return htonl(S_IFREG | ce_permissions(mode));
 }
+static inline unsigned int ce_mode_from_stat(struct cache_entry *ce, unsigned int mode)
+{
+	extern int trust_executable_bit;
+	if (!trust_executable_bit && S_ISREG(mode)) {
+		if (ce && S_ISREG(ntohl(ce->ce_mode)))
+			return ce->ce_mode;
+		return create_ce_mode(0666);
+	}
+	return create_ce_mode(mode);
+}
 #define canon_mode(mode) \
 	(S_ISREG(mode) ? (S_IFREG | ce_permissions(mode)) : \
 	S_ISLNK(mode) ? S_IFLNK : S_IFDIR)
diff --git a/diff-lib.c b/diff-lib.c
index 91cd877..556d534 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -170,9 +170,7 @@ static int get_stat_data(struct cache_entry *ce,
 		}
 		changed = ce_match_stat(ce, &st, 0);
 		if (changed) {
-			mode = create_ce_mode(st.st_mode);
-			if (!trust_executable_bit && S_ISREG(st.st_mode))
-				mode = ce->ce_mode;
+			mode = ce_mode_from_stat(ce, st.st_mode);
 			sha1 = no_sha1;
 		}
 	}
diff --git a/read-cache.c b/read-cache.c
index c54a611..605b352 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -344,16 +344,17 @@ int add_file_to_index(const char *path, int verbose)
 	ce->ce_flags = htons(namelen);
 	fill_stat_cache_info(ce, &st);
 
-	ce->ce_mode = create_ce_mode(st.st_mode);
-	if (!trust_executable_bit) {
+	if (trust_executable_bit)
+		ce->ce_mode = create_ce_mode(st.st_mode);
+	else {
 		/* If there is an existing entry, pick the mode bits
 		 * from it, otherwise assume unexecutable.
 		 */
+		struct cache_entry *ent;
 		int pos = cache_name_pos(path, namelen);
-		if (pos >= 0)
-			ce->ce_mode = active_cache[pos]->ce_mode;
-		else if (S_ISREG(st.st_mode))
-			ce->ce_mode = create_ce_mode(S_IFREG | 0666);
+
+		ent = (0 <= pos) ? active_cache[pos] : NULL;
+		ce->ce_mode = ce_mode_from_stat(ent, st.st_mode);
 	}
 
 	if (index_path(ce->sha1, path, &st, 1))
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index caaab26..08e0352 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -30,6 +30,16 @@ test_expect_success \
 	 *) echo fail; git-ls-files --stage xfoo1; (exit 1);;
 	 esac'
 
+test_expect_success 'git-add: filemode=0 should not get confused by symlink' '
+	rm -f xfoo1 &&
+	ln -s foo xfoo1 &&
+	git-add xfoo1 &&
+	case "`git-ls-files --stage xfoo1`" in
+	120000" "*xfoo1) echo ok;;
+	*) echo fail; git-ls-files --stage xfoo1; (exit 1);;
+	esac
+'
+
 test_expect_success \
 	'git-update-index --add: Test that executable bit is not used...' \
 	'git config core.filemode 0 &&
@@ -41,6 +51,16 @@ test_expect_success \
 	 *) echo fail; git-ls-files --stage xfoo2; (exit 1);;
 	 esac'
 
+test_expect_success 'git-add: filemode=0 should not get confused by symlink' '
+	rm -f xfoo2 &&
+	ln -s foo xfoo2 &&
+	git update-index --add xfoo2 &&
+	case "`git-ls-files --stage xfoo2`" in
+	120000" "*xfoo2) echo ok;;
+	*) echo fail; git-ls-files --stage xfoo2; (exit 1);;
+	esac
+'
+
 test_expect_success \
 	'git-update-index --add: Test that executable bit is not used...' \
 	'git config core.filemode 0 &&
-- 
1.5.0.552.ge1b1c
