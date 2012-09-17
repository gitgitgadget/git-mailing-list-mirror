From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCHv5] clone --single: limit the fetch refspec to fetched branch
Date: Mon, 17 Sep 2012 21:21:46 +0200
Message-ID: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
References: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 17 21:22:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDgtw-0007qa-Nl
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 21:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492Ab2IQTV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 15:21:58 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:58262 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417Ab2IQTV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 15:21:57 -0400
Received: by bkwj10 with SMTP id j10so2725181bkw.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cQu7RdLO3AmC77Vg153Gpbe77ta1P72/2BbtnRO5bEw=;
        b=K4lkybzq4gX1RD+eeC4e8DMAgMy1g9q+ZFDVIBLstRI6A+yIoYySj91EGDUra0DfK+
         DjA1F/5B0LzoZmSqj0yLJYWSTbLPjqsBy90Bzj6UmwrsSN8+eEUx5hbW8mIZ4FVlehjd
         a+j6g/2PDzSrDky/yN9OxNmzu56ASdzj6LWA96Y2skVVG//9H5fEZQ6elA5TZwkCR/U2
         w40kl2OT3Bw6UcG8kqZotK52ikms412FIPnklHkrKO1m8mMDaRzKriasH6ydsdzHSCR1
         I+jJ+eUyDNF6nrDgfm4+27nqknqrqKgquaVqUKlrbElvaPJS+Fpr1nd95w5Rf6fHN4mB
         qV2g==
Received: by 10.204.152.137 with SMTP id g9mr4981181bkw.106.1347909715263;
        Mon, 17 Sep 2012 12:21:55 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id he8sm6439795bkc.3.2012.09.17.12.21.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 12:21:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.397.ge29f79e.dirty
In-Reply-To: <CACsJy8BGBwNp-oDsnB1QObrVLU54rtDmGGBF=Muww8ZJjfZScA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205730>

After running "git clone --single", the resulting repository has the
usual default "+refs/heads/*:refs/remotes/origin/*" wildcard fetch
refspec installed, which means that a subsequent "git fetch" will
end up grabbing all the other branches.

Update the fetch refspec to cover only the singly cloned ref instead
to correct this.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

changes in v5:
- extract a function to write refspec config
- handle --mirror option (test added)
- install correct refspec if the value of --branch is a tag (test added)
Thanks to Junio for:
- refactor tests
- add tests for created refs 

I'm not happy about using "our_head_points_to" for the remote
part of the refspec. Junio already complaint about that. As far
as I can see it's the only way of getting the information that
it's a tag. Also the condition "is this a tag" might not be the
best way.

 builtin/clone.c          |  66 +++++++++++++++-----
 t/t5709-clone-refspec.sh | 156 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 208 insertions(+), 14 deletions(-)
 create mode 100755 t/t5709-clone-refspec.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index 5e8f3ba..431635c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -610,6 +610,55 @@ static void write_config(struct string_list *config)
 	}
 }
 
+static void write_refspec_config(const char* src_ref_prefix,
+		const struct ref* our_head_points_at,
+		const struct ref* remote_head_points_at, struct strbuf* branch_top)
+{
+	struct strbuf key = STRBUF_INIT;
+	struct strbuf value = STRBUF_INIT;
+
+	if (option_mirror || !option_bare) {
+		if (option_single_branch && !option_mirror) {
+			if (option_branch) {
+				if (strstr(our_head_points_at->name, "refs/tags/"))
+					strbuf_addf(&value, "+%s:%s", our_head_points_at->name,
+						our_head_points_at->name);
+				else
+					strbuf_addf(&value, "+%s:%s%s", our_head_points_at->name,
+						branch_top->buf, option_branch);
+			} else if (remote_head_points_at) {
+				strbuf_addf(&value, "+%s:%s%s", remote_head_points_at->name,
+						branch_top->buf,
+						skip_prefix(remote_head_points_at->name, "refs/heads/"));
+			}
+			/*
+			 * otherwise, the next "git fetch" will
+			 * simply fetch from HEAD without updating
+			 * any remote tracking branch, which is what
+			 * we want.
+			 */
+		} else {
+			strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top->buf);
+		}
+		/* Configure the remote */
+		if (value.len) {
+			strbuf_reset(&key);
+			strbuf_addf(&key, "remote.%s.fetch", option_origin);
+			git_config_set_multivar(key.buf, value.buf, "^$", 0);
+			strbuf_reset(&key);
+
+			if (option_mirror) {
+				strbuf_addf(&key, "remote.%s.mirror", option_origin);
+				git_config_set(key.buf, "true");
+				strbuf_reset(&key);
+			}
+		}
+	}
+
+	strbuf_release(&key);
+	strbuf_release(&value);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -755,20 +804,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
-
-	if (option_mirror || !option_bare) {
-		/* Configure the remote */
-		strbuf_addf(&key, "remote.%s.fetch", option_origin);
-		git_config_set_multivar(key.buf, value.buf, "^$", 0);
-		strbuf_reset(&key);
-
-		if (option_mirror) {
-			strbuf_addf(&key, "remote.%s.mirror", option_origin);
-			git_config_set(key.buf, "true");
-			strbuf_reset(&key);
-		}
-	}
-
 	strbuf_addf(&key, "remote.%s.url", option_origin);
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
@@ -853,6 +888,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					      "refs/heads/master");
 	}
 
+	write_refspec_config(src_ref_prefix, our_head_points_at,
+			remote_head_points_at, &branch_top);
+
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
diff --git a/t/t5709-clone-refspec.sh b/t/t5709-clone-refspec.sh
new file mode 100755
index 0000000..af45182
--- /dev/null
+++ b/t/t5709-clone-refspec.sh
@@ -0,0 +1,156 @@
+#!/bin/sh
+
+test_description='test refspec written by clone-command'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	# Make two branches, "master" and "side"
+	echo one >file &&
+	git add file &&
+	git commit -m one &&
+	echo two >file &&
+	git commit -a -m two &&
+	git tag two &&
+	echo three >file &&
+	git commit -a -m three &&
+	git checkout -b side &&
+	echo four >file &&
+	git commit -a -m four &&
+	git checkout master &&
+
+	# default clone
+	git clone . dir_all &&
+
+	# default --single that follows HEAD=master
+	git clone --single-branch . dir_master &&
+
+	# default --single that follows HEAD=side
+	git checkout side &&
+	git clone --single-branch . dir_side &&
+
+	# explicit --single that follows side
+	git checkout master &&
+	git clone --single-branch --branch side . dir_side2 &&
+
+	# default --single with --mirror
+	git clone --single-branch --mirror . dir_mirror &&
+
+	# --single that does not know what branch to follow
+	git checkout two^ &&
+	git clone --single-branch . dir_detached &&
+
+	# explicit --single with tag
+	git clone --single-branch --branch two . dir_tag &&
+
+	# advance both "master" and "side" branches
+	git checkout side &&
+	echo five >file &&
+	git commit -a -m five &&
+	git checkout master &&
+	echo six >file &&
+	git commit -a -m six
+'
+
+test_expect_success 'refspec contains all branches by default' '
+	echo "+refs/heads/*:refs/remotes/origin/*" > expect &&
+	git --git-dir=dir_all/.git config --get remote.origin.fetch > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'refspec contains all refs with option --mirror' '
+	echo "+refs/*:refs/*" > expect &&
+	git --git-dir=dir_mirror config --get remote.origin.fetch > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'refspec contains tag ref' '
+	echo "+refs/tags/two:refs/tags/two" > expect &&
+	git --git-dir=dir_tag/.git config --get remote.origin.fetch > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'refspec contains only master with option --single-branch and remotes HEAD point to master' '
+	echo "+refs/heads/master:refs/remotes/origin/master" > expect &&
+	git --git-dir=dir_master/.git config --get remote.origin.fetch > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'refspec contains only foo with option --single-branch and remotes HEAD point to side' '
+	echo "+refs/heads/side:refs/remotes/origin/side" > expect &&
+	git --git-dir=dir_side/.git config --get remote.origin.fetch > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'refspec contains one branch after using option --single-branch with --branch' '
+	echo "+refs/heads/side:refs/remotes/origin/side" > expect &&
+	git --git-dir=dir_side2/.git config --get remote.origin.fetch > actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'no refspec is written if remotes HEAD is detached' '
+	> expect &&
+	git --git-dir=dir_detached/.git config --get remote.origin.fetch > actual
+	test_cmp expect actual
+'
+
+test_expect_success 'by default all branches will be kept updated' '
+	(
+		cd dir_all && git fetch &&
+		git for-each-ref refs/remotes/origin |
+		sed -e "/HEAD$/d" \
+		    -e "s|/remotes/origin/|/heads/|" >../actual
+	) &&
+	# follow both master and side
+	git for-each-ref refs/heads >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch while HEAD pointing at master' '
+	(
+		cd dir_master && git fetch &&
+		git for-each-ref refs/remotes/origin |
+		sed -e "/HEAD$/d" \
+		    -e "s|/remotes/origin/|/heads/|" >../actual
+	) &&
+	# only follow master
+	git for-each-ref refs/heads/master >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch while HEAD pointing at side' '
+	(
+		cd dir_side && git fetch &&
+		git for-each-ref refs/remotes/origin |
+		sed -e "/HEAD$/d" \
+		    -e "s|/remotes/origin/|/heads/|" >../actual
+	) &&
+	# only follow side
+	git for-each-ref refs/heads/side >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch with explicit --branch side' '
+	(
+		cd dir_side2 && git fetch &&
+		git for-each-ref refs/remotes/origin |
+		sed -e "/HEAD$/d" \
+		    -e "s|/remotes/origin/|/heads/|" >../actual
+	) &&
+	# only follow side
+	git for-each-ref refs/heads/side >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch with detached' '
+	(
+		cd dir_detached && git fetch &&
+		git for-each-ref refs/remotes/origin |
+		sed -e "/HEAD$/d" \
+		    -e "s|/remotes/origin/|/heads/|" >../actual
+	)
+	# nothing
+	>expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.12.397.ge29f79e.dirty
