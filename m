From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/10] cmd_merge: convert to single exit point
Date: Tue, 15 Nov 2011 13:07:48 +0700
Message-ID: <1321337276-17803-2-git-send-email-pclouds@gmail.com>
References: <20111115060603.GA17585@tre>
 <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:06:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQC9x-0005p2-Jy
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399Ab1KOGFt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Nov 2011 01:05:49 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:46627 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173Ab1KOGFU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:05:20 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so14544202pzk.1
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 22:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5wgOaBcazAZRoUwYtVwdITasxHUBz0/qSlXa4r/cWwM=;
        b=V/SjoLI0+BwJ//k4MfdEoAtoiCiZjIpSQwvc8OzyatDbOHpoK13e3ZX1hBz+W7Kwpw
         9siXWRmuWudODLlolhZbrUkN0G0sFkSWyLiNfDNYvfbNr9PPoaKdFx+9qHDxSPLMeJ9s
         yv08XiKh/RLHcSS3aOqr2geIlJCsfFNGvNxck=
Received: by 10.68.24.65 with SMTP id s1mr56283115pbf.12.1321337119876;
        Mon, 14 Nov 2011 22:05:19 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id b4sm62380480pbc.19.2011.11.14.22.05.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 22:05:18 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 15 Nov 2011 13:08:04 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321337276-17803-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185429>

This makes post-processing easier.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |   48 +++++++++++++++++++++++++++++------------------=
-
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d9c7a80..1be6f3b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1082,7 +1082,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	struct commit *head_commit;
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *head_arg;
-	int flag, i;
+	int flag, i, ret =3D 0;
 	int best_cnt =3D -1, merge_was_ok =3D 0, automerge_was_ok =3D 0;
 	struct commit_list *common =3D NULL;
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
@@ -1121,7 +1121,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
=20
 		/* Invoke 'git reset --merge' */
-		return cmd_reset(nargc, nargv, prefix);
+		ret =3D cmd_reset(nargc, nargv, prefix);
+		goto done;
 	}
=20
 	if (read_cache_unmerged())
@@ -1205,7 +1206,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		read_empty(remote_head->sha1, 0);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		return 0;
+		goto done;
 	} else {
 		struct strbuf merge_names =3D STRBUF_INIT;
=20
@@ -1292,7 +1293,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		 * but first the most common case of merging one remote.
 		 */
 		finish_up_to_date("Already up-to-date.");
-		return 0;
+		goto done;
 	} else if (allow_fast_forward && !remoteheads->next &&
 			!common->next &&
 			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
@@ -1313,15 +1314,16 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 			strbuf_addstr(&msg,
 				" (no commit created; -m option ignored)");
 		o =3D want_commit(sha1_to_hex(remoteheads->item->object.sha1));
-		if (!o)
-			return 1;
-
-		if (checkout_fast_forward(head_commit->object.sha1, remoteheads->ite=
m->object.sha1))
-			return 1;
+		if (!o ||
+		    checkout_fast_forward(head_commit->object.sha1,
+					  remoteheads->item->object.sha1)) {
+			ret =3D 1;
+			goto done;
+		}
=20
 		finish(head_commit, o->sha1, msg.buf);
 		drop_save();
-		return 0;
+		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
 		/*
@@ -1339,8 +1341,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 			git_committer_info(IDENT_ERROR_ON_NO_NAME);
 			printf(_("Trying really trivial in-index merge...\n"));
 			if (!read_tree_trivial(common->item->object.sha1,
-					head_commit->object.sha1, remoteheads->item->object.sha1))
-				return merge_trivial(head_commit);
+					       head_commit->object.sha1,
+					       remoteheads->item->object.sha1)) {
+				ret =3D merge_trivial(head_commit);
+				goto done;
+			}
 			printf(_("Nope.\n"));
 		}
 	} else {
@@ -1368,7 +1373,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		}
 		if (up_to_date) {
 			finish_up_to_date("Already up-to-date. Yeeah!");
-			return 0;
+			goto done;
 		}
 	}
=20
@@ -1450,9 +1455,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 	 * If we have a resulting tree, that means the strategy module
 	 * auto resolved the merge cleanly.
 	 */
-	if (automerge_was_ok)
-		return finish_automerge(head_commit, common, result_tree,
-					wt_strategy);
+	if (automerge_was_ok) {
+		ret =3D finish_automerge(head_commit, common, result_tree,
+				       wt_strategy);
+		goto done;
+	}
=20
 	/*
 	 * Pick the result from the best strategy and have the user fix
@@ -1466,7 +1473,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		else
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
-		return 2;
+		ret =3D 2;
+		goto done;
 	} else if (best_strategy =3D=3D wt_strategy)
 		; /* We already have its result in the working tree. */
 	else {
@@ -1485,7 +1493,9 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	if (merge_was_ok) {
 		fprintf(stderr, _("Automatic merge went well; "
 			"stopped before committing as requested\n"));
-		return 0;
 	} else
-		return suggest_conflicts(option_renormalize);
+		ret =3D suggest_conflicts(option_renormalize);
+
+done:
+	return ret;
 }
--=20
1.7.4.74.g639db
