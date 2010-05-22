From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Fri, 21 May 2010 21:28:37 -0300
Message-ID: <1274488119-6989-4-git-send-email-erick.mattos@gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org, Erick Mattos <erick.mattos@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 02:29:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFcbE-0002Ar-Hf
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 02:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755Ab0EVA3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 20:29:51 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51924 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341Ab0EVA3t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 20:29:49 -0400
Received: by gwaa20 with SMTP id a20so740982gwa.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=6tihvDoqAUSeAVVyBiNb+VxXP/0XHc7OVBlzc5VCeqc=;
        b=vkq0neHFiYuNIXwZzhVoGTuowR4gfeCm/iCkXK9JkrANNLOxitC0+ZrncRR4SpUhFL
         dONUaU6t7byKTaeKQPu9kWDidtnFCjRwpjO3NCzHcYNz3JrozWzRXVPJxYPORFX8U3Kv
         LYvN3i52UKI9lUjw1lcZ8K5KFnkPYlr5o0cQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=eiEqZFBU3Ad24STLp3X9D8tztUtmIzc+HquxnEGTU/b5G4vb/W7twtkqC1NWHirriZ
         Sy1Y4vHFfYIsQ0CslsOMXyn0F0Vp7mdT1JP9A3o+rTRx0F9EZ6dHcU9iElUqSLIsr/DA
         EKR0LscqRs5Uwi3JrUaOnfS6Ylaujst7gpniU=
Received: by 10.150.170.17 with SMTP id s17mr3596724ybe.410.1274488188098;
        Fri, 21 May 2010 17:29:48 -0700 (PDT)
Received: from localhost.localdomain ([187.15.117.192])
        by mx.google.com with ESMTPS id z42sm23557998ybc.6.2010.05.21.17.29.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 17:29:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.231.g0687c.dirty
In-Reply-To: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147500>

Added changes to satisfy a corner case: creating reflogs by using -l
when core.logAllRefUpdates is set to false.
---
 builtin/checkout.c         |   31 ++++++++++++++++--
 t/t2017-checkout-orphan.sh |   78 ++++++++++++++++++++++++++++++++------------
 2 files changed, 85 insertions(+), 24 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index c382521..024c936 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -493,7 +493,24 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	struct strbuf msg = STRBUF_INIT;
 	const char *old_desc;
 	if (opts->new_branch) {
-		if (!opts->new_orphan_branch)
+		if (opts->new_orphan_branch) {
+			if (opts->new_branch_log && !log_all_ref_updates) {
+				int temp;
+				char *log_file;
+				char *ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
+
+				temp = log_all_ref_updates;
+				log_all_ref_updates = 1;
+				if (log_ref_setup(ref_name, &log_file)) {
+					fprintf(stderr, "Can not do reflog for '%s'\n",
+					    opts->new_orphan_branch);
+					log_all_ref_updates = temp;
+					return;
+				}
+				log_all_ref_updates = temp;
+			}
+		}
+		else
 			create_branch(old->name, opts->new_branch, new->name, 0,
 				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
@@ -517,6 +534,14 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 					opts->new_branch ? " a new" : "",
 					new->name);
 		}
+		if (old->path && old->name) {
+			char log_file[PATH_MAX], ref_file[PATH_MAX];
+
+			git_snpath(log_file, sizeof(log_file), "logs/%s", old->path);
+			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
+			if (!file_exists(ref_file) && file_exists(log_file))
+				remove_path(log_file);
+		}
 	} else if (strcmp(new->name, "HEAD")) {
 		update_ref(msg.buf, "HEAD", new->commit->object.sha1, NULL,
 			   REF_NODEREF, DIE_ON_ERR);
@@ -684,8 +709,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (opts.new_orphan_branch) {
 		if (opts.new_branch)
 			die("--orphan and -b are mutually exclusive");
-		if (opts.track > 0 || opts.new_branch_log)
-			die("--orphan cannot be used with -t or -l");
+		if (opts.track > 0)
+			die("--orphan should not be used with -t");
 		opts.new_branch = opts.new_orphan_branch;
 	}
 
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index a8297c6..be88d4b 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -49,6 +49,62 @@ test_expect_success '--orphan must be rejected with -b' '
 	test refs/heads/master = "$(git symbolic-ref HEAD)"
 '
 
+test_expect_success '--orphan must be rejected with -t' '
+	git checkout master &&
+	test_must_fail git checkout --orphan new -t master &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success '--orphan ignores branch.autosetupmerge' '
+	git checkout master &&
+	git config branch.autosetupmerge always &&
+	git checkout --orphan gamma &&
+	test -z "$(git config branch.gamma.merge)" &&
+	test refs/heads/gamma = "$(git symbolic-ref HEAD)" &&
+	test_must_fail git rev-parse --verify HEAD^
+'
+
+test_expect_success '--orphan makes reflog by default' '
+	git checkout master &&
+	git config --unset core.logAllRefUpdates &&
+	git checkout --orphan delta &&
+	! test -f .git/logs/refs/heads/delta &&
+	test_must_fail PAGER= git reflog show delta &&
+	git commit -m Delta &&
+	test -f .git/logs/refs/heads/delta &&
+	PAGER= git reflog show delta
+'
+
+test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
+	git checkout master &&
+	git config core.logAllRefUpdates false &&
+	git checkout --orphan epsilon &&
+	! test -f .git/logs/refs/heads/epsilon &&
+	test_must_fail PAGER= git reflog show epsilon &&
+	git commit -m Epsilon &&
+	! test -f .git/logs/refs/heads/epsilon &&
+	test_must_fail PAGER= git reflog show epsilon
+'
+
+test_expect_success '--orphan with -l makes reflog when core.logAllRefUpdates = false' '
+	git checkout master &&
+	git checkout -l --orphan zeta &&
+	test -f .git/logs/refs/heads/zeta &&
+	test_must_fail PAGER= git reflog show zeta &&
+	git commit -m Zeta &&
+	PAGER= git reflog show zeta
+'
+
+test_expect_success 'giving up --orphan not committed when -l and core.logAllRefUpdates = false deletes reflog' '
+	git checkout master &&
+	git checkout -l --orphan eta &&
+	test -f .git/logs/refs/heads/eta &&
+	test_must_fail PAGER= git reflog show eta &&
+	git checkout master &&
+	! test -f .git/logs/refs/heads/eta &&
+	test_must_fail PAGER= git reflog show eta
+'
+
 test_expect_success '--orphan is rejected with an existing name' '
 	git checkout master &&
 	test_must_fail git checkout --orphan master &&
@@ -60,31 +116,11 @@ test_expect_success '--orphan refuses to switch if a merge is needed' '
 	git reset --hard &&
 	echo local >>"$TEST_FILE" &&
 	cat "$TEST_FILE" >"$TEST_FILE.saved" &&
-	test_must_fail git checkout --orphan gamma master^ &&
+	test_must_fail git checkout --orphan new master^ &&
 	test refs/heads/master = "$(git symbolic-ref HEAD)" &&
 	test_cmp "$TEST_FILE" "$TEST_FILE.saved" &&
 	git diff-index --quiet --cached HEAD &&
 	git reset --hard
 '
 
-test_expect_success '--orphan does not mix well with -t' '
-	git checkout master &&
-	test_must_fail git checkout -t master --orphan gamma &&
-	test refs/heads/master = "$(git symbolic-ref HEAD)"
-'
-
-test_expect_success '--orphan ignores branch.autosetupmerge' '
-	git checkout -f master &&
-	git config branch.autosetupmerge always &&
-	git checkout --orphan delta &&
-	test -z "$(git config branch.delta.merge)" &&
-	test refs/heads/delta = "$(git symbolic-ref HEAD)" &&
-	test_must_fail git rev-parse --verify HEAD^
-'
-
-test_expect_success '--orphan does not mix well with -l' '
-	git checkout -f master &&
-	test_must_fail git checkout -l --orphan gamma
-'
-
 test_done
-- 
1.7.1.231.g0687c.dirty
