Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6EAEAE7
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760522; cv=none; b=rE7ZgPpLJZ2PLzHWXt6+AbtJJcd/YLRz8x4KOTUyvF6ahIpbF4lxszFbCmY+2Df8gyeKyCzcRssmREu47ERopFX5T08KzAyWtGmW4cEi+I0UHxmKcpNcNtIW5IyG5DHB40o1jcHW2E3iZC5eHXHtJgIYWBhJdsEufLcsMuyCzME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760522; c=relaxed/simple;
	bh=HgNAgTskANCFwt+MPnB7eB2RRD1UDYZaembg9Adc6LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cH2P1Kaa8G1PZ8aRh++Curw2hpl/kWJUZrkTu9riKKOb5I0WLrivzCkVNP2WN+mq8e9Nlm4cmt6tIPRl3TaXDH4nIsW2sGKoEDmqOBQTpR/X+9Wiwdx7a1h7tAEzGrPDgYus51a2JaJnZqwFSb10r2ZVSM4YxmEZEEybv3aOfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eZbpigzA; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eZbpigzA"
Received: (qmail 42104 invoked by uid 109); 21 Aug 2025 07:15:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HgNAgTskANCFwt+MPnB7eB2RRD1UDYZaembg9Adc6LE=; b=eZbpigzACa4mAL6HZOTl84JlqsMK0est7HMKMIJPYQyJxEtnPfrf3IsBLaW3RwKRHF349dyVPDvPN1aAxXYnaV8H5M09/7nNIFxOmStfOnwcR86aVpsJqnY4y6m1+EJySRbB3p5G/9hU0JO95JHdwz1uuYpmniJQBUvpd0xJa0tq79atL1bGyXkr3Tgom2CiU+fbu2NvCWvl4AVrsk7M9IDzA8xSnf777Fne/gbOOF77DGuOTDUOrFaZp9PlhN5dHawuLjGqBy0LN2rBkOwuLHctj41k7dNYanJq6tl2Bf3IfuOvEVcEAFeBSNuB7UULAUNu7LHyqTTNckXOGCw4nA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 Aug 2025 07:15:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 72218 invoked by uid 111); 21 Aug 2025 07:15:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 Aug 2025 03:15:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 21 Aug 2025 03:15:17 -0400
From: Jeff King <peff@peff.net>
To: Isaac Oscar Gariano <isaacoscar@live.com.au>
Cc: git@vger.kernel.org
Subject: [PATCH 1/4] stash: pass --no-color to diff-tree child processes
Message-ID: <20250821071517.GA1839835@coredump.intra.peff.net>
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

After a partial stash, we may clear out the working tree by capturing
the output of diff-tree and piping it into git-apply. So we most
definitely do not want color diff output from that diff-tree process.
And it normally would not produce any, since its stdout is not going to
a tty, and the default value of color.ui is "auto".

However, if GIT_PAGER_IN_USE is set in the environment, that overrides
the tty check, and we'll produce a colorized diff that chokes git-apply:

  $ echo y | GIT_PAGER_IN_USE=1 git stash -p
  [...]
  Saved working directory and index state WIP on main: 4f2e2bb foo
  error: No valid patches in input (allow with "--allow-empty")
  Cannot remove worktree changes

Setting this variable is a relatively silly thing to do, and not
something most users would run into. But we sometimes do it in our tests
to stimulate color. And it is a user-visible bug, so let's fix it rather
than work around it in the tests.

The root issue here is that diff-tree (and other diff plumbing) should
probably not ever produce color by default. It does so not by parsing
color.ui, but because of the baked-in "auto" default from 4c7f1819b3
(make color.ui default to 'auto', 2013-06-10). But changing that is
risky; we've had discussions back and forth on the topic over the years.
E.g.:

  https://lore.kernel.org/git/86D0A377-8AFD-460D-A90E-6327C6934DFC@gmail.com/.

So let's accept that as the status quo for now and protect ourselves by
passing --no-color to the child processes. This is the same thing we did
for add-interactive itself in 1c6ffb546b (add--interactive.perl: specify
--no-color explicitly, 2020-09-07).

Signed-off-by: Jeff King <peff@peff.net>
---
I ran into this while writing tests for the subsequent patches.

Reading that referenced thread again, Junio was in favor of reverting
4c7f1819b3 and replacing it with something that didn't kick in for
plumbing (thus fixing the root issue). I argued against it somewhat
there, but now I think I was foolish and agree with 2017-Junio. ;) I do
think that fixing it now carries some risk of people complaining,
though. So I'd rather do this immediate fix and worry about the larger
problem separately.

I also had another patch long ago that would have helped here:

  https://lore.kernel.org/git/20150810052353.GB15441@sigill.intra.peff.net/

The general idea is for GIT_PAGER_IN_USE to actually identify the pipe
to the pager, so that sub-processes that are not going directly to the
pager know to ignore it. I think I didn't pursue it because I never
worked out the portability issues for Windows.

 builtin/stash.c        |  4 +++-
 t/t3904-stash-patch.sh | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 1977e50df2..c55628aafc 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -377,7 +377,7 @@ static int diff_tree_binary(struct strbuf *out, struct object_id *w_commit)
 	 * however it should be done together with apply_cached.
 	 */
 	cp.git_cmd = 1;
-	strvec_pushl(&cp.args, "diff-tree", "--binary", NULL);
+	strvec_pushl(&cp.args, "diff-tree", "--binary", "--no-color", NULL);
 	strvec_pushf(&cp.args, "%s^2^..%s^2", w_commit_hex, w_commit_hex);
 
 	return pipe_command(&cp, NULL, 0, out, 0, NULL, 0);
@@ -1283,6 +1283,7 @@ static int stash_staged(struct stash_info *info, struct strbuf *out_patch,
 
 	cp_diff_tree.git_cmd = 1;
 	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "--binary",
+		     "--no-color",
 		     "-U1", "HEAD", oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
@@ -1345,6 +1346,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 
 	cp_diff_tree.git_cmd = 1;
 	strvec_pushl(&cp_diff_tree.args, "diff-tree", "-p", "-U1", "HEAD",
+		     "--no-color",
 		     oid_to_hex(&info->w_tree), "--", NULL);
 	if (pipe_command(&cp_diff_tree, NULL, 0, out_patch, 0, NULL, 0)) {
 		ret = -1;
diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
index ae313e3c70..0bddbce504 100755
--- a/t/t3904-stash-patch.sh
+++ b/t/t3904-stash-patch.sh
@@ -107,4 +107,14 @@ test_expect_success 'stash -p with split hunk' '
 	! grep "added line 2" test
 '
 
+test_expect_success 'stash -p not confused by GIT_PAGER_IN_USE' '
+	echo to-stash >test &&
+	# Set both GIT_PAGER_IN_USE and TERM. Our goal is entice any
+	# diff subprocesses into thinking that they could output
+	# color, even though their stdout is not going into a tty.
+	echo y |
+	GIT_PAGER_IN_USE=1 TERM=vt100 git stash -p &&
+	git diff --exit-code
+'
+
 test_done
-- 
2.51.0.356.g99d8374de0

