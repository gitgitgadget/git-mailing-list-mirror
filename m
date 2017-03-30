Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 907D61FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 10:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933122AbdC3Kf5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 06:35:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:54094 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932958AbdC3Kfy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 06:35:54 -0400
Received: (qmail 25742 invoked by uid 109); 30 Mar 2017 10:35:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 10:35:52 +0000
Received: (qmail 30756 invoked by uid 111); 30 Mar 2017 10:36:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 06:36:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 06:35:50 -0400
Date:   Thu, 30 Mar 2017 06:35:50 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: [PATCH] difftool: avoid strcpy
Message-ID: <20170330103550.vpjrurqho4oz3caa@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to checkout files, difftool reads "diff --raw"
output and feeds the names to checkout_entry(). That
function requires us to have a "struct cache_entry". And
because that struct uses a FLEX_ARRAY for the name field, we
have to actually copy in our new name.

The current code allocates a single re-usable cache_entry
that can hold a name up to PATH_MAX, and then copies
filenames into it using strcpy(). But there's no guarantee
that incoming names are smaller than PATH_MAX. They've come
from "diff --raw" output which might be diffing between two
trees (and hence we'd be subject to the PATH_MAX of some
other system, or even none at all if they were created
directly via "update-index").

We can fix this by using make_cache_entry() to create a
correctly-sized cache_entry for each name. This incurs an
extra allocation per file, but this is negligible compared
to actually writing out the file contents.

To make this simpler, we can push this procedure into a new
helper function. Note that we can also get rid of the "len"
variables for src_path and dst_path (and in fact we must, as
the compiler complains that they are unused).

Signed-off-by: Jeff King <peff@peff.net>
---
I tested this with:

  git init
  sha1=$(echo whatever | git hash-object -w --stdin)
  git update-index --add --cacheinfo \
    100644 $sha1 $(perl -e 'print join("/", 1..2048)')
  git difftool -d HEAD

It fails anyway, of course, because we can't check out a filename of
that length, but not until after it has overflowed the buffer.

I'm not sure if we'd want that in the test suite or not, since the
outcome is unpredictable.

 builtin/difftool.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 25e54ad3e..b350b3d39 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -297,6 +297,19 @@ static char *get_symlink(const struct object_id *oid, const char *path)
 	return data;
 }
 
+static int checkout_path(unsigned mode, struct object_id *oid,
+			 const char *path, const struct checkout *state)
+{
+	struct cache_entry *ce;
+	int ret;
+
+	ce = make_cache_entry(mode, oid->hash, path, 0, 0);
+	ret = checkout_entry(ce, state, NULL);
+
+	free(ce);
+	return ret;
+}
+
 static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			int argc, const char **argv)
 {
@@ -306,7 +319,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 	struct strbuf ldir = STRBUF_INIT, rdir = STRBUF_INIT;
 	struct strbuf wtdir = STRBUF_INIT;
 	size_t ldir_len, rdir_len, wtdir_len;
-	struct cache_entry *ce = xcalloc(1, sizeof(ce) + PATH_MAX + 1);
 	const char *workdir, *tmp;
 	int ret = 0, i;
 	FILE *fp;
@@ -377,7 +389,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		struct object_id loid, roid;
 		char status;
 		const char *src_path, *dst_path;
-		size_t src_path_len, dst_path_len;
 
 		if (starts_with(info.buf, "::"))
 			die(N_("combined diff formats('-c' and '--cc') are "
@@ -390,17 +401,14 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		if (strbuf_getline_nul(&lpath, fp))
 			break;
 		src_path = lpath.buf;
-		src_path_len = lpath.len;
 
 		i++;
 		if (status != 'C' && status != 'R') {
 			dst_path = src_path;
-			dst_path_len = src_path_len;
 		} else {
 			if (strbuf_getline_nul(&rpath, fp))
 				break;
 			dst_path = rpath.buf;
-			dst_path_len = rpath.len;
 		}
 
 		if (S_ISGITLINK(lmode) || S_ISGITLINK(rmode)) {
@@ -430,11 +438,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		}
 
 		if (lmode && status != 'C') {
-			ce->ce_mode = lmode;
-			oidcpy(&ce->oid, &loid);
-			strcpy(ce->name, src_path);
-			ce->ce_namelen = src_path_len;
-			if (checkout_entry(ce, &lstate, NULL))
+			if (checkout_path(lmode, &loid, src_path, &lstate))
 				return error("could not write '%s'", src_path);
 		}
 
@@ -451,11 +455,7 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 			hashmap_add(&working_tree_dups, entry);
 
 			if (!use_wt_file(workdir, dst_path, &roid)) {
-				ce->ce_mode = rmode;
-				oidcpy(&ce->oid, &roid);
-				strcpy(ce->name, dst_path);
-				ce->ce_namelen = dst_path_len;
-				if (checkout_entry(ce, &rstate, NULL))
+				if (checkout_path(rmode, &roid, dst_path, &rstate))
 					return error("could not write '%s'",
 						     dst_path);
 			} else if (!is_null_oid(&roid)) {
@@ -625,7 +625,6 @@ static int run_dir_diff(const char *extcmd, int symlinks, const char *prefix,
 		exit_cleanup(tmpdir, rc);
 
 finish:
-	free(ce);
 	strbuf_release(&ldir);
 	strbuf_release(&rdir);
 	strbuf_release(&wtdir);
-- 
2.12.2.920.g2106709b0
