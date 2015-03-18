From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 4/4] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 18 Mar 2015 15:04:36 +0800
Message-ID: <1426662276-8728-4-git-send-email-pyokagan@gmail.com>
References: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 08:05:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY82v-0004Cx-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 08:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbbCRHFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 03:05:36 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36392 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbbCRHF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 03:05:28 -0400
Received: by padcy3 with SMTP id cy3so33870001pad.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 00:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pM5/lag8CdzTBXzPNSCKt3oktpMK23ssDP4bfZd4Rjg=;
        b=TyESEkOC3bjKA/eZa7DUbQvqZ+zxTv3tsH5PTikUjuIKkEBhGAtjVr4E+rVHusEeir
         ECbudO3zHDkO4Cr0KJ8Ba9z9rtxWs7Czu1T4FsDyPJb0z7Za1Ec+DptC2N/vCLptR9rn
         L3unfCMiUZzpJcphCtAI3dl5fLDgKyAKpbjBv5/TLYtRueg1rI1Gkp7SLzqFuexcgKnA
         Iora7R6WuffRMwVan/mDeDKQROEZFi8zVORTef7WROTCA2oid0NdCgm/6eFL/NYekVvy
         QK4Ci3YxqqmQcmhYvweAZFsUN4BKxZISahuSDvQI2GhEptVpSMN5vlv/D55Vr34yQJSr
         9rNA==
X-Received: by 10.66.63.7 with SMTP id c7mr160779401pas.13.1426662327895;
        Wed, 18 Mar 2015 00:05:27 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id fu14sm25824804pad.44.2015.03.18.00.05.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2015 00:05:24 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YY82c-0002MP-0o; Wed, 18 Mar 2015 15:05:22 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1426662276-8728-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265684>

t0302 now tests git-credential-store's support for the XDG user-specific
configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:

* Ensure that the XDG file is strictly opt-in. It should not be created
  by git at all times if it does not exist.

* Conversely, if the XDG file exists, ~/.git-credentials should
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
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Paul Tan <pyokagan@gmail.com>
---

The previous version can be found at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/265305/focus=265308

* Merge related, but previously separate, tests together in order to
  make the test suite easier to understand.

* Instead of setting/unsetting XDG_CONFIG_HOME in separate tests, set
  it, and unset it immediately before and after "helper_test store" is
  called in order to make it localized to only the command that it
  should affect.

* Add test, previously missing, to check that only the home credentials
  file is written to if both the xdg and home files exist.

* Correct mislabelling of "home-user"/"home-pass" to the proper
  "xdg-user"/"xdg-pass".

* Use "rm -f" instead of "test_might_fail rm".

Thanks Eric for the code review.

 t/t0302-credential-store.sh | 111 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index f61b40c..5b0a666 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -6,4 +6,115 @@ test_description='credential-store tests'
 
 helper_test store
 
+test_expect_success 'when xdg credentials file does not exist, only write to ~/.git-credentials; do not create xdg file' '
+	test -s "$HOME/.git-credentials" &&
+	test_path_is_missing "$HOME/.config/git/credentials"
+'
+
+test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '
+	rm -f "$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
+	>"$HOME/.config/git/credentials"
+'
+
+helper_test store
+
+test_expect_success 'when xdg credentials file exists, only write to xdg file; do not create ~/.git-credentials' '
+	test -s "$HOME/.config/git/credentials" &&
+	test_path_is_missing "$HOME/.git-credentials"
+'
+
+test_expect_success 'set up custom XDG_CONFIG_HOME credential file at ~/xdg/git/credentials' '
+	mkdir -p "$HOME/xdg/git" &&
+	rm -f "$HOME/.config/git/credentials" &&
+	>"$HOME/xdg/git/credentials"
+'
+
+XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME && helper_test store
+unset XDG_CONFIG_HOME
+
+test_expect_success 'if custom XDG_CONFIG_HOME credentials file ~/xdg/git/credentials exists, it will only be written to; ~/.config/git/credentials and ~/.git-credentials will not be created' '
+	test_when_finished "rm -f $HOME/xdg/git/credentials" &&
+	test -s "$HOME/xdg/git/credentials" &&
+	test_path_is_missing "$HOME/.config/git/credentials"
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
+	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
+	check fill store <<-\EOF
+	protocol=https
+	host=example.com
+	--
+	protocol=https
+	host=example.com
+	username=xdg-user
+	password=xdg-pass
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
+test_expect_success 'store: If both xdg and home files exist, only store in home file' '
+	mkdir -p "$HOME/.config/git" &&
+	>"$HOME/.config/git/credentials" &&
+	>"$HOME/.git-credentials" &&
+	check approve store <<-\EOF &&
+	protocol=https
+	host=example.com
+	username=store-user
+	password=store-pass
+	EOF
+	echo "https://store-user:store-pass@example.com" >expected &&
+	test_cmp expected "$HOME/.git-credentials" &&
+	test_must_be_empty "$HOME/.config/git/credentials"
+'
+
+
+test_expect_success 'erase: erase matching credentials from both xdg and home files' '
+	mkdir -p "$HOME/.config/git" &&
+	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
+	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
+	check reject store <<-\EOF &&
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
