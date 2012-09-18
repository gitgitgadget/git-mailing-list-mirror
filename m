From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv6=5D=20clone=20--single=3A=20limit=20the=20fetch=20refspec=20to=20fetched=20branch?=
Date: Tue, 18 Sep 2012 21:14:20 +0200
Message-ID: <1347995660-9956-1-git-send-email-ralf.thielow@gmail.com>
References: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 18 21:15:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE3GT-0005ym-Sm
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 21:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab2IRTPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2012 15:15:13 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47991 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2IRTPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 15:15:11 -0400
Received: by bkwj10 with SMTP id j10so112969bkw.19
        for <git@vger.kernel.org>; Tue, 18 Sep 2012 12:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Vplr+bmWHzY2uY+zPbHt8WlajcMb0l9grdI6L18ilcQ=;
        b=mNLu3Ml/wZfipSgqJjvkSgWZpBWW3R5PqcP9fzJzjEPB2Kd8ppYxwpiy7t+2Aqv6yO
         EhR5UGC1t18nRd2ZqWY9sDUUewglZ5duiJWVT+qH+wTiVF5y2N71xU9N9nRc0OONilfw
         QGQmw+uURsQ39ZBNQ+wUQjQMlwURNx8Wtqyev74bvg/3BIldtSepp106HAcb+zfncnTn
         o5MJbU9PU9HaLezVGFrH0fISwOHLwhIgqBxLz0DRD5tKXnjP4puPJ5jugZiIOVtcajTK
         LCdpvQbkpTqp6G8FjexMdnjaNfHOCA3EZ2D7mneeQBgZgQat5rJjvgAGspJC+T5cbwId
         FXPQ==
Received: by 10.204.157.22 with SMTP id z22mr533513bkw.4.1347995709487;
        Tue, 18 Sep 2012 12:15:09 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id c18sm442470bkv.8.2012.09.18.12.15.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 18 Sep 2012 12:15:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.396.g7954078
In-Reply-To: <1347909706-22888-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205852>

After running "git clone --single", the resulting repository has the
usual default "+refs/heads/*:refs/remotes/origin/*" wildcard fetch
refspec installed, which means that a subsequent "git fetch" will
end up grabbing all the other branches.

Update the fetch refspec to cover only the singly cloned ref instead
to correct this.

That means:
If "--single" is used without "--branch" or "--mirror", the
fetch refspec covers the branch on which remote's HEAD points to.
If "--single" is used with "--branch", it'll cover only the branch
specified in the "--branch" option.
If "--single" is combined with "--mirror", then it'll cover all
refs of the cloned repository.
If "--single" is used with "--branch" that specifies a tag, then
it'll cover only the ref for this tag.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

changes in v6
- remove initial created tests (they tested in a too deep level)
- add tests for "--mirror" option
- add tests for the case of cloning a tag
- update commit message

I've tried to update "Documentation/git-clone.txt", but I don't
know in which way this patch changes already described behaviour.
The resulting refspec seems only be covered in the last part of
the "--single-branch" section by describing "--no-single-branch",
but this hasn't changed. Or did I miss something?

 builtin/clone.c          |  66 ++++++++++++++++-----
 t/t5709-clone-refspec.sh | 145 +++++++++++++++++++++++++++++++++++++++=
++++++++
 2 Dateien ge=C3=A4ndert, 197 Zeilen hinzugef=C3=BCgt(+), 14 Zeilen ent=
fernt(-)
 create mode 100755 t/t5709-clone-refspec.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index 5e8f3ba..431635c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -610,6 +610,55 @@ static void write_config(struct string_list *confi=
g)
 	}
 }
=20
+static void write_refspec_config(const char* src_ref_prefix,
+		const struct ref* our_head_points_at,
+		const struct ref* remote_head_points_at, struct strbuf* branch_top)
+{
+	struct strbuf key =3D STRBUF_INIT;
+	struct strbuf value =3D STRBUF_INIT;
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
 	int is_bundle =3D 0, is_local;
@@ -755,20 +804,6 @@ int cmd_clone(int argc, const char **argv, const c=
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
@@ -853,6 +888,9 @@ int cmd_clone(int argc, const char **argv, const ch=
ar *prefix)
 					      "refs/heads/master");
 	}
=20
+	write_refspec_config(src_ref_prefix, our_head_points_at,
+			remote_head_points_at, &branch_top);
+
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch)
diff --git a/t/t5709-clone-refspec.sh b/t/t5709-clone-refspec.sh
new file mode 100755
index 0000000..8d32a97
--- /dev/null
+++ b/t/t5709-clone-refspec.sh
@@ -0,0 +1,145 @@
+#!/bin/sh
+
+test_description=3D'test refspec written by clone-command'
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
+	# default --single that follows HEAD=3Dmaster
+	git clone --single-branch . dir_master &&
+
+	# default --single that follows HEAD=3Dside
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
+	# default --single with --branch and --mirror
+	git clone --single-branch --mirror --branch side . dir_mirror_side &&
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
+
+test_expect_success '--single-branch with explicit --branch tag' '
+	(
+		cd dir_tag && git fetch &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	git for-each-ref refs/tags >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch with --mirror' '
+	(
+		cd dir_mirror && git fetch &&
+		git for-each-ref refs > ../actual
+	) &&
+	git for-each-ref refs >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch with explicit --branch and --mirr=
or' '
+	(
+		cd dir_mirror_side && git fetch &&
+		git for-each-ref refs > ../actual
+	) &&
+	git for-each-ref refs >expect &&
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
--=20
1.7.12.396.g7954078
