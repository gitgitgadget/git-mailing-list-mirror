From: Jeff King <peff@peff.net>
Subject: [PATCH 5/9] use strip_suffix instead of ends_with in simple cases
Date: Mon, 30 Jun 2014 12:58:51 -0400
Message-ID: <20140630165850.GE16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:58:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1euu-0001Th-PC
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756713AbaF3Q6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 12:58:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:53658 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755174AbaF3Q6w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:58:52 -0400
Received: (qmail 7774 invoked by uid 102); 30 Jun 2014 16:58:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:58:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:58:51 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252687>

When stripping a suffix like:

  if (ends_with(str, "foo"))
	buf = xmemdupz(str, strlen(str) - 3);

we can instead use strip_suffix to avoid the constant 3,
which must match the literal "foo" (we sometimes use
strlen("foo") instead, but that means we are repeating
ourselves). The example above becomes:

  if (strip_suffix(str, "foo", &len))
	buf = xmemdupz(str, len);

This also saves a strlen(), since we calculate the string
length when detecting the suffix.

Note that in some cases we also switch from xstrndup to
xmemdupz, which saves a further strlen call.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c | 13 +++++++------
 builtin/repack.c |  5 ++---
 connected.c      |  6 +++---
 help.c           |  5 ++---
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c9102e8..7c2999e 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -265,16 +265,17 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		struct string_list_item *item;
 		struct branch_info *info;
 		enum { REMOTE, MERGE, REBASE } type;
+		size_t key_len;
 
 		key += 7;
-		if (ends_with(key, ".remote")) {
-			name = xstrndup(key, strlen(key) - 7);
+		if (strip_suffix(key, ".remote", &key_len)) {
+			name = xmemdupz(key, key_len);
 			type = REMOTE;
-		} else if (ends_with(key, ".merge")) {
-			name = xstrndup(key, strlen(key) - 6);
+		} else if (strip_suffix(key, ".merge", &key_len)) {
+			name = xmemdupz(key, key_len);
 			type = MERGE;
-		} else if (ends_with(key, ".rebase")) {
-			name = xstrndup(key, strlen(key) - 7);
+		} else if (strip_suffix(key, ".rebase", &key_len)) {
+			name = xmemdupz(key, key_len);
 			type = REBASE;
 		} else
 			return 0;
diff --git a/builtin/repack.c b/builtin/repack.c
index ff2216a..a77e743 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -83,16 +83,15 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 	DIR *dir;
 	struct dirent *e;
 	char *fname;
-	size_t len;
 
 	if (!(dir = opendir(packdir)))
 		return;
 
 	while ((e = readdir(dir)) != NULL) {
-		if (!ends_with(e->d_name, ".pack"))
+		size_t len;
+		if (!strip_suffix(e->d_name, ".pack", &len))
 			continue;
 
-		len = strlen(e->d_name) - strlen(".pack");
 		fname = xmemdupz(e->d_name, len);
 
 		if (!file_exists(mkpath("%s/%s.keep", packdir, fname)))
diff --git a/connected.c b/connected.c
index be0253e..dae9c99 100644
--- a/connected.c
+++ b/connected.c
@@ -31,6 +31,7 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 	unsigned char sha1[20];
 	int err = 0, ac = 0;
 	struct packed_git *new_pack = NULL;
+	size_t base_len;
 
 	if (fn(cb_data, sha1))
 		return err;
@@ -38,10 +39,9 @@ static int check_everything_connected_real(sha1_iterate_fn fn,
 	if (transport && transport->smart_options &&
 	    transport->smart_options->self_contained_and_connected &&
 	    transport->pack_lockfile &&
-	    ends_with(transport->pack_lockfile, ".keep")) {
+	    strip_suffix(transport->pack_lockfile, ".keep", &base_len)) {
 		struct strbuf idx_file = STRBUF_INIT;
-		strbuf_addstr(&idx_file, transport->pack_lockfile);
-		strbuf_setlen(&idx_file, idx_file.len - 5); /* ".keep" */
+		strbuf_add(&idx_file, transport->pack_lockfile, base_len);
 		strbuf_addstr(&idx_file, ".idx");
 		new_pack = add_packed_git(idx_file.buf, idx_file.len, 1);
 		strbuf_release(&idx_file);
diff --git a/help.c b/help.c
index 372728f..97567c4 100644
--- a/help.c
+++ b/help.c
@@ -145,7 +145,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 	len = buf.len;
 
 	while ((de = readdir(dir)) != NULL) {
-		int entlen;
+		size_t entlen;
 
 		if (!starts_with(de->d_name, prefix))
 			continue;
@@ -156,8 +156,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 			continue;
 
 		entlen = strlen(de->d_name) - prefix_len;
-		if (ends_with(de->d_name, ".exe"))
-			entlen -= 4;
+		strip_suffix(de->d_name, ".exe", &entlen);
 
 		add_cmdname(cmds, de->d_name + prefix_len, entlen);
 	}
-- 
2.0.0.566.gfe3e6b2
