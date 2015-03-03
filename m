From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/2] tests: test credential-store XDG support
Date: Wed,  4 Mar 2015 04:24:59 +0800
Message-ID: <1425414299-24000-3-git-send-email-pyokagan@gmail.com>
References: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
Cc: Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 21:28:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStQl-0002PU-99
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbbCCU2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:28:33 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35448 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624AbbCCU2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:28:33 -0500
Received: by pdbfp1 with SMTP id fp1so138994pdb.2
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 12:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lbvd/+clkSoFWdooMFy78htHXixLRfBRFqzIopPtNMY=;
        b=BphkZu12xIbMYejOQPVzi2rBTTKfIRHj/2gTJhGkG666pl7TPmVcAM03P87f+Z/6V1
         C/hChtdMuDrAa1CHXPHFHg2bx6TQwztb2u3K8SQtenihGTMWQl/lX7hPxvVO/QWkOubD
         aheni0ZM65oeJDzpFCqCZyxaYkNWDEZcyoBthrKfvHXB5indxS7ezM1BB+rmhi/bOBlC
         HbSQwIboxW6j6dVJbbvnzRLFAqSwmJEwoLEK7K2g1OMjUEYE8+xpaNIQ54pFyGJSX+sW
         h8UNgSGGTrRIQxKJJSNicdOlmWDcM5d2SlDJkLXesilOofeNaXmq0wl8E/FARDOHbnqn
         QUJA==
X-Received: by 10.67.23.101 with SMTP id hz5mr863833pad.47.1425414512523;
        Tue, 03 Mar 2015 12:28:32 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id kd6sm1821309pbb.40.2015.03.03.12.28.30
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2015 12:28:31 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YStQa-0007RG-Q7; Wed, 04 Mar 2015 04:28:28 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425414299-24000-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264683>

* "helper_test store" is run for when $XDG_CONFIG_HOME/git/credentials
  exists and ~/.git-credentials does not and the other way around.
* Test that credentials are stored in XDG file if both XDG and HOME
  files exist.
* Test that credentials from XDG file are used if matching credentials
  are found in both XDG and HOME files.
* Test that credentials from HOME file are used if a matching credential
  could not be found in the XDG file.
* Test that when erasing credentials, matching credentials in both the
  XDG and HOME files are erase.d

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t0302-credential-store.sh | 74 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index f61b40c..80893b9 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -4,6 +4,80 @@ test_description='credential-store tests'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-credential.sh
 
+# Tests for when ~/.git-credentials exists but
+# $XDG_CONFIG_HOME/git/credentials does not
 helper_test store
+test_expect_success '~/.git-credentials is written to when XDG git-credentials does not exist' '
+	test -s "$HOME/.git-credentials"
+'
+test_expect_success 'XDG credentials will not be created if it does not exist' '
+	test ! -e "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
+'
+
+# Tests for when $XDG_CONFIG_HOME/git/credentials exists but
+# ~/.git-credentials does not.
+rm "$HOME/.git-credentials"
+mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/git"
+echo '' > "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
+helper_test store
+test_expect_success '~/.git-credentials will not be created if XDG git-credentials exist' '
+	test ! -e "$HOME/.git-credentials"
+'
+test_expect_success 'XDG credentials will be written to if it exists' '
+	test -s "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
+'
+
+# Tests for when both $XDG_CONFIG_HOME/git/credentials and
+# ~/.git-credentials exists.
+echo '' > "$HOME/.git-credentials"
+echo '' > "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
+test_expect_success 'Credentials are stored in XDG file if both XDG and HOME files exist' '
+	check approve store <<-\EOF
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	read contents < "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
+	test ! -z "$contents"
+	read contents < "$HOME/.git-credentials"
+	test -z "$contents"
+'
+test_expect_success 'Credentials from XDG file are used if the credentials exist in both XDG and HOME files' '
+	echo "https://baduser:badpass@example.com" > "$HOME/.git-credentials"
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	--
+	EOF
+'
+test_expect_success 'Credentials from HOME file are used if the XDG files does not have them' '
+	echo "" > "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=baduser
+	password=badpass
+	--
+	EOF
+'
+test_expect_success 'Credentials from both XDG and HOME files meeting the criteria are erased' '
+	check reject $HELPER <<-\EOF &&
+	protocol=https
+	host=example.com
+	EOF
+	read contents < "${XDG_CONFIG_HOME:-$HOME/.config}/git/credentials"
+	test -z "$contents"
+	read contents < "$HOME/.git-credentials"
+	test -z "$contents"
+'
 
 test_done
-- 
2.1.4
