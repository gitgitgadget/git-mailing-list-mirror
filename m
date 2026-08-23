Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B323750BD
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 10:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481063; cv=none; b=lxF530h0HJmon5B8J4VmlJXs0ZEBptoWxOMOFp9ZVp1oyAw52/wtXySwxxEvgTf9AziW4MAzvfEo/27UZoHgm5s5QEdJC/5tol9R24w7cyQG8cJHo9q4Cq9rpbQqQ7bxfbLnXeTxljdk55geleuxLoLsAqRCKo2j7XQcrY4eC/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481063; c=relaxed/simple;
	bh=5vFKQVs9pOH1cYVBpnRN/M30FnQ/gJu3HuEnTIYFqB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s91IgE3NWUv6BmLffZqWXgH42EXhsD9XnXwtHBIejB6/7tWz5Xnc2e0iFhTLBmtqrWSfbWTRQ8l1NiivSiYF8zZudtwGMO2AHL7nI5gXSX6pq/8P2//jkhYryoGYE6m1WQcNBm4JQKqVtdTHv1ywN7EEWuAEEE7+SdTvbtA3zsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c8TnLPX1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c8TnLPX1"
Received: from [192.168.4.34] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C0A220B7167;
	Sun, 23 Aug 2026 03:30:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C0A220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787481023;
	bh=S5kQpmWBoEv+g6nO3dmgVQId7thOD4BhpPEbniFiexo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c8TnLPX140PGiUPFe3PaMpqyZ625dURrQ4Y2LARUOirajFyGPyAPVrCWcKNgSL0qx
	 7CRYDPlfIRVgyLRfmIOWnz/fr0pwUhSjEoPZhO7ADb1dLm8oiYiO8XTP9WJ9xAJ4Rq
	 RVwlNKrCMgEf7KC0ndxpDGUGO9pg1I/blfmPbRYM=
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Date: Sun, 23 Aug 2026 20:28:26 +1000
Subject: [PATCH v2 1/3] path: use forward slashes in XDG config on Windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-fix-config-list-global-home-and-xdg-v2-1-b29cc63f017b@microsoft.com>
References: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
In-Reply-To: <20260823-fix-config-list-global-home-and-xdg-v2-0-b29cc63f017b@microsoft.com>
To: git@vger.kernel.org
Cc: Nils Fahldieck <nils@fahldieck.de>, Patrick Steinhardt <ps@pks.im>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Delilah Ashley Wu <delilahwu@microsoft.com>, 
 Derrick Stolee <stolee@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

From: Delilah Ashley Wu <delilahwu@microsoft.com>

Git prefers forward slashes as directory separators across all
platforms. On Windows, the backslash is the native directory separator,
but all Windows versions supported by Git also accept the forward slash
in all but rare circumstances. Our tests expect forward slashes. Git
displays relative paths with forward slashes. Forward slashes are more
convenient to use in shell scripts.

For these reasons, we enforced forward slashes in `interpolate_path()`
in 5ca6b7bb47b (config --show-origin: report paths with forward slashes,
2016-03-23). However, other code paths may construct paths containing
backslashes. For example, `config --show-origin` prints the XDG config
path with mixed slashes on Windows:

    $ git config --list --show-origin
    file:C:/Program Files/Git/etc/gitconfig         system.foo=bar
    file:"C:\\Users\\delilah/.config/git/config"    xdg.foo=bar
    file:C:/Users/delilah/.gitconfig                home.foo=bar
    file:.git/config                                local.foo=bar

These mixed slashes occur because the `$HOME` and `$XDG_CONFIG_HOME`
environment variables usually contain backslashes on Windows, and
`xdg_config_home_for()` interpolates them into templates that use
hardcoded forward slashes.

Since callers of `xdg_config_home_for()` handle mixed slashes correctly,
it is reasonable to assume that they can handle paths with only forward
slashes. Let's enforce forward slashes in `xdg_config_home_for()` by
using `convert_slashes()` on Windows.

Also, there are no tests for the XDG path with `--show-origin`. Add a
test for slash conversion and a confidence check for the default path.

Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
---
 path.c            | 16 ++++++++++------
 t/t1300-config.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/path.c b/path.c
index c3a709a928..f17595fd1b 100644
--- a/path.c
+++ b/path.c
@@ -1544,19 +1544,23 @@ int looks_like_command_line_option(const char *str)
 
 char *xdg_config_home_for(const char *subdir, const char *filename)
 {
+	char *ret;
 	const char *home, *config_home;
 
 	assert(subdir);
 	assert(filename);
 	config_home = getenv("XDG_CONFIG_HOME");
 	if (config_home && *config_home)
-		return mkpathdup("%s/%s/%s", config_home, subdir, filename);
-
-	home = getenv("HOME");
-	if (home)
-		return mkpathdup("%s/.config/%s/%s", home, subdir, filename);
+		ret = mkpathdup("%s/%s/%s", config_home, subdir, filename);
+	else if ((home = getenv("HOME")))
+		ret = mkpathdup("%s/.config/%s/%s", home, subdir, filename);
+	else
+		return NULL;
 
-	return NULL;
+#ifdef GIT_WINDOWS_NATIVE
+	convert_slashes(ret);
+#endif
+	return ret;
 }
 
 char *xdg_config_home(const char *filename)
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e3f8064889..329407a73d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2350,6 +2350,38 @@ test_expect_success '--show-origin with --default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set up xdg config --show-origin tests' '
+	mkdir -p "$HOME"/.config/git &&
+	cat >"$HOME"/.config/git/config <<-EOF
+	[xdg]
+		config = true
+	EOF
+'
+
+test_expect_success MINGW '--show-origin converts backslashes in xdg path to forward slashes on Windows' '
+	backslash_home="$(echo "$HOME" | tr / \\\\)" &&
+	echo "file:$HOME/.config/git/config	true" >expect &&
+
+	(
+		sane_unset XDG_CONFIG_HOME &&
+		HOME="$backslash_home" git config ${mode_get} --show-origin xdg.config >actual
+	) &&
+	test_cmp expect actual &&
+
+	XDG_CONFIG_HOME="$backslash_home\\.config" git config ${mode_get} --show-origin xdg.config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--show-origin with default xdg path' '
+	echo "file:$HOME/.config/git/config	true" >expect &&
+	git config ${mode_get} --show-origin xdg.config >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'clean up xdg config --show-origin tests' '
+	rm -rf "$HOME"/.config/git
+'
+
 test_expect_success '--show-scope with --list' '
 	cat >expect <<-EOF &&
 	global	user.global=true

-- 
2.54.0

