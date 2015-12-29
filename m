From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/20] fetch: define shallow boundary with --not
Date: Tue, 29 Dec 2015 19:10:40 +0700
Message-ID: <1451391043-28093-18-git-send-email-pclouds@gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 13:12:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDt8o-0007IB-U2
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 13:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbbL2MMg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 07:12:36 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35372 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbL2MMe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 07:12:34 -0500
Received: by mail-pf0-f170.google.com with SMTP id 78so126444567pfw.2
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 04:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=u14am8ERooCcDkVq9BW6a8OLXeQlzRoMMWsadlohBHM=;
        b=0oTZ3T1AXzxOKwC/ttfPjPDmzD27pAJzN1XRoKEwUgZz13ReSvBZvE1dvaTpsTFqRc
         Fo17yNePVTVgGpl6NDfoXPmPmaOdeiAgoX2i+KFTIRtVB48BDLYZYN9DyjRR8fpIFyLn
         E2Ow0Zu0kTIqz7QENzm1kcs8HXMCVUYl4A/sXTtxKYBg9t3yYKgaXH/PO9PhkulDl69l
         OOVZDydyixBKjDDhhP03/BoYtVxmDq85JyF7RU73slEBNVhpU+AZNJLrhEkqxTLdZUCK
         rYUWnV5MyOf3vBnC6hbddUsgpacQJewi4G5CQdtUDA/9s6W130FP/Oe0AZSh/uaz1nW9
         JYeg==
X-Received: by 10.98.15.206 with SMTP id 75mr20569928pfp.60.1451391153882;
        Tue, 29 Dec 2015 04:12:33 -0800 (PST)
Received: from lanh ([171.233.234.31])
        by smtp.gmail.com with ESMTPSA id r90sm83019534pfi.80.2015.12.29.04.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Dec 2015 04:12:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Dec 2015 19:12:29 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1451391043-28093-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283127>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt |  5 +++++
 builtin/fetch.c                 | 17 ++++++++++++++++-
 fetch-pack.c                    | 15 ++++++++++++++-
 fetch-pack.h                    |  1 +
 transport.c                     |  4 ++++
 transport.h                     |  6 ++++++
 6 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index ff6e6ad..39fbcc3 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -17,6 +17,11 @@
 	Deepen or shorten the history of a 'shallow' repository to
 	include all reachable commits after <date>.
=20
+--not=3D<revision>::
+	Deepen or shorten the history of a 'shallow' repository to
+	exclude commits reachable from a specified remote branch or tag.
+	This option can be specified multiple times.
+
 --unshallow::
 	If the source repository is complete, convert a shallow
 	repository to a complete one, removing all the limitations
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 3317152..02a50e4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -40,6 +40,7 @@ static int tags =3D TAGS_DEFAULT, unshallow, update_s=
hallow, deepen;
 static const char *depth;
 static const char *deepen_since;
 static const char *upload_pack;
+struct string_list deepen_not =3D STRING_LIST_INIT_NODUP;
 static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
@@ -49,6 +50,13 @@ static int shown_url =3D 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
=20
+static int option_parse_deepen_not(const struct option *opt,
+				   const char *arg, int unset)
+{
+	string_list_append(&deepen_not, arg);
+	return 0;
+}
+
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -115,6 +123,9 @@ static struct option builtin_fetch_options[] =3D {
 		   N_("deepen history of shallow clone")),
 	OPT_STRING(0, "since", &deepen_since, N_("time"),
 		   N_("deepen history of shallow clone based on time")),
+	{ OPTION_CALLBACK, 0, "not", NULL, N_("revision"),
+		    N_("deepen history of shallow clone by excluding rev"),
+		    PARSE_OPT_NONEG, option_parse_deepen_not },
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -872,6 +883,9 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
 	if (deepen_since)
 		set_option(transport, TRANS_OPT_DEEPEN_SINCE, deepen_since);
+	if (deepen_not.nr)
+		set_option(transport, TRANS_OPT_DEEPEN_NOT,
+			   (const char *)&deepen_not);
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
@@ -887,6 +901,7 @@ static void backfill_tags(struct transport *transpo=
rt, struct ref *ref_map)
 	transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, NULL);
 	transport_set_option(transport, TRANS_OPT_DEPTH, "0");
 	transport_set_option(transport, TRANS_OPT_DEEPEN_SINCE, NULL);
+	transport_set_option(transport, TRANS_OPT_DEEPEN_NOT, NULL);
 	fetch_refs(transport, ref_map);
=20
 	if (gsecondary) {
@@ -1170,7 +1185,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	/* no need to be strict, transport_set_option() will validate it agai=
n */
 	if (depth && atoi(depth) < 1)
 		die(_("depth %s is not a positive number"), depth);
-	if (depth || deepen_since)
+	if (depth || deepen_since || deepen_not.nr)
 		deepen =3D 1;
=20
 	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
diff --git a/fetch-pack.c b/fetch-pack.c
index f26cef4..45f69de 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -22,6 +22,7 @@ static int unpack_limit =3D 100;
 static int prefer_ofs_delta =3D 1;
 static int no_done;
 static int deepen_since_ok;
+static int deepen_not_ok;
 static int fetch_fsck_objects =3D -1;
 static int transfer_fsck_objects =3D -1;
 static int agent_supported;
@@ -328,6 +329,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
 			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
+			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -351,6 +353,13 @@ static int find_common(struct fetch_pack_args *arg=
s,
 		unsigned long max_age =3D approxidate(args->deepen_since);
 		packet_buf_write(&req_buf, "deepen-since %lu", max_age);
 	}
+	if (args->deepen_not) {
+		int i;
+		for (i =3D 0; i < args->deepen_not->nr; i++) {
+			struct string_list_item *s =3D args->deepen_not->items + i;
+			packet_buf_write(&req_buf, "deepen-not %s", s->string);
+		}
+	}
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
@@ -819,7 +828,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die("Server does not support shallow clients");
-	if (args->depth > 0 || args->deepen_since)
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen =3D 1;
 	if (server_supports("multi_ack_detailed")) {
 		print_verbose(args, "Server supports multi_ack_detailed");
@@ -871,6 +880,10 @@ static struct ref *do_fetch_pack(struct fetch_pack=
_args *args,
 		deepen_since_ok =3D 1;
 	else if (args->deepen_since)
 		die("Server does not support --since");
+	if (server_supports("deepen-not"))
+		deepen_not_ok =3D 1;
+	else if (args->deepen_not)
+		die("Server does not support --not");
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index f7eadb2..144301f 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -11,6 +11,7 @@ struct fetch_pack_args {
 	int unpacklimit;
 	int depth;
 	const char *deepen_since;
+	const struct string_list *deepen_not;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/transport.c b/transport.c
index 4902036..3094c6b 100644
--- a/transport.c
+++ b/transport.c
@@ -480,6 +480,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_SINCE)) {
 		opts->deepen_since =3D value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN_NOT)) {
+		opts->deepen_not =3D (const struct string_list *)value;
+		return 0;
 	}
 	return 1;
 }
@@ -534,6 +537,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
 	args.deepen_since =3D data->options.deepen_since;
+	args.deepen_not =3D data->options.deepen_not;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
diff --git a/transport.h b/transport.h
index 9c10a44..ab61932 100644
--- a/transport.h
+++ b/transport.h
@@ -5,6 +5,8 @@
 #include "run-command.h"
 #include "remote.h"
=20
+struct string_list;
+
 struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
@@ -14,6 +16,7 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	int depth;
 	const char *deepen_since;
+	const struct string_list *deepen_not;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
@@ -175,6 +178,9 @@ int transport_restrict_protocols(void);
 /* Limit the depth of the fetch based on time if not null */
 #define TRANS_OPT_DEEPEN_SINCE "deepen-since"
=20
+/* Limit the depth of the fetch based on revs if not null */
+#define TRANS_OPT_DEEPEN_NOT "deepen-not"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
--=20
2.3.0.rc1.137.g477eb31
