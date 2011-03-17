From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] system_path: use a static buffer
Date: Thu, 17 Mar 2011 12:01:04 +0100
Message-ID: <1300359664-6230-1-git-send-email-cmn@elego.de>
References: <7vipvi7q5g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 12:01:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0Ax8-0007sM-0b
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 12:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab1CQLBI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 07:01:08 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:33552 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257Ab1CQLBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 07:01:07 -0400
Received: from bee.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 8BD3F460FD;
	Thu, 17 Mar 2011 12:00:59 +0100 (CET)
Received: (nullmailer pid 6311 invoked by uid 1000);
	Thu, 17 Mar 2011 11:01:04 -0000
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <7vipvi7q5g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169233>

Make system_path behave like the other path functions by using a
static buffer, fixing a memory leak.

Also make sure the prefix pointer is always initialized to either
PREFIX or NULL.

git_etc_gitattributes and git_etc_gitconfig are the only users who are
affected by this change. Make them use a static buffer, which fits
their use better as well.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

On mi=C3=A9, 2011-03-16 at 13:43 -0700, Junio C Hamano wrote:
Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > Make system_path behave like the other path functions by using a
> > static buffer, fixing a memory leak.
> >
> > Also make sure the prefix pointer is always initialized to either
> > PREFIX or NULL.
> >
> > Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> > ---
>=20
> Have you made sure all the callers are Ok with this change?
>=20
> If somebody called system_path(GIT_EXEC_PATH), saved the result in a
> variable without copying, and then called system_path(ETC_GITATTRIBUT=
ES),
> his variable may now have a value unrelated to GIT_EXEC_PATH, and you
> would fix all such callers to save the value away with strdup().


I checked again, and except for the ones changed in this patch, the
rest copy it to their own buffer or pass it to puts, setenv or
strbuf_addstr.

The way these functions are used suggest the caller expects them to
deal with their own memory, so that's what I've done.

TBH, valgrind only reports a win of ~6-7kB when doing git log on
git.git, but it's a step in the right direction (and adds consistency
to system_path, which is the main win).

 attr.c     |    6 +++---
 config.c   |    6 +++---
 exec_cmd.c |   11 ++++++-----
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/attr.c b/attr.c
index 6aff695..64d803f 100644
--- a/attr.c
+++ b/attr.c
@@ -467,9 +467,9 @@ static void drop_attr_stack(void)
=20
 const char *git_etc_gitattributes(void)
 {
-	static const char *system_wide;
-	if (!system_wide)
-		system_wide =3D system_path(ETC_GITATTRIBUTES);
+	static char system_wide[PATH_MAX];
+	if (!system_wide[0])
+		strlcpy(system_wide, system_path(ETC_GITATTRIBUTES), PATH_MAX);
 	return system_wide;
 }
=20
diff --git a/config.c b/config.c
index 822ef83..cd1c295 100644
--- a/config.c
+++ b/config.c
@@ -808,9 +808,9 @@ int git_config_from_file(config_fn_t fn, const char=
 *filename, void *data)
=20
 const char *git_etc_gitconfig(void)
 {
-	static const char *system_wide;
-	if (!system_wide)
-		system_wide =3D system_path(ETC_GITCONFIG);
+	static char system_wide[PATH_MAX];
+	if (!system_wide[0])
+		strlcpy(system_wide, system_path(ETC_GITCONFIG), PATH_MAX);
 	return system_wide;
 }
=20
diff --git a/exec_cmd.c b/exec_cmd.c
index 38545e8..5686952 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -9,11 +9,11 @@ static const char *argv0_path;
 const char *system_path(const char *path)
 {
 #ifdef RUNTIME_PREFIX
-	static const char *prefix;
+	static const char *prefix =3D NULL;
 #else
 	static const char *prefix =3D PREFIX;
 #endif
-	struct strbuf d =3D STRBUF_INIT;
+	static char buf[PATH_MAX];
=20
 	if (is_absolute_path(path))
 		return path;
@@ -33,9 +33,10 @@ const char *system_path(const char *path)
 	}
 #endif
=20
-	strbuf_addf(&d, "%s/%s", prefix, path);
-	path =3D strbuf_detach(&d, NULL);
-	return path;
+	if (snprintf(buf, sizeof(buf), "%s/%s", prefix, path) >=3D sizeof(buf=
))
+		die("system path too long for %s", path);
+
+	return buf;
 }
=20
 const char *git_extract_argv0_path(const char *argv0)
--=20
1.7.4.1
