From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv7=5D=20clone=20--single=3A=20limit=20the=20fetch=20refspec=20to=20fetched=20branch?=
Date: Wed, 19 Sep 2012 18:45:36 +0200
Message-ID: <1348073136-8842-1-git-send-email-ralf.thielow@gmail.com>
References: <7vfw6fm7xb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 19 18:46:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TENPZ-0001Mx-C5
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 18:46:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147Ab2ISQp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2012 12:45:56 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44130 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab2ISQpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 12:45:54 -0400
Received: by bkwj10 with SMTP id j10so651889bkw.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=B+T0OzEo4+rGbxZ5CjSfNcM3ySoKblxWLSMNYpcBynY=;
        b=ZIUqklrxK8fqHYZtbCTerGCeBU1cpMoieMep94ql1uCSl2JH8laQm3GINK/k4Ql/zb
         T2kCPPT4rAH+bchIlHdS1cSEVRbG2/fwhizd00kFyA/zUUDpfzILSZX4I7xnAZMvCypS
         izqkpkp9r+k2ndiG+XcnPvl40uOAyoPz4fJoa/JHDGJeiBgWDR7gZetUoSocts1zSVHg
         VbeWXb1ZtSuwC2LlgLW1BDgbq7xXU8XgbGAcnBqJ8ZzjifvmQdsKCah4a52LmG3SvPVL
         RGRrTD5RR+ODsZQoSa8k+xIY+ORAAGwIHfpTfqZs4QoeCK8eKm34nX/1MeLpfX5esLLS
         k50Q==
Received: by 10.204.4.154 with SMTP id 26mr1512596bkr.91.1348073153477;
        Wed, 19 Sep 2012 09:45:53 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id p2sm2521542bkw.3.2012.09.19.09.45.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 09:45:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.396.g7954078
In-Reply-To: <7vfw6fm7xb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205945>

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

Changes in v7:
- remove a test which has shown that after the next "git fetch"
  the tags will be the same (was actually a bit senseless)
- add a test to show that the initial clone with "--single" fetches tag=
s
- add a test to show when using "--single" with "--branch"
  which points to a tag, then the next "git fetch" will update
  this tag if it was updated in the cloned repository
- update documentation of "git clone" (Thanks to Junio)

 Documentation/git-clone.txt |  15 +++--
 builtin/clone.c             |  66 +++++++++++++++----
 t/t5709-clone-refspec.sh    | 155 ++++++++++++++++++++++++++++++++++++=
++++++++
 3 Dateien ge=C3=A4ndert, 218 Zeilen hinzugef=C3=BCgt(+), 18 Zeilen ent=
fernt(-)
 create mode 100755 t/t5709-clone-refspec.sh

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c1ddd4c..6d98ef3 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -29,7 +29,8 @@ currently active branch.
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
 arguments will in addition merge the remote master branch into the
-current master branch, if any.
+current master branch, if any (this is untrue when "--single-branch"
+is given; see below).
=20
 This default configuration is achieved by creating references to
 the remote branch heads under `refs/remotes/origin` and
@@ -152,9 +153,10 @@ objects from the source repository into a pack in =
the cloned repository.
 -b <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
 	to by the cloned repository's HEAD, point to `<name>` branch
-	instead. `--branch` can also take tags and treat them like
-	detached HEAD. In a non-bare repository, this is the branch
-	that will be checked out.
+	instead. In a non-bare repository, this is the branch that will
+	be checked out.
+	`--branch` can also take tags and detaches the HEAD at that commit
+	in the resulting repository.
=20
 --upload-pack <upload-pack>::
 -u <upload-pack>::
@@ -193,6 +195,11 @@ objects from the source repository into a pack in =
the cloned repository.
 	clone with the `--depth` option, this is the default, unless
 	`--no-single-branch` is given to fetch the histories near the
 	tips of all branches.
+	Further fetches into the resulting repository will only update the
+	remote tracking branch for the branch this option was used for the
+	initial cloning.  If the HEAD at the remote did not point at any
+	branch when `--single-branch` clone was made, no remote tracking
+	branch is created.
=20
 --recursive::
 --recurse-submodules::
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
index 0000000..69a0779
--- /dev/null
+++ b/t/t5709-clone-refspec.sh
@@ -0,0 +1,155 @@
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
+test_expect_success '--single-branch fetches tags' '
+	(
+		cd dir_all &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	git for-each-ref refs/tags >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--single-branch with explicit --branch with tag f=
etches updated tag' '
+	git tag -d two && git tag two &&
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
