From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 20/20] fetch: add --deepen=<N> to extend shallow boundary by <N> commits
Date: Tue, 29 Dec 2015 19:10:43 +0700
Message-ID: <1451391043-28093-21-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Dongcan Jiang <dongcan.jiang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt96-0007Ub-F9
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751538AbbL2MMx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:53 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33277 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbbL2MMv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:51 -0500
Received: by mail-pa0-f41.google.com with SMTP id cy9so123719141pac.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=kfo0JCEUyWUHXO/XvR07YEhFQ8lbbE1mvafSZWOT50g=;
        b=MRHjTIAY0DMfzRp07kXLKyVou/Rc2/CsllJi/jZKvYH9EESGmBAArFii7/p4Qzx7K+
         GREE/Uh5F7K9Y5cRbMTNc0iv2BxuF3I6x20b9QsHoszwFQSFlXhsmq3QF+oDAATgwjQt
         erEUXJaxncTg/RG2fsKq0/4edBw+KOZRioFage8JDSOFJyldZym00RqvuXg1ZRY9IA9q
         4cWOgax54zkTMQ/D3FUsrTRKoGQvB+0jkl22FiCNN5knuac7vf0XdX/XZBAWPoSPwhPI
         a4ZPpbn1fjbo28qvDxKK0LH1L7KqHqRlOc6Fx0iMeYnj4NlWcS6QbHJYz+SS9949iuPC
         cynA==
X-Received: by 10.67.6.233 with SMTP id cx9mr25188251pad.54.1451391171007;
        Tue, 29 Dec 2015 04:12:51 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id q82sm35155728pfq.1.2015.12.29.04.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:49 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:46 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283130>

In git-fetch, --depth argument is always relative with the latest
remote refs. This makes it a bit difficult to cover this use case,
where the user wants to make the shallow history, say 3 levels
deeper. It would work if remote refs have not moved yet, but nobody
can guarantee that, especially when that use case is performed a
couple months after the last clone or "git fetch --depth". Also,
modifying shallow boundary using --depth does not work well with
clones created by --since or --not.

This patch fixes that. A new argument --deepen=3D<N> will add <N> more =
(*)
parent commits to the current history regardless of where remote refs
are. Note that "git fetch --deepen" also fetches latest changes (so
updates happen on both shallow and ref ends). This is mostly to ease
the verification task at server side.

The main work was done by Dongcan Jiang. I fixed it up here and there.
And of course all the bugs belong to me.

(*) We could even support --deepen=3D<N> where <N> is negative. In that
case we can cut some history from the shallow clone. This operation
(and --depth=3D<shorter depth>) does not require interaction with remot=
e
side (and more complicated to implement as a result).

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-By: Eric Sunshine <sunshine@sunshineco.com>
Helped-By: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt                   |  5 +++++
 Documentation/technical/protocol-capabilities.txt |  7 +++++++
 builtin/fetch.c                                   | 17 +++++++++++++++=
--
 fetch-pack.c                                      |  3 +++
 fetch-pack.h                                      |  1 +
 t/t5510-fetch.sh                                  | 12 ++++++++++++
 transport.c                                       |  3 +++
 transport.h                                       |  4 ++++
 upload-pack.c                                     | 14 ++++++++++++--
 9 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 39fbcc3..c12f1c5 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -13,6 +13,11 @@
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
=20
+--deepen=3D<depth>::
+	Similar to --depth, except it specifies the number of commits
+	from the current shallow boundary instead of from the tip of
+	reach remote branch history.
+
 --since=3D<date>::
 	Deepen or shorten the history of a 'shallow' repository to
 	include all reachable commits after <date>.
diff --git a/Documentation/technical/protocol-capabilities.txt b/Docume=
ntation/technical/protocol-capabilities.txt
index 0e6b57d..f732a41 100644
--- a/Documentation/technical/protocol-capabilities.txt
+++ b/Documentation/technical/protocol-capabilities.txt
@@ -197,6 +197,13 @@ specific revision, instead of depth. Internally it=
's equivalent of
 doing "rev-list --not <rev>" on the server side. "deepen-not"
 cannot be used with "deepen", but can be used with "deepen-since".
=20
+deepen-relative
+---------------
+
+If this capacity is requested by the client, the semantics of "deepen"
+command is changed. The "depth" argument is the depth from the current
+shallow boundary, instead of the depth from remote refs.
+
 no-progress
 -----------
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 02a50e4..0aff238 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -34,7 +34,7 @@ static int fetch_prune_config =3D -1; /* unspecified =
*/
 static int prune =3D -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
=20
-static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity;
+static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity, deepen_relative;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
 static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static const char *depth;
@@ -126,6 +126,8 @@ static struct option builtin_fetch_options[] =3D {
 	{ OPTION_CALLBACK, 0, "not", NULL, N_("revision"),
 		    N_("deepen history of shallow clone by excluding rev"),
 		    PARSE_OPT_NONEG, option_parse_deepen_not },
+	OPT_INTEGER(0, "deepen", &deepen_relative,
+		    N_("deepen history of shallow clone")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -775,7 +777,7 @@ static int fetch_refs(struct transport *transport, =
struct ref *ref_map)
 	int ret =3D quickfetch(ref_map);
 	if (ret)
 		ret =3D transport_fetch_refs(transport, ref_map);
-	if (!ret)
+	if (!ret && !deepen_relative)
 		ret |=3D store_updated_refs(transport->url,
 				transport->remote->name,
 				ref_map);
@@ -886,6 +888,8 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 	if (deepen_not.nr)
 		set_option(transport, TRANS_OPT_DEEPEN_NOT,
 			   (const char *)&deepen_not);
+	if (deepen_relative)
+		set_option(transport, TRANS_OPT_DEEPEN_RELATIVE, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
@@ -1185,6 +1189,15 @@ int cmd_fetch(int argc, const char **argv, const=
 char *prefix)
 	/* no need to be strict, transport_set_option() will validate it agai=
n */
 	if (depth && atoi(depth) < 1)
 		die(_("depth %s is not a positive number"), depth);
+	if (deepen_relative) {
+		struct strbuf sb =3D STRBUF_INIT;
+		if (deepen_relative < 0)
+			die(_("Negative depth in --deepen is not supported"));
+		if (depth)
+			die(_("--deepen and --depth are mutually exclusive"));
+		strbuf_addf(&sb, "%d", deepen_relative);
+		depth =3D strbuf_detach(&sb, NULL);
+	}
 	if (depth || deepen_since || deepen_not.nr)
 		deepen =3D 1;
=20
diff --git a/fetch-pack.c b/fetch-pack.c
index 45f69de..67cbb7a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -324,6 +324,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			if (no_done)            strbuf_addstr(&c, " no-done");
 			if (use_sideband =3D=3D 2)  strbuf_addstr(&c, " side-band-64k");
 			if (use_sideband =3D=3D 1)  strbuf_addstr(&c, " side-band");
+			if (args->deepen_relative) strbuf_addstr(&c, " deepen-relative");
 			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
 			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
@@ -884,6 +885,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 		deepen_not_ok =3D 1;
 	else if (args->deepen_not)
 		die("Server does not support --not");
+	if (!server_supports("deepen-relative") && args->deepen_relative)
+		die("Server does not support --deepen");
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index 144301f..c912e3d 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -12,6 +12,7 @@ struct fetch_pack_args {
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
+	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 0ba9db0..760cd23 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -708,4 +708,16 @@ test_expect_success 'fetching a one-level ref work=
s' '
 	)
 '
=20
+test_expect_success 'fetching deepen' '
+	git clone . deepen --depth=3D1 && (
+		cd deepen &&
+		git fetch .. foo --depth=3D1
+		git show foo
+		test_must_fail git show foo~
+		git fetch .. foo --deepen=3D1
+		git show foo~
+		test_must_fail git show foo~2
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 3094c6b..2f3823a 100644
--- a/transport.c
+++ b/transport.c
@@ -482,6 +482,8 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_NOT)) {
 		opts->deepen_not =3D (const struct string_list *)value;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN_RELATIVE)) {
+		opts->deepen_relative =3D !!value;
 		return 0;
 	}
 	return 1;
@@ -538,6 +540,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.depth =3D data->options.depth;
 	args.deepen_since =3D data->options.deepen_since;
 	args.deepen_not =3D data->options.deepen_not;
+	args.deepen_relative =3D data->options.deepen_relative;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
diff --git a/transport.h b/transport.h
index ab61932..bdc3518 100644
--- a/transport.h
+++ b/transport.h
@@ -14,6 +14,7 @@ struct git_transport_options {
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
+	unsigned deepen_relative : 1;
 	int depth;
 	const char *deepen_since;
 	const struct string_list *deepen_not;
@@ -181,6 +182,9 @@ int transport_restrict_protocols(void);
 /* Limit the depth of the fetch based on revs if not null */
 #define TRANS_OPT_DEEPEN_NOT "deepen-not"
=20
+/* Limit the deepen of the fetch if not null */
+#define TRANS_OPT_DEEPEN_RELATIVE "deepen-relative"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
diff --git a/upload-pack.c b/upload-pack.c
index 90ecb5b..5384411 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -32,6 +32,7 @@ static const char upload_pack_usage[] =3D "git upload=
-pack [--strict] [--timeout=3D<
=20
 static unsigned long oldest_have;
=20
+static int deepen_relative;
 static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
@@ -583,7 +584,8 @@ static void send_unshallow(const struct object_arra=
y *shallows)
 	}
 }
=20
-static void deepen(int depth, const struct object_array *shallows)
+static void deepen(int depth, int deepen_relative,
+		   struct object_array *shallows)
 {
 	struct commit_list *result =3D NULL;
 	int i;
@@ -592,6 +594,9 @@ static void deepen(int depth, const struct object_a=
rray *shallows)
 			struct object *object =3D shallows->objects[i].item;
 			object->flags |=3D NOT_SHALLOW;
 		}
+	else if (deepen_relative)
+		result =3D get_shallow_commits(shallows, depth + 1,
+					     SHALLOW, NOT_SHALLOW);
 	else
 		result =3D
 			get_shallow_commits(&want_obj, depth,
@@ -687,6 +692,8 @@ static void receive_needs(void)
=20
 		features =3D arg + 40;
=20
+		if (parse_feature_request(features, "deepen-relative"))
+			deepen_relative =3D 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack =3D 2;
 		else if (parse_feature_request(features, "multi_ack"))
@@ -706,6 +713,9 @@ static void receive_needs(void)
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag =3D 1;
=20
+		if (deepen_relative)
+			continue;
+
 		o =3D parse_object(sha1_buf);
 		if (!o)
 			die("git upload-pack: not our ref %s",
@@ -736,7 +746,7 @@ static void receive_needs(void)
 	if (depth > 0 && deepen_rev_list)
 		die("--depth and --since (or --not) cannot be used together");
 	if (depth > 0)
-		deepen(depth, &shallows);
+		deepen(depth, deepen_relative, &shallows);
 	else if (deepen_rev_list) {
 		struct argv_array av =3D ARGV_ARRAY_INIT;
 		int i;
--=20
2.3.0.rc1.137.g477eb31
