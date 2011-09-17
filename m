From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 1/4] merge: keep stash[] a local variable
Date: Sat, 17 Sep 2011 21:57:42 +1000
Message-ID: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 13:58:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4tXJ-0005Dj-Rn
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 13:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab1IQL6J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 07:58:09 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35780 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753609Ab1IQL5y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 07:57:54 -0400
Received: by iaqq3 with SMTP id q3so3214468iaq.19
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 04:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rPn1EZQjx8g/JyXgIW8dBftOPLlyrQQ/OVleMgCTg34=;
        b=cYRiI3rcHIbFYV6VTZ0HXhWlB9MCdF6c5pv0GdEunCroWi1qWcYiRS8PDuJbh2KwqI
         goMdl1Rfimz31JC6zdhxWwc7bAQmugzOwh/WTbU+lx+kars7jychj1a04IcqCdHDUz5L
         6sZSs4r25xpUjuaTp0I09GS0BZVZjNZY8spCA=
Received: by 10.42.73.7 with SMTP id q7mr822679icj.55.1316260674270;
        Sat, 17 Sep 2011 04:57:54 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id df21sm14276729ibb.9.2011.09.17.04.57.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 04:57:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 17 Sep 2011 21:57:46 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181576>

A stash is created by save_state() and used by restore_state(). Pass
SHA-1 explicitly for clarity and keep stash[] to cmd_merge().

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 v4 was http://thread.gmane.org/gmane.comp.version-control.git/179375/f=
ocus=3D179706

 builtin/merge.c |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 325891e..a068660 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -50,7 +50,7 @@ static int fast_forward_only;
 static int allow_trivial =3D 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
-static unsigned char head[20], stash[20];
+static unsigned char head[20];
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
@@ -217,7 +217,7 @@ static void drop_save(void)
 	unlink(git_path("MERGE_MODE"));
 }
=20
-static void save_state(void)
+static int save_state(unsigned char *stash)
 {
 	int len;
 	struct child_process cp;
@@ -236,11 +236,12 @@ static void save_state(void)
=20
 	if (finish_command(&cp) || len < 0)
 		die(_("stash failed"));
-	else if (!len)
-		return;
+	else if (!len)		/* no changes */
+		return -1;
 	strbuf_setlen(&buffer, buffer.len-1);
 	if (get_sha1(buffer.buf, stash))
 		die(_("not a valid object: %s"), buffer.buf);
+	return 0;
 }
=20
 static void read_empty(unsigned const char *sha1, int verbose)
@@ -278,7 +279,7 @@ static void reset_hard(unsigned const char *sha1, i=
nt verbose)
 		die(_("read-tree failed"));
 }
=20
-static void restore_state(void)
+static void restore_state(const unsigned char *stash)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	const char *args[] =3D { "stash", "apply", NULL, NULL };
@@ -1010,6 +1011,7 @@ static int setup_with_upstream(const char ***argv=
)
 int cmd_merge(int argc, const char **argv, const char *prefix)
 {
 	unsigned char result_tree[20];
+	unsigned char stash[20];
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *head_arg;
 	int flag, head_invalid =3D 0, i;
@@ -1320,21 +1322,18 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	 * sync with the head commit.  The strategies are responsible
 	 * to ensure this.
 	 */
-	if (use_strategies_nr !=3D 1) {
-		/*
-		 * Stash away the local changes so that we can try more
-		 * than one.
-		 */
-		save_state();
-	} else {
-		memcpy(stash, null_sha1, 20);
-	}
+	if (use_strategies_nr =3D=3D 1 ||
+	    /*
+	     * Stash away the local changes so that we can try more than one.
+	     */
+	    save_state(stash))
+		hashcpy(stash, null_sha1);
=20
 	for (i =3D 0; i < use_strategies_nr; i++) {
 		int ret;
 		if (i) {
 			printf(_("Rewinding the tree to pristine...\n"));
-			restore_state();
+			restore_state(stash);
 		}
 		if (use_strategies_nr !=3D 1)
 			printf(_("Trying merge strategy %s...\n"),
@@ -1395,7 +1394,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	 * it up.
 	 */
 	if (!best_strategy) {
-		restore_state();
+		restore_state(stash);
 		if (use_strategies_nr > 1)
 			fprintf(stderr,
 				_("No merge strategy handled the merge.\n"));
@@ -1407,7 +1406,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		; /* We already have its result in the working tree. */
 	else {
 		printf(_("Rewinding the tree to pristine...\n"));
-		restore_state();
+		restore_state(stash);
 		printf(_("Using the %s to prepare resolving by hand.\n"),
 			best_strategy);
 		try_merge_strategy(best_strategy, common, head_arg);
--=20
1.7.3.1.256.g2539c.dirty
