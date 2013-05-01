From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 5/5] Use --not-so-strict on all pack transfer for connectivity check
Date: Wed,  1 May 2013 17:59:34 +0700
Message-ID: <1367405974-22190-6-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 12:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXUkx-0007XA-Ji
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760582Ab3EAK7X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 06:59:23 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55639 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759472Ab3EAK7V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:59:21 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so823202pad.2
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=DGjzpdOVgRC/A7lPTaXDg5GjCMmlNVpXeMBuUY6oVec=;
        b=gam+NV1e1arMAqs24rOcksQQNUD0Y/MTCeRTKQsO1QFjXTAjKFUoN/wkMOAHp2J2vF
         jVXvr08GN4PpcQtnzWR5yqdkkAquY9ZlaBCs+oXIHA/qniFj/UWSSenVTn9cVtggbqoQ
         i8y9NVUvVDXUhNQGoXIp9ezmr67pzN18Yn8M0J6rycXmRqXVQ7y1JZvOhCT9dZfpXA0X
         +faynYCHjUemandJR7w2ZN0ulOcD+qzJ4g59NXrXs1uYSSxqfQX/FUCPcEdpjmN1MXUO
         g8sNXGK06hu96lWRwuX/RBDC30T/PTtrxOTLa2R93PuNLwvDHDQImNlgRav1o1KincsT
         EeFw==
X-Received: by 10.68.164.33 with SMTP id yn1mr3537897pbb.71.1367405961338;
        Wed, 01 May 2013 03:59:21 -0700 (PDT)
Received: from lanh ([115.74.47.19])
        by mx.google.com with ESMTPSA id k2sm3258655pat.7.2013.05.01.03.59.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 03:59:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 May 2013 18:00:10 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223085>

This replaces check_everything_connected() with --not-so-strict, which
accomplishes the same thing and is generally cheaper when index-pack
or unpack-objects are used. All other cases fall back to
check_everything_connected.

This could help reduce the impact of check_everything_connected() on
pack transport. For example, cloning file://../linux-2.6.git

        before       after
real    4m23.664s    3m47.280s
user    4m55.613s    4m39.530s
sys     0m14.805s    0m17.728s

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c                 | 22 ++++++++++--------
 builtin/fetch.c                 | 11 +++++----
 builtin/receive-pack.c          | 51 ++++-----------------------------=
--------
 fetch-pack.c                    |  2 ++
 fetch-pack.h                    |  3 ++-
 t/t5504-fetch-receive-strict.sh |  2 +-
 transport.c                     |  2 ++
 transport.h                     |  1 +
 8 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index dad4265..1cd37c1 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -497,6 +497,8 @@ static void write_remote_refs(const struct ref *loc=
al_refs)
 	for (r =3D local_refs; r; r =3D r->next) {
 		if (!r->peer_ref)
 			continue;
+		if (!has_sha1_file(r->old_sha1))
+			die(_("remote did not send all necessary objects"));
 		add_packed_ref(r->peer_ref->name, r->old_sha1);
 	}
=20
@@ -544,15 +546,6 @@ static void update_remote_refs(const struct ref *r=
efs,
 			       const char *branch_top,
 			       const char *msg)
 {
-	const struct ref *rm =3D mapped_refs;
-
-	if (0 <=3D option_verbosity)
-		printf(_("Checking connectivity... "));
-	if (check_everything_connected(iterate_ref_map, 0, &rm))
-		die(_("remote did not send all necessary objects"));
-	if (0 <=3D option_verbosity)
-		printf(_("done\n"));
-
 	if (refs) {
 		write_remote_refs(mapped_refs);
 		if (option_single_branch)
@@ -953,6 +946,17 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	else if (refs && complete_refs_before_fetch)
 		transport_fetch_refs(transport, mapped_refs);
=20
+	if (!transport->smart_options ||
+	    !transport->smart_options->connected) {
+		const struct ref *rm =3D mapped_refs;
+
+		if (0 <=3D option_verbosity)
+			printf(_("Checking connectivity... "));
+		if (check_everything_connected(iterate_ref_map, 0, &rm))
+			die(_("remote did not send all necessary objects"));
+		if (0 <=3D option_verbosity)
+			printf(_("done\n"));
+	}
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf);
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4b6b1df..e013d3f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -380,7 +380,7 @@ static int iterate_ref_map(void *cb_data, unsigned =
char sha1[20])
 }
=20
 static int store_updated_refs(const char *raw_url, const char *remote_=
name,
-		struct ref *ref_map)
+			      struct ref *ref_map, int need_check)
 {
 	FILE *fp;
 	struct commit *commit;
@@ -401,7 +401,8 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 		url =3D xstrdup("foreign");
=20
 	rm =3D ref_map;
-	if (check_everything_connected(iterate_ref_map, 0, &rm)) {
+	if (need_check &&
+	    check_everything_connected(iterate_ref_map, 0, &rm)) {
 		rc =3D error(_("%s did not send all necessary objects\n"), url);
 		goto abort;
 	}
@@ -538,8 +539,10 @@ static int fetch_refs(struct transport *transport,=
 struct ref *ref_map)
 		ret =3D transport_fetch_refs(transport, ref_map);
 	if (!ret)
 		ret |=3D store_updated_refs(transport->url,
-				transport->remote->name,
-				ref_map);
+					  transport->remote->name,
+					  ref_map,
+					  !transport->smart_options ||
+					  !transport->smart_options->connected);
 	transport_unlock_pack(transport);
 	return ret;
 }
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..2157c1a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -651,48 +651,6 @@ static void check_aliased_updates(struct command *=
commands)
 	string_list_clear(&ref_list, 0);
 }
=20
-static int command_singleton_iterator(void *cb_data, unsigned char sha=
1[20])
-{
-	struct command **cmd_list =3D cb_data;
-	struct command *cmd =3D *cmd_list;
-
-	if (!cmd || is_null_sha1(cmd->new_sha1))
-		return -1; /* end of list */
-	*cmd_list =3D NULL; /* this returns only one */
-	hashcpy(sha1, cmd->new_sha1);
-	return 0;
-}
-
-static void set_connectivity_errors(struct command *commands)
-{
-	struct command *cmd;
-
-	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
-		struct command *singleton =3D cmd;
-		if (!check_everything_connected(command_singleton_iterator,
-						0, &singleton))
-			continue;
-		cmd->error_string =3D "missing necessary objects";
-	}
-}
-
-static int iterate_receive_command_list(void *cb_data, unsigned char s=
ha1[20])
-{
-	struct command **cmd_list =3D cb_data;
-	struct command *cmd =3D *cmd_list;
-
-	while (cmd) {
-		if (!is_null_sha1(cmd->new_sha1)) {
-			hashcpy(sha1, cmd->new_sha1);
-			*cmd_list =3D cmd->next;
-			return 0;
-		}
-		cmd =3D cmd->next;
-	}
-	*cmd_list =3D NULL;
-	return -1; /* end of list */
-}
-
 static void reject_updates_to_hidden(struct command *commands)
 {
 	struct command *cmd;
@@ -718,11 +676,6 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
 		return;
 	}
=20
-	cmd =3D commands;
-	if (check_everything_connected(iterate_receive_command_list,
-				       0, &cmd))
-		set_connectivity_errors(commands);
-
 	reject_updates_to_hidden(commands);
=20
 	if (run_receive_hook(commands, "pre-receive", 0)) {
@@ -844,6 +797,8 @@ static const char *unpack(int err_fd)
 			unpacker[i++] =3D "-q";
 		if (fsck_objects)
 			unpacker[i++] =3D "--strict";
+		else
+			unpacker[i++] =3D "--not-so-strict";
 		unpacker[i++] =3D hdr_arg;
 		unpacker[i++] =3D NULL;
 		memset(&child, 0, sizeof(child));
@@ -869,6 +824,8 @@ static const char *unpack(int err_fd)
 		keeper[i++] =3D "--stdin";
 		if (fsck_objects)
 			keeper[i++] =3D "--strict";
+		else
+			keeper[i++] =3D "--not-so-strict";
 		keeper[i++] =3D "--fix-thin";
 		keeper[i++] =3D hdr_arg;
 		keeper[i++] =3D keep_arg;
diff --git a/fetch-pack.c b/fetch-pack.c
index 17cfa88..cdd9e2d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -755,6 +755,8 @@ static int get_pack(struct fetch_pack_args *args,
 	    ? transfer_fsck_objects
 	    : 0)
 		*av++ =3D "--strict";
+	else if (args->check_connectivity)
+		*av++ =3D "--not-so-strict";
 	*av++ =3D NULL;
=20
 	cmd.in =3D demux.out;
diff --git a/fetch-pack.h b/fetch-pack.h
index dc5266c..824136d 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -16,7 +16,8 @@ struct fetch_pack_args {
 		verbose:1,
 		no_progress:1,
 		include_tag:1,
-		stateless_rpc:1;
+		stateless_rpc:1,
+		check_connectivity:1;
 };
=20
 /*
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-st=
rict.sh
index 69ee13c..14d2935 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -60,7 +60,7 @@ test_expect_success 'fetch with transfer.fsckobjects'=
 '
=20
 cat >exp <<EOF
 To dst
-!	refs/heads/master:refs/heads/test	[remote rejected] (missing necessa=
ry objects)
+!	refs/heads/master:refs/heads/test	[remote rejected] (unpacker error)
 EOF
=20
 test_expect_success 'push without strict' '
diff --git a/transport.c b/transport.c
index ba5d8af..72e6fa3 100644
--- a/transport.c
+++ b/transport.c
@@ -534,6 +534,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.quiet =3D (transport->verbose < 0);
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
+	args.check_connectivity =3D 1;
=20
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
@@ -551,6 +552,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 		refs =3D NULL;
 	data->conn =3D NULL;
 	data->got_remote_heads =3D 0;
+	data->options.connected =3D 1;
=20
 	free_refs(refs_tmp);
=20
diff --git a/transport.h b/transport.h
index fcb1d25..e127224 100644
--- a/transport.h
+++ b/transport.h
@@ -8,6 +8,7 @@ struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
 	unsigned followtags : 1;
+	unsigned connected : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
--=20
1.8.2.83.gc99314b
