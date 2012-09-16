From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv4=5D=20clone=20--single=3A=20limit=20the=20fetch=20refspec=20to=20fetched=20branch?=
Date: Sun, 16 Sep 2012 10:13:04 +0200
Message-ID: <1347783184-20045-1-git-send-email-ralf.thielow@gmail.com>
References: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 16 10:14:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD9zv-00085G-51
	for gcvg-git-2@plane.gmane.org; Sun, 16 Sep 2012 10:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab2IPINX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2012 04:13:23 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41819 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab2IPINO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2012 04:13:14 -0400
Received: by wibhi8 with SMTP id hi8so1373483wib.1
        for <git@vger.kernel.org>; Sun, 16 Sep 2012 01:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=jbUsTOXJ1Rpf2DZC8K86lcmqCSgYx6p4C6S5GJtc/9Q=;
        b=buFxD53/XqE5DbNpzLLd49t1rT9DRjbTlhybzXndUPmmQYj6/tvUSG5pv3hNUwmJmY
         eTE+7MdlxKhTqDgck54ibcKN7wLYpm8Cb19bgMvi/RPS4MT/2Yyhjz3gdo0SZbTd1IKo
         Rn5gyncTGTQhwMb1kNbcXGS5TecS/PFwndvcBT8VDCHvdNXOL8XUbMbMXt5PaWUeC8pL
         b+qUiKqJJq1ukwHSThu2hjFmii+gBgZfYcwEpGoRUUh5uhghRKKfFiqcBVJuOcsuV0AM
         sXpMzWjrSavp28FmxYD+J7/Gm+19C1PVHVtQyu8wO8gRfwXi/bKzMWMTYLzNSMHh7Iay
         46Xg==
Received: by 10.217.3.1 with SMTP id q1mr4079084wes.38.1347783192107;
        Sun, 16 Sep 2012 01:13:12 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id v3sm10203876wiw.7.2012.09.16.01.13.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Sep 2012 01:13:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.396.g6bea32d.dirty
In-Reply-To: <7vy5kc1avx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205600>

After running "git clone --single", the resulting repository has the
usual default "+refs/heads/*:refs/remotes/origin/*" wildcard fetch
refspec installed, which means that a subsequent "git fetch" will
end up grabbing all the other branches.

Update the fetch refspec to cover only the singly cloned ref instead
to correct this.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

Changes to v3:
- use commit message from Junio's topic branch
- add comment for the 'detached HEAD' case (also from Junio's topic bra=
nch)
(thanks for that)
- add tests for the refspec installed by the clone command

 builtin/clone.c          | 49 ++++++++++++++++++++++++++++------------
 t/t5709-clone-refspec.sh | 59 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 Dateien ge=C3=A4ndert, 94 Zeilen hinzugef=C3=BCgt(+), 14 Zeilen entf=
ernt(-)
 create mode 100755 t/t5709-clone-refspec.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index 5e8f3ba..be4c62b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -755,20 +755,6 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 	}
=20
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
@@ -853,6 +839,41 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 					      "refs/heads/master");
 	}
=20
+	if (option_mirror || !option_bare) {
+		strbuf_reset(&value);
+		if (option_single_branch) {
+			if (option_branch)
+				strbuf_addf(&value, "+%s%s:%s%s",
+						src_ref_prefix, option_branch,
+						branch_top.buf, option_branch);
+			else if (remote_head_points_at)
+				strbuf_addf(&value, "+%s:%s%s",
+						remote_head_points_at->name, branch_top.buf,
+						skip_prefix(remote_head_points_at->name, "refs/heads/"));
+			/*
+			 * otherwise, the next "git fetch" will
+			 * simply fetch from HEAD without updating
+			 * any remote tracking branch, which is what
+			 * we want.
+			 */
+		} else {
+			strbuf_addf(&value, "+%s*:%s*", src_ref_prefix, branch_top.buf);
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
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
diff --git a/t/t5709-clone-refspec.sh b/t/t5709-clone-refspec.sh
new file mode 100755
index 0000000..f4c8e31
--- /dev/null
+++ b/t/t5709-clone-refspec.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description=3D'test refspec written by clone-command'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo one >file &&
+	git add file &&
+	git commit -m one &&
+	echo two >file &&
+	git commit -a -m two &&
+	git tag two &&
+	echo three >file &&
+	git commit -a -m three &&
+	git checkout -b foo &&
+	echo four >file &&
+	git commit -a -m four &&
+	git checkout master
+'
+
+test_expect_success 'refspec contains all branches by default' '
+	git clone "file://$PWD" dir_all &&
+	echo "+refs/heads/*:refs/remotes/origin/*" > expected &&
+	git --git-dir=3Ddir_all/.git config --get remote.origin.fetch > actua=
l &&
+	test_cmp expected actual
+'
+
+test_expect_success 'refspec contains only master with option --single=
-branch and remotes HEAD point to master' '
+	git clone --single-branch "file://$PWD" dir_master &&
+	echo "+refs/heads/master:refs/remotes/origin/master" > expected &&
+	git --git-dir=3Ddir_master/.git config --get remote.origin.fetch > ac=
tual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'refspec contains only foo with option --single-br=
anch and remotes HEAD point to foo' '
+	git checkout foo &&
+	git clone --single-branch "file://$PWD" dir_foo &&
+	echo "+refs/heads/foo:refs/remotes/origin/foo" > expected &&
+	git --git-dir=3Ddir_foo/.git config --get remote.origin.fetch > actua=
l &&
+	test_cmp expected actual
+'
+
+test_expect_success 'refspec contains one branch after using option --=
single-branch with --branch' '
+	git checkout master &&
+	git clone --single-branch --branch foo "file://$PWD" dir_foo2 &&
+	echo "+refs/heads/foo:refs/remotes/origin/foo" > expected &&
+	git --git-dir=3Ddir_foo2/.git config --get remote.origin.fetch > actu=
al &&
+	test_cmp expected actual
+'
+
+test_expect_success 'no refspec is written if remotes HEAD is detached=
' '
+	git checkout two^ &&
+	git clone --single-branch "file://$PWD" dir_detached &&
+	rm expected && touch expected &&
+	git --git-dir=3Ddir_detached/.git config --get remote.origin.fetch > =
actual
+	test_cmp expected actual
+'
+
+test_done
--=20
1.7.12.396.g6bea32d.dirty
