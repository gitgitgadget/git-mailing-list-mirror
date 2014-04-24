From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 02/12] cherry-pick: add --skip-empty option
Date: Wed, 23 Apr 2014 21:44:41 -0500
Message-ID: <1398307491-21314-3-git-send-email-felipe.contreras@gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 24 04:55:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd9p7-0007UD-Ut
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 04:55:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbaDXCzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 22:55:31 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:51055 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbaDXCz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 22:55:26 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so2025213obc.14
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 19:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gxPrzjgDQpE52al2Q7XyeAd1nS0AuXB4QzlRZ08RN44=;
        b=h/8TrpgX5+gp6UcP7g/85O24s7Jt3R2PHCQIX1QmSJ8wv4+4LxIb4yDr9V3p0OGudM
         Uxk39bL4zFWSTXEkWQYLU/GOuLTE7xY/cq8OrVxlRjgbrXEz8+pcHBh6yH7aOid27C16
         N8KlqlZo35PRZET4k+JUZC3BTYk+quXzAHgrKc5snSsJJNkJjbBdx9Xa2dvUd51CA96E
         gl/25iOAHLxRKTD5E6Wp+VTi8KukdhnjQosSVIZ4my1kRK4EXgaomXlt0tDO/lJGuiyL
         4zrntblmL9bXk1gpgfCvvgBBCmsZpwRJVbTROrSsbm0dzKQgX64qukzz7fEx418pTqvI
         Eh3Q==
X-Received: by 10.60.95.230 with SMTP id dn6mr45743878oeb.25.1398308125488;
        Wed, 23 Apr 2014 19:55:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cn1sm11809822oeb.11.2014.04.23.19.55.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 19:55:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.2.gfbaae8c
In-Reply-To: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246919>

Pretty much what it says on the tin.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-cherry-pick.txt   |  3 +++
 builtin/revert.c                    |  2 ++
 sequencer.c                         |  6 ++++++
 sequencer.h                         |  1 +
 t/t3508-cherry-pick-many-commits.sh | 13 +++++++++++++
 5 files changed, 25 insertions(+)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c205d23..fccd936 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -129,6 +129,9 @@ effect to your index in a row.
 	redundant commits are ignored.  This option overrides that behavior and
 	creates an empty commit object.  Implies `--allow-empty`.
 
+--skip-empty::
+	Instead of failing, skip commits that are or become empty.
+
 --strategy=<strategy>::
 	Use the given merge strategy.  Should only be used once.
 	See the MERGE STRATEGIES section in linkgit:git-merge[1]
diff --git a/builtin/revert.c b/builtin/revert.c
index 87659c9..9946ecd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -95,6 +95,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
+		OPT_END(),
 	};
 
 	if (opts->action == REPLAY_PICK) {
@@ -104,6 +105,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
 			OPT_BOOL(0, "keep-redundant-commits", &opts->keep_redundant_commits, N_("keep redundant, empty commits")),
+			OPT_BOOL(0, "skip-empty", &opts->skip_empty, N_("skip empty commits")),
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
diff --git a/sequencer.c b/sequencer.c
index c94942a..951f51d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -634,6 +634,12 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		goto leave;
 	}
 
+	if (opts->skip_empty && is_index_unchanged() == 1) {
+		warning(_("skipping %s... %s"),
+			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
+			msg.subject);
+		goto leave;
+	}
 	allow = allow_empty(opts, commit);
 	if (allow < 0) {
 		res = allow;
diff --git a/sequencer.h b/sequencer.h
index 1fc22dc..3b04844 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -34,6 +34,7 @@ struct replay_opts {
 	int allow_empty;
 	int allow_empty_message;
 	int keep_redundant_commits;
+	int skip_empty;
 
 	int mainline;
 
diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 19c99d7..0cdf07e 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -187,4 +187,17 @@ test_expect_success 'cherry-pick --stdin works' '
 	check_head_differs_from fourth
 '
 
+test_expect_success 'cherry-pick skip empty' '
+	git clean -fxd &&
+	git checkout -b empty fourth &&
+	git commit --allow-empty -m empty &&
+	test_commit ontop &&
+	git checkout -f master &&
+	git reset --hard fourth &&
+	git cherry-pick --skip-empty fourth..empty &&
+	echo ontop > expected &&
+	git log --format=%s fourth..HEAD > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.9.2+fc1.2.gfbaae8c
