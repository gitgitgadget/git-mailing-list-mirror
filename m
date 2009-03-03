From: pknotz@sandia.gov
Subject: [PATCH] Make git-clone respect branch.autosetuprebase
Date: Tue, 3 Mar 2009 11:35:52 -0700
Message-ID: <1236105352-21335-1-git-send-email-pknotz@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Pat Notz" <pknotz@sandia.gov>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 19:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeZUp-0000zm-3G
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 19:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbZCCSgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbZCCSgJ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 13:36:09 -0500
Received: from sentry-three.sandia.gov ([132.175.109.17]:51683 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbZCCSgI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 13:36:08 -0500
X-WSS-ID: 0KFY108-08-587-02
X-M-MSG: 
Received: from sentry.sandia.gov (mm03snlnto.sandia.gov [132.175.109.20])
	by sentry-three.sandia.gov (Tumbleweed MailGate 3.6.1) with ESMTP id 2645A8CAD25
	for <git@vger.kernel.org>; Tue,  3 Mar 2009 11:36:08 -0700 (MST)
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.2)); Tue, 03 Mar 2009 11:35:52 -0700
X-Server-Uuid: 6BFC7783-7E22-49B4-B610-66D6BE496C0E
Received: from mail.sandia.gov (cas2.sandia.gov [134.253.165.160]) by
 mailgate.sandia.gov (8.14.1/8.14.1) with ESMTP id n23IZqxJ012983 for
 <git@vger.kernel.org>; Tue, 3 Mar 2009 11:35:52 -0700
Received: from localhost.localdomain (134.253.246.168) by
 cas2.srn.sandia.gov (134.253.165.189) with Microsoft SMTP Server id
 8.1.340.0; Tue, 3 Mar 2009 11:35:52 -0700
X-Mailer: git-send-email 1.6.1.2
X-TMWD-Spam-Summary: TS=20090303183554; ID=1; SEV=2.3.1;
 DFV=B2009030314; IFV=NA; AIF=B2009030314; RPD=5.03.0010; ENG=NA;
 RPDID=7374723D303030312E30413031303230372E34394144373838422E303032463A534346535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE; SIG=AAAAAAAAAAAAAAAAAAAAAAAAfQ==
X-MMS-Spam-Filter-ID: B2009030314_5.03.0010
X-WSS-ID: 65B3A7023BW730188-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112144>

From: Pat Notz <pknotz@sandia.gov>

When git-clone creates an initial branch it was not
checking the branch.autosetuprebase configuration
option (which may exist in ~/.gitconfig).

Signed-off-by: Pat Notz <pknotz@sandia.gov>
---
 builtin-clone.c  |    8 ++++++++
 t/t5601-clone.sh |   14 ++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index c338910..f547267 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -360,6 +360,14 @@ static void install_branch_config(const char *local,
 	strbuf_reset(&key);
 	strbuf_addf(&key, "branch.%s.merge", local);
 	git_config_set(key.buf, remote);
+	switch (autorebase) {
+	case AUTOREBASE_REMOTE:
+	case AUTOREBASE_ALWAYS:
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.rebase", local);
+		git_config_set(key.buf, "true");
+		printf("Default branch '%s' will rebase on pull.\n", local);
+	}
 	strbuf_release(&key);
 }
 
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 44793f2..0f8b43c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -159,4 +159,18 @@ test_expect_success 'clone a void' '
 	test_cmp target-6/.git/config target-7/.git/config
 '
 
+test_expect_success 'clone respects global branch.autosetuprebase' '
+	HOME="`pwd`" &&
+	export HOME &&
+	test_config="$HOME"/.gitconfig &&
+	unset GIT_CONFIG_NOGLOBAL &&
+	git config -f "$test_config" branch.autosetuprebase remote &&
+	rm -fr dst &&
+	git clone src dst &&
+	cd dst &&
+	expected="ztrue" &&
+	actual="z$(git config branch.master.rebase)" &&
+	test $expected = $actual
+'
+
 test_done
-- 
1.6.1.2
