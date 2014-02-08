From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Sat,  8 Feb 2014 14:08:52 +0700
Message-ID: <1391843332-20583-2-git-send-email-pclouds@gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
 <1391843332-20583-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, jugg@hotmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 08 08:09:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WC22E-0000ym-5B
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 08:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbaBHHI7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Feb 2014 02:08:59 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:62123 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbaBHHI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 02:08:58 -0500
Received: by mail-pb0-f53.google.com with SMTP id md12so4150391pbc.26
        for <git@vger.kernel.org>; Fri, 07 Feb 2014 23:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2VijXvmuQJ9OtyTqUh0dB/mhrkXI3cXP8DAiyHnkDgM=;
        b=gttA23KfgO7zThRCWk8AfgarahohRXv/vGEBNLdyGTPPfcKBn3KmLrIuupaJsYN9EU
         zxdTeOm25jB5FfjAbO/n9H/VygD7o5sf3nZtmy5jxma6Dh4MjiCtO25NR7r2T7lPKBye
         Kjrux8iu3WzMwmoP5kvwBXgWvUtP9Bc0mZ7KqqhtW9AIhK7tew5jM65tY4nr/4PfK8rF
         qyszdVADBs8WU2gfr+tru0v0DtOgm/3RHEShfUs42/6RH7L1t60F176AlMv2hxSjOlBy
         W9B9tFcvOnN8ggooLTxKyYDQK5OzcX5t/Jx1TmrgGdUjtWV+TZnJ4hzicDZYvkYE/M/k
         2WAg==
X-Received: by 10.66.27.201 with SMTP id v9mr12876666pag.136.1391843338115;
        Fri, 07 Feb 2014 23:08:58 -0800 (PST)
Received: from lanh ([115.73.239.36])
        by mx.google.com with ESMTPSA id ns7sm20461642pbc.32.2014.02.07.23.08.54
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 23:08:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 08 Feb 2014 14:09:00 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391843332-20583-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241821>

`gc --auto` takes time and can block the user temporarily (but not any
less annoyingly). Make it run in background on systems that support
it. The only thing lost with running in background is printouts. But
gc output is not really interesting. You can keep it in foreground by
changing gc.autodetach.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  4 ++++
 builtin/gc.c             | 23 ++++++++++++++++++-----
 t/t5400-send-pack.sh     |  1 +
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f4d793..4781773 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1167,6 +1167,10 @@ gc.autopacklimit::
 	--auto` consolidates them into one larger pack.  The
 	default	value is 50.  Setting this to 0 disables it.
=20
+gc.autodetach::
+	Make `git gc --auto` return immediately andrun in background
+	if the system supports it. Default is true.
+
 gc.packrefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
diff --git a/builtin/gc.c b/builtin/gc.c
index c19545d..ed5cc3c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -29,6 +29,7 @@ static int pack_refs =3D 1;
 static int aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
+static int detach_auto =3D 1;
 static const char *prune_expire =3D "2.weeks.ago";
=20
 static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
@@ -73,6 +74,10 @@ static int gc_config(const char *var, const char *va=
lue, void *cb)
 		gc_auto_pack_limit =3D git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.autodetach")) {
+		detach_auto =3D git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "gc.pruneexpire")) {
 		if (value && strcmp(value, "now")) {
 			unsigned long now =3D approxidate("now");
@@ -301,11 +306,19 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
-		if (!quiet)
-			fprintf(stderr,
-					_("Auto packing the repository for optimum performance. You may a=
lso\n"
-					"run \"git gc\" manually. See "
-					"\"git help gc\" for more information.\n"));
+		if (!quiet) {
+			if (detach_auto)
+				fprintf(stderr, _("Auto packing the repository in background for o=
ptimum performance.\n"));
+			else
+				fprintf(stderr, _("Auto packing the repository for optimum perform=
ance.\n"));
+			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n")=
);
+		}
+		if (detach_auto)
+			/*
+			 * failure to daemonize is ok, we'll continue
+			 * in foreground
+			 */
+			daemonize();
 	} else
 		add_repack_all_option();
=20
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 129fc88..0736bcb 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -164,6 +164,7 @@ test_expect_success 'receive-pack runs auto-gc in r=
emote repo' '
 	    # Set the child to auto-pack if more than one pack exists
 	    cd child &&
 	    git config gc.autopacklimit 1 &&
+	    git config gc.autodetach false &&
 	    git branch test_auto_gc &&
 	    # And create a file that follows the temporary object naming
 	    # convention for the auto-gc to remove
--=20
1.8.5.2.240.g8478abd
