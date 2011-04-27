From: =?us-ascii?B?PT9VVEYtOD9xP01vdGllanVzPTIwSmFrPUM1PUExdHlzPz0=?= 
	<desired.mta@gmail.com>
Subject: [PATCH/RFC] inconsistent error messages for translation
Date: Wed, 27 Apr 2011 13:22:50 +0100
Message-ID: <20110427122250.GA10919@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 14:23:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF3lk-0004SL-BA
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 14:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013Ab1D0MWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 08:22:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36378 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221Ab1D0MWy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 08:22:54 -0400
Received: by wwa36 with SMTP id 36so1818215wwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :user-agent;
        bh=apbT+tgG3eHpL0YqH7////DmZMr9OKxW4gpsINre4mE=;
        b=wVPfXVSCJy39XqC8NWSxEB03USJMLjXdzCnr2ZQEtFFUL8ia4fCTJ4TQCGCbbo0/48
         eGdt905wo8ZaHllaRN/iC1iwJfiJ/tudx74dEEUCMSPuVIhKJjek4RmYj+etTUjSdCI/
         DOwp+cut3yqKwg/MCRWCcIrDN5KMsqgU8QusE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=KQgiR3Wpfv0fgLStq6xWKpx4ZFYXdSwaziuco4GFppgYeanP2Uz43XAOwfXHNcYVMu
         ifbeFurqoIwyWj20KiV7cexxtcoB0fLWF94gKebnWC3jeHXerYU26a5o5gtq4DKa7jLr
         uogd0kuDV0rXL6tNG4cdExWVxtAq0RnG0JT9A=
Received: by 10.227.130.78 with SMTP id r14mr2101460wbs.101.1303906972993;
        Wed, 27 Apr 2011 05:22:52 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id y29sm424529wbd.55.2011.04.27.05.22.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 05:22:52 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172230>

There are lots of variants of the same message:

msgid "cannot stat '%s'"
msgid "failed to stat '%s'"
msgid "failed to stat %s\n"
msgid "Could not stat '%s'"

This patch makes them all "Could not stat %s" and "Could not stat '%s'\=
n".
That makes .po file shorter.

Also same trivial fix:
-		return error(_("path '%s' does not have all three versions"),
+		return error(_("path '%s' does not have all 3 versions"),

Signed-off-by: Motiejus Jak=C5=A1tys <desired.mta@gmail.com>
---

DRY:

#: builtin/fetch.c:282
sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '-',
    TRANSPORT_SUMMARY_WIDTH, _("[tag update]"), REFCOL_WIDTH, remote,
    pretty_ref, r ? _("  (unable to update local ref)") : "");

#: builtin/fetch.c:338
sprintf(display, "%c %-*s %-*s -> %s  (%s)", r ? '!' : '+',
    TRANSPORT_SUMMARY_WIDTH, quickref, REFCOL_WIDTH, remote,
    pretty_ref,
    r ? _("unable to update local ref") : _("forced update"));

It produces
#: builtin/fetch.c:282 builtin/fetch.c:307 builtin/fetch.c:323
msgid "  (unable to update local ref)"
#: builtin/fetch.c:338
msgid "unable to update local ref"

I would like to have one string to translate instead of two.

How I would solve this:
// or similar, unsure if this will work
char *without_brackets =3D _("unable to update local ref");
char *with_brackets;
snprintf(with_brackets, 20, "  (%s)", trans);

// -- code --
    pretty_ref, r ? with_brackets : "");

It introduces 2 more variables. Is there a more elegant way?

Motiejus

 builtin/checkout.c |    2 +-
 builtin/grep.c     |    2 +-
 builtin/init-db.c  |   24 ++++++++++++------------
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index eece5d6..417f03d 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -118,7 +118,7 @@ static int check_all_stages(struct cache_entry *ce,=
 int pos)
 	    ce_stage(active_cache[pos+1]) !=3D 2 ||
 	    strcmp(active_cache[pos+2]->name, ce->name) ||
 	    ce_stage(active_cache[pos+2]) !=3D 3)
-		return error(_("path '%s' does not have all three versions"),
+		return error(_("path '%s' does not have all 3 versions"),
 			     ce->name);
 	return 0;
 }
diff --git a/builtin/grep.c b/builtin/grep.c
index 10a1f65..24d19b8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -413,7 +413,7 @@ static void *load_file(const char *filename, size_t=
 *sz)
 	if (lstat(filename, &st) < 0) {
 	err_ret:
 		if (errno !=3D ENOENT)
-			error(_("'%s': %s"), filename, strerror(errno));
+			error("'%s': %s", filename, strerror(errno));
 		return NULL;
 	}
 	if (!S_ISREG(st.st_mode))
diff --git a/builtin/init-db.c b/builtin/init-db.c
index b7370d9..f1bee61 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -64,20 +64,20 @@ static void copy_templates_1(char *path, int basele=
n,
 		memcpy(template + template_baselen, de->d_name, namelen+1);
 		if (lstat(path, &st_git)) {
 			if (errno !=3D ENOENT)
-				die_errno(_("cannot stat '%s'"), path);
+				die_errno(_("Could not stat '%s'"), path);
 		}
 		else
 			exists =3D 1;
=20
 		if (lstat(template, &st_template))
-			die_errno(_("cannot stat template '%s'"), template);
+			die_errno(_("Could not stat template '%s'"), template);
=20
 		if (S_ISDIR(st_template.st_mode)) {
 			DIR *subdir =3D opendir(template);
 			int baselen_sub =3D baselen + namelen;
 			int template_baselen_sub =3D template_baselen + namelen;
 			if (!subdir)
-				die_errno(_("cannot opendir '%s'"), template);
+				die_errno(_("Could not opendir '%s'"), template);
 			path[baselen_sub++] =3D
 				template[template_baselen_sub++] =3D '/';
 			path[baselen_sub] =3D
@@ -94,16 +94,16 @@ static void copy_templates_1(char *path, int basele=
n,
 			int len;
 			len =3D readlink(template, lnk, sizeof(lnk));
 			if (len < 0)
-				die_errno(_("cannot readlink '%s'"), template);
+				die_errno(_("Could not readlink '%s'"), template);
 			if (sizeof(lnk) <=3D len)
 				die(_("insanely long symlink %s"), template);
 			lnk[len] =3D 0;
 			if (symlink(lnk, path))
-				die_errno(_("cannot symlink '%s' '%s'"), lnk, path);
+				die_errno(_("Could not symlink '%s' '%s'"), lnk, path);
 		}
 		else if (S_ISREG(st_template.st_mode)) {
 			if (copy_file(path, template, st_template.st_mode))
-				die_errno(_("cannot copy '%s' to '%s'"), template,
+				die_errno(_("Could not copy '%s' to '%s'"), template,
 					  path);
 		}
 		else
@@ -437,7 +437,7 @@ static int guess_repository_type(const char *git_di=
r)
 	if (!strcmp(".", git_dir))
 		return 1;
 	if (!getcwd(cwd, sizeof(cwd)))
-		die_errno(_("cannot tell cwd"));
+		die_errno(_("Could not tell cwd"));
 	if (!strcmp(git_dir, cwd))
 		return 1;
 	/*
@@ -518,18 +518,18 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 					errno =3D EEXIST;
 					/* fallthru */
 				case -1:
-					die_errno(_("cannot mkdir %s"), argv[0]);
+					die_errno(_("Could not mkdir %s"), argv[0]);
 					break;
 				default:
 					break;
 				}
 				shared_repository =3D saved;
 				if (mkdir(argv[0], 0777) < 0)
-					die_errno(_("cannot mkdir %s"), argv[0]);
+					die_errno(_("Could not mkdir %s"), argv[0]);
 				mkdir_tried =3D 1;
 				goto retry;
 			}
-			die_errno(_("cannot chdir to %s"), argv[0]);
+			die_errno(_("Could not chdir to %s"), argv[0]);
 		}
 	} else if (0 < argc) {
 		usage(init_db_usage[0]);
@@ -575,14 +575,14 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 		if (!git_work_tree_cfg) {
 			git_work_tree_cfg =3D xcalloc(PATH_MAX, 1);
 			if (!getcwd(git_work_tree_cfg, PATH_MAX))
-				die_errno (_("Cannot access current working directory"));
+				die_errno (_("Could not access current working directory"));
 		}
 		if (work_tree)
 			set_git_work_tree(real_path(work_tree));
 		else
 			set_git_work_tree(git_work_tree_cfg);
 		if (access(get_git_work_tree(), X_OK))
-			die_errno (_("Cannot access work tree '%s'"),
+			die_errno (_("Could not access work tree '%s'"),
 				   get_git_work_tree());
 	}
 	else {
--=20
1.7.2.5
