From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 4/4] commit: remove commit.ignoreIntentToAdd, assume it's always true
Date: Tue,  7 Feb 2012 19:46:44 +0700
Message-ID: <1328618804-31796-5-git-send-email-pclouds@gmail.com>
References: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 13:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RukNE-00070D-MX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 13:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342Ab2BGMmL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Feb 2012 07:42:11 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34915 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab2BGMmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 07:42:09 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so358770dae.19
        for <git@vger.kernel.org>; Tue, 07 Feb 2012 04:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X+j16X7t9WWH0SGiACQdUWC6lx3I0mWuUjOIv+Ex62s=;
        b=Fr82IAN+gIpBKPlCescmtSXq3usX+KccdlZY3aTmUM/fwRLHM/BQRymG34GCui7eDN
         K4mdvjZj25lp9Jz7RkuW59AVnbulo7fbNPl6P7J1x7P5pDajJ93NbjElQKfMOSttAkH3
         +ESkJUibN6e0nR7yjmdzRtFFpaSDqDDrfayxs=
Received: by 10.68.73.4 with SMTP id h4mr58199558pbv.27.1328618529650;
        Tue, 07 Feb 2012 04:42:09 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id b7sm46331631pba.2.2012.02.07.04.42.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Feb 2012 04:42:08 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 07 Feb 2012 19:47:20 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328618804-31796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190170>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |   13 -------------
 builtin/commit.c         |   35 +----------------------------------
 t/t2203-add-intent.sh    |    4 ++--
 3 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fa56753..abeb82b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -831,19 +831,6 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to =
the
 	specified user's home directory.
=20
-commit.ignoreIntentToAdd::
-	When set to `false`, prevent `git commit` from creating a
-	commit from an index that has entries that were added with
-	`git add -N` but have not been updated with real contents, as
-	the user may have forgotten to tell the final contents for
-	these entries.  Setting this to `true` makes `git commit`
-	pretend as if these entries do not exist in the index.
-+
-The default for this variable is `true`. You are discouraged to set it
-to `false` to keep the old behaviour a bit longer because support
-setting this to `false` will be removed in future releases without
-warning.
-
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/builtin/commit.c b/builtin/commit.c
index cd28081..491cae1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -118,8 +118,6 @@ static enum {
 } status_format =3D STATUS_FORMAT_LONG;
 static int status_show_branch;
=20
-static int set_commit_ignoreintenttoadd;
-
 static int opt_parse_m(const struct option *opt, const char *arg, int =
unset)
 {
 	struct strbuf *buf =3D opt->value;
@@ -423,20 +421,6 @@ static char *prepare_index(int argc, const char **=
argv, const char *prefix,
 	if (!pathspec || !*pathspec) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
-		if (!(cache_tree_flags & WRITE_TREE_IGNORE_INTENT_TO_ADD)) {
-			int i;
-			for (i =3D 0; i < active_nr; i++)
-				if (active_cache[i]->ce_flags & CE_INTENT_TO_ADD)
-					break;
-			if (i < active_nr) {
-				error(_("you intended to add \"%s\" but did not add it; not commit=
ting\n"
-					"this behavior is deprecated, please set commit.ignoreIntentToAdd=
\n"
-					"to true or remove the configuration variable. See the configurat=
ion\n"
-					"variable documentation for more information."),
-				      active_cache[i]->name);
-				exit(128); /* die() */
-			}
-		}
 		if (active_cache_changed) {
 			update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
@@ -1355,13 +1339,6 @@ static int git_commit_config(const char *k, cons=
t char *v, void *cb)
 		include_status =3D git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "commit.ignoreintenttoadd")) {
-		set_commit_ignoreintenttoadd =3D 1;
-		if (git_config_bool(k, v))
-			cache_tree_flags |=3D WRITE_TREE_IGNORE_INTENT_TO_ADD;
-		else
-			cache_tree_flags &=3D ~WRITE_TREE_IGNORE_INTENT_TO_ADD;
-	}
=20
 	status =3D git_gpg_config(k, v, NULL);
 	if (status)
@@ -1425,8 +1402,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	git_config(git_commit_config, &s);
 	determine_whence(&s);
=20
-	if (!set_commit_ignoreintenttoadd)
-		cache_tree_flags |=3D WRITE_TREE_IGNORE_INTENT_TO_ADD;
+	cache_tree_flags |=3D WRITE_TREE_IGNORE_INTENT_TO_ADD;
=20
 	if (get_sha1("HEAD", sha1))
 		current_head =3D NULL;
@@ -1587,14 +1563,5 @@ int cmd_commit(int argc, const char **argv, cons=
t char *prefix)
 	if (!quiet)
 		print_summary(prefix, sha1, !current_head);
=20
-	if (set_commit_ignoreintenttoadd) {
-		if (cache_tree_flags & WRITE_TREE_IGNORE_INTENT_TO_ADD)
-			warning(_("commit.ignoreIntentToAdd =3D true is not needed anymore.=
\n"
-				  "Please remove it."));
-		else
-			warning(_("commit.ignoreIntentToAdd =3D false is deprecated.\n"
-				  "Please see the commit.ignoreIntentToAdd documentation for\n"
-				  "more information and remove the configuration variable."));
-	}
 	return 0;
 }
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 09b8bbf..6dbfb74 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -44,13 +44,13 @@ test_expect_success 'cannot commit with i-t-a entry=
' '
 	git commit -minitial
 '
=20
-test_expect_success 'can commit tree with i-t-a entry' '
+test_expect_success 'commit.ignoreIntentToAdd =3D false is ignored' '
 	git reset --hard HEAD^ &&
 	echo xyzzy >rezrov &&
 	echo frotz >nitfol &&
 	git add rezrov &&
 	git add -N nitfol &&
-	git config commit.ignoreIntentToAdd true &&
+	git config commit.ignoreIntentToAdd false &&
 	git commit -m initial &&
 	git ls-tree -r HEAD >actual &&
 	cat >expected <<EOF &&
--=20
1.7.8.36.g69ee2
