From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] Add test case for running from a subdirectory with
	GIT_WORK_TREE
Date: Sat, 27 Oct 2007 15:19:54 +0700
Message-ID: <20071027081954.GA23406@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 10:20:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ilgu3-0005FW-6q
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 10:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbXJ0IUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 04:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbXJ0IUF
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 04:20:05 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:39695 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbXJ0IUC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 04:20:02 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1014485rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 01:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=mLZOEoLU+3zRfmGJGRi0U6niC0osbX8IDNb5QXU/mUI=;
        b=KIqDa/mYBmmMsoBnrnK+5pd6k155wrJuCw+cd6/L+sqH9zpCVH+D0rZ1pkwDC+8ELuz+c/EzJ6qeM7+ebEO4W1YpnPcr23aYymD4fVQdBGptkm/ghefjzl105EqRb1a2QKnfiiirvx4MOlnv0gCxcH0YKuIQNFVwkStEZXcqu58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=KcTj85CVXatJ4vLGHRuJ5AauM2NNOKSdhubCKxobchGm2JCOFmuyifvQmzSU8V7K2ULKwn17LjLY9ynj55VsYpaWMFnGgyRxJb0VwbvSLEliEhftsToU/wquLDCvLL4LMg6+t2PRkC8uxBKhDllbC1nEGpn5bCELI7746XSXY74=
Received: by 10.141.164.10 with SMTP id r10mr1910948rvo.1193473201505;
        Sat, 27 Oct 2007 01:20:01 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.1.6])
        by mx.google.com with ESMTPS id b5sm8295724rva.2007.10.27.01.19.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2007 01:20:00 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Oct 2007 15:19:54 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62470>

This one is ugly (and not intended to submit to git.git), but
it shows how to reproduce the issues.  You can run it with
arg "--normal" to see it works just fine without GIT_WORK_TREE.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t1502-subworktree.sh |  109 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100755 t/t1502-subworktree.sh

diff --git a/t/t1502-subworktree.sh b/t/t1502-subworktree.sh
new file mode 100755
index 0000000..6b8f02f
--- /dev/null
+++ b/t/t1502-subworktree.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+test_description=3D'test commands on separate work tree'
+. ./test-lib.sh
+
+mkdir -p work/sub/dir || exit 1
+mv .git work
+if test "$1" =3D --normal; then
+	say "Normal case"
+else
+	say "Worktree case"
+fi
+test "$1" =3D --normal || mv work/.git repo.git || exit 1
+
+test "$1" =3D --normal || export GIT_DIR=3D$(pwd)/repo.git
+export GIT_CONFIG=3D"$(pwd)"/$GIT_DIR/config
+test "$1" =3D --normal || export GIT_WORK_TREE=3D$(pwd)/work
+
+cd work/sub || exit 1
+
+cat >expected <<EOF
+100644 9daeafb9864cf43055ae93beb0afd6c7d144bfa4 0	dir/untracked
+EOF
+
+test_expect_success 'git-ls-files' 'test expected =3D "$(git ls-files =
--others)"'
+
+test_expect_success 'git-add' '
+	 ( : > dir/untracked &&
+	 git add dir/untracked &&
+	 test dir/untracked =3D "$(git ls-files)")
+'
+test_expect_success 'git-update-index' '
+	( echo test > dir/untracked &&
+	git update-index dir/untracked &&
+	git ls-files --stage > check &&
+	cmp expected check)
+'
+
+test_expect_success 'git-commit' 'git commit -m one'
+
+cat >expected <<EOF
+100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	dir/untracked
+EOF
+
+test_expect_success 'git-ls-tree' '
+	(git ls-tree -r HEAD > check &&
+	cmp expected check)
+'
+test_expect_success 'git-rm' '
+	 (git rm --cached dir/untracked &&
+	 test -z "$(git ls-files)")
+'
+test_expect_success 'git-reset' '
+	(git reset HEAD -- dir/untracked &&
+	test dir/untracked =3D "$(git ls-files)")
+'
+test_expect_success 'git-annotate' 'git annotate dir/untracked'
+
+test_expect_success 'git-blame' 'git blame dir/untracked'
+
+cat > patch <<EOF
+From b774efc5a2199bfc1c9c18db70363c69a5a10c86 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Tue, 23 Oct 2007 21:17:24 +0700
+Subject: bah
+
+---
+ sub/dir/untracked |    1 +
+ 1 files changed, 1 insertions(+), 0 deletions(-)
+
+diff --git a/sub/dir/untracked b/sub/dir/untracked
+index 9daeafb..c73d3ff 100644
+--- a/sub/dir/untracked
++++ b/sub/dir/untracked
+@@ -1 +1,2 @@
+ test
++test again
+--=20
+1.5.3.rc4.3.gab089
+
+EOF
+
+cat > expected <<EOF
+100644 c73d3ffa5fa32888de8219e49fd45d37dc209677 0	dir/untracked
+EOF
+
+test_expect_success 'git-apply to index' '
+	(git apply --index patch &&
+	git ls-files --stage > check &&
+	cmp expected check)'
+
+test_expect_failure 'git-apply to worktree' 'test -f sub/dir/untracked=
'
+
+test_expect_success 'git-reset --hard' '( git reset --hard HEAD && tes=
t -z "$(git ls-files -m)")'
+
+test_expect_failure 'git-am must not be run from subdir' 'git-am -k pa=
tch'
+
+test_expect_success 'git-reset --hard' 'git reset --hard HEAD'
+
+test_expect_success 'git-am' '(cd .. && git-am -k sub/patch)'
+
+test_expect_success 'git-format-patch' '
+	(git format-patch -k HEAD^ &&
+	sed "1d;/^-- /,\$d" patch > expected &&
+	sed "1d;/^-- /,\$d" 0001-bah.patch > check &&
+	cmp expected check)
+'
+
+test_done
--=20
1.5.3.rc4.3.gab089
