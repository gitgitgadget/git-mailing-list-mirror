From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] commit: remove commit.ignoreIntentToAdd, assume it's always true
Date: Mon,  6 Feb 2012 17:57:35 +0700
Message-ID: <1328525855-2547-5-git-send-email-pclouds@gmail.com>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 11:53:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuMCB-0005G3-81
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 11:53:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754693Ab2BFKxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 05:53:10 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:40579 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754527Ab2BFKxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 05:53:09 -0500
Received: by mail-pw0-f46.google.com with SMTP id u11so4870137pbd.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 02:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=FMCfoUIyNLGo01pojkFaR8XPXBijRW7M6iSedPjWijU=;
        b=siqhwKgcgk/nM1thgHE2dngkxLTFb4eFvX+9ZTMLUVcX6xmAkqJtZ1zW+njQ+CgZKM
         yVh6iaKVVxzQ4X5z2amYaLcfZ6Vsw7en2m0YCuks2Kl7QoZOi0p1hC+C+E69yHb996qg
         bV/tAfo/0eucEF+efTuqmRqlpW9dkqk2rgx1s=
Received: by 10.68.228.6 with SMTP id se6mr43614478pbc.80.1328525588838;
        Mon, 06 Feb 2012 02:53:08 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id w4sm38340052pbf.4.2012.02.06.02.53.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 02:53:07 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Mon, 06 Feb 2012 17:58:04 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190066>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |    9 ---------
 builtin/commit.c         |   24 +-----------------------
 t/t2203-add-intent.sh    |    2 +-
 3 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f9a05ac..abeb82b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -831,15 +831,6 @@ commit.template::
 	"{tilde}/" is expanded to the value of `$HOME` and "{tilde}user/" to =
the
 	specified user's home directory.
=20
-commit.ignoreIntentToAdd::
-	Allow to commit the index as-is even if there are
-	intent-to-add entries (see option `-N` in linkgit:git-add[1])
-	in index. Set to `false` to disallow commit in this acase, or `true`
-	to allow it.
-+
-By default, `git commit` allows to commit as-is when you have intent-t=
o-add
-entries. Support for this configuration variable will be dropped in FI=
XME.
-
 credential.helper::
 	Specify an external helper to be called when a username or
 	password credential is needed; the helper may consult external
diff --git a/builtin/commit.c b/builtin/commit.c
index eb0ca49..491cae1 100644
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
@@ -423,18 +421,6 @@ static char *prepare_index(int argc, const char **=
argv, const char *prefix,
 	if (!pathspec || !*pathspec) {
 		fd =3D hold_locked_index(&index_lock, 1);
 		refresh_cache_or_die(refresh_flags);
-		if (!(cache_tree_flags & WRITE_TREE_IGNORE_INTENT_TO_ADD)) {
-			int i;
-			for (i =3D 0; i < active_nr; i++)
-				if (active_cache[i]->ce_flags & CE_INTENT_TO_ADD)
-					break;
-			if (i < active_nr)
-				warning(_("You are committing as-is with intent-to-add entries as =
the result of\n"
-					  "\"git add -N\". Git currently forbids this case. But this is d=
eprecated\n"
-					  "support for this behavior will be dropped in FIXME.\n"
-					  "Please look up document and set commit.ignoreIntentToAdd to tr=
ue\n"
-					  "or remove it."));
-		}
 		if (active_cache_changed) {
 			update_main_cache_tree(cache_tree_flags | WRITE_TREE_SILENT);
 			if (write_cache(fd, active_cache, active_nr) ||
@@ -1353,13 +1339,6 @@ static int git_commit_config(const char *k, cons=
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
@@ -1423,8 +1402,7 @@ int cmd_commit(int argc, const char **argv, const=
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
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 09b8bbf..7c7ab54 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -50,7 +50,7 @@ test_expect_success 'can commit tree with i-t-a entry=
' '
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
