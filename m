Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53603373C1A
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535979; cv=none; b=B3ADhI1jLfR6jYMLKrvDB3AfGK8a6TaNv+1I8FnuyTrUCaMaU+Zc3vMs9baNTC9VaHPAwMHEp4h8dGBVZuHDuppYhhdZrIEs0L2kB316vHB4emaMVUCRVrHd5BcWzvghevxtnYZUPLTpab/D64LqWaZXeyoF3eBcTChDY6Q80kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535979; c=relaxed/simple;
	bh=uo7hii1zJ3Tkrbm62V7uTshqGu52M5Hy2Aa66rm8D6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g410ngKnw9Mip9QJTuaLy5vfYzeYMfFpxinW995LRgTvTJpNlxooKQXaZCm71aUUm67eTCF7Ej5OLHBkKF9UurgBJU5djkFCBD8oXWLNn4Er0uYekU5YmHsUZZO0d+yPr5vYBLo2KDZggVY1TibdZr8b1QUkTVWnURldnp/XwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y9Gwy2gx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y9Gwy2gx"
Received: from [192.168.4.34] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id AC22C20B7169;
	Fri,  9 Oct 2026 01:52:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC22C20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791535977;
	bh=ubGSugaxt7CUoMLwWfULNNRWl02H1HTjG1y+wOBP40A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y9Gwy2gxjQ1Nbhljpzwc7TDd8NXK5W7B43Ai7z7hxxVZrUaLoX/wMITVyrGnfsWGS
	 mbDNtY6RI0e8P3J/xRoBPCxWZB9YUIlWnfwo/5+vIadwWLSeuCiJDCP7xiwmfRAjSO
	 yzKibq5Alxi4KFXLzroQ4DdQOsQ/BMPlrfakSRaw=
From: Delilah Ashley Wu <delilahwu@linux.microsoft.com>
Date: Fri, 09 Oct 2026 19:51:45 +1100
Subject: [PATCH v3 1/2] t1300: test list with missing global config
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-fix-config-list-global-home-and-xdg-v3-1-f936b9c8a0cc@microsoft.com>
References: <20261009-fix-config-list-global-home-and-xdg-v3-0-f936b9c8a0cc@microsoft.com>
In-Reply-To: <20261009-fix-config-list-global-home-and-xdg-v3-0-f936b9c8a0cc@microsoft.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Chris Torek <chris.torek@gmail.com>, 
 Patrick Steinhardt <ps@pks.im>, Delilah Ashley Wu <delilahwu@microsoft.com>, 
 Ben Knoble <ben.knoble@gmail.com>, Nils Fahldieck <nils@fahldieck.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

From: Delilah Ashley Wu <delilahwu@microsoft.com>

Record behaviour in two new tests: when no global configuration file
exists, `git config list` succeeds whereas `git config list --global`
fails. Only check the exit code, as we're not interested in the exact
error message.

This prevents regressions in the next patch, "config: read global scope
via config_sequence", which modifies `do_git_config_sequence()` to
optionally return a failure if no global configuration files were
successfully read (i.e. when the `--global` flag is specified).

Signed-off-by: Delilah Ashley Wu <delilahwu@microsoft.com>
---
 t/t1300-config.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e3f8064889..df8c14da0d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2425,6 +2425,18 @@ test_expect_success '--show-scope with --default' '
 	test_cmp expect actual
 '
 
+test_expect_success 'list with nonexistent global config gracefully exits' '
+	rm -f "$HOME"/.gitconfig "$HOME"/.config/git/config &&
+	git config ${mode_prefix}list &&
+	git config ${mode_prefix}list --show-scope
+'
+
+test_expect_success 'list --global with nonexistent global config fails' '
+	rm -f "$HOME"/.gitconfig "$HOME"/.config/git/config &&
+	test_must_fail git config ${mode_prefix}list --global &&
+	test_must_fail git config ${mode_prefix}list --global --show-scope
+'
+
 test_expect_success 'override global and system config' '
 	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
 	cat >"$HOME"/.gitconfig <<-EOF &&

-- 
2.54.0

