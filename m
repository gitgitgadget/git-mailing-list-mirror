From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/4] remote-hg: add more tests
Date: Sat,  3 May 2014 21:16:51 -0500
Message-ID: <1399169814-20201-2-git-send-email-felipe.contreras@gmail.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 04:27:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgm9k-0005zA-3i
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 04:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbaEDC1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 22:27:39 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:58862 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468AbaEDC1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 22:27:38 -0400
Received: by mail-oa0-f43.google.com with SMTP id eb12so7010963oac.16
        for <git@vger.kernel.org>; Sat, 03 May 2014 19:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q+QlJNFUFPEAuUvN4fjpgKJolH3uvmYOm/y0Dh4e/K0=;
        b=dZ/JAUnL46t4zl+dFAOhY3tOOFQKTnqXL5OYH35Buyed0q3ICVC+5r+Wi1EAAdCgib
         +L3HY4gZ9gYYEmVer+TqYetU7n8G4vH0efK+xYAvHpULUEnnMGrgsWXbO2e5WxoG51iR
         amarjKymO32fD1ufDgcEKXLkFpmDN/n7JYbmskCJ+yYL+sGUQvf8+auL8s1YMeFz+uYM
         oP9Xc0C4hruADotN0yAttaEGO6YB8v8t4sPU5ChYjTtp80KRQjoiJUIncAhpRh44ho8X
         j/O9JECndiAjSB+HADnBiNHvy7FZa2ALP5EcPfS1RBepANwWp7fRsdk1ADME+v6DllSU
         GuxQ==
X-Received: by 10.60.37.99 with SMTP id x3mr25538353oej.2.1399170457723;
        Sat, 03 May 2014 19:27:37 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id js4sm17530409oeb.3.2014.05.03.19.27.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 19:27:36 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
In-Reply-To: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248067>

Inspired by the tests in gitifyhg.

One test is failing, but that's because of a limitation of
remote-helpers.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 150 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 7d90056..33a434d 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -845,4 +845,154 @@ test_expect_success 'clone remote with generic null bookmark, then push to the b
 	)
 '
 
+test_expect_success 'notes' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo one > content &&
+	hg add content &&
+	hg commit -m one &&
+	echo two > content &&
+	hg commit -m two
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+	hg -R hgrepo log --template "{node}\n\n" > expected &&
+	git --git-dir=gitrepo/.git log --pretty="tformat:%N" --notes=hg > actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'push updates notes' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo one > content &&
+	hg add content &&
+	hg commit -m one
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(
+	cd gitrepo &&
+	echo two > content &&
+	git commit -a -m two
+	git push
+	) &&
+
+	hg -R hgrepo log --template "{node}\n\n" > expected &&
+	git --git-dir=gitrepo/.git log --pretty="tformat:%N" --notes=hg > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'pull tags' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo one > content &&
+	hg add content &&
+	hg commit -m one
+	) &&
+
+	git clone "hg::hgrepo" gitrepo &&
+
+	(cd hgrepo && hg tag v1.0) &&
+	(cd gitrepo && git pull) &&
+
+	echo "v1.0" > expected &&
+	git --git-dir=gitrepo/.git tag > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'push merged named branch' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo one > content &&
+	hg add content &&
+	hg commit -m one &&
+	hg branch feature &&
+	echo two > content &&
+	hg commit -m two &&
+	hg update default &&
+	echo three > content &&
+	hg commit -m three
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git merge -m Merge -Xtheirs origin/branches/feature &&
+	git push
+	) &&
+
+	cat > expected <<-EOF
+	Merge
+	three
+	two
+	one
+	EOF
+	hg -R hgrepo log --template "{desc}\n" > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'light tag sets author' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo one > content &&
+	hg add content &&
+	hg commit -m one
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git tag v1.0 &&
+	git push --tags
+	) &&
+
+	echo "C O Mitter <committer@example.com>" > expected &&
+	hg -R hgrepo log --template "{author}\n" -r tip > actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'push tag different branch' '
+	test_when_finished "rm -rf hgrepo gitrepo" &&
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+	echo one > content &&
+	hg add content &&
+	hg commit -m one
+	hg branch feature &&
+	echo two > content &&
+	hg commit -m two
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git branch &&
+	git checkout branches/feature &&
+	git tag v1.0 &&
+	git push --tags
+	) &&
+
+	echo feature > expected &&
+	hg -R hgrepo log --template="{branch}\n" -r tip > actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.9.2+fc1.20.g204a630
