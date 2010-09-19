From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 1/3] add rebase patch id tests
Date: Sun, 19 Sep 2010 11:59:27 +0200
Message-ID: <1284890369-4136-2-git-send-email-drizzd@aon.at>
References: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Cc: gitster@pobox.com, Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 11:59:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxGgM-0005V2-S7
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 11:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab0ISJ7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 05:59:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44960 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab0ISJ7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 05:59:18 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so3701062bwz.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3hxGsXUSSozYGxfN1WOEKQcuP4oWAsxWtFWBMDzF7jM=;
        b=WFXBBn2ovCpPnDHUzQA60J2Wncf9DVo4xmQgk9XRzLkRN1hk6SMLksFXEEv0s8X2On
         Yt7dOCJTdQ7hsV3Ob8IrNO0UjvQ93/fNJtKFH89LocCnk8+Fzgu/bePWw4lYbXiXe+o0
         AgsfvZ4Ou4fGRIv1WlLoUGAV4uBB9sMMaM7cM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=Hgu6dxfs0ykwrxF3DW9+gAVRgCaC7NwEVlyZYKUPjEMnefGgGkWvNF8xwDk/KL9xln
         V0RsNpeClfMpkkQojIKpvrZlzUFPz+oBlnO/h8kiC/hH3VANQ7a60W/449HpkFAnhYWp
         HKRTB32hwJuxxquJ7yuPvKztq6+tJKtDhQefM=
Received: by 10.204.119.134 with SMTP id z6mr5436591bkq.193.1284890358013;
        Sun, 19 Sep 2010 02:59:18 -0700 (PDT)
Received: from darc.lan (p549A467A.dip.t-dialin.net [84.154.70.122])
        by mx.google.com with ESMTPS id g12sm5428428bkb.14.2010.09.19.02.59.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Sep 2010 02:59:17 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OxGgm-00015T-05; Sun, 19 Sep 2010 12:00:04 +0200
X-Mailer: git-send-email 1.7.1.571.gba4d01
In-Reply-To: <1284890369-4136-1-git-send-email-drizzd@aon.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156491>


Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 t/t3419-rebase-patch-id.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100755 t/t3419-rebase-patch-id.sh

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
new file mode 100755
index 0000000..1aee483
--- /dev/null
+++ b/t/t3419-rebase-patch-id.sh
@@ -0,0 +1,109 @@
+#!/bin/bash
+
+test_description='git rebase - test patch id computation'
+
+. ./test-lib.sh
+
+test_set_prereq NOT_EXPENSIVE
+test -n "$GIT_PATCHID_TIMING_TESTS" && test_set_prereq EXPENSIVE
+test -x /usr/bin/time && test_set_prereq USR_BIN_TIME
+
+count()
+{
+	i=0
+	while test $i -lt $1
+	do
+		echo "$i"
+		i=$(($i+1))
+	done
+}
+
+scramble()
+{
+	i=0
+	while read x
+	do
+		if test $i -ne 0
+		then
+			echo "$x"
+		fi
+		i=$(((i+1) % 10))
+	done < "$1" > "$1.new"
+	mv -f "$1.new" "$1"
+}
+
+run()
+{
+	echo \$ "$@"
+	/usr/bin/time "$@" >/dev/null
+}
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m initial
+	git tag root
+'
+
+do_tests()
+{
+	pr=$1
+	nlines=$2
+
+	test_expect_success $pr "setup: $nlines lines" "
+		rm -f .gitattributes &&
+		git checkout -q -f master &&
+		git reset --hard root &&
+		count $nlines >file &&
+		git add file &&
+		git commit -q -m initial &&
+		git branch -f other &&
+
+		scramble file &&
+		git add file &&
+		git commit -q -m 'change big file' &&
+
+		git checkout -q other &&
+		: >newfile &&
+		git add newfile &&
+		git commit -q -m 'add small file' &&
+
+		git cherry-pick master >/dev/null 2>&1
+	"
+
+	test_debug "
+		run git diff master^\!
+	"
+
+	test_expect_success $pr 'setup attributes' "
+		echo 'file binary' >.gitattributes
+	"
+
+	test_debug "
+		run git format-patch --stdout master &&
+		run git format-patch --stdout --ignore-if-in-upstream master
+	"
+
+	test_expect_success $pr 'detect upstream patch' "
+		git checkout -q master &&
+		scramble file &&
+		git add file &&
+		git commit -q -m 'change big file again' &&
+		git checkout -q other^{} &&
+		git rebase master &&
+		test_must_fail test -n \"\$(git rev-list master...HEAD~)\"
+	"
+
+	test_expect_success $pr 'do not drop patch' "
+		git branch -f squashed master &&
+		git checkout -q -f squashed &&
+		git reset -q --soft HEAD~2 &&
+		git commit -q -m squashed &&
+		git checkout -q other^{} &&
+		test_must_fail git rebase squashed &&
+		rm -rf .git/rebase-apply
+	"
+}
+
+do_tests NOT_EXPENSIVE 500
+do_tests EXPENSIVE 50000
+
+test_done
-- 
1.7.1.571.gba4d01
