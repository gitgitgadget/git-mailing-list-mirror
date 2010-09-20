From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 04/37] t6022: Add test combinations of {content conflict?, D/F conflict remains?}
Date: Mon, 20 Sep 2010 02:28:37 -0600
Message-ID: <1284971350-30590-5-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblR-0006R4-JK
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756004Ab0ITI3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:29:44 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755704Ab0ITI1j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:27:39 -0400
Received: by pwi3 with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=i7+lxEQRuDWUmGK+YdzTXG6gRzyqAhGflIWQ/dROBHw=;
        b=uqZEv3dZIKi00iJAeZTJj+nTm2VEnvpk+KfcTgdvxAnRF1Ti8sjYO9yQC/pxhBkfLh
         5BXdNAaFVlmvcM2qtIDwbAPBTmmu6n+UaNU2sXDU9ipUeT8bXzA6fsmchHu9kevKqKoX
         AJ4xUuhW48RLpb60o1H4NiqZDlEectXp68PPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=t2pxU7IsZwdy83Jgq2iaQt4VROOIZqTiBEihUTtOwY/8HZWVUND38EZASOyJL6MvvW
         1E0R6gNb6xRw4hkw4BgZkKjb7+VaH2KsmGO31HbfXxfrYgo84jutSxUdf/28RhsO8X/q
         QGDCOvUep01QWEJ1hLedfpNf/cMen+YW8bxGI=
Received: by 10.142.207.15 with SMTP id e15mr7347100wfg.277.1284971258689;
        Mon, 20 Sep 2010 01:27:38 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156595>

Add testing of the various ways that a renamed file to a path involved in
a directory/file conflict may be involved in.  This includes whether or not
there are conflicts of the contents of the renamed file (if the file was
modified on both sides of history), and whether the directory from the
other side of the merge will disappear as a result of the merge or not.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |  128 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 128 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index b66544b..a992206 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -3,6 +3,11 @@
 test_description='Merge-recursive merging renames'
 . ./test-lib.sh
 
+modify () {
+	sed -e "$1" <"$2" >"$2.x" &&
+	mv "$2.x" "$2"
+}
+
 test_expect_success setup \
 '
 cat >A <<\EOF &&
@@ -341,4 +346,127 @@ test_expect_success 'merge of identical changes in a renamed file' '
 	GIT_MERGE_VERBOSITY=3 git merge change+rename | grep "^Skipped B"
 '
 
+test_expect_success 'setup for rename + d/f conflicts' '
+	git reset --hard &&
+	git checkout --orphan dir-in-way &&
+	git rm -rf . &&
+
+	mkdir sub &&
+	mkdir dir &&
+	printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >sub/file &&
+	echo foo >dir/file-in-the-way &&
+	git add -A &&
+	git commit -m "Common commmit" &&
+
+	echo 11 >>sub/file &&
+	echo more >>dir/file-in-the-way &&
+	git add -u &&
+	git commit -m "Commit to merge, with dir in the way" &&
+
+	git checkout -b dir-not-in-way &&
+	git reset --soft HEAD^ &&
+	git rm -rf dir &&
+	git commit -m "Commit to merge, with dir removed" -- dir sub/file &&
+
+	git checkout -b renamed-file-has-no-conflicts dir-in-way~1 &&
+	git rm -rf dir &&
+	git rm sub/file &&
+	printf "1\n2\n3\n4\n5555\n6\n7\n8\n9\n10\n" >dir &&
+	git add dir &&
+	git commit -m "Independent change" &&
+
+	git checkout -b renamed-file-has-conflicts dir-in-way~1 &&
+	git rm -rf dir &&
+	git mv sub/file dir &&
+	echo 12 >>dir &&
+	git add dir &&
+	git commit -m "Conflicting change"
+'
+
+printf "1\n2\n3\n4\n5555\n6\n7\n8\n9\n10\n11\n" >expected
+
+test_expect_success 'Rename+D/F conflict; renamed file merges + dir not in way' '
+	git reset --hard &&
+	git checkout -q renamed-file-has-no-conflicts^0 &&
+	git merge --strategy=recursive dir-not-in-way &&
+	git diff --quiet &&
+	test -f dir &&
+	test_cmp expected dir
+'
+
+test_expect_failure 'Rename+D/F conflict; renamed file merges but dir in way' '
+	git reset --hard &&
+	rm -rf dir~* &&
+	git checkout -q renamed-file-has-no-conflicts^0 &&
+	test_must_fail git merge --strategy=recursive dir-in-way >output &&
+
+	grep "CONFLICT (delete/modify): dir/file-in-the-way" output &&
+	grep "Auto-merging dir" output &&
+	grep "Adding as dir~HEAD instead" output &&
+
+	test 2 = "$(git ls-files -u | wc -l)" &&
+	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+	test_must_fail git diff --cached --quiet &&
+
+	test -f dir/file-in-the-way &&
+	test -f dir~HEAD &&
+	test_cmp expected dir~HEAD
+'
+
+cat >expected <<\EOF &&
+1
+2
+3
+4
+5
+6
+7
+8
+9
+10
+<<<<<<< HEAD
+12
+=======
+11
+>>>>>>> dir-not-in-way
+EOF
+
+test_expect_failure 'Rename+D/F conflict; renamed file cannot merge, dir not in way' '
+	git reset --hard &&
+	rm -rf dir~* &&
+	git checkout -q renamed-file-has-conflicts^0 &&
+	test_must_fail git merge --strategy=recursive dir-not-in-way &&
+
+	test 3 = "$(git ls-files -u | wc -l)" &&
+	test 3 = "$(git ls-files -u dir | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+	test_must_fail git diff --cached --quiet &&
+
+	test -f dir &&
+	test_cmp expected dir
+'
+
+test_expect_failure 'Rename+D/F conflict; renamed file cannot merge and dir in the way' '
+	modify s/dir-not-in-way/dir-in-way/ expected &&
+
+	git reset --hard &&
+	rm -rf dir~* &&
+	git checkout -q renamed-file-has-conflicts^0 &&
+	test_must_fail git merge --strategy=recursive dir-in-way &&
+
+	test 5 = "$(git ls-files -u | wc -l)" &&
+	test 3 = "$(git ls-files -u dir | grep -v file-in-the-way | wc -l)" &&
+	test 2 = "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
+
+	test_must_fail git diff --quiet &&
+	test_must_fail git diff --cached --quiet &&
+
+	test -f dir/file-in-the-way &&
+	test -f dir~HEAD &&
+	test_cmp expected dir~HEAD
+'
+
 test_done
-- 
1.7.3.271.g16009
