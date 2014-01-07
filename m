From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 1/2] mv: better document side effects when moving a submodule
Date: Tue, 07 Jan 2014 22:31:32 +0100
Message-ID: <52CC7234.7090700@web.de>
References: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>	<52A602A2.6060909@web.de> <52CB023C.2050001@web.de> <xmqq8uushgz3.fsf@gitster.dls.corp.google.com> <52CC4021.60209@web.de> <52CC71E0.7010603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:31:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eFO-0006vi-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbaAGVbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:31:35 -0500
Received: from mout.web.de ([212.227.15.4]:62545 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114AbaAGVbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:31:34 -0500
Received: from [192.168.178.41] ([84.132.139.6]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LheZV-1Vf0nV3AEz-00mtzc for <git@vger.kernel.org>;
 Tue, 07 Jan 2014 22:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52CC71E0.7010603@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:07WLpVJ283e2bp7XmSArcKlhO0rWxnZH0aMbUF709W7UT6niQ0n
 14cICzvuh/tLjDDZZfvTSoXmESWHCpxcuhlDbTaJdlal18gALwpDX0KNMd1CeIt4S4lmG/a
 mWZBDZg3Fgp+23TJnL6VqyEpnmADZHjso3Y7ttqvQh/MQt0Loy5oaW2c6pdhWXfAje6fDos
 NoTj/4DNztWTuZzl3pj0A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240161>

The "Submodules" section of the "git mv" documentation mentions what will
happen when a submodule with a gitfile gets moved with newer git. But it
doesn't talk about what happens when the user changes between commits
before and after the move, which does not update the work tree like using
the mv command did the first time.

Explain what happens and what the user has to do manually to fix that in
the new BUGS section. Also document this behavior in a new test.

Reported-by: George Papanikolaou <g3orge.app@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-mv.txt | 12 ++++++++++++
 t/t7001-mv.sh            | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index b1f7988..e453132 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -52,6 +52,18 @@ core.worktree setting to make the submodule work in the new location.
 It also will attempt to update the submodule.<name>.path setting in
 the linkgit:gitmodules[5] file and stage that file (unless -n is used).

+BUGS
+----
+Each time a superproject update moves a populated submodule (e.g. when
+switching between commits before and after the move) a stale submodule
+checkout will remain in the old location and an empty directory will
+appear in the new location. To populate the submodule again in the new
+location the user will have to run "git submodule update"
+afterwards. Removing the old directory is only safe when it uses a
+gitfile, as otherwise the history of the submodule will be deleted
+too. Both steps will be obsolete when recursive submodule update has
+been implemented.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 3bfdfed..e3c8c2c 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -442,4 +442,25 @@ test_expect_success 'mv --dry-run does not touch the submodule or .gitmodules' '
 	git diff-files --quiet -- sub .gitmodules
 '

+test_expect_success 'checking out a commit before submodule moved needs manual updates' '
+	git mv sub sub2 &&
+	git commit -m "moved sub to sub2" &&
+	git checkout -q HEAD^ 2>actual &&
+	echo "warning: unable to rmdir sub2: Directory not empty" >expected &&
+	test_i18ncmp expected actual &&
+	git status -s sub2 >actual &&
+	echo "?? sub2/" >expected &&
+	test_cmp expected actual &&
+	! test -f sub/.git &&
+	test -f sub2/.git &&
+	git submodule update &&
+	test -f sub/.git &&
+	rm -rf sub2 &&
+	git diff-index --exit-code HEAD &&
+	git update-index --refresh &&
+	git diff-files --quiet -- sub .gitmodules &&
+	git status -s sub2 >actual &&
+	! test -s actual
+'
+
 test_done
-- 
1.8.5.2.231.gfc86eb1
