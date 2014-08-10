From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 0/8] builtin/mv.c cleanup
Date: Sun, 10 Aug 2014 09:29:28 +0700
Message-ID: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:29:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGItQ-0003Nh-Cf
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:29:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbaHJC3n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:29:43 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:54809 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbaHJC3m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:29:42 -0400
Received: by mail-pa0-f48.google.com with SMTP id et14so9163062pad.7
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=ya1fILLanDg3PuADdrOHzo2R4FDncOhO59zO1jL8USA=;
        b=JGRsqne6ApdzV76FpTCSr5ssZdImLlmQdSecrlMwp6m6WSLGU4ys7JH5Xf7gUWyngM
         nt6ANnQ+VLRpn3nW188g2p03rkhWb6reG4R9IrRxuRm4ulAXL5b8pihCyKCVWGyQJDEH
         f9fORUkDe+g/rnAsobTIuxQMSTVdMXbegm0IsFqyooW18Khtij07lbbTZJgiZwfYJ+39
         M2WW8Gf3tqGq6n2rpH2f4KoBywi15pdWfaZ9M2EzfbGNcPejP4UllTrOQw9PucF5YNne
         NwGgsbzcBsBDw1WClOhbPzpVd/2fKntr6dEfJN2zQGOvPZHDXfRU6KaAHURyysPoEdW6
         hrsQ==
X-Received: by 10.70.88.75 with SMTP id be11mr13378615pdb.69.1407637782427;
        Sat, 09 Aug 2014 19:29:42 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id ey10sm11024943pdb.50.2014.08.09.19.29.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:29:41 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:29:45 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255076>

Interdiff on v1 below. I'm not going with MOVE_UP_BY_ONE because [1]
seems to agree with the name CLOSE_GAP, but that should be a separate
topic (touching more than just mv.c)

[1] http://thread.gmane.org/gmane.comp.version-control.git/243675/focus=
=3D244390

-- 8< --
diff --git a/builtin/mv.c b/builtin/mv.c
index 4eb420b..bf513e0 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -58,11 +58,6 @@ static const char *add_slash(const char *path)
 	return path;
 }
=20
-static void move_up_one(void *p, int nmemb, int size)
-{
-	memmove(p, (char*)p + size, nmemb * size);
-}
-
 static struct lock_file lock_file;
 #define SUBMODULE_WITH_GITDIR ((const char *)1)
=20
@@ -71,9 +66,9 @@ static void prepare_move_submodule(const char *src, i=
nt first,
 {
 	struct strbuf submodule_dotgit =3D STRBUF_INIT;
 	if (!S_ISGITLINK(active_cache[first]->ce_mode))
-		die (_("Directory %s is in index and no submodule?"), src);
+		die(_("Directory %s is in index and no submodule?"), src);
 	if (!is_staging_gitmodules_ok())
-		die (_("Please, stage your changes to .gitmodules or stash them to p=
roceed"));
+		die(_("Please stage your changes to .gitmodules or stash them to pro=
ceed"));
 	strbuf_addf(&submodule_dotgit, "%s/.git", src);
 	*submodule_gitfile =3D read_gitfile(submodule_dotgit.buf);
 	if (*submodule_gitfile)
@@ -91,7 +86,7 @@ static int index_range_of_same_dir(const char *src, i=
nt length,
=20
 	first =3D cache_name_pos(src_w_slash, len_w_slash);
 	if (first >=3D 0)
-		die (_("%.*s is in index"), len_w_slash, src_w_slash);
+		die(_("%.*s is in index"), len_w_slash, src_w_slash);
=20
 	first =3D -1 - first;
 	for (last =3D first; last < active_nr; last++) {
@@ -235,14 +230,18 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
 		if (!bad)
 			continue;
 		if (!ignore_errors)
-			die (_("%s, source=3D%s, destination=3D%s"),
+			die(_("%s, source=3D%s, destination=3D%s"),
 			     bad, src, dst);
 		if (--argc > 0) {
 			int n =3D argc - i;
-			move_up_one(source + i, n, sizeof(*source));
-			move_up_one(destination + i, n, sizeof(*destination));
-			move_up_one(modes + i, n, sizeof(*modes));
-			move_up_one(submodule_gitfile + i, n, sizeof(*submodule_gitfile));
+			memmove(source + i, source + i + 1,
+				n * sizeof(char *));
+			memmove(destination + i, destination + i + 1,
+				n * sizeof(char *));
+			memmove(modes + i, modes + i + 1,
+				n * sizeof(enum update_mode));
+			memmove(submodule_gitfile + i, submodule_gitfile + i + 1,
+				n * sizeof(char *));
 			i--;
 		}
 	}
@@ -255,7 +254,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 			printf(_("Renaming %s to %s\n"), src, dst);
 		if (!show_only && mode !=3D INDEX) {
 			if (rename(src, dst) < 0 && !ignore_errors)
-				die_errno (_("renaming '%s' failed"), src);
+				die_errno(_("renaming '%s' failed"), src);
 			if (submodule_gitfile[i]) {
 				if (submodule_gitfile[i] !=3D SUBMODULE_WITH_GITDIR)
 					connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
@@ -278,7 +277,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
=20
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock_file, COMMIT_LOCK))
-			die(_("Unable to write new index file"));
+		die(_("Unable to write new index file"));
=20
 	return 0;
 }
-- 8< --

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (8):
  mv: mark strings for translations
  mv: flatten error handling code block
  mv: split submodule move preparation code out
  mv: remove an "if" that's always true
  mv: move index search code out
  mv: unindent one level for directory move code
  mv: combine two if(s)
  mv: no SP between function name and the first opening parenthese

 builtin/mv.c | 171 +++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 85 insertions(+), 86 deletions(-)

--=20
2.1.0.rc0.78.gc0d8480
