From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 11 Mar 2015 14:49:13 +0800
Message-ID: <1426056553-9364-5-git-send-email-pyokagan@gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 07:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVaTm-0007mc-2T
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 07:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbbCKGum (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 02:50:42 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34250 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbCKGuf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 02:50:35 -0400
Received: by paceu11 with SMTP id eu11so8977119pac.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W2i8P3jTrOupNsPmOiDhvg8cDjxp4thZtN8cQQ6BVoQ=;
        b=aL6TeHWO3MhM9obtlDC5kVeUsFODOqnNwkvjZlM/sWqS4m7KOFb8jryizX5a6mdIYS
         Ape1W3HU/UcCQK+EKgsxR+lx+Lt1YpmL21yAK3N9+a4f1B2xv+JMN0QXKxwtBnsRQTrs
         gN773w1XCBVy2WjKaoTIITw2alzs8SUo+yO9bL3RecT/Vp1jo2v2L/CMVSUwpLCiWQuL
         yEyXPB0WCXzYPxCFLeGf/++4EzN2HLnr2yHXOJn7eoopXnhvvwo1e+VJkHOsqanOFRg/
         RpjxS5QcdtARC/CCqA+HdkLBPQa+siFJfhPGsU0cgjIBQ+q72C9kGT07dJpuEobXQfa+
         p6KA==
X-Received: by 10.70.136.202 with SMTP id qc10mr73623678pdb.117.1426056634474;
        Tue, 10 Mar 2015 23:50:34 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id sg4sm4307985pac.11.2015.03.10.23.50.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 23:50:32 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YVaTO-0002ek-07; Wed, 11 Mar 2015 14:50:30 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265307>

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

The previous version can be found at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/265042/focus=265041

The changes are as follows:

* Corrected code style violations: All tests are now separated by newlines.

* After $XDG_CONFIG_HOME is set to "$HOME/xdg", use $XDG_CONFIG_HOME directly
for all paths instead of "$HOME/xdg".

Thanks Matthieu for the code review.

 t/t0302-credential-store.sh | 107 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index f61b40c..34752ea 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -6,4 +6,111 @@ test_description='credential-store tests'
 
 helper_test store
 
+test_expect_success '~/.git-credentials is written to when xdg credentials file does not exist' '
+	test -s "$HOME/.git-credentials"
+'
+
+test_expect_success 'xdg credentials file will not be created if it does not exist' '
+	test_path_is_missing "$HOME/.config/git/credentials"
+'
+
+test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '
+	test_might_fail rm "$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
+	>"$HOME/.config/git/credentials"
+'
+
+helper_test store
+
+test_expect_success 'xdg credentials file will be written to if it exists' '
+	test -s "$HOME/.config/git/credentials"
+'
+
+test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
+	test_path_is_missing "$HOME/.git-credentials"
+'
+
+test_expect_success 'set up custom XDG_CONFIG_HOME credential file' '
+	XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME &&
+	mkdir -p "$XDG_CONFIG_HOME/git" &&
+	>"$XDG_CONFIG_HOME/git/credentials" &&
+	>"$HOME/.config/git/credentials"
+'
+
+helper_test store
+
+test_expect_success 'custom XDG_CONFIG_HOME credentials file will be written to if it exists' '
+	test_when_finished "unset XDG_CONFIG_HOME" &&
+	test -s "$XDG_CONFIG_HOME/git/credentials"
+'
+
+test_expect_success '~/.config/git/credentials file will not be written to if a custom XDG_CONFIG_HOME is set' '
+	test_must_be_empty "$HOME/.config/git/credentials"
+'
+
+test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
+	test_path_is_missing "$HOME/.git-credentials"
+'
+
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
+
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
+
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
+
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
+
 test_done
-- 
2.1.4
