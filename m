From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 84/94] builtin/am: use apply api in run_apply()
Date: Wed, 11 May 2016 15:17:35 +0200
Message-ID: <20160511131745.2914-85-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:21:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U4w-0004oo-NB
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbcEKNV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 May 2016 09:21:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36051 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932357AbcEKNVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:21:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id w143so9357272wmw.3
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNVqUjetaZtFlrSQ5ab4ITtWA1PyU0nXeILrFsEEQqg=;
        b=jkBggIThmeRdyNqhFjHtMi9AmF2ztM7Adqins9JHZcWvgprCkLn+3Ap5chdRvKKbky
         VRib8+2WR9adknjy935ZFKTpHsYTwdnU17B7aNO0U0jgeo6mvjW45UjSISZFNdCtJVnh
         xzHzSsEVxhV6OGFM/Z7cZ4XqKFcjZ0uooHz0h1MpnNcKAq6d+91+qz8uyTy33XmaZNZy
         1cXZ9wkMCAUxyRn9HEJtYLgAJYdPro8b+8WZKdKJARKsBDXI9uXaQUVEqe6swT70olJh
         S4G2nzn1e066+v8AegbHcgQqUSMVt55FrQIk2iR9Nfn3+SlU01eTZyCEvMwyl5oxrHa/
         CGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNVqUjetaZtFlrSQ5ab4ITtWA1PyU0nXeILrFsEEQqg=;
        b=Zd0790aqaW8N+q9Z7CFRaBxBrYGrYl3YbJ4xRFoGmMAq679yGajZg02XnIRPw/T5eD
         C9bJM5jgx4pGYWdIZCthjMCi9rSV895MPFg0f+TD/P4vGkJ00VyrnQ/3nNoF0n9XDsMz
         cHhMhl9lgk4OUd5w1AaqfB7cAN+zqjbliA1xcNywwKxA4Y7RKwR0FzUVaCLfSmwD9CpM
         RmAJIsvnNva8iEBE0iefI1vg9wrZoEZmOXtUQofHluxU9eFz6UMsSETmmoAXVQWJEy20
         w6krf5Xo1EokR1AdR5KS8rzcQzHoWlDjIW1FHaOA+3/PheBqNrQAM674gHE7XaujZ2Lu
         L6hg==
X-Gm-Message-State: AOPr4FVp8ljqAuwdDexOzBVIQyxq912uIEMiHVVEKv0v/63qZE2cSvZmDlUxsz5aWq+WDw==
X-Received: by 10.194.77.42 with SMTP id p10mr3734653wjw.111.1462972880770;
        Wed, 11 May 2016 06:21:20 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.21.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:21:19 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294297>

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
index d003939..cc66a48 100644
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
@@ -1522,39 +1523,106 @@ static int parse_mail_rebase(struct am_state *=
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
2.8.2.490.g3dabe57
