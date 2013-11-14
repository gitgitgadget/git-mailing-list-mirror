From: Jeff King <peff@peff.net>
Subject: [PATCH v3 17/21] repack: consider bitmaps when performing repacks
Date: Thu, 14 Nov 2013 07:46:10 -0500
Message-ID: <20131114124610.GQ10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:46:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwJL-0001bU-Ia
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab3KNMqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:46:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:39149 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753559Ab3KNMqL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:46:11 -0500
Received: (qmail 11657 invoked by uid 102); 14 Nov 2013 12:46:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:46:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:46:10 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237841>

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
 Documentation/git-repack.txt | 9 ++++++++-
 builtin/repack.c             | 9 ++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 509cf73..002cfd5 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [--window=<n>] [--depth=<n>]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>]
 
 DESCRIPTION
 -----------
@@ -110,6 +110,13 @@ other objects in that pack they already have locally.
 	The default is unlimited, unless the config variable
 	`pack.packSizeLimit` is set.
 
+-b::
+--write-bitmap-index::
+	Write a reachability bitmap index as part of the repack. This
+	only makes sense when used with `-a` or `-A`, as the bitmaps
+	must be able to refer to all reachable objects. This option
+	overrides the setting of `pack.writebitmaps`.
+
 
 Configuration
 -------------
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
1.8.5.rc0.443.g2df7f3f
