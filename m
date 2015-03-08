From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 19/24] update-index: manually enable or disable untracked cache
Date: Sun,  8 Mar 2015 17:12:42 +0700
Message-ID: <1425809567-25518-20-git-send-email-pclouds@gmail.com>
References: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 11:15:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUYEf-0004Cz-Nh
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 11:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbbCHKO5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Mar 2015 06:14:57 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36561 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbCHKO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 06:14:56 -0400
Received: by pdbnh10 with SMTP id nh10so63852854pdb.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2015 03:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IHoAwJCL85KQkSLGCJxliqtoOZAyzU2CdxJdwTtcFVA=;
        b=goo1i7YZDKAo9c5W+UyGTS7zy+TzkI1K2Agk9yXNlrhuIWXlBCjm3iEgvj1I3084e9
         7knYHTs1bDCXxFsphTASe+CF4j22U0uL2QniUuHGTHzwAhcGV9h8QcHIKJfmiADRqi9o
         I//WOzcpclrEvzkzy72TXIatZZ6AZCSjvDAS/fktWSvbmIZ+2JxdweEpnDC0d/sgiWXc
         sSKnv7Nu88jcz+SiO65Mk5NGBTblJzhiLQqqBM3HGT7CFBR+LYiVm4/lRZLp53Y9leLI
         OjkLtS0XsjqonEWl7kau7IwCJ3+TdRpUCAR6SGo9Zy95u5BuvQWs2dHprngSs4eK1e4l
         lUVA==
X-Received: by 10.68.68.209 with SMTP id y17mr41207228pbt.3.1425809696058;
        Sun, 08 Mar 2015 03:14:56 -0700 (PDT)
Received: from lanh ([115.73.247.162])
        by mx.google.com with ESMTPSA id bh15sm14446789pdb.21.2015.03.08.03.14.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Mar 2015 03:14:55 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 08 Mar 2015 17:14:51 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1425809567-25518-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265073>

Overall time saving on "git status" is about 40% in the best case
scenario, removing ..collect_untracked() as the most time consuming
function. read and refresh index operations are now at the top (which
should drop when index-helper and/or watchman support is added). More
numbers and analysis below.

webkit.git
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

169k files. 6k dirs. Lots of test data (i.e. not touched most of the
time)

Base status
-----------

Index version 4 in split index mode and cache-tree populated. No
untracked cache. It shows how time is consumed by "git status". The
same settings are used for other repos below.

18:28:10.199679 builtin/commit.c:1394   performance: 0.000000451 s: cmd=
_status:setup
18:28:10.474847 read-cache.c:1407       performance: 0.274873831 s: rea=
d_index
18:28:10.475295 read-cache.c:1407       performance: 0.000000656 s: rea=
d_index
18:28:10.728443 preload-index.c:131     performance: 0.253147487 s: rea=
d_index_preload
18:28:10.741422 read-cache.c:1254       performance: 0.012868340 s: ref=
resh_index
18:28:10.752300 wt-status.c:623         performance: 0.010421357 s: wt_=
status_collect_changes_worktree
18:28:10.762069 wt-status.c:629         performance: 0.009644748 s: wt_=
status_collect_changes_index
18:28:11.601019 wt-status.c:632         performance: 0.838859547 s: wt_=
status_collect_untracked
18:28:11.605939 builtin/commit.c:1421   performance: 0.004835004 s: cmd=
_status:update_index
18:28:11.606580 trace.c:415             performance: 1.407878388 s: git=
 command: 'git' 'status'

Populating status
-----------------

This is after enabling untracked cache and the cache is still empty.
We see a slight increase in .._collect_untracked() and update_index
(because new cache has to be written to $GIT_DIR/index).

18:28:18.915213 builtin/commit.c:1394   performance: 0.000000326 s: cmd=
_status:setup
18:28:19.197364 read-cache.c:1407       performance: 0.281901416 s: rea=
d_index
18:28:19.197754 read-cache.c:1407       performance: 0.000000546 s: rea=
d_index
18:28:19.451355 preload-index.c:131     performance: 0.253599607 s: rea=
d_index_preload
18:28:19.464400 read-cache.c:1254       performance: 0.012935336 s: ref=
resh_index
18:28:19.475115 wt-status.c:623         performance: 0.010236920 s: wt_=
status_collect_changes_worktree
18:28:19.486022 wt-status.c:629         performance: 0.010801685 s: wt_=
status_collect_changes_index
18:28:20.362660 wt-status.c:632         performance: 0.876551366 s: wt_=
status_collect_untracked
18:28:20.396199 builtin/commit.c:1421   performance: 0.033447969 s: cmd=
_status:update_index
18:28:20.396939 trace.c:415             performance: 1.482695902 s: git=
 command: 'git' 'status'

Populated status
----------------

After the cache is populated, wt_status_collect_untracked() drops 82%
from 0.838s to 0.144s. Overall time drops 45%. Top offenders are now
read_index() and read_index_preload().

18:28:20.408605 builtin/commit.c:1394   performance: 0.000000457 s: cmd=
_status:setup
18:28:20.692864 read-cache.c:1407       performance: 0.283980458 s: rea=
d_index
18:28:20.693273 read-cache.c:1407       performance: 0.000000661 s: rea=
d_index
18:28:20.958814 preload-index.c:131     performance: 0.265540254 s: rea=
d_index_preload
18:28:20.972375 read-cache.c:1254       performance: 0.013437429 s: ref=
resh_index
18:28:20.983959 wt-status.c:623         performance: 0.011146646 s: wt_=
status_collect_changes_worktree
18:28:20.993948 wt-status.c:629         performance: 0.009879094 s: wt_=
status_collect_changes_index
18:28:21.138125 wt-status.c:632         performance: 0.144084737 s: wt_=
status_collect_untracked
18:28:21.173678 builtin/commit.c:1421   performance: 0.035463949 s: cmd=
_status:update_index
18:28:21.174251 trace.c:415             performance: 0.766707355 s: git=
 command: 'git' 'status'

gentoo-x86.git
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This repository is a strange one with a balanced, wide and shallow
worktree (about 100k files and 23k dirs) and no .gitignore in
worktree. .._collect_untracked() time drops 88%, total time drops 56%.

Base status
-----------
18:20:40.828642 builtin/commit.c:1394   performance: 0.000000496 s: cmd=
_status:setup
18:20:41.027233 read-cache.c:1407       performance: 0.198130532 s: rea=
d_index
18:20:41.027670 read-cache.c:1407       performance: 0.000000581 s: rea=
d_index
18:20:41.171716 preload-index.c:131     performance: 0.144045594 s: rea=
d_index_preload
18:20:41.179171 read-cache.c:1254       performance: 0.007320424 s: ref=
resh_index
18:20:41.185785 wt-status.c:623         performance: 0.006144638 s: wt_=
status_collect_changes_worktree
18:20:41.192701 wt-status.c:629         performance: 0.006780184 s: wt_=
status_collect_changes_index
18:20:41.991723 wt-status.c:632         performance: 0.798927029 s: wt_=
status_collect_untracked
18:20:41.994664 builtin/commit.c:1421   performance: 0.002852772 s: cmd=
_status:update_index
18:20:41.995458 trace.c:415             performance: 1.168427502 s: git=
 command: 'git' 'status'
Populating status
-----------------
18:20:48.968848 builtin/commit.c:1394   performance: 0.000000380 s: cmd=
_status:setup
18:20:49.172918 read-cache.c:1407       performance: 0.203734214 s: rea=
d_index
18:20:49.173341 read-cache.c:1407       performance: 0.000000562 s: rea=
d_index
18:20:49.320013 preload-index.c:131     performance: 0.146671391 s: rea=
d_index_preload
18:20:49.328039 read-cache.c:1254       performance: 0.007921957 s: ref=
resh_index
18:20:49.334680 wt-status.c:623         performance: 0.006172020 s: wt_=
status_collect_changes_worktree
18:20:49.342526 wt-status.c:629         performance: 0.007731746 s: wt_=
status_collect_changes_index
18:20:50.257510 wt-status.c:632         performance: 0.914864222 s: wt_=
status_collect_untracked
18:20:50.338371 builtin/commit.c:1421   performance: 0.080776477 s: cmd=
_status:update_index
18:20:50.338900 trace.c:415             performance: 1.371462446 s: git=
 command: 'git' 'status'
Populated status
----------------
18:20:50.351160 builtin/commit.c:1394   performance: 0.000000571 s: cmd=
_status:setup
18:20:50.577358 read-cache.c:1407       performance: 0.225917338 s: rea=
d_index
18:20:50.577794 read-cache.c:1407       performance: 0.000000617 s: rea=
d_index
18:20:50.734140 preload-index.c:131     performance: 0.156345564 s: rea=
d_index_preload
18:20:50.745717 read-cache.c:1254       performance: 0.011463075 s: ref=
resh_index
18:20:50.755176 wt-status.c:623         performance: 0.008877929 s: wt_=
status_collect_changes_worktree
18:20:50.763768 wt-status.c:629         performance: 0.008471633 s: wt_=
status_collect_changes_index
18:20:50.854885 wt-status.c:632         performance: 0.090988721 s: wt_=
status_collect_untracked
18:20:50.857765 builtin/commit.c:1421   performance: 0.002789097 s: cmd=
_status:update_index
18:20:50.858411 trace.c:415             performance: 0.508647673 s: git=
 command: 'git' 'status'

linux-2.6
=3D=3D=3D=3D=3D=3D=3D=3D=3D

Reference repo. Not too big. .._collect_status() drops 84%. Total time
drops 42%.

Base status
-----------
18:34:09.870122 builtin/commit.c:1394   performance: 0.000000385 s: cmd=
_status:setup
18:34:09.943218 read-cache.c:1407       performance: 0.072871177 s: rea=
d_index
18:34:09.943614 read-cache.c:1407       performance: 0.000000491 s: rea=
d_index
18:34:10.004364 preload-index.c:131     performance: 0.060748102 s: rea=
d_index_preload
18:34:10.008190 read-cache.c:1254       performance: 0.003714285 s: ref=
resh_index
18:34:10.012087 wt-status.c:623         performance: 0.002775446 s: wt_=
status_collect_changes_worktree
18:34:10.016054 wt-status.c:629         performance: 0.003862140 s: wt_=
status_collect_changes_index
18:34:10.214747 wt-status.c:632         performance: 0.198604837 s: wt_=
status_collect_untracked
18:34:10.216102 builtin/commit.c:1421   performance: 0.001244166 s: cmd=
_status:update_index
18:34:10.216817 trace.c:415             performance: 0.347670735 s: git=
 command: 'git' 'status'
Populating status
-----------------
18:34:16.595102 builtin/commit.c:1394   performance: 0.000000456 s: cmd=
_status:setup
18:34:16.666600 read-cache.c:1407       performance: 0.070992413 s: rea=
d_index
18:34:16.667012 read-cache.c:1407       performance: 0.000000606 s: rea=
d_index
18:34:16.729375 preload-index.c:131     performance: 0.062362492 s: rea=
d_index_preload
18:34:16.732565 read-cache.c:1254       performance: 0.003075517 s: ref=
resh_index
18:34:16.736148 wt-status.c:623         performance: 0.002422201 s: wt_=
status_collect_changes_worktree
18:34:16.739990 wt-status.c:629         performance: 0.003746618 s: wt_=
status_collect_changes_index
18:34:16.948505 wt-status.c:632         performance: 0.208426710 s: wt_=
status_collect_untracked
18:34:16.961744 builtin/commit.c:1421   performance: 0.013151887 s: cmd=
_status:update_index
18:34:16.962233 trace.c:415             performance: 0.368537535 s: git=
 command: 'git' 'status'
Populated status
----------------
18:34:16.970026 builtin/commit.c:1394   performance: 0.000000631 s: cmd=
_status:setup
18:34:17.046235 read-cache.c:1407       performance: 0.075904673 s: rea=
d_index
18:34:17.046644 read-cache.c:1407       performance: 0.000000681 s: rea=
d_index
18:34:17.113564 preload-index.c:131     performance: 0.066920253 s: rea=
d_index_preload
18:34:17.117281 read-cache.c:1254       performance: 0.003604055 s: ref=
resh_index
18:34:17.121115 wt-status.c:623         performance: 0.002508345 s: wt_=
status_collect_changes_worktree
18:34:17.125089 wt-status.c:629         performance: 0.003871636 s: wt_=
status_collect_changes_index
18:34:17.156089 wt-status.c:632         performance: 0.030895703 s: wt_=
status_collect_untracked
18:34:17.169861 builtin/commit.c:1421   performance: 0.013686404 s: cmd=
_status:update_index
18:34:17.170391 trace.c:415             performance: 0.201474531 s: git=
 command: 'git' 'status'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-update-index.txt |  8 ++++++++
 builtin/update-index.c             | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-upd=
ate-index.txt
index dfc09d9..f9a35cd 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -172,6 +172,14 @@ may not support it yet.
 	the shared index file. This mode is designed for very large
 	indexes that take a signficant amount of time to read or write.
=20
+--untracked-cache::
+--no-untracked-cache::
+	Enable or disable untracked cache extension. This could speed
+	up for commands that involve determining untracked files such
+	as `git status`. The underlying operating system and file
+	system must change `st_mtime` field of a directory if files
+	are added or deleted in that directory.
+
 \--::
 	Do not interpret any more arguments as options.
=20
diff --git a/builtin/update-index.c b/builtin/update-index.c
index e8c7fd4..3d2dedd 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -740,6 +740,7 @@ static int reupdate_callback(struct parse_opt_ctx_t=
 *ctx,
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors =3D 0, line_termination =3D '\n';
+	int untracked_cache =3D -1;
 	int read_from_stdin =3D 0;
 	int prefix_length =3D prefix ? strlen(prefix) : 0;
 	int preferred_index_format =3D 0;
@@ -831,6 +832,8 @@ int cmd_update_index(int argc, const char **argv, c=
onst char *prefix)
 			N_("write index in this format")),
 		OPT_BOOL(0, "split-index", &split_index,
 			N_("enable or disable split index")),
+		OPT_BOOL(0, "untracked-cache", &untracked_cache,
+			N_("enable/disable untracked cache")),
 		OPT_END()
 	};
=20
@@ -937,6 +940,19 @@ int cmd_update_index(int argc, const char **argv, =
const char *prefix)
 		the_index.split_index =3D NULL;
 		the_index.cache_changed |=3D SOMETHING_CHANGED;
 	}
+	if (untracked_cache > 0 && !the_index.untracked) {
+		struct untracked_cache *uc;
+
+		uc =3D xcalloc(1, sizeof(*uc));
+		uc->exclude_per_dir =3D ".gitignore";
+		/* should be the same flags used by git-status */
+		uc->dir_flags =3D DIR_SHOW_OTHER_DIRECTORIES | DIR_HIDE_EMPTY_DIRECT=
ORIES;
+		the_index.untracked =3D uc;
+		the_index.cache_changed |=3D UNTRACKED_CHANGED;
+	} else if (!untracked_cache && the_index.untracked) {
+		the_index.untracked =3D NULL;
+		the_index.cache_changed |=3D UNTRACKED_CHANGED;
+	}
=20
 	if (active_cache_changed) {
 		if (newfd < 0) {
--=20
2.3.0.rc1.137.g477eb31
