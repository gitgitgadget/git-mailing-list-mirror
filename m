From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] rerere: rerere_created_at() and has_resolution()
 abstraction
Date: Sun, 22 Jun 2008 02:47:40 -0700
Message-ID: <7vod5tol6r.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu>
 <7vskvd9kai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Jun 22 11:48:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAMBi-0006BW-FR
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 11:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbYFVJrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 05:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbYFVJrv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 05:47:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbYFVJru (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 05:47:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E451A355;
	Sun, 22 Jun 2008 05:47:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6C399A354; Sun, 22 Jun 2008 05:47:43 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44A9C164-4040-11DD-9D15-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85758>

There were too many places in the code how an entry in the rerere database
looks like, and the garbage_collect() function that iterates over
subdirectories of the rr-cache directory was the worse offender.

Introduce two helper functions, rerere_created_at() and has_resolution(),
to abstract out the logic a bit better.

Incidentally this fixes a small memory leak in garbage_collect()
function.  The path list to collect the entries to be pruned were defined
to strdup the paths but the caller was feeding a path after doing an extra
copy.  Because the list does not have to be sorted by conflict signature
hash, we use path_list_append() instead of path_list_insert().

While we are at it, make a conflicted hunk comparision in handle_file() a
bit easier to read.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * So this is a series to handle the first point in the message I am
   replying to.

 builtin-rerere.c |   57 ++++++++++++++++++++++++-----------------------------
 1 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 85222d9..610b96a 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -23,6 +23,18 @@ static const char *rr_path(const char *name, const char *file)
 	return git_path("rr-cache/%s/%s", name, file);
 }
 
+static time_t rerere_created_at(const char *name)
+{
+	struct stat st;
+	return stat(rr_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+}
+
+static int has_resolution(const char *name)
+{
+	struct stat st;
+	return !stat(rr_path(name, "postimage"), &st);
+}
+
 static void read_rr(struct path_list *rr)
 {
 	unsigned char sha1[20];
@@ -98,13 +110,10 @@ static int handle_file(const char *path,
 		else if (!prefixcmp(buf, "======="))
 			hunk = 2;
 		else if (!prefixcmp(buf, ">>>>>>> ")) {
-			int cmp = strbuf_cmp(&one, &two);
-
+			if (strbuf_cmp(&one, &two) > 0)
+				strbuf_swap(&one, &two);
 			hunk_no++;
 			hunk = 0;
-			if (cmp > 0) {
-				strbuf_swap(&one, &two);
-			}
 			if (out) {
 				fputs("<<<<<<<\n", out);
 				fwrite(one.buf, one.len, 1, out);
@@ -201,33 +210,24 @@ static void unlink_rr_item(const char *name)
 static void garbage_collect(struct path_list *rr)
 {
 	struct path_list to_remove = { NULL, 0, 0, 1 };
-	char buf[1024];
 	DIR *dir;
 	struct dirent *e;
-	int len, i, cutoff;
+	int i, cutoff;
 	time_t now = time(NULL), then;
 
-	strlcpy(buf, git_path("rr-cache"), sizeof(buf));
-	len = strlen(buf);
-	dir = opendir(buf);
-	strcpy(buf + len++, "/");
+	dir = opendir(git_path("rr-cache"));
 	while ((e = readdir(dir))) {
 		const char *name = e->d_name;
-		struct stat st;
-		if (name[0] == '.' && (name[1] == '\0' ||
-					(name[1] == '.' && name[2] == '\0')))
+		if (name[0] == '.' &&
+		    (name[1] == '\0' || (name[1] == '.' && name[2] == '\0')))
 			continue;
-		i = snprintf(buf + len, sizeof(buf) - len, "%s", name);
-		strlcpy(buf + len + i, "/preimage", sizeof(buf) - len - i);
-		if (stat(buf, &st))
+		then = rerere_created_at(name);
+		if (!then)
 			continue;
-		then = st.st_mtime;
-		strlcpy(buf + len + i, "/postimage", sizeof(buf) - len - i);
-		cutoff = stat(buf, &st) ? cutoff_noresolve : cutoff_resolve;
-		if (then < now - cutoff * 86400) {
-			buf[len + i] = '\0';
-			path_list_insert(xstrdup(name), &to_remove);
-		}
+		cutoff = (has_resolution(name)
+			  ? cutoff_resolve : cutoff_noresolve);
+		if (then < now - cutoff * 86400)
+			path_list_append(name, &to_remove);
 	}
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].path);
@@ -306,13 +306,11 @@ static int do_plain_rerere(struct path_list *rr, int fd)
 	 */
 
 	for (i = 0; i < rr->nr; i++) {
-		struct stat st;
 		int ret;
 		const char *path = rr->items[i].path;
 		const char *name = (const char *)rr->items[i].util;
 
-		if (!stat(rr_path(name, "preimage"), &st) &&
-				!stat(rr_path(name, "postimage"), &st)) {
+		if (has_resolution(name)) {
 			if (!merge(name, path)) {
 				fprintf(stderr, "Resolved '%s' using "
 						"previous resolution.\n", path);
@@ -410,11 +408,8 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		return do_plain_rerere(&merge_rr, fd);
 	else if (!strcmp(argv[1], "clear")) {
 		for (i = 0; i < merge_rr.nr; i++) {
-			struct stat st;
 			const char *name = (const char *)merge_rr.items[i].util;
-			if (!stat(git_path("rr-cache/%s", name), &st) &&
-					S_ISDIR(st.st_mode) &&
-					stat(rr_path(name, "postimage"), &st))
+			if (!has_resolution(name))
 				unlink_rr_item(name);
 		}
 		unlink(merge_rr_path);
-- 
1.5.6.12.g73f03
