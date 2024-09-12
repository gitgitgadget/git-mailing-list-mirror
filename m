Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC217DFF5
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726180648; cv=none; b=nKwHuyh0CkbTiyYOQV9GUkJ8S/Qk5zOPVmcSMPEscVHLw8SC8xuwXNW8mBUKrzdNzT2btUcsxN6EhG06vqiCvVdLanF6XlxN3pWykGdKYWja+iAK9sFPm0EVoWsoiJJykFSo6eN5Q00XGL4S7keTtpdiEz0RR/z5CUIpMibx3iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726180648; c=relaxed/simple;
	bh=iWMLJFAh4kTeo8zoUdmpCC2upGxhiuHustUQf8/XfyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfAUnw1dgbhaROVhGag2CqSgoaujTZCuc7mtg/VZ9LLCnmdrEIOh/FoGVlus34nElrdFhokzO/ufxd+TaUrdei/sy/S6xX2KfhdAFlG61W2PBPOIp5/hrvXH1QIRF7eEoIWFNqIIL5aolNw0oTIzJgfZwnkygBsGvpicDwwLo0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 19398 invoked by uid 109); 12 Sep 2024 22:37:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 22:37:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29371 invoked by uid 111); 12 Sep 2024 22:37:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 18:37:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 18:37:25 -0400
From: Jeff King <peff@peff.net>
To: Rodrigo <rodrigolive@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/2] Git.pm: use "rev-parse --absolute-git-dir" rather than
 perl code
Message-ID: <20240912223725.GB650605@coredump.intra.peff.net>
References: <20240912223413.GA649897@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240912223413.GA649897@coredump.intra.peff.net>

When we open a repository with the "Directory" option, we use "rev-parse
--git-dir" to get the path relative to that directory, and then use
Cwd::abs_path() to make it absolute (since our process working directory
may not be the same).

These days we can just ask for "--absolute-git-dir" instead, which saves
us a little code. That option was added in Git v2.13.0 via a2f5a87626
(rev-parse: add '--absolute-git-dir' option, 2017-02-03). I don't think
we make any promises about running mismatched versions of git and
Git.pm, but even if somebody tries it, that's sufficiently old that it
should be OK.

Signed-off-by: Jeff King <peff@peff.net>
---
I retained the "require Cwd" here since we use it in the conditional
(but moved it closer to the point of use). It's not strictly necessary,
as earlier code will have required it as a side effect, but it's
probably best not to rely on that.

 perl/Git.pm | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index cf1ef0b32a..667152c6c6 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -187,7 +187,7 @@ sub repository {
 		try {
 		  # Note that "--is-bare-repository" must come first, as
 		  # --git-dir output could contain newlines.
-		  $out = $search->command([qw(rev-parse --is-bare-repository --git-dir)],
+		  $out = $search->command([qw(rev-parse --is-bare-repository --absolute-git-dir)],
 			                  STDERR => 0);
 		} catch Git::Error::Command with {
 			throw Error::Simple("fatal: not a git repository: $opts{Directory}");
@@ -196,12 +196,12 @@ sub repository {
 		chomp $out;
 		my ($bare, $dir) = split /\n/, $out, 2;
 
-		require Cwd;
-		require File::Spec;
-		File::Spec->file_name_is_absolute($dir) or $dir = $opts{Directory} . '/' . $dir;
-		$opts{Repository} = Cwd::abs_path($dir);
+		# We know this is an absolute path, because we used
+		# --absolute-git-dir above.
+		$opts{Repository} = $dir;
 
 		if ($bare ne 'true') {
+			require Cwd;
 			# If --git-dir went ok, this shouldn't die either.
 			my $prefix = $search->command_oneline('rev-parse', '--show-prefix');
 			$dir = Cwd::abs_path($opts{Directory}) . '/';
-- 
2.46.0.918.gab30941bff
