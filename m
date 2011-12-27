From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] gc --auto: warn garbage collection happens soon
Date: Tue, 27 Dec 2011 20:45:34 +0700
Message-ID: <1324993534-16307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 27 14:42:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfXIL-00042m-Ke
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 14:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937Ab1L0NmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Dec 2011 08:42:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46678 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab1L0NmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 08:42:15 -0500
Received: by iaeh11 with SMTP id h11so20418707iae.19
        for <git@vger.kernel.org>; Tue, 27 Dec 2011 05:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=657kOmm8p1T1xYpyK3fX8mSayY8qgdSbsfP94btw+Gw=;
        b=MxV0b2S/KlBfI9MabYuDaJXTOjAdTSukM5Oa/f/F4Yf5UfmO6JBtH+DUHnBc7iv2ks
         ORJIap8V2FO3+A+Ye7srKxA3bonv7M5kFbLFJpejDu5cge8omvW2mHCWp70WQ0IYiGlK
         YcsVSRydxrZb/4zwXRY2RCA2Af8Ulf8cRCPqM=
Received: by 10.50.214.38 with SMTP id nx6mr2856699igc.19.1324993335203;
        Tue, 27 Dec 2011 05:42:15 -0800 (PST)
Received: from tre ([115.74.41.172])
        by mx.google.com with ESMTPS id xu6sm491435igb.7.2011.12.27.05.42.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Dec 2011 05:42:13 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 27 Dec 2011 20:45:35 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187711>

This gives users a chance to run gc explicitly elsewhere if they do not
want gc to run suddenly in current terminal.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 v2 of a patch posted a few months ago. The warning limits are in
 percentage and configurable. I could have set the default limits to
 100% (i.e. no warnings) to keep current behavior. However I think
 warning is better.

 May need rewording inn config.txt, I'm not sure I state it clearly.

 Documentation/config.txt |   12 ++++++++++++
 Documentation/git-gc.txt |    4 ++++
 builtin/gc.c             |   41 ++++++++++++++++++++++++++++++++++++++=
+--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5a841da..c263496 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -965,12 +965,24 @@ gc.auto::
 	light-weight garbage collection from time to time.  The
 	default value is 6700.  Setting this to 0 disables it.
=20
+gc.autowarn::
+	The percentage of loose objects specified in `gc.auto`. If the
+	number of loose objects exceeds this limit, `git gc --auto`
+	will warn users garbage collection will happen soon. Default
+	value is 90. Setting this to 100 disables it.
+
 gc.autopacklimit::
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
 	--auto` consolidates them into one larger pack.  The
 	default	value is 50.  Setting this to 0 disables it.
=20
+gc.autopackwarn::
+	The percentage of packs specified in `gc.autopacklimit`. If
+	the number of packs exceeds this limit, `git gc --auto` will
+	warn users garbage collection will happen soon. Default value
+	is 90. Setting this to 100 disables it.
+
 gc.packrefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 815afcb..937b3d6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -59,6 +59,10 @@ then existing packs (except those marked with a `.ke=
ep` file)
 are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autopacklimit` to 0 disables
 automatic consolidation of packs.
++
+`git gc --auto` will warn users when the number of loose objects or
+packs is close to the limits. See `gc.autowarn` and `gc.autopackwarn`
+for details.
=20
 --prune=3D<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
diff --git a/builtin/gc.c b/builtin/gc.c
index 0498094..f3fa46d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,6 +28,10 @@ static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static const char *prune_expire =3D "2.weeks.ago";
=20
+/* numbers are in percent, to be converted to absolute later */
+static int gc_warn_auto_threshold =3D 90;
+static int gc_warn_auto_pack_limit =3D 90;
+
 #define MAX_ADD 10
 static const char *argv_pack_refs[] =3D {"pack-refs", "--all", "--prun=
e", NULL};
 static const char *argv_reflog[] =3D {"reflog", "expire", "--all", NUL=
L};
@@ -52,10 +56,26 @@ static int gc_config(const char *var, const char *v=
alue, void *cb)
 		gc_auto_threshold =3D git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.autowarn")) {
+		int percent =3D percent =3D git_config_int(var, value);
+		if (percent <=3D 0 || percent > 100)
+			die(_("gc.autowarn %d%% does not make sense"),
+			    percent);
+		gc_warn_auto_threshold =3D percent;
+		return 0;
+	}
 	if (!strcmp(var, "gc.autopacklimit")) {
 		gc_auto_pack_limit =3D git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.autopackwarn")) {
+		int percent =3D percent =3D git_config_int(var, value);
+		if (percent <=3D 0 || percent > 100)
+			die(_("gc.autopackwarn %d%% does not make sense"),
+			    percent);
+		gc_warn_auto_pack_limit =3D percent;
+		return 0;
+	}
 	if (!strcmp(var, "gc.pruneexpire")) {
 		if (value && strcmp(value, "now")) {
 			unsigned long now =3D approxidate("now");
@@ -118,7 +138,15 @@ static int too_many_loose_objects(void)
 		}
 	}
 	closedir(dir);
-	return needed;
+	if (needed)
+		return 1;
+
+	auto_threshold =3D (gc_warn_auto_threshold + 255) / 256;
+	if (num_loose >=3D auto_threshold)
+		warning(_("Too many loose objects (current approx. %d, limit %d).\n"
+			  "\"git gc\" will soon run automatically"),
+			num_loose * 256, gc_auto_threshold);
+	return 0;
 }
=20
 static int too_many_packs(void)
@@ -141,7 +169,14 @@ static int too_many_packs(void)
 		 */
 		cnt++;
 	}
-	return gc_auto_pack_limit <=3D cnt;
+	if (gc_auto_pack_limit <=3D cnt)
+		return 1;
+
+	if (gc_warn_auto_pack_limit <=3D cnt)
+		warning(_("Too many packs (current %d, limit %d)\n"
+			  "\"git gc\" will soon run automatically."),
+			cnt, gc_auto_pack_limit);
+	return 0;
 }
=20
 static int need_to_gc(void)
@@ -193,6 +228,8 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
=20
 	git_config(gc_config, NULL);
+	gc_warn_auto_threshold =3D 0.01 * gc_auto_threshold * gc_warn_auto_th=
reshold;
+	gc_warn_auto_pack_limit =3D 0.01 * gc_auto_pack_limit * gc_auto_pack_=
limit;
=20
 	if (pack_refs < 0)
 		pack_refs =3D !is_bare_repository();
--=20
1.7.8.36.g69ee2
