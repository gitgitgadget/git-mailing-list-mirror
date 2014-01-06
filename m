From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] mv: better document side effects when moving a submodule
Date: Mon, 06 Jan 2014 20:21:32 +0100
Message-ID: <52CB023C.2050001@web.de>
References: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com> <52A602A2.6060909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: George Papanikolaou <g3orge.app@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 20:21:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0Fk7-0007X2-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 20:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892AbaAFTVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 14:21:40 -0500
Received: from mout.web.de ([212.227.15.14]:53619 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755124AbaAFTVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 14:21:39 -0500
Received: from [192.168.178.41] ([84.132.177.45]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0Lsvn8-1VFklv32Og-012Vt5 for <git@vger.kernel.org>;
 Mon, 06 Jan 2014 20:21:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52A602A2.6060909@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:SPzzrVAse2hsyVkNscBURyx1TFi8YhHSyZzPhjFG6fzbphVf6hm
 8bckfzzoOrhXmEeSd1aKN9lOcawEO4pH6p/jyaLOFQ8NfPxfCvkBsRYw0bZv9tYMbpuMQnP
 PJy2IFLRrJReA7maK7xsFP80FokiJStnQaoM6fYFvvHXZ8sMW1Icrt0KZAdsIAGauLQSrJS
 tff80itHRsdPBv/hpKZaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240051>

The "Submodules" section of the "git mv" documentation mentions what will
happen when a submodule with a gitfile gets moved with newer git. But it
doesn't talk about what happens when the user changes between commits
before and after the move, which does not update the work tree like using
the mv command did the first time.

Explain what happens and what the user has to do manually to fix that.
Also document this in a new test.

Reported-by: George Papanikolaou <g3orge.app@gmail.com>
Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 09.12.2013 18:49, schrieb Jens Lehmann:
> Am 09.12.2013 11:59, schrieb George Papanikolaou:
>> Also after mv you need to run 'submodule update' and I think this should be
>> documented somewhere.
> 
> You're right, this should be mentioned in the mv man page. I'll
> prepare a patch for that.

Does this new paragraph make it clearer?


 Documentation/git-mv.txt | 10 ++++++++++
 t/t7001-mv.sh            | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index b1f7988..c9e8568 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -52,6 +52,16 @@ core.worktree setting to make the submodule work in the new location.
 It also will attempt to update the submodule.<name>.path setting in
 the linkgit:gitmodules[5] file and stage that file (unless -n is used).

+Please note that each time a superproject update moves a populated
+submodule (e.g. when switching between commits before and after the
+move) a stale submodule checkout will remain in the old location
+and an empty directory will appear in the new location. To populate
+the submodule again in the new location the user will have to run
+"git submodule update" afterwards. Removing the old directory is
+only safe when it uses a gitfile, as otherwise the history of the
+submodule will be deleted too. Both steps will be obsolete when
+recursive submodule update has been implemented.
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
1.8.5.2.230.g9325930
