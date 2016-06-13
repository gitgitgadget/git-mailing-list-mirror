From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] repack: extend --keep-unreachable to loose objects
Date: Mon, 13 Jun 2016 00:38:04 -0400
Message-ID: <20160613043804.GC3902@sigill.intra.peff.net>
References: <20160613043313.GA29422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nasser Grainawi <nasser@codeaurora.org>
X-From: git-owner@vger.kernel.org Mon Jun 13 06:38:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCJdd-0000ht-Fp
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 06:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbcFMEiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 00:38:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:53604 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750823AbcFMEiH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 00:38:07 -0400
Received: (qmail 23599 invoked by uid 102); 13 Jun 2016 04:38:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:38:07 -0400
Received: (qmail 10061 invoked by uid 107); 13 Jun 2016 04:38:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 00:38:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 00:38:04 -0400
Content-Disposition: inline
In-Reply-To: <20160613043313.GA29422@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297152>

If you use "repack -adk" currently, we will pack all objects
that are already packed into the new pack, and then drop the
old packs. However, loose unreachable objects will be left
as-is. In theory these are meant to expire eventually with
"git prune". But if you are using "repack -k", you probably
want to keep things forever and therefore do not run "git
prune" at all. Meaning those loose objects may build up over
time and end up fooling any object-count heuristics (such as
the one done by "gc --auto", though since git-gc does not
support "repack -k", this really applies to whatever custom
scripts people might have driving "repack -k").

With this patch, we instead stuff any loose unreachable
objects into the pack along with the already-packed
unreachable objects. This may seem wasteful, but it is
really no more so than using "repack -k" in the first place.
We are at a slight disadvantage, in that we have no useful
ordering for the result, or names to hand to the delta code.
However, this is again no worse than what "repack -k" is
already doing for the packed objects. The packing of these
objects doesn't matter much because they should not be
accessed frequently (unless they actually _do_ become
referenced, but then they would get moved to a different
part of the packfile during the next repack).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-repack.txt         |  3 ++-
 builtin/pack-objects.c               | 31 +++++++++++++++++++++++++++++++
 builtin/repack.c                     |  1 +
 t/t7701-repack-unpack-unreachable.sh | 13 +++++++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 68702ea..b58b6b5 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -138,7 +138,8 @@ other objects in that pack they already have locally.
 --keep-unreachable::
 	When used with `-ad`, any unreachable objects from existing
 	packs will be appended to the end of the packfile instead of
-	being removed.
+	being removed. In addition, any unreachable loose objects will
+	be packed (and their loose counterparts removed).
 
 Configuration
 -------------
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8f5e358..a2f8cfd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -44,6 +44,7 @@ static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
 static int keep_unreachable, unpack_unreachable, include_tag;
 static unsigned long unpack_unreachable_expiration;
+static int pack_loose_unreachable;
 static int local;
 static int incremental;
 static int ignore_packed_keep;
@@ -2378,6 +2379,32 @@ static void add_objects_in_unpacked_packs(struct rev_info *revs)
 	free(in_pack.array);
 }
 
+static int add_loose_object(const unsigned char *sha1, const char *path,
+			    void *data)
+{
+	enum object_type type = sha1_object_info(sha1, NULL);
+
+	if (type < 0) {
+		warning("loose object at %s could not be examined", path);
+		return 0;
+	}
+
+	add_object_entry(sha1, type, "", 0);
+	return 0;
+}
+
+/*
+ * We actually don't even have to worry about reachability here.
+ * add_object_entry will weed out duplicates, so we just add every
+ * loose object we find.
+ */
+static void add_unreachable_loose_objects(void)
+{
+	for_each_loose_file_in_objdir(get_object_directory(),
+				      add_loose_object,
+				      NULL, NULL, NULL);
+}
+
 static int has_sha1_pack_kept_or_nonlocal(const unsigned char *sha1)
 {
 	static struct packed_git *last_found = (void *)1;
@@ -2547,6 +2574,8 @@ static void get_object_list(int ac, const char **av)
 
 	if (keep_unreachable)
 		add_objects_in_unpacked_packs(&revs);
+	if (pack_loose_unreachable)
+		add_unreachable_loose_objects();
 	if (unpack_unreachable)
 		loosen_unused_packed_objects(&revs);
 
@@ -2647,6 +2676,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("include tag objects that refer to objects to be packed")),
 		OPT_BOOL(0, "keep-unreachable", &keep_unreachable,
 			 N_("keep unreachable objects")),
+		OPT_BOOL(0, "pack-loose-unreachable", &pack_loose_unreachable,
+			 N_("pack loose unreachable objects")),
 		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
 		  N_("unpack unreachable objects newer than <time>"),
 		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
diff --git a/builtin/repack.c b/builtin/repack.c
index 573e66c..f7b7409 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -248,6 +248,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 						"--unpack-unreachable");
 			} else if (keep_unreachable) {
 				argv_array_push(&cmd.args, "--keep-unreachable");
+				argv_array_push(&cmd.args, "--pack-loose-unreachable");
 			} else {
 				argv_array_push(&cmd.env_array, "GIT_REF_PARANOIA=1");
 			}
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index f13df43..987573c 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -137,4 +137,17 @@ test_expect_success 'repack -k keeps unreachable packed objects' '
 	test_must_fail git cat-file -p $sha1
 '
 
+test_expect_success 'repack -k packs unreachable loose objects' '
+	# create loose unreachable object
+	sha1=$(echo would-be-deleted-loose | git hash-object -w --stdin) &&
+	objpath=.git/objects/$(echo $sha1 | sed "s,..,&/,") &&
+	test_path_is_file $objpath &&
+
+	# and confirm that the loose object goes away, but we can
+	# still access it (ergo, it is packed)
+	git repack -adk &&
+	test_path_is_missing $objpath &&
+	git cat-file -p $sha1
+'
+
 test_done
-- 
2.9.0.rc2.149.gd580ccd
