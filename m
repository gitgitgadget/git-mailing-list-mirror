Received: from nef.ens.fr (nef2.ens.fr [129.199.96.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D02DB781
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.199.96.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867327; cv=none; b=pnCJudO9mHR7692TUIlIUP2iAUlUD7Zbz2iAXldSOOO72IJXqH37gslj6x8dlrFFofT2+S2VlJ9jfER39v2imQSC9JLiU5GZgHMdagkSEbWgCpH5mtuC9xVF92ZSG5kEQXSfgeG8AU32xOIYHtFg0xWHC08YclM4hsoQFlF332Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867327; c=relaxed/simple;
	bh=qZNqDng7ZSqLCtxGhsgEh7exYi9uV1mvvKkSIb05MJE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=t/fB6zoRItyiLNYhXbG2BKfQ7Fl7wrUyyTsqxn2NKnygLNeyR4ClaGPUXg1htf3KvtnhYVb06z+K/o+5gamFs7kBT0gHdcTTtnvAHV7jOwuEb+51BeH+8QAmSIuDGlpjpcrhd5iB9KWRjEELaER2CRtlUuYmXPA6AHjlGuH9vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nsup.org; spf=pass smtp.mailfrom=phare.normalesup.org; arc=none smtp.client-ip=129.199.96.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nsup.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phare.normalesup.org
X-ENS-nef-client:   129.199.129.80 ( name = phare.normalesup.org )
Received: from phare.normalesup.org (phare.normalesup.org [129.199.129.80])
          by nef.ens.fr (8.14.4/1.01.28121999) with ESMTP id 62IKMn9f001799
          for <git@vger.kernel.org>; Wed, 18 Mar 2026 21:22:49 +0100
Received: by phare.normalesup.org (Postfix, from userid 1001)
	id 5967F2EFDF; Wed, 18 Mar 2026 21:22:49 +0100 (CET)
Date: Wed, 18 Mar 2026 21:22:49 +0100
From: Nicolas George <george@nsup.org>
To: git@vger.kernel.org
Subject: gitweb bug report: hash mistaken for an option
Message-ID: <absJmT_S9gGqbwyT@phare.normalesup.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AAm8trb6/FcXSNYm"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3 (nef.ens.fr [129.199.96.32]); Wed, 18 Mar 2026 21:22:49 +0100 (CET)


--AAm8trb6/FcXSNYm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi.

We have a web server with gitweb (from Debian), and we observed git error
messages in apache's error.log. I tracked down the issue to a request that
had this:

```
?p=…/.git;a=tree;hb=-c
```

I will not bother giving the actual URL since nobody else can check the
issue in the logs or our server, but the issue can be reproduced on any
server by replacing the `hb=…` parameter with `hb=-c`.

I tracked down the issue further to the `git_tree` function of the CGI
script:

<https://git.kernel.org/pub/scm/git/git.git/tree/gitweb/gitweb.perl#n7200>

If `$hash_base`, i.e. the `hb` parameter, is set and not `$file_name`, then
it is passed as is as the last argument of `ls-tree -z`, and since it is not
a valid hash, it prints an error.

Since no shell gets invoked and the options of `ls-tree` are very limited, I
do not think it counts as a security flaw. But it could become one, so
better fix it.

I see really two issues:

First, that the parameter is interpreted as an option. It could become a
more severe issue if new options get introduced. And it is very easy to fix:
add a double dash.

Second, that the error (be it “unknown switch”, “Not a valid object name” or
“not a tree object” gets written into the error log: it is an error entirely
caused by the client that has no repercussion on the server, it should be
either passed back to the client or ignored. This is more minor but harder
to fix.

It might also be a good idea to check the rest of the source code for
similar patterns.

Thanks.

Regards,

-- 
  Nicolas George

[System Info]
git version:
git version 2.39.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-44-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.164-1 (2026-03-09) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
not run from a git repository - no hooks to show

--AAm8trb6/FcXSNYm
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-gitweb-avoid-hash-being-mistaken-for-an-option.patch"

From a52031aac02bc0704a56d8ca36ba3ee6d25d5b11 Mon Sep 17 00:00:00 2001
From: Nicolas George <george@nsup.org>
Date: Wed, 18 Mar 2026 21:11:57 +0100
Subject: [PATCH] gitweb: avoid hash being mistaken for an option

Fix (partially) weird warning in the error log of the server,
and potentially more severe issues if new options are added.

Signed-off-by: Nicolas George <george@nsup.org>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fde804593b..2e131bcbe9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -7217,7 +7217,7 @@ sub git_tree {
 	{
 		local $/ = "\0";
 		open my $fd, "-|", git_cmd(), "ls-tree", '-z',
-			($show_sizes ? '-l' : ()), @extra_options, $hash
+			($show_sizes ? '-l' : ()), @extra_options, "--", $hash
 			or die_error(500, "Open git-ls-tree failed");
 		@entries = map { chomp; $_ } <$fd>;
 		close $fd
-- 
2.51.0


--AAm8trb6/FcXSNYm--
