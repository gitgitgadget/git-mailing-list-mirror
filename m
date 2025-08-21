Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870522D97A9
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760948; cv=none; b=BZynSlJHSKolWe6gWc1qc46UrEOr9h6oUAt6HZKNt3jY1d5gElNNM8I/7pnZeuBi7DJ70QW9TdqiAZRGVd2w0GJx+CBZk+2eASha/GiEjcqi+lpaKOtDNNl7JHMFCw2Knyk0YCJDIPuczuL5xtW+8Oz3y7NLX7NKDLt4933Fl6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760948; c=relaxed/simple;
	bh=0xCLNjuzT5c97TfP8LcxCxE7nDzaqqAd0zzx9OpPHnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ4dzS0YzwISWtb+a5hVyRHBEg6BCmRnBgDt/3LWbWWby9c6SkQOCEOfCNxaJtC4fTq0W8d7WOWbsSoG0hWjuC1D+II3orfwVQE8657jkTB365g4FQqJhJMdfgtM/hB4sdA150ibI/kr8fykRMcL+Q97WtytaedpkM326QX9nJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NNe/i3z3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NNe/i3z3"
Received: (qmail 42133 invoked by uid 109); 21 Aug 2025 07:22:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0xCLNjuzT5c97TfP8LcxCxE7nDzaqqAd0zzx9OpPHnc=; b=NNe/i3z31VByzgdD8XCiRljiA1DjWVB91YOIXsFbdYDBMZeYHIznVVVl+etBMMgBxLgw1djxlHYf+/Zs9bBFOl5o/UN4FGsQj25AfpWIQreLRPOeJ6XWf4mWRJyiGnrXcl6x4RaDSmV74VL5XS3PsQ8Ypeq1fU1wKDaNMLK6vQS6S6DZJyY8LXp+5r3HWpCD9qfx5s6fupDjzR7cu7O2AlaZCl3dVGrgXSqylyW3uMvFUIhMCI1VOVTjd0Uap7CR1TdwgkRYuo/OJSJOBM4ruqDLMM9/dN6y9LJ7etiwMB/04YileVRz2vMxTb7vrWE2cQ8N0UfndHAVu59JHs8+Ew==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Aug 2025 07:22:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 72373 invoked by uid 111); 21 Aug 2025 07:22:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Aug 2025 03:22:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Aug 2025 03:22:24 -0400
From: Jeff King <peff@peff.net>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: git@vger.kernel.org
Subject: [PATCH 3/4] add-interactive: manually fall back color config to
 color.ui
Message-ID: <20250821072224.GC1839835@coredump.intra.peff.net>
References: <20250821070740.GA3356411@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821070740.GA3356411@coredump.intra.peff.net>

Color options like color.interactive and color.diff should fall back to
the value of color.ui if they aren't set. In add-interactive, we check
the specific options (e.g., color.diff) via repo_config_get_value(),
which does not depend on the main command having loaded any color config
via the git_config() callback mechanism.

But then we call want_color() on the result; if our specific config is
unset then that function uses the value of git_use_color_default. That
variable is typically set from color.ui by the git_color_config()
callback, which is called by the main command in its own git_config()
callback function.

This works fine for "add -p", whose add_config() callback calls into
git_color_config(). But it doesn't work for other commands like
"checkout -p", which is otherwise unaware of color at all. People tend
not to notice because the default is "auto", and that's what they'd set
color.ui to as well. But something like:

  git -c color.ui=false checkout -p

should disable color, and it doesn't.

This regression goes back to 0527ccb1b5 (add -i: default to the built-in
implementation, 2021-11-30). In the perl version we got the color config
from "git config --get-colorbool", which did the full lookup for us.

The obvious fix is for git-checkout to add a call to git_color_config()
to its own config callback. But we'd have to do so for every command
with this problem, which is error-prone. Let's see if we can fix it more
centrally.

It is tempting to teach want_color() to look up the value of
repo_config_get_value("color.ui") itself. But I think that would have
disastrous consequences. Plumbing commands, especially older ones, avoid
porcelain config like color. by simply not parsing it in their config
callbacks. Looking up the value of color.ui under the hood would
undermine that.

Instead, let's do that lookup in the add-interactive setup code. We're
already demand-loading other color config there, which is probably fine
(even in a plumbing command like "git reset", the interactive mode is
inherently porcelain-ish). That catches all commands that use the
interactive code, whether they were calling git_color_config()
themselves or not.

Reported-by: Isaac Oscar Gariano <isaacoscar@live.com.au>
Signed-off-by: Jeff King <peff@peff.net>
---
 add-interactive.c          |  9 +++++++++
 t/t3701-add-interactive.sh | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 95ab251963..db7e6a81a8 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -45,6 +45,15 @@ static int check_color_config(struct repository *r, const char *var)
 		ret = -1;
 	else
 		ret = git_config_colorbool(var, value);
+
+	/*
+	 * Do not rely on want_color() to fall back to color.ui for us. It uses
+	 * the value parsed by git_color_config(), which may not have been
+	 * called by the main command.
+	 */
+	if (ret < 0 && !repo_config_get_value(r, "color.ui", &value))
+		ret = git_config_colorbool("color.ui", value);
+
 	return want_color(ret);
 }
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3f9cb9453f..0024991257 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1319,6 +1319,12 @@ test_expect_success 'stash accepts -U and --inter-hunk-context' '
 	test_grep "@@ -2,20 +2,20 @@" actual
 '
 
+test_expect_success 'set up base for -p color tests' '
+	echo commit >file &&
+	git commit -am "commit state" &&
+	git tag patch-base
+'
+
 for cmd in add checkout commit reset restore "stash save" "stash push"
 do
 	test_expect_success "$cmd rejects invalid context options" '
@@ -1335,6 +1341,15 @@ do
 		test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
 		test_grep -E ".--inter-hunk-context. requires .(--interactive/)?--patch." actual
 	'
+
+	test_expect_success "$cmd falls back to color.ui" '
+		git reset --hard patch-base &&
+		echo working-tree >file &&
+		test_write_lines y |
+		force_color git -c color.ui=false $cmd -p >output.raw 2>&1 &&
+		test_decode_color <output.raw >output &&
+		test_cmp output.raw output
+	'
 done
 
 test_done
-- 
2.51.0.356.g99d8374de0

