From: Jeff King <peff@peff.net>
Subject: [PATCH 7/7] cat-file: add --batch-all-objects option
Date: Mon, 22 Jun 2015 06:45:59 -0400
Message-ID: <20150622104559.GG14475@peff.net>
References: <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:46:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6zEu-0006Lk-70
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281AbbFVKqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:46:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:49791 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933252AbbFVKqC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:46:02 -0400
Received: (qmail 17472 invoked by uid 102); 22 Jun 2015 10:46:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:46:02 -0500
Received: (qmail 7597 invoked by uid 107); 22 Jun 2015 10:46:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:46:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:45:59 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272330>

It can sometimes be useful to examine all objects in the
repository. Normally this is done with "git rev-list --all
--objects", but:

  1. That shows only reachable objects. You may want to look
     at all available objects.

  2. It's slow. We actually open each object to walk the
     graph. If your operation is OK with seeing unreachable
     objects, it's an order of magnitude faster to just
     enumerate the loose directories and pack indices.

You can do this yourself using "ls" and "git show-index",
but it's non-obvious.  This patch adds an option to
"cat-file --batch-check" to operate on all available
objects (rather than reading names from stdin).

This is based on a proposal by Charles Bailey to provide a
separate "git list-all-objects" command. That is more
orthogonal, as it splits enumerating the objects from
getting information about them. However, in practice you
will either:

  a. Feed the list of objects directly into cat-file anyway,
     so you can find out information about them. Keeping it
     in a single process is more efficient.

  b. Ask the listing process to start telling you more
     information about the objects, in which case you will
     reinvent cat-file's batch-check formatter.

Adding a cat-file option is simple and efficient. And if you
really do want just the object names, you can always do:

  git cat-file --batch-check='%(objectname)' --batch-all-objects

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-cat-file.txt |  8 ++++++++
 builtin/cat-file.c             | 44 ++++++++++++++++++++++++++++++++++++++++--
 t/t1006-cat-file.sh            | 27 ++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 0058bd4..6831b08 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -69,6 +69,14 @@ OPTIONS
 	not be combined with any other options or arguments.  See the
 	section `BATCH OUTPUT` below for details.
 
+--batch-all-objects::
+	Instead of reading a list of objects on stdin, perform the
+	requested batch operation on all objects in the repository and
+	any alternate object stores (not just reachable objects).
+	Requires `--batch` or `--batch-check` be specified. Note that
+	the order of the objects is unspecified, and there may be
+	duplicate entries.
+
 --buffer::
 	Normally batch output is flushed after each object is output, so
 	that a process can interactively read and write from
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 499ccda..95604c4 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -15,6 +15,7 @@ struct batch_options {
 	int follow_symlinks;
 	int print_contents;
 	int buffer_output;
+	int all_objects;
 	const char *format;
 };
 
@@ -257,7 +258,7 @@ static void batch_object_write(const char *obj_name, struct batch_options *opt,
 	struct strbuf buf = STRBUF_INIT;
 
 	if (sha1_object_info_extended(data->sha1, &data->info, LOOKUP_REPLACE_OBJECT) < 0) {
-		printf("%s missing\n", obj_name);
+		printf("%s missing\n", obj_name ? obj_name : sha1_to_hex(data->sha1));
 		fflush(stdout);
 		return;
 	}
@@ -318,6 +319,34 @@ static void batch_one_object(const char *obj_name, struct batch_options *opt,
 	batch_object_write(obj_name, opt, data);
 }
 
+struct object_cb_data {
+	struct batch_options *opt;
+	struct expand_data *expand;
+};
+
+static int batch_object_cb(const unsigned char *sha1,
+			   struct object_cb_data *data)
+{
+	hashcpy(data->expand->sha1, sha1);
+	batch_object_write(NULL, data->opt, data->expand);
+	return 0;
+}
+
+static int batch_loose_object(const unsigned char *sha1,
+			      const char *path,
+			      void *data)
+{
+	return batch_object_cb(sha1, data);
+}
+
+static int batch_packed_object(const unsigned char *sha1,
+			       struct packed_git *pack,
+			       uint32_t pos,
+			       void *data)
+{
+	return batch_object_cb(sha1, data);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf buf = STRBUF_INIT;
@@ -345,6 +374,15 @@ static int batch_objects(struct batch_options *opt)
 	if (opt->print_contents)
 		data.info.typep = &data.type;
 
+	if (opt->all_objects) {
+		struct object_cb_data cb;
+		cb.opt = opt;
+		cb.expand = &data;
+		for_each_loose_object(batch_loose_object, &cb, 0);
+		for_each_packed_object(batch_packed_object, &cb, 0);
+		return 0;
+	}
+
 	/*
 	 * We are going to call get_sha1 on a potentially very large number of
 	 * objects. In most large cases, these will be actual object sha1s. The
@@ -436,6 +474,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_OPTARG, batch_option_callback },
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
+		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
+			 N_("show all objects with --batch or --batch-check")),
 		OPT_END()
 	};
 
@@ -460,7 +500,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		usage_with_options(cat_file_usage, options);
 	}
 
-	if (batch.follow_symlinks && !batch.enabled) {
+	if ((batch.follow_symlinks || batch.all_objects) && !batch.enabled) {
 		usage_with_options(cat_file_usage, options);
 	}
 
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 93a4794..2b4220a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -547,4 +547,31 @@ test_expect_success 'git cat-file --batch --follow-symlink returns correct sha a
 	test_cmp expect actual
 '
 
+test_expect_success 'cat-file --batch-all-objects shows all objects' '
+	# make new repos so we now the full set of objects; we will
+	# also make sure that there are some packed and some loose
+	# objects, some referenced and some not, and that there are
+	# some available only via alternates.
+	git init all-one &&
+	(
+		cd all-one &&
+		echo content >file &&
+		git add file &&
+		git commit -qm base &&
+		git rev-parse HEAD HEAD^{tree} HEAD:file &&
+		git repack -ad &&
+		echo not-cloned | git hash-object -w --stdin
+	) >expect.unsorted &&
+	git clone -s all-one all-two &&
+	(
+		cd all-two &&
+		echo local-unref | git hash-object -w --stdin
+	) >>expect.unsorted &&
+	sort <expect.unsorted >expect &&
+	git -C all-two cat-file --batch-all-objects \
+				--batch-check="%(objectname)" >actual.unsorted &&
+	sort <actual.unsorted >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.4.719.g3984bc6
