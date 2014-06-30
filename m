From: Jeff King <peff@peff.net>
Subject: [PATCH 4/9] replace has_extension with ends_with
Date: Mon, 30 Jun 2014 12:58:25 -0400
Message-ID: <20140630165825.GD16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:58:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1euW-0001GZ-Tx
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756302AbaF3Q62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 12:58:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:53654 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755150AbaF3Q60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:58:26 -0400
Received: (qmail 7755 invoked by uid 102); 30 Jun 2014 16:58:26 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:58:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:58:25 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252686>

These two are almost the same function, with the exception
that has_extension only matches if there is content before
the suffix. So ends_with(".exe", ".exe") is true, but
has_extension would not be.

This distinction does not matter to any of the callers,
though, and we can just replace uses of has_extension with
ends_with. We prefer the "ends_with" name because it is more
generic, and there is nothing about the function that
requires it to be used for file extensions.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c  |  4 ++--
 builtin/verify-pack.c |  4 ++--
 git-compat-util.h     |  7 -------
 help.c                |  2 +-
 refs.c                |  4 ++--
 sha1_file.c           | 10 +++++-----
 6 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 18f57de..46376b6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1603,7 +1603,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		die(_("--fix-thin cannot be used without --stdin"));
 	if (!index_name && pack_name) {
 		int len = strlen(pack_name);
-		if (!has_extension(pack_name, ".pack"))
+		if (!ends_with(pack_name, ".pack"))
 			die(_("packfile name '%s' does not end with '.pack'"),
 			    pack_name);
 		index_name_buf = xmalloc(len);
@@ -1613,7 +1613,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (keep_msg && !keep_name && pack_name) {
 		int len = strlen(pack_name);
-		if (!has_extension(pack_name, ".pack"))
+		if (!ends_with(pack_name, ".pack"))
 			die(_("packfile name '%s' does not end with '.pack'"),
 			    pack_name);
 		keep_name_buf = xmalloc(len);
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 66cd2df..2fd29ce 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -27,9 +27,9 @@ static int verify_one_pack(const char *path, unsigned int flags)
 	 * normalize these forms to "foo.pack" for "index-pack --verify".
 	 */
 	strbuf_addstr(&arg, path);
-	if (has_extension(arg.buf, ".idx"))
+	if (ends_with(arg.buf, ".idx"))
 		strbuf_splice(&arg, arg.len - 3, 3, "pack", 4);
-	else if (!has_extension(arg.buf, ".pack"))
+	else if (!ends_with(arg.buf, ".pack"))
 		strbuf_add(&arg, ".pack", 5);
 	argv[2] = arg.buf;
 
diff --git a/git-compat-util.h b/git-compat-util.h
index 4cfde49..8cf79ae 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -594,13 +594,6 @@ static inline size_t xsize_t(off_t len)
 	return (size_t)len;
 }
 
-static inline int has_extension(const char *filename, const char *ext)
-{
-	size_t len = strlen(filename);
-	size_t extlen = strlen(ext);
-	return len > extlen && !memcmp(filename + len - extlen, ext, extlen);
-}
-
 /* in ctype.c, for kwset users */
 extern const char tolower_trans_tbl[256];
 
diff --git a/help.c b/help.c
index b266b09..372728f 100644
--- a/help.c
+++ b/help.c
@@ -156,7 +156,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 			continue;
 
 		entlen = strlen(de->d_name) - prefix_len;
-		if (has_extension(de->d_name, ".exe"))
+		if (ends_with(de->d_name, ".exe"))
 			entlen -= 4;
 
 		add_cmdname(cmds, de->d_name + prefix_len, entlen);
diff --git a/refs.c b/refs.c
index dc45774..e31adfd 100644
--- a/refs.c
+++ b/refs.c
@@ -1162,7 +1162,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 
 		if (de->d_name[0] == '.')
 			continue;
-		if (has_extension(de->d_name, ".lock"))
+		if (ends_with(de->d_name, ".lock"))
 			continue;
 		strbuf_addstr(&refname, de->d_name);
 		refdir = *refs->name
@@ -3233,7 +3233,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 
 		if (de->d_name[0] == '.')
 			continue;
-		if (has_extension(de->d_name, ".lock"))
+		if (ends_with(de->d_name, ".lock"))
 			continue;
 		strbuf_addstr(name, de->d_name);
 		if (stat(git_path("logs/%s", name->buf), &st) < 0) {
diff --git a/sha1_file.c b/sha1_file.c
index 394fa45..93b794f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1204,7 +1204,7 @@ static void prepare_packed_git_one(char *objdir, int local)
 		strbuf_setlen(&path, dirnamelen);
 		strbuf_addstr(&path, de->d_name);
 
-		if (has_extension(de->d_name, ".idx")) {
+		if (ends_with(de->d_name, ".idx")) {
 			/* Don't reopen a pack we already have. */
 			for (p = packed_git; p; p = p->next) {
 				if (!memcmp(path.buf, p->pack_name, path.len - 4))
@@ -1222,10 +1222,10 @@ static void prepare_packed_git_one(char *objdir, int local)
 		if (!report_garbage)
 			continue;
 
-		if (has_extension(de->d_name, ".idx") ||
-		    has_extension(de->d_name, ".pack") ||
-		    has_extension(de->d_name, ".bitmap") ||
-		    has_extension(de->d_name, ".keep"))
+		if (ends_with(de->d_name, ".idx") ||
+		    ends_with(de->d_name, ".pack") ||
+		    ends_with(de->d_name, ".bitmap") ||
+		    ends_with(de->d_name, ".keep"))
 			string_list_append(&garbage, path.buf);
 		else
 			report_garbage("garbage found", path.buf);
-- 
2.0.0.566.gfe3e6b2
