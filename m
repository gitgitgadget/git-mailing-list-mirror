From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [RFC 2/2] Don't push a repository with unpushed submodules
Date: Sun, 26 Jun 2011 20:29:47 +0200
Message-ID: <1309112987-3185-3-git-send-email-iveqy@iveqy.com>
References: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
Cc: gitster@pobox.com, iveqy@iveqy.com, hvoigt@hvoigt.net,
	jens.lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 26 20:32:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qau84-0000xI-5A
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 20:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1FZSbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 14:31:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52731 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660Ab1FZS3g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 14:29:36 -0400
Received: by bwd5 with SMTP id 5so775667bwd.19
        for <git@vger.kernel.org>; Sun, 26 Jun 2011 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:from:to:cc:subject:date:message-id
         :x-mailer:in-reply-to:references;
        bh=zzvzCxHCJqk7X7YL8ieD/ySkMBALDWvHrOYXW/Y3abo=;
        b=mvEXaznweeHuMZAJvCNSgNc5/BuConSPbSLsFx3OfuVgHWgyHbsgQCzi+uYffmnUsz
         casCUwqBMbs86JbqUoPwOND6kutPcg3+umWX1+HXsBk34cpMJ4fBPifh2z4gj1//ro7+
         lSPRKXC8dy6BUxDWUS2R3HYzEa8NFc+gq7ppU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=Ux/1TH6EXthhB+wJiqWSImU+do7D2WmzD9EWcU6fxLFQE7OjfLau5MsLa9uJpB0ASG
         QsXDQYLrDapFY75WgLNL3YyDYpGY2tzvIdUB/xrBNrzGVXnXbsHRFqp39GeCmzdyPepL
         IgDYIif7tPMfwYLF9m4B1+j23kJ7sEV39hPzY=
Received: by 10.204.2.141 with SMTP id 13mr3501134bkj.20.1309112974979;
        Sun, 26 Jun 2011 11:29:34 -0700 (PDT)
Received: from kolya (h-185-240.A189.priv.bahnhof.se [85.24.185.240])
        by mx.google.com with ESMTPS id n3sm3478214bka.4.2011.06.26.11.29.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Jun 2011 11:29:34 -0700 (PDT)
Received: from iveqy by kolya with local (Exim 4.72)
	(envelope-from <iveqy@kolya>)
	id 1Qau5h-0000q8-Kb; Sun, 26 Jun 2011 20:29:53 +0200
X-Mailer: git-send-email 1.7.6.rc3.2.g0185a
In-Reply-To: <1309112987-3185-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176327>

When working with submodules it is easy to forget to push a submodule
to the server but pushing a super-project that contains a commit for
that submodule. The result is that the superproject points at a
submodule commit that is not avaliable on the server.

Check that all submodule commits that are about to be pushed are present
on a remote of the submodule and require forcing if that is not the
case.

This does not guarantee that all submodules a super-project needs will be
available on the server. In that case both the super-project and the
submodules would need an atomic push. This does however prevent the
human error of forgetting to push a submodule.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
Mentored-by: Jens Lehmann <Jens.Lehmann@web.de>
Mentored-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c                    |   79 ++++++++++++++++++++++++++++++++++++++++
 submodule.h                    |    1 +
 t/t5531-deep-submodule-push.sh |   30 ++++++++++++++--
 transport.c                    |    8 ++++
 4 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index b6dec70..fe1daae 100644
--- a/submodule.c
+++ b/submodule.c
@@ -308,6 +308,85 @@ void set_config_fetch_recurse_submodules(int value)
 	config_fetch_recurse_submodules = value;
 }
 
+static int is_submodule_commit_pushed(const char *path, const unsigned char sha1[20])
+{
+	int is_pushed = 0;
+	if (!add_submodule_odb(path) && lookup_commit_reference(sha1)) {
+		struct child_process cp;
+		const char *argv[] = {"rev-list", NULL, "--not", "--remotes", "-n", "1" , NULL};
+		struct strbuf buf = STRBUF_INIT;
+
+		argv[1] = sha1_to_hex(sha1);
+		memset(&cp, 0, sizeof(cp));
+		cp.argv = argv;
+		cp.env = local_repo_env;
+		cp.git_cmd = 1;
+		cp.no_stdin = 1;
+		cp.out = -1;
+		cp.dir = path;
+		if (!run_command(&cp) && !strbuf_read(&buf, cp.out, 41))
+			is_pushed = 1;
+		close(cp.out);
+		strbuf_release(&buf);
+	}
+	return is_pushed;
+}
+
+static void submodule_collect_unpushed_cb(struct diff_queue_struct *q,
+					 struct diff_options *options,
+					 void *data)
+{
+	int i;
+	int *found_unpushed_submodule = data;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		if (!S_ISGITLINK(p->two->mode))
+			continue;
+		if (!is_submodule_commit_pushed(p->two->path, p->two->sha1)) {
+			*found_unpushed_submodule = 1;
+			break;
+		}
+	}
+}
+
+int check_for_unpushed_submodule_commits(unsigned char new_sha1[20])
+{
+	struct rev_info rev;
+	struct commit *commit;
+	const char *argv[] = {NULL, NULL, "--not", "--remotes", NULL};
+	int argc = ARRAY_SIZE(argv) - 1;
+	char *sha1_copy;
+	int found_unpushed_submodule = 0;
+
+	init_revisions(&rev, NULL);
+	sha1_copy = xstrdup(sha1_to_hex(new_sha1));
+	argv[1] = sha1_copy;
+	setup_revisions(argc, argv, &rev, NULL);
+	if (prepare_revision_walk(&rev))
+		die("revision walk setup failed");
+
+	while ((commit = get_revision(&rev)) && !found_unpushed_submodule) {
+		struct commit_list *parent = commit->parents;
+		while (parent) {
+			struct diff_options diff_opts;
+			diff_setup(&diff_opts);
+			DIFF_OPT_SET(&diff_opts, RECURSIVE);
+			diff_opts.output_format |= DIFF_FORMAT_CALLBACK;
+			diff_opts.format_callback = submodule_collect_unpushed_cb;
+			diff_opts.format_callback_data = &found_unpushed_submodule;
+			if (diff_setup_done(&diff_opts) < 0)
+				die("diff_setup_done failed");
+			diff_tree_sha1(parent->item->object.sha1, commit->object.sha1, "", &diff_opts);
+			diffcore_std(&diff_opts);
+			diff_flush(&diff_opts);
+			parent = parent->next;
+		}
+	}
+	free(sha1_copy);
+	return found_unpushed_submodule;
+}
+
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
 {
 	int is_present = 0;
diff --git a/submodule.h b/submodule.h
index 5350b0d..0a4d395 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,5 +29,6 @@ int fetch_populated_submodules(int num_options, const char **options,
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20]);
+int check_for_unpushed_submodule_commits(unsigned char sha1[20]);
 
 #endif
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 0b55466..0ef943a 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -32,7 +32,7 @@ test_expect_success push '
 	)
 '
 
-test_expect_failure 'push fails if submodule has no remote' '
+test_expect_success 'push fails if submodule has no remote' '
 	(
 		cd work/gar/bage &&
 		>junk2 &&
@@ -47,7 +47,7 @@ test_expect_failure 'push fails if submodule has no remote' '
 	)
 '
 
-test_expect_failure 'push fails if submodule commit not on remote' '
+test_expect_success 'push fails if submodule commit not on remote' '
 	(
 		cd work/gar &&
 		git clone --bare bage ../../submodule.git &&
@@ -66,7 +66,7 @@ test_expect_failure 'push fails if submodule commit not on remote' '
 	)
 '
 
-test_expect_failure 'push succeeds after commit was pushed to remote' '
+test_expect_success 'push succeeds after commit was pushed to remote' '
 	(
 		cd work/gar/bage &&
 		git push origin master
@@ -76,4 +76,28 @@ test_expect_failure 'push succeeds after commit was pushed to remote' '
 		git push ../pub.git master
 	)
 '
+
+test_expect_success 'push fails when commit on multiple branches if one branch has no remote' '
+	(
+		cd work/gar/bage &&
+		>junk4 &&
+		git add junk4 &&
+		git commit -m "Fourth junk"
+	) &&
+	(
+		cd work &&
+		git branch branch2 &&
+		git add gar/bage &&
+		git commit -m "Fourth commit for gar/bage" &&
+		git checkout branch2 &&
+		(
+			cd gar/bage &&
+			git checkout HEAD~1
+		) &&
+		>junk1 &&
+		git add junk1 &&
+		git commit -m "First junk" &&
+		test_must_fail git push ../pub.git
+	)
+'
 test_done
diff --git a/transport.c b/transport.c
index c9c8056..d83595b 100644
--- a/transport.c
+++ b/transport.c
@@ -10,6 +10,7 @@
 #include "refs.h"
 #include "branch.h"
 #include "url.h"
+#include "submodule.h"
 
 /* rsync support */
 
@@ -1041,6 +1042,13 @@ int transport_push(struct transport *transport,
 			flags & TRANSPORT_PUSH_MIRROR,
 			flags & TRANSPORT_PUSH_FORCE);
 
+		if(!(flags & TRANSPORT_PUSH_FORCE) && !is_bare_repository()) {
+			struct ref *ref = remote_refs;
+			for (; ref; ref = ref->next)
+				if(!is_null_sha1(ref->new_sha1) && check_for_unpushed_submodule_commits(ref->new_sha1))
+					die("There's unpushed submodules, aborting. Use -f to force a push");
+		}
+
 		push_ret = transport->push_refs(transport, remote_refs, flags);
 		err = push_had_errors(remote_refs);
 		ret = push_ret | err;
-- 
1.7.6.rc3.2.g0185a
