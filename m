From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Sun, 16 Mar 2014 20:35:04 +0700
Message-ID: <1394976904-15395-6-git-send-email-pclouds@gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 16 14:35:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPBDP-0006Ag-U4
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 14:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbaCPNey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Mar 2014 09:34:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45221 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbaCPNex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 09:34:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so4553096pbb.5
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oJUZDHTzwWLsGLLngTzpeVJCNhQ4QKKUpa57SwRW2yU=;
        b=btSYpd32f8/lx2RCZyJgaJRRVanyIrwRpvq7E63GRaSNJ8q8KMc6ro6nniAM/oM69r
         EoFxPhXnQbpDkLElVl0XweiErYahZwlrd/N7DoqoUEC0ErwIdzhwC2GRk1Nb2PdbovrK
         aeZ9C64NVClAM2ddTSDI5A3PaHHkP1S0QjiMOSr/v9xAzdQ/8WORlbeHa95K8N35Vu9v
         d+5pSMx9OdgaKe5aWpQsfaiJhay+r6DoZqi3KGw3l3mjWZC9eypOV8fRyAA5SsXA1Wv8
         yYyaRaQcpyyUBSGAFsCFRYBYiH1HMjJDo9u7oyP4WbICNSrTluYMLeCqe1q6C9xTIM/k
         WbfQ==
X-Received: by 10.66.150.69 with SMTP id ug5mr20389649pab.55.1394976892946;
        Sun, 16 Mar 2014 06:34:52 -0700 (PDT)
Received: from lanh ([115.73.203.48])
        by mx.google.com with ESMTPSA id zb2sm34428186pbc.30.2014.03.16.06.34.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Mar 2014 06:34:52 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 16 Mar 2014 20:35:34 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244199>

As explained in the previous commit, current aggressive settings
--depth=3D250 --window=3D250 could slow down repository access
significantly. Notice that people usually work on recent history only,
we could keep recent history more loosely packed, so that repo access
is fast most of the time while the pack file remains small.

Three more configuration variables are used to make that happen. The
first one, gc.aggressiveCommitLimits covers the old history part,
which will be tightly packed. The remaining part will be packed with
gc.lessAggresiveWindow and gc.lessAggressiveDepth. If
gc.aggressiveCommitLimits is empty, everything will be tightly packed
as before.

The repack process becomes:

 - repack -adf on old history (e.g. the default --before=3D1.year.ago)
   mark to keep that pack

 - repack the second time with lessAggressive settings, the kept pack
   should be left untouched.

 - remove .keep file and repack the final time, reusing all deltas

This process costs more time, but produce a more effecient pack. It is
assumed that people who do "gc --aggressive" do not do this often and
do not mind if it takes a bit longer.

git.git is not a great repo to test it because its size is modest but
so are my laptop's cpu and memory, so here are the timings and pack
sizes

            size  time
old aggr.   36MB  5m51
new aggr.   37MB  6m13
repack -adf 48MB  1m12

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  19 +++++++++
 builtin/gc.c             | 109 +++++++++++++++++++++++++++++++++++++++=
++++++--
 2 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5ce7f9a..47979dc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1161,6 +1161,25 @@ gc.aggressiveWindow::
 	algorithm used by 'git gc --aggressive'.  This defaults
 	to 250.
=20
+gc.aggressiveCommitLimits::
+	This one parameter to linkgit:git-rev-list[1] to select
+	commits that are repacked with gc.aggressiveDepth and
+	gc.aggressiveWindow, while the remaining commits are repacked
+	with gc.lessAggressiveDepth and gc.lessAggressiveWindow.
++
+If this is an empty string, everything will be repacked with
+gc.aggressiveWindow and gc.aggressiveDepth.
+
+gc.lessAggressiveDepth::
+	The depth parameter used in the delta compression
+	algorithm used by 'git gc --aggressive' when
+	gc.aggressiveCommitLimits is set.  This defaults to 50.
+
+gc.lessAggressiveWindow::
+	The window size parameter used in the delta compression
+	algorithm used by 'git gc --aggressive' when
+	gc.aggressiveCommitLimits is set.  This defaults to 250.
+
 gc.auto::
 	When there are approximately more than this many loose
 	objects in the repository, `git gc --auto` will pack them.
diff --git a/builtin/gc.c b/builtin/gc.c
index 72aa912..37fc603 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -28,10 +28,14 @@ static const char * const builtin_gc_usage[] =3D {
 static int pack_refs =3D 1;
 static int aggressive_depth =3D 250;
 static int aggressive_window =3D 250;
+static const char *aggressive_rev_list =3D "--before=3D1.year.ago";
+static int less_aggressive_depth =3D 50;
+static int less_aggressive_window =3D 250;
 static int gc_auto_threshold =3D 6700;
 static int gc_auto_pack_limit =3D 50;
 static int detach_auto =3D 1;
 static const char *prune_expire =3D "2.weeks.ago";
+static int delta_base_offset =3D 1;
=20
 static struct argv_array pack_refs_cmd =3D ARGV_ARRAY_INIT;
 static struct argv_array reflog =3D ARGV_ARRAY_INIT;
@@ -39,10 +43,13 @@ static struct argv_array repack =3D ARGV_ARRAY_INIT=
;
 static struct argv_array prune =3D ARGV_ARRAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
+static char *keep_file;
 static char *pidfile;
=20
 static void remove_pidfile(void)
 {
+	if (keep_file)
+		unlink_or_warn(keep_file);
 	if (pidfile)
 		unlink(pidfile);
 }
@@ -54,6 +61,63 @@ static void remove_pidfile_on_signal(int signo)
 	raise(signo);
 }
=20
+static void pack_old_history(int quiet)
+{
+	struct child_process pack_objects;
+	struct child_process rev_list;
+	struct argv_array av_po =3D ARGV_ARRAY_INIT;
+	struct argv_array av_rl =3D ARGV_ARRAY_INIT;
+	char sha1[41];
+
+	argv_array_pushl(&av_rl, "rev-list", "--all", "--objects",
+			 "--reflog", NULL);
+	argv_array_push(&av_rl, aggressive_rev_list);
+
+	memset(&rev_list, 0, sizeof(rev_list));
+	rev_list.no_stdin =3D 1;
+	rev_list.out =3D -1;
+	rev_list.git_cmd =3D 1;
+	rev_list.argv =3D av_rl.argv;
+
+	if (start_command(&rev_list))
+		die(_("gc: unable to fork git-rev-list"));
+
+	argv_array_pushl(&av_po, "pack-objects", "--keep-true-parents",
+			 "--honor-pack-keep", "--non-empty", "--no-reuse-delta",
+			 "--keep", "--local", NULL);
+	if (delta_base_offset)
+		argv_array_push(&av_po,  "--delta-base-offset");
+	if (quiet)
+		argv_array_push(&av_po, "-q");
+	if (aggressive_window)
+		argv_array_pushf(&av_po, "--window=3D%d", aggressive_window);
+	if (aggressive_depth)
+		argv_array_pushf(&av_po, "--depth=3D%d", aggressive_depth);
+	argv_array_push(&av_po, git_path("objects/pack/pack"));
+
+	memset(&pack_objects, 0, sizeof(pack_objects));
+	pack_objects.in =3D rev_list.out;
+	pack_objects.out =3D -1;
+	pack_objects.git_cmd =3D 1;
+	pack_objects.argv =3D av_po.argv;
+
+	if (start_command(&pack_objects))
+		die(_("gc: unable to fork git-pack-objects"));
+
+	if (read_in_full(pack_objects.out, sha1, 41) !=3D 41 ||
+	    sha1[40] !=3D '\n')
+		die_errno(_("gc: pack-objects did not return the new pack's SHA-1"))=
;
+	sha1[40] =3D '\0';
+	keep_file =3D git_pathdup("objects/pack/pack-%s.keep", sha1);
+	close(pack_objects.out);
+
+	if (finish_command(&rev_list))
+		die(_("gc: git-rev-list died with error"));
+
+	if (finish_command(&pack_objects))
+		die(_("gc: git-pack-objects died with error"));
+}
+
 static int gc_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.packrefs")) {
@@ -71,6 +135,22 @@ static int gc_config(const char *var, const char *v=
alue, void *cb)
 		aggressive_depth =3D git_config_int(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "gc.aggressivecommitlimits")) {
+		aggressive_rev_list =3D value && *value ? xstrdup(value) : NULL;
+		return 0;
+	}
+	if (!strcmp(var, "gc.lessaggressivewindow")) {
+		less_aggressive_window =3D git_config_int(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "gc.lessaggressivedepth")) {
+		less_aggressive_depth =3D git_config_int(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "repack.usedeltabaseoffset")) {
+		delta_base_offset =3D git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "gc.auto")) {
 		gc_auto_threshold =3D git_config_int(var, value);
 		return 0;
@@ -298,11 +378,19 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
=20
 	if (aggressive) {
+		int depth, window;
+		if (aggressive_rev_list) {
+			depth =3D less_aggressive_depth;
+			window =3D less_aggressive_window;
+		} else {
+			depth =3D aggressive_depth;
+			window =3D aggressive_window;
+		}
 		argv_array_push(&repack, "-f");
-		if (aggressive_depth > 0)
-			argv_array_pushf(&repack, "--depth=3D%d", aggressive_depth);
-		if (aggressive_window > 0)
-			argv_array_pushf(&repack, "--window=3D%d", aggressive_window);
+		if (depth > 0)
+			argv_array_pushf(&repack, "--depth=3D%d", depth);
+		if (window > 0)
+			argv_array_pushf(&repack, "--window=3D%d", window);
 	}
 	if (quiet)
 		argv_array_push(&repack, "-q");
@@ -343,9 +431,22 @@ int cmd_gc(int argc, const char **argv, const char=
 *prefix)
 	if (run_command_v_opt(reflog.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, reflog.argv[0]);
=20
+	if (aggressive && aggressive_rev_list)
+		pack_old_history(quiet);
+
 	if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
 		return error(FAILED_RUN, repack.argv[0]);
=20
+	if (aggressive && aggressive_rev_list) {
+		if (keep_file)
+			unlink_or_warn(keep_file);
+		argv_array_clear(&repack);
+		argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
+		add_repack_all_option();
+		if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, repack.argv[0]);
+	}
+
 	if (prune_expire) {
 		argv_array_push(&prune, prune_expire);
 		if (quiet)
--=20
1.9.0.40.gaa8c3ea
