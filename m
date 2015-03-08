From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Sun,  8 Mar 2015 15:58:52 +0800
Message-ID: <1425801532-8483-5-git-send-email-pyokagan@gmail.com>
References: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 08 08:59:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUW7H-0000iO-Np
	for gcvg-git-2@plane.gmane.org; Sun, 08 Mar 2015 08:59:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbCHH7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2015 03:59:09 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35863 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbbCHH7D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2015 03:59:03 -0400
Received: by padfa1 with SMTP id fa1so57962062pad.3
        for <git@vger.kernel.org>; Sat, 07 Mar 2015 23:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wpii1ijSSa/qrNlCY3OGt0IHYb/r8hch07h+YBDsSJQ=;
        b=Itaj+8S2ATMLgmKICgaDPA5znKWQiFI3I2Rj8vDF4d9568Z6XeM+dVoTSHFYqSNL9J
         UJUgpW1uKYjMhM+weEDi1tCnck3uthEPI5r5Pa7ceiyXGRYivF5e3CFOgezB6hcOXazd
         kxh2YhxNCsUf3tPh/XOkEJ9rDZqWL4B4hAx/SEU8ZZahGuMtWBeHPh+0yIg90kFqkWsd
         vqEPQ7QTamLPBkyn58kIgTfVfyyx2BmrfbSGd/MTfzPPUio+iehuZOnGNCD0F6pXRUnM
         YuMKrqkVBVLjqdkmwHCxim+YolKtz4kA/+QFCXo4ez1FECfLAeNKELH6saV0cFukgALL
         60yg==
X-Received: by 10.66.119.193 with SMTP id kw1mr41362765pab.64.1425801542820;
        Sat, 07 Mar 2015 23:59:02 -0800 (PST)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id ek7sm3547426pdb.44.2015.03.07.23.58.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Mar 2015 23:59:00 -0800 (PST)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YUW6z-0002E9-F6; Sun, 08 Mar 2015 15:58:57 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1425801532-8483-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265041>

t0302 now tests git-credential-store's support for the XDG user-specific
configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:

* Ensure that the XDG file is strictly opt-in. It should not be created
  by git at all times if it does not exist.

* On the flip side, if the XDG file exists, ~/.git-credentials should
  not be created at all times.

* If both the XDG file and ~/.git-credentials exists, then both files
  should be used for credential lookups. However, credentials should
  only be written to ~/.git-credentials.

* Credentials must be erased from both files.

* $XDG_CONFIG_HOME can be a custom directory set by the user as per the
  XDG base directory specification. Test that git-credential-store
  respects that, but defaults to "~/.config/git/credentials" if it does
  not exist or is empty.

Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 t/t0302-credential-store.sh | 92 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index f61b40c..7fe832d 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -5,5 +5,97 @@ test_description='credential-store tests'
 . "$TEST_DIRECTORY"/lib-credential.sh
 
 helper_test store
+test_expect_success '~/.git-credentials is written to when xdg credentials file does not exist' '
+	test -s "$HOME/.git-credentials"
+'
+test_expect_success 'xdg credentials file will not be created if it does not exist' '
+	test_path_is_missing "$HOME/.config/git/credentials"
+'
+test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '
+	test_might_fail rm "$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
+	>"$HOME/.config/git/credentials"
+'
+helper_test store
+test_expect_success 'xdg credentials file will be written to if it exists' '
+	test -s "$HOME/.config/git/credentials"
+'
+test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
+	test_path_is_missing "$HOME/.git-credentials"
+'
+test_expect_success 'set up custom XDG_CONFIG_HOME credential file' '
+	XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME &&
+	mkdir -p "$HOME/xdg/git" &&
+	>"$HOME/xdg/git/credentials" &&
+	>"$HOME/.config/git/credentials"
+'
+helper_test store
+test_expect_success 'custom XDG_CONFIG_HOME credentials file will be written to if it exists' '
+	unset XDG_CONFIG_HOME &&
+	test -s "$HOME/xdg/git/credentials"
+'
+test_expect_success '~/.config/git/credentials file will not be written to if a custom XDG_CONFIG_HOME is set' '
+	test_must_be_empty "$HOME/.config/git/credentials"
+'
+test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
+	test_path_is_missing "$HOME/.git-credentials"
+'
+test_expect_success 'get: return credentials from home file if matches are found in both home and xdg files' '
+	mkdir -p "$HOME/.config/git" &&
+	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
+	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=home-user
+	password=home-pass
+	--
+	EOF
+'
+test_expect_success 'get: return credentials from xdg file if the home files do not have them' '
+	mkdir -p "$HOME/.config/git" &&
+	>"$HOME/.git-credentials" &&
+	echo "https://home-user:home-pass@example.com" >"$HOME/.config/git/credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=home-user
+	password=home-pass
+	--
+	EOF
+'
+test_expect_success 'get: return credentials from home file if xdg files are unreadable' '
+	mkdir -p "$HOME/.config/git" &&
+	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
+	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
+	chmod -r "$HOME/.config/git/credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=home-user
+	password=home-pass
+	--
+	EOF
+'
+test_expect_success 'erase: erase matching credentials from both xdg and home files' '
+	mkdir -p "$HOME/.config/git" &&
+	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
+	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
+	check reject store <<-\EOF
+	protocol=https
+	host=example.com
+	EOF
+	test_must_be_empty "$HOME/.config/git/credentials" &&
+	test_must_be_empty "$HOME/.git-credentials"
+'
 
 test_done
-- 
2.1.4
