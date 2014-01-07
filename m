From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 2/2] rm: better document side effects when removing a submodule
Date: Tue, 07 Jan 2014 22:32:37 +0100
Message-ID: <52CC7275.3040907@web.de>
References: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>	<52A602A2.6060909@web.de> <52CB023C.2050001@web.de> <xmqq8uushgz3.fsf@gitster.dls.corp.google.com> <52CC4021.60209@web.de> <52CC71E0.7010603@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:32:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0eGU-00014q-3i
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821AbaAGVcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:32:43 -0500
Received: from mout.web.de ([212.227.15.3]:61352 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753626AbaAGVcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:32:41 -0500
Received: from [192.168.178.41] ([84.132.139.6]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LgpYk-1VeBji2TDi-00oESZ for <git@vger.kernel.org>;
 Tue, 07 Jan 2014 22:32:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52CC71E0.7010603@web.de>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:N4eGXy3motiEaFUlJn0AUnrrwYmdNMXDnBWFGvF0JSi0i1kLLUJ
 S4GUjop0pu0RtRyZLwPJI1/yQR7iE0c3EcVTQINwEvH3PPoR2l2VpPR0NG3TjQpplmyQekw
 Ey3jFn1qK/cbz0OkleWJiOBzrfGRxKnN6vp8WuQULxwgdvomivxBZHyGkC5eck01DOqO5T7
 YAQqLtHnV64jcXaKgXr4A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240162>

The "Submodules" section of the "git rm" documentation mentions what will
happen when a submodule with a gitfile gets removed with newer git. But it
doesn't talk about what happens when the user changes between commits
before and after the removal, which does not remove the submodule from the
work tree like using the rm command did the first time.

Explain what happens and what the user has to do manually to fix that in
the new BUGS section. Also document this behavior in a new test.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 Documentation/git-rm.txt |  9 +++++++++
 t/t3600-rm.sh            | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 9d731b4..f1efc11 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -170,6 +170,15 @@ of files and subdirectories under the `Documentation/` directory.
 	(i.e. you are listing the files explicitly), it
 	does not remove `subdir/git-foo.sh`.

+BUGS
+----
+Each time a superproject update removes a populated submodule
+(e.g. when switching between commits before and after the removal) a
+stale submodule checkout will remain in the old location. Removing the
+old directory is only safe when it uses a gitfile, as otherwise the
+history of the submodule will be deleted too. This step will be
+obsolete when recursive submodule update has been implemented.
+
 SEE ALSO
 --------
 linkgit:git-add[1]
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 540c49b..3d30581 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -705,6 +705,22 @@ test_expect_success 'rm of a populated nested submodule with a nested .git direc
 	rm -rf submod
 '

+test_expect_success 'checking out a commit after submodule removal needs manual updates' '
+	git commit -m "submodule removal" submod &&
+	git checkout HEAD^ &&
+	git submodule update &&
+	git checkout -q HEAD^ 2>actual &&
+	git checkout -q master 2>actual &&
+	echo "warning: unable to rmdir submod: Directory not empty" >expected &&
+	test_i18ncmp expected actual &&
+	git status -s submod >actual &&
+	echo "?? submod/" >expected &&
+	test_cmp expected actual &&
+	rm -rf submod &&
+	git status -s -uno --ignore-submodules=none > actual &&
+	! test -s actual
+'
+
 test_expect_success 'rm of d/f when d has become a non-directory' '
 	rm -rf d &&
 	mkdir d &&
-- 
1.8.5.2.231.gfc86eb1
