From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Tue, 24 Mar 2015 13:20:29 +0800
Message-ID: <1427174429-5876-3-git-send-email-pyokagan@gmail.com>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 06:22:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaHHz-0002xZ-VZ
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 06:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbbCXFWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 01:22:00 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35559 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbbCXFVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 01:21:54 -0400
Received: by pagv19 with SMTP id v19so39277352pag.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 22:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6f7Ia6TJFaqfbNS3RpDbq5BU6Bd91tcWsruPb5IJI+o=;
        b=CeLwIMoLyjwJh1bfHwNPjfuecOT3GvCPWgfDBUJNLB7EE26VlNcarGatEMhZyUjE7n
         ltpCKF/70v/hRv5CoWnETHwDEXHd2+vpDWhO9AMMPxnA8NH1u+Ibv2LrwiyHtdpjgSe2
         4oyFEc6SFJMpokkKhmVM3UT+M1ZTpzPXMJmOqUwd+iUe6iYblTvmvSarqIq6sdCbtl7z
         m/07gnh0AoDwo4Nvj03n0HmcP3gYIxA44TIPNOB2HBe3e3GaRFopcONE4X2jZLUNZCjp
         HV/tO/cGfrUjgMqXiLGV++PXpjAYpKx5NKH7ypuzRVM+qzpUITyw9JrqIkZHatBtUGUn
         xAVg==
X-Received: by 10.68.201.10 with SMTP id jw10mr4425104pbc.25.1427174513988;
        Mon, 23 Mar 2015 22:21:53 -0700 (PDT)
Received: from yoshi.chippynet.com ([116.86.172.217])
        by mx.google.com with ESMTPSA id dk3sm2650967pbb.91.2015.03.23.22.21.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2015 22:21:51 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YaHHg-0001e6-EY; Tue, 24 Mar 2015 13:21:48 +0800
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266177>

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

[1] http://thread.gmane.org/gmane.comp.version-control.git/265683/focus=265684

The changes are as follows:

* Fix broken && chains

* Rewrite test descriptions to be shorter

* Code formatting

* Fixed test "get: return credentials from home file if xdg files are
unreadable". It should actually be the reverse to follow the actual
precedence order.

Thanks Eric and Matthieu for the code review.

Matthieu and Eric: I know I said I will try to re-order the patches to
put the tests before the implementation, but after thinking and trying
to rewrite the commit messages I realised it seems really weird to me.
In this patch series, the implementation is split across the first two
patches. The first patch should use the old tests, and ideally, the new
tests should be squashed with the second patch because it seems more
logical to me to implement the tests at the same time as the new
feature. However, since the tests patch is very long, to make it easier
to review it is split into a separate patch which is applied after the
implementation patches.

 t/t0302-credential-store.sh | 114 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index f61b40c..4e1f8ec 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -6,4 +6,118 @@ test_description='credential-store tests'
 
 helper_test store
 
+test_expect_success 'when xdg file does not exist, xdg file not created' '
+	test_path_is_missing "$HOME/.config/git/credentials" &&
+	test -s "$HOME/.git-credentials"
+'
+
+test_expect_success 'setup xdg file' '
+	rm -f "$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
+	>"$HOME/.config/git/credentials"
+'
+
+helper_test store
+
+test_expect_success 'when xdg file exists, home file not created' '
+	test -s "$HOME/.config/git/credentials" &&
+	test_path_is_missing "$HOME/.git-credentials"
+'
+
+test_expect_success 'setup custom xdg file' '
+	rm -f "$HOME/.git-credentials" &&
+	rm -f "$HOME/.config/git/credentials" &&
+	mkdir -p "$HOME/xdg/git" &&
+	>"$HOME/xdg/git/credentials"
+'
+
+XDG_CONFIG_HOME="$HOME/xdg"
+export XDG_CONFIG_HOME
+helper_test store
+unset XDG_CONFIG_HOME
+
+test_expect_success 'if custom xdg file exists, home and xdg files not created' '
+	test_when_finished "rm -f $HOME/xdg/git/credentials" &&
+	test -s "$HOME/xdg/git/credentials" &&
+	test_path_is_missing "$HOME/.git-credentials" &&
+	test_path_is_missing "$HOME/.config/git/credentials"
+'
+
+test_expect_success 'get: use home file if both home and xdg files have matches' '
+	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
+	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
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
+test_expect_success 'get: use xdg file if home file has no matches' '
+	>"$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
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
+test_expect_success 'get: use xdg file if home file is unreadable' '
+	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
+	chmod -r "$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
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
+test_expect_success 'store: if both xdg and home files exist, only store in home file' '
+	>"$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
+	>"$HOME/.config/git/credentials" &&
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
+	echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
+	mkdir -p "$HOME/.config/git" &&
+	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
+	check reject store <<-\EOF &&
+	protocol=https
+	host=example.com
+	EOF
+	test_must_be_empty "$HOME/.git-credentials" &&
+	test_must_be_empty "$HOME/.config/git/credentials"
+'
+
 test_done
-- 
2.1.4
