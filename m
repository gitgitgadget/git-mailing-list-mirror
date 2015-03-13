From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Fri, 13 Mar 2015 21:04:06 +0800
Message-ID: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com,
	Dongcan Jiang <dongcan.jiang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 14:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWPoL-0003C1-5C
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 14:39:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbbCMNj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 09:39:28 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:41151 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbCMNj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 09:39:27 -0400
Received: by pdjy10 with SMTP id y10so28930425pdj.8
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=KqQVBqbgjf9iEEQTZC94w0fyEEhx/+7XKx+wUYwz2Og=;
        b=gsrC647FDNgu23L67wwvGWKMtsoXPtD1mNZr8cXUfk2l3F2SDRC8r4SeiV3iSEtaeb
         3f0+FdO+By37jaS5qFFPwaWuyrdkijR0/Xlx83/EsrC+5eEu3f6o9kIsDvvJYBnqn7Tm
         TvAeAUar8luHcx/pgwa6ryv+3aauQuzQuu998dCYFJ8VE4iw76/McyBgMQ8ZbsaJCs08
         VVTsRAH2j0OCKsh6XFlSDridd1cKSvjOQpL1pPSIga6DGp8mzC0gVWVdvNrkMFjGC2+H
         J5RBKEoqhFC2fQr9RTnhUyIy3CCeDd9sHSfrGHW8qs1X7PGaM6uYux/bnjx2d48ewK8O
         LeIw==
X-Received: by 10.70.54.198 with SMTP id l6mr103841095pdp.74.1426253966951;
        Fri, 13 Mar 2015 06:39:26 -0700 (PDT)
Received: from localhost.localdomain ([162.105.205.253])
        by mx.google.com with ESMTPSA id hk6sm3655809pdb.83.2015.03.13.06.39.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Mar 2015 06:39:26 -0700 (PDT)
X-Mailer: git-send-email 2.3.2.223.g7a9409c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265413>

This patch is just for discusstion. An option --deepen is added to
'git fetch'. When it comes to '--deepen', git should fetch N more
commits ahead the local shallow commit, where N is indicated by
'--depth=N'. [1]

e.g.

>  (upstream)
>   ---o---o---o---A---B
>
>  (you)
>                  A---B

After excuting "git fetch --depth=1 --deepen", (you) get one more
tip and it becomes

>  (you)
>              o---A---B

'--deepen' is designed to be a boolean option in this patch, which
is a little different from [1]. It's designed in this way, because
it can reuse '--depth' in the program, and just costs one more bit
in some data structure, such as fetch_pack_args,
git_transport_options.

Of course, as a patch for discussion, it remains a long way to go
before being complete.

	1) Documents should be completed.
	2) More test cases, expecially corner cases, should be added.
	3) No need to get remote refs when it comes to '--deepen' option.
	4) Validity on options combination should be checked.
	5) smart-http protocol remains to be supported. [2]

Besides, I still have one question:
What does (you) exactly mean in [1]? The local branch or the local
remote ref?

I hope you could give me some comments and suggestions on this
patch. I would like to know whether I'm off the right way.

[1] http://article.gmane.org/gmane.comp.version-control.git/212950
[2] http://article.gmane.org/gmane.comp.version-control.git/265050

Helped-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
---
 builtin/fetch.c  |  5 ++++-
 fetch-pack.c     |  3 ++-
 fetch-pack.h     |  1 +
 t/t5510-fetch.sh | 11 +++++++++++
 transport.c      |  4 ++++
 transport.h      |  4 ++++
 upload-pack.c    | 15 +++++++++++----
 7 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f951265..6861207 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -33,7 +33,7 @@ static int fetch_prune_config = -1; /* unspecified */
 static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */

-static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
+static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
 static const char *depth;
@@ -111,6 +111,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	OPT_BOOL(0, "deepen", &deepen, N_("deepen")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -853,6 +854,8 @@ static struct transport *prepare_transport(struct remote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
+	if (deepen)
+		set_option(transport, TRANS_OPT_DEEPEN, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
diff --git a/fetch-pack.c b/fetch-pack.c
index 655ee64..6f4adca 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -295,6 +295,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (no_done)            strbuf_addstr(&c, " no-done");
 			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
 			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
+			if (args->depth_deepen)  strbuf_addstr(&c, " depth_deepen");
 			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
 			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
@@ -317,7 +318,7 @@ static int find_common(struct fetch_pack_args *args,
 	if (is_repository_shallow())
 		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
-		packet_buf_write(&req_buf, "deepen %d", args->depth);
+		packet_buf_write(&req_buf, "depth %d", args->depth);
 	packet_buf_flush(&req_buf);
 	state_len = req_buf.len;

diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..200ac78 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,7 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
+	unsigned depth_deepen:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d78f320..6738006 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -708,4 +708,15 @@ test_expect_success 'fetching a one-level ref works' '
 	)
 '

+test_expect_success 'fetching deepen' '
+	git clone . deepen --depth=1 &&
+	cd deepen &&
+	git fetch .. foo --depth=1
+	git show foo
+	test_must_fail git show foo~
+	git fetch .. foo --depth=1 --deepen
+	git show foo~
+	test_must_fail git show foo~2
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 0694a7c..53ee7b3 100644
--- a/transport.c
+++ b/transport.c
@@ -478,6 +478,9 @@ static int set_git_option(struct git_transport_options *opts,
 				die("transport: invalid depth option '%s'", value);
 		}
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN)) {
+		opts->depth_deepen = !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_PUSH_CERT)) {
 		opts->push_cert = !!value;
 		return 0;
@@ -534,6 +537,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.quiet = (transport->verbose < 0);
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
+	args.depth_deepen = data->options.depth_deepen;
 	args.check_self_contained_and_connected =
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
diff --git a/transport.h b/transport.h
index 18d2cf8..4f432fd 100644
--- a/transport.h
+++ b/transport.h
@@ -13,6 +13,7 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned push_cert : 1;
+	unsigned depth_deepen : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -153,6 +154,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"

+/* Limit the deepen of the fetch if not null */
+#define TRANS_OPT_DEEPEN "deepen"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"

diff --git a/upload-pack.c b/upload-pack.c
index b531a32..8004f2f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -31,6 +31,7 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<

 static unsigned long oldest_have;

+static int depth_deepen;
 static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
@@ -563,11 +564,11 @@ static void receive_needs(void)
 			}
 			continue;
 		}
-		if (starts_with(line, "deepen ")) {
+		if (starts_with(line, "depth ")) {
 			char *end;
-			depth = strtol(line + 7, &end, 0);
-			if (end == line + 7 || depth <= 0)
-				die("Invalid deepen: %s", line);
+			depth = strtol(line + 6, &end, 0);
+			if (end == line + 6 || depth <= 0)
+				die("Invalid depth: %s", line);
 			continue;
 		}
 		if (!starts_with(line, "want ") ||
@@ -577,6 +578,8 @@ static void receive_needs(void)

 		features = line + 45;

+		if (parse_feature_request(features, "depth_deepen"))
+			depth_deepen = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack = 2;
 		else if (parse_feature_request(features, "multi_ack"))
@@ -631,6 +634,10 @@ static void receive_needs(void)
 				struct object *object = shallows.objects[i].item;
 				object->flags |= NOT_SHALLOW;
 			}
+		else if (depth_deepen)
+			backup = result =
+				get_shallow_commits(&shallows, depth + 1,
+						    SHALLOW, NOT_SHALLOW);
 		else
 			backup = result =
 				get_shallow_commits(&want_obj, depth,
--
2.3.1.253.gb3fd89e
