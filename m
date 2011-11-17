From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] cmd_merge: convert to single exit point
Date: Thu, 17 Nov 2011 16:32:11 +0700
Message-ID: <1321522335-24193-5-git-send-email-pclouds@gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:29:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyHb-0002jp-Od
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189Ab1KQJ3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:29:16 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44094 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185Ab1KQJ3N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:29:13 -0500
Received: by mail-iy0-f174.google.com with SMTP id e36so1839093iag.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dHm6WlUFSF1l2M8qsJ+3GYni0gvtfNAoxAv8roOsONk=;
        b=OfIRYsZlopyb/DIWcm+kPjTtWqEi+RE0LIpieAoJ6dI0fWCl3zFkgCn/Bk0Qda/vJ9
         Basc8B37vur/kL/iHjAcoo9jOzAbFAxKg9zCkHIu/p6+IDQoIH0QsMckTzcQhquQs1Y+
         nrfT5xwFTwFgAcgyF67YvdbyQbXGyWbGB0sho=
Received: by 10.42.146.72 with SMTP id i8mr13502346icv.38.1321522153124;
        Thu, 17 Nov 2011 01:29:13 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id eb23sm55727765ibb.2.2011.11.17.01.29.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:29:12 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:32:49 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185584>

This makes post-processing easier.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |   48 +++++++++++++++++++++++++++++------------------=
-
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 519e3c5..0d597b3 100644
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
