From: Jeff King <peff@peff.net>
Subject: [PATCH 17/19] repack: consider bitmaps when performing repacks
Date: Thu, 24 Oct 2013 14:08:11 -0400
Message-ID: <20131024180811.GQ24180@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 24 20:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZPKl-0001Pv-4L
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 20:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755997Ab3JXSIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 14:08:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:54912 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755407Ab3JXSIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 14:08:13 -0400
Received: (qmail 1104 invoked by uid 102); 24 Oct 2013 18:08:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 13:08:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 14:08:11 -0400
Content-Disposition: inline
In-Reply-To: <20131024175915.GA23398@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236605>

From: Vicent Marti <tanoku@gmail.com>

Since `pack-objects` will write a `.bitmap` file next to the `.pack` and
`.idx` files, this commit teaches `git-repack` to consider the new
bitmap indexes (if they exist) when performing repack operations.

This implies moving old bitmap indexes out of the way if we are
repacking a repository that already has them, and moving the newly
generated bitmap indexes into the `objects/pack` directory, next to
their corresponding packfiles.

Since `git repack` is now capable of handling these `.bitmap` files,
a normal `git gc` run on a repository that has `pack.writebitmaps` set
to true in its config file will generate bitmap indexes as part of the
garbage collection process.

Alternatively, `git repack` can be called with the `-b` switch to
explicitly generate bitmap indexes if you are experimenting
and don't want them on all the time.

Signed-off-by: Vicent Marti <tanoku@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 8b7dfd0..239f278 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -94,7 +94,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
-	const char *exts[] = {".pack", ".idx", ".keep"};
+	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap"};
 	int i;
 	struct strbuf buf = STRBUF_INIT;
 	size_t plen;
@@ -121,6 +121,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	} exts[] = {
 		{".pack"},
 		{".idx"},
+		{".bitmap", 1},
 	};
 	struct child_process cmd;
 	struct string_list_item *item;
@@ -143,6 +144,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	int no_update_server_info = 0;
 	int quiet = 0;
 	int local = 0;
+	int write_bitmap = -1;
 
 	struct option builtin_repack_options[] = {
 		OPT_BIT('a', NULL, &pack_everything,
@@ -161,6 +163,8 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		OPT__QUIET(&quiet, N_("be quiet")),
 		OPT_BOOL('l', "local", &local,
 				N_("pass --local to git-pack-objects")),
+		OPT_BOOL('b', "write-bitmap-index", &write_bitmap,
+				N_("write bitmap index")),
 		OPT_STRING(0, "unpack-unreachable", &unpack_unreachable, N_("approxidate"),
 				N_("with -A, do not loosen objects older than this")),
 		OPT_INTEGER(0, "window", &window,
@@ -202,6 +206,9 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		argv_array_pushf(&cmd_args, "--no-reuse-delta");
 	if (no_reuse_object)
 		argv_array_pushf(&cmd_args, "--no-reuse-object");
+	if (write_bitmap >= 0)
+		argv_array_pushf(&cmd_args, "--%swrite-bitmap-index",
+				 write_bitmap ? "" : "no-");
 
 	if (pack_everything & ALL_INTO_ONE) {
 		get_non_kept_pack_filenames(&existing_packs);
-- 
1.8.4.1.898.g8bf8a41.dirty
