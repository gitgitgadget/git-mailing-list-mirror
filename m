From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 33/44] builtin/am: use apply api in run_apply()
Date: Fri, 10 Jun 2016 22:11:07 +0200
Message-ID: <20160610201118.13813-34-chriscool@tuxfamily.org>
References: <20160610201118.13813-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 22:13:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBSo2-0004Ew-2m
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 22:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbcFJUNT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 16:13:19 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34543 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbcFJUMh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 16:12:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id n184so1057784wmn.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vngwak61GGuVA9tp4dARbad793nyLaEKwsnSlbdDwWQ=;
        b=CMIMz4MhoDoQvgUtwq+0aSr4aJadL4fYi9QhYO3Ir5BxGlB0mW9QZG3TMSXwRemvxv
         9Xx/gGH9XvoUoqym7j0XC3eRFi0il54X2A6KC68Vw4J+TTI5j+szCs4YInTecYgk9bhV
         efBqCjgyQc/2sYVPwsGCkTYedtNJvXMkLtfVk/LMOszc00QXTPaJy4tIyko+IFdPP84K
         GegZJYawudiruGrE4s8//P4q0eQo/Ssg3jyySsgx08kArmQSOoIrnwf4Nzd+WZGHi29U
         zxBv04TgQ88siFrELrfLQhqt1VZYNyWkMdL5kbBCk3gmwKRbVuASICB8IsfTtsUbIgIw
         47pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vngwak61GGuVA9tp4dARbad793nyLaEKwsnSlbdDwWQ=;
        b=gSDx5TH2gd3SGVe9NcKSVXZUzV3tyhhcX35xlRneeBhchhoAvMCAWLVp9qL6H1QjiW
         xB+eFuA6smnovHsPq3ZJfq30K35zBjFfOhiDNmbydbhWcahlbkur0G+T4wDchwVka4eS
         YaHgZa1co9Es+936z4H0AF9FisyK+vP6uZnlB76dKpG+MswDJLjfrwkeohfLPjl7r0G9
         Q2vGoNK2cVLU69L1sXlur3vZfivZD5I+laCivH4ZxEuigE+SY/jAt4fdeRkStDTHK2VU
         E7rWDODvomBl1AbuTHPzy1Z0/FQKVp4+lyHJKv04uB27hbHUMsa8eJZ1V2VjKQVID6wp
         TiSw==
X-Gm-Message-State: ALyK8tKIOd7yDNurcj8RNHsF84Cit8hghihIuyBchahJWtElVVkqAQw2ruZ2TBs7XWSQoA==
X-Received: by 10.194.242.230 with SMTP id wt6mr4036493wjc.143.1465589556070;
        Fri, 10 Jun 2016 13:12:36 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o129sm689125wmb.17.2016.06.10.13.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2016 13:12:35 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.362.g3cd93d0
In-Reply-To: <20160610201118.13813-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297055>

This replaces run_apply() implementation with a new one that
uses the apply api that has been previously prepared in
apply.c and apply.h.

This shoud improve performance a lot in certain cases.

As the previous implementation was creating a new `git apply`
process to apply each patch, it could be slow on systems like
Windows where it is costly to create new processes.

Also the new `git apply` process had to read the index from
disk, and when the process was done the calling process
discarded its own index and read back from disk the new
index that had been created by the `git apply` process.

This could be very inefficient with big repositories that
have big index files, especially when the system decided
that it was a good idea to run the `git apply` processes on
a different processor core.

Also eliminating index reads enables further performance
improvements by using:

`git update-index --split-index`

=46or example here is a benchmark of a multi hundred commit
rebase on the Linux kernel on a Debian laptop with SSD:

command: git rebase --onto 1993b17 52bef0c 29dde7c

Vanilla "next" without split index:                1m54.953s
Vanilla "next" with split index:                   1m22.476s
This series on top of "next" without split index:  1m12.034s
This series on top of "next" with split index:     0m15.678s

(using branch "next" from mid April 2016.)

Benchmarked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/am.c | 104 ++++++++++++++++++++++++++++++++++++++++++++++++---=
--------
 1 file changed, 86 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..a16b06c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -28,6 +28,7 @@
 #include "rerere.h"
 #include "prompt.h"
 #include "mailinfo.h"
+#include "apply.h"
=20
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -1521,39 +1522,106 @@ static int parse_mail_rebase(struct am_state *=
state, const char *mail)
  */
 static int run_apply(const struct am_state *state, const char *index_f=
ile)
 {
-	struct child_process cp =3D CHILD_PROCESS_INIT;
-
-	cp.git_cmd =3D 1;
-
-	if (index_file)
-		argv_array_pushf(&cp.env_array, "GIT_INDEX_FILE=3D%s", index_file);
+	struct argv_array apply_paths =3D ARGV_ARRAY_INIT;
+	struct argv_array apply_opts =3D ARGV_ARRAY_INIT;
+	struct apply_state apply_state;
+	int save_stdout_fd, save_stderr_fd;
+	int res, opts_left;
+	char *save_index_file;
+	static struct lock_file lock_file;
+
+	struct option am_apply_options[] =3D {
+		{ OPTION_CALLBACK, 0, "whitespace", &apply_state, N_("action"),
+			N_("detect new or modified lines that have whitespace errors"),
+			0, apply_option_parse_whitespace },
+		{ OPTION_CALLBACK, 0, "ignore-space-change", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "ignore-whitespace", &apply_state, NULL,
+			N_("ignore changes in whitespace when finding context"),
+			PARSE_OPT_NOARG, apply_option_parse_space_change },
+		{ OPTION_CALLBACK, 0, "directory", &apply_state, N_("root"),
+			N_("prepend <root> to all filenames"),
+			0, apply_option_parse_directory },
+		{ OPTION_CALLBACK, 0, "exclude", &apply_state, N_("path"),
+			N_("don't apply changes matching the given path"),
+			0, apply_option_parse_exclude },
+		{ OPTION_CALLBACK, 0, "include", &apply_state, N_("path"),
+			N_("apply changes matching the given path"),
+			0, apply_option_parse_include },
+		OPT_INTEGER('C', NULL, &apply_state.p_context,
+				N_("ensure at least <n> lines of context match")),
+		{ OPTION_CALLBACK, 'p', NULL, &apply_state, N_("num"),
+			N_("remove <num> leading slashes from traditional diff paths"),
+			0, apply_option_parse_p },
+		OPT_BOOL(0, "reject", &apply_state.apply_with_reject,
+			N_("leave the rejected hunks in corresponding *.rej files")),
+		OPT_END()
+	};
=20
 	/*
 	 * If we are allowed to fall back on 3-way merge, don't give false
 	 * errors during the initial attempt.
 	 */
+
 	if (state->threeway && !index_file) {
-		cp.no_stdout =3D 1;
-		cp.no_stderr =3D 1;
+		save_stdout_fd =3D dup(1);
+		dup_devnull(1);
+		save_stderr_fd =3D dup(2);
+		dup_devnull(2);
 	}
=20
-	argv_array_push(&cp.args, "apply");
+	if (index_file) {
+		save_index_file =3D get_index_file();
+		set_index_file((char *)index_file);
+	}
=20
-	argv_array_pushv(&cp.args, state->git_apply_opts.argv);
+	if (init_apply_state(&apply_state, NULL, &lock_file))
+		die("init_apply_state() failed");
+
+	argv_array_push(&apply_opts, "apply");
+	argv_array_pushv(&apply_opts, state->git_apply_opts.argv);
+
+	opts_left =3D parse_options(apply_opts.argc, apply_opts.argv,
+				  NULL, am_apply_options, NULL, 0);
+
+	if (opts_left !=3D 0)
+		die("unknown option passed thru to git apply");
=20
 	if (index_file)
-		argv_array_push(&cp.args, "--cached");
+		apply_state.cached =3D 1;
 	else
-		argv_array_push(&cp.args, "--index");
+		apply_state.check_index =3D 1;
=20
-	argv_array_push(&cp.args, am_path(state, "patch"));
+	if (check_apply_state(&apply_state, 0))
+		die("check_apply_state() failed");
=20
-	if (run_command(&cp))
-		return -1;
+	argv_array_push(&apply_paths, am_path(state, "patch"));
=20
-	/* Reload index as git-apply will have modified it. */
-	discard_cache();
-	read_cache_from(index_file ? index_file : get_index_file());
+	res =3D apply_all_patches(&apply_state, apply_paths.argc, apply_paths=
=2Eargv, 0);
+
+	/* Restore stdout and stderr */
+	if (state->threeway && !index_file) {
+		dup2(save_stdout_fd, 1);
+		close(save_stdout_fd);
+		dup2(save_stderr_fd, 2);
+		close(save_stderr_fd);
+	}
+
+	if (index_file)
+		set_index_file(save_index_file);
+
+	argv_array_clear(&apply_paths);
+	argv_array_clear(&apply_opts);
+
+	if (res)
+		return res;
+
+	if (index_file) {
+		/* Reload index as apply_all_patches() will have modified it. */
+		discard_cache();
+		read_cache_from(index_file);
+	}
=20
 	return 0;
 }
--=20
2.9.0.rc2.362.g3cd93d0
