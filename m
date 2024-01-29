Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8606ADDA3
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706493439; cv=none; b=T++syrKlB5AwSWkKQoPESBtRreZ+stqE+d5c/EEt9hmW6GN9urLG/XajXQFvE/kWceNAS3BP4qEUSO3zT4NMQN5ILGcvBRHezFRrxlBJotDJop17Euh/K5Lb+/cCJdsHM/EJBw86yC07w9U4pz5xIvO36vKMTH0TPSsWydTL1aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706493439; c=relaxed/simple;
	bh=elG/VPEYHArE+gJF8KSBSHawzPSBLBqMOGTeAcmd/GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=swgz1uJRI2NE7OAVXl6hA63illbRZnVl66rmzhVIGe3HYxpJv9z576hsk+PQsWkxWpiYC4kJoO4kRdwxY9Rnl8RJldQs4gBPkRliETQ7zA96INjWmbT5Be1Rt9DLOI/+1INAO+TcsFCsfjAnDknaYreeYkXfsNOwBu0vFM0m+Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27414 invoked by uid 109); 29 Jan 2024 01:57:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jan 2024 01:57:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17459 invoked by uid 111); 29 Jan 2024 01:57:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 28 Jan 2024 20:57:10 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 28 Jan 2024 20:57:08 -0500
From: Jeff King <peff@peff.net>
To: Wilfred Hughes <me@wilfred.me.uk>
Cc: git@vger.kernel.org
Subject: [PATCH] diff: handle NULL meta-info when spawning external diff
Message-ID: <20240129015708.GA1762343@coredump.intra.peff.net>
References: <CAFXAjY7XcL1APhLRXU8TO96z=f7957f2ieK56dHVsXUay55vpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFXAjY7XcL1APhLRXU8TO96z=f7957f2ieK56dHVsXUay55vpg@mail.gmail.com>

On Sun, Jan 28, 2024 at 12:24:39PM -0800, Wilfred Hughes wrote:

> It looks like git crashes if diff.external is set and the user
> compares files that have different permissions. Here's a repro:
> 
> $ mkdir demo
> $ cd demo
> $ git init .
> Initialized empty Git repository in /tmp/demo/.git/
> 
> $ git config diff.external /bin/echo
> $ touch foo bar
> $ chmod 755 foo
> $ git diff --no-ext-diff --no-index foo bar
> diff --git 1/foo 2/bar
> old mode 100755
> new mode 100644
> 
> $ git diff --no-index foo bar
> zsh: segmentation fault (core dumped)  git diff --no-index foo bar

Thanks for providing a simple reproduction recipe. There's a pretty
straight-forward fix below, though it leaves open some question of
whether there's another bug lurking with --no-index (but either way, I
think we'd want this simple fix as a first step).

-- >8 --
Subject: diff: handle NULL meta-info when spawning external diff

Running this:

  $ touch foo bar
  $ chmod +x foo
  $ git -c diff.external=echo diff --ext-diff --no-index foo bar

results in a segfault. The issue is that run_diff_cmd() passes a NULL
"xfrm_msg" variable to run_external_diff(), which feeds it to
strvec_push(), causing the segfault. The bug dates back to 82fbf269b9
(run_external_diff: use an argv_array for the command line, 2014-04-19),
though it mostly only ever worked accidentally.  Before then, we just
stuck the NULL pointer into a "const char **" array, so our NULL ended
up acting as an extra end-of-argv sentinel (which was OK, because it was
the last thing in the array).

Curiously, though, this is only a problem with --no-index. We set up
xfrm_msg by calling fill_metainfo(). This result may be empty, or may
have text like "index 1234..5678\n", "rename from foo\nrename from
bar\n", etc. In run_external_diff(), we only look at xfrm_msg if the
"other" variable is not NULL. That variable is set when the paths of the
two sides of the diff pair aren't the same (in which case the
destination path becomes "other"). So normally it would kick in only for
a rename, in which case xfrm_msg should not be NULL (it would have the
rename information in it).

But with a "--no-index" of two blobs, we of course have two different
pathnames, and thus end up with a non-NULL "other" filename (which is
always just a repeat of the file2-name), but possibly a NULL xfrm_msg.

So how to fix it? I have a feeling that --no-index always passing
"other" to the external diff command is probably a bug. There was no
rename, and the name is always redundant with existing information we
pass (and this may even cause us to pass a useless "xfrm_msg" that
contains an "index 1234..5678" line). So one option would be to change
that behavior. We don't seem to have ever documented the "other" or
"xfrm_msg" parameters for external diffs.

But I'm not sure what fallout we might have from changing that behavior
now. So this patch takes the less-risky option, and simply teaches
run_external_diff() to avoid passing xfrm_msg when it's NULL. That makes
it agnostic to whether "other" and "xfrm_msg" always come as a pair. It
fixes the segfault now, and if we want to change the --no-index "other"
behavior on top, it will handle that, too.

Reported-by: Wilfred Hughes <me@wilfred.me.uk>
Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                   |  3 ++-
 t/t4053-diff-no-index.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index a89a6a6128..ccfa1fca0d 100644
--- a/diff.c
+++ b/diff.c
@@ -4384,7 +4384,8 @@ static void run_external_diff(const char *pgm,
 		add_external_diff_name(o->repo, &cmd.args, two);
 		if (other) {
 			strvec_push(&cmd.args, other);
-			strvec_push(&cmd.args, xfrm_msg);
+			if (xfrm_msg)
+				strvec_push(&cmd.args, xfrm_msg);
 		}
 	}
 
diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
index 5ce345d309..651ec77660 100755
--- a/t/t4053-diff-no-index.sh
+++ b/t/t4053-diff-no-index.sh
@@ -205,6 +205,18 @@ test_expect_success POSIXPERM,SYMLINKS 'diff --no-index normalizes: mode not lik
 	test_cmp expected actual
 '
 
+test_expect_success POSIXPERM 'external diff with mode-only change' '
+	echo content >not-executable &&
+	echo content >executable &&
+	chmod +x executable &&
+	echo executable executable $(test_oid zero) 100755 \
+		not-executable $(test_oid zero) 100644 not-executable \
+		>expect &&
+	test_expect_code 1 git -c diff.external=echo diff \
+		--no-index executable not-executable >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "diff --no-index treats '-' as stdin" '
 	cat >expect <<-EOF &&
 	diff --git a/- b/a/1
-- 
2.43.0.794.g6ebf4d0024

