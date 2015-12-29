From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 12/20] fetch: define shallow boundary with --since
Date: Tue, 29 Dec 2015 19:10:35 +0700
Message-ID: <1451391043-28093-13-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8O-0006ul-LE
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbbL2MMH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:07 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33488 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbL2MMG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:06 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so90972082pfb.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k0CaB88k/RZ3I2HRwuxk/QOL2joXTHUpW8SodvGqEqA=;
        b=JlLEtjDdV37vwBk9s0UCpSIWa4mtSKAcWxFCavVmEYSp6TFHtSo7Rl5jlHcf/myarp
         koLGShQsY3Ori16qA9X+WSJzB/J2FwDfewgIkp9J2cmUjx0ArsznHPIo2qyj1V9YjXSB
         oyzk4zXcWqcfrTErXLRXW10qZVuocQyS7LJnQysQ/KVQ/27iGAAdQRJSIKBGhdAYryeP
         ybOnWM691l6g32euvytNn4sRMdjSZsjagfVqHv8MUF8N0mx5FqyPJ5w+5dTvGDgWR4Q/
         pM1TaTxL6ThhYI3pCpNISIBXvu2WeCCcTsjXnqE1ylZR+IIemhrBYVmCwRxPCTz3HOAl
         pttw==
X-Received: by 10.98.44.213 with SMTP id s204mr67983801pfs.1.1451391125646;
        Tue, 29 Dec 2015 04:12:05 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id cp4sm87810088pad.41.2015.12.29.04.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:04 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:01 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283122>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt |  4 ++++
 builtin/fetch.c                 | 12 ++++++++++--
 fetch-pack.c                    | 12 +++++++++++-
 fetch-pack.h                    |  1 +
 transport.c                     |  4 ++++
 transport.h                     |  4 ++++
 6 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 45583d8..ff6e6ad 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -13,6 +13,10 @@
 	to the specified number of commits from the tip of each remote
 	branch history. Tags for the deepened commits are not fetched.
=20
+--since=3D<date>::
+	Deepen or shorten the history of a 'shallow' repository to
+	include all reachable commits after <date>.
+
 --unshallow::
 	If the source repository is complete, convert a shallow
 	repository to a complete one, removing all the limitations
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c85f347..3317152 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -36,8 +36,9 @@ static int prune =3D -1; /* unspecified */
=20
 static int all, append, dry_run, force, keep, multiple, update_head_ok=
, verbosity;
 static int progress =3D -1, recurse_submodules =3D RECURSE_SUBMODULES_=
DEFAULT;
-static int tags =3D TAGS_DEFAULT, unshallow, update_shallow;
+static int tags =3D TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static const char *depth;
+static const char *deepen_since;
 static const char *upload_pack;
 static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *gtransport;
@@ -112,6 +113,8 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	OPT_STRING(0, "since", &deepen_since, N_("time"),
+		   N_("deepen history of shallow clone based on time")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -751,7 +754,7 @@ static int quickfetch(struct ref *ref_map)
 	 * really need to perform.  Claiming failure now will ensure
 	 * we perform the network exchange to deepen our history.
 	 */
-	if (depth)
+	if (deepen)
 		return -1;
 	return check_everything_connected(iterate_ref_map, 1, &rm);
 }
@@ -867,6 +870,8 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
+	if (deepen_since)
+		set_option(transport, TRANS_OPT_DEEPEN_SINCE, deepen_since);
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
@@ -881,6 +886,7 @@ static void backfill_tags(struct transport *transpo=
rt, struct ref *ref_map)
=20
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
+	transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE, NULL);
 	fetch_refs(transport, ref_map);
=20
 	if (gsecondary) {
@@ -1164,6 +1170,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	/* no need to be strict, transport_set_option() will validate it agai=
n */
 	if (depth && atoi(depth) < 1)
 		die(_("depth %s is not a positive number"), depth);
+	if (depth || deepen_since)
+		deepen =3D 1;
=20
 	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
 		if (recurse_submodules_default) {
diff --git a/fetch-pack.c b/fetch-pack.c
index e947514..f26cef4 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -21,6 +21,7 @@ static int fetch_unpack_limit =3D -1;
 static int unpack_limit =3D 100;
 static int prefer_ofs_delta =3D 1;
 static int no_done;
+static int deepen_since_ok;
 static int fetch_fsck_objects =3D -1;
 static int transfer_fsck_objects =3D -1;
 static int agent_supported;
@@ -326,6 +327,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
 			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -345,6 +347,10 @@ static int find_common(struct fetch_pack_args *arg=
s,
 		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
+	if (args->deepen_since) {
+		unsigned long max_age =3D approxidate(args->deepen_since);
+		packet_buf_write(&req_buf, "deepen-since %lu", max_age);
+	}
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
@@ -813,7 +819,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die("Server does not support shallow clients");
-	if (args->depth > 0)
+	if (args->depth > 0 || args->deepen_since)
 		args->deepen =3D 1;
 	if (server_supports("multi_ack_detailed")) {
 		print_verbose(args, "Server supports multi_ack_detailed");
@@ -861,6 +867,10 @@ static struct ref *do_fetch_pack(struct fetch_pack=
_args *args,
 			print_verbose(args, "Server version is %.*s",
 				      agent_len, agent_feature);
 	}
+	if (server_supports("deepen-since"))
+		deepen_since_ok =3D 1;
+	else if (args->deepen_since)
+		die("Server does not support --since");
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index 4d0adb0..f7eadb2 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,7 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
+	const char *deepen_since;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/transport.c b/transport.c
index 67f3666..4902036 100644
--- a/transport.c
+++ b/transport.c
@@ -477,6 +477,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 				die("transport: invalid depth option '%s'", value);
 		}
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN_SINCE)) {
+		opts->deepen_since =3D value;
+		return 0;
 	}
 	return 1;
 }
@@ -530,6 +533,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.quiet =3D (transport->verbose < 0);
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
+	args.deepen_since =3D data->options.deepen_since;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
diff --git a/transport.h b/transport.h
index 8ebaaf2..9c10a44 100644
--- a/transport.h
+++ b/transport.h
@@ -13,6 +13,7 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	int depth;
+	const char *deepen_since;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
@@ -171,6 +172,9 @@ int transport_restrict_protocols(void);
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"
=20
+/* Limit the depth of the fetch based on time if not null */
+#define TRANS_OPT_DEEPEN_SINCE "deepen-since"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
--=20
2.3.0.rc1.137.g477eb31
