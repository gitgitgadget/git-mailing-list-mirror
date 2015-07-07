From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 09/12] t4150: am with post-applypatch hook
Date: Tue,  7 Jul 2015 22:08:31 +0800
Message-ID: <1436278114-28057-10-git-send-email-pyokagan@gmail.com>
References: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 16:10:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCTZJ-000610-B2
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 16:09:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757800AbbGGOJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 10:09:20 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36817 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757628AbbGGOJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 10:09:13 -0400
Received: by pacgz10 with SMTP id gz10so40282200pac.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Se0qZ0CndlSh4tZkVRGs7fHnQH/0GWrwFCFBQD/bkZ4=;
        b=xmujyEFu1xxTTcQ8+cPPrPHOSj47Ia9YekrVhOsw5fm72AOJxZn+rPOTEQQQG+Xhci
         nFhRt+BzfJpPPoIg5gTAiFYLK42GTCKvV2m5zLVQ7Mr9vSd+T/sypEadKShEiUfRoSYY
         XzNBiWdVr9gotvzuSDR0HfkbDpWNbFjdXcgEFyIQJi9qxwI6c5+w2B8ktFpErrJqeohM
         zfdmO+Q4dNMJrSKzpfp9Moc0LaYEgqMwpg/ilJ1h8tnHpcbPsfa8BBq0U3yFMEowrZGd
         ZSNGaMpcpDfmJvqch2D4rzUF6Cp4wQ1nGgxO35NNNnXDss5TgLEWt05P97nkSLXwGpqk
         lSNQ==
X-Received: by 10.70.100.168 with SMTP id ez8mr9230198pdb.129.1436278153209;
        Tue, 07 Jul 2015 07:09:13 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id im7sm22004766pbc.25.2015.07.07.07.09.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 07:09:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.76.gf60a929
In-Reply-To: <1436278114-28057-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273515>

Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07),
git-am.sh will invoke the post-applypatch hook after the patch is
applied and a commit is made. The exit code of the hook is ignored.

Add tests for this hook.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

Notes:
    v2
    
    * use write_script() to shave off the shebang line and chmod

 t/t4150-am.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 957c63c..7494240 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -267,6 +267,44 @@ test_expect_success 'am with failing pre-applypatch hook' '
 	test_cmp_rev first HEAD
 '
 
+test_expect_success 'am with post-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/post-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-applypatch <<-\EOF &&
+	git rev-parse HEAD >head.actual
+	git diff second >diff.actual
+	exit 0
+	EOF
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	test_cmp_rev second HEAD &&
+	git rev-parse second >head.expected &&
+	test_cmp head.expected head.actual &&
+	git diff second >diff.expected &&
+	test_cmp diff.expected diff.actual
+'
+
+test_expect_success 'am with failing post-applypatch hook' '
+	test_when_finished "rm -f .git/hooks/post-applypatch" &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	mkdir -p .git/hooks &&
+	write_script .git/hooks/post-applypatch <<-\EOF &&
+	git rev-parse HEAD >head.actual
+	exit 1
+	EOF
+	git am patch1 &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test_cmp_rev second HEAD &&
+	git rev-parse second >head.expected &&
+	test_cmp head.expected head.actual
+'
+
 test_expect_success 'setup: new author and committer' '
 	GIT_AUTHOR_NAME="Another Thor" &&
 	GIT_AUTHOR_EMAIL="a.thor@example.com" &&
-- 
2.5.0.rc1.76.gf60a929
