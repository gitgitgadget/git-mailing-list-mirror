Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2914483A5
	for <git@vger.kernel.org>; Tue, 28 Jul 2026 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785249528; cv=none; b=hS1WgvALuL9F/jJ2azEupBqR20rVQmibjfNau/81L+Cwb0KGa6bqsrjbW4hZTc1266qSQeEv+EZDXT2VJCvcbsCHs+W08h1AH2mxjBo7FTH5Mx0V8KeTVT6xOSlvBbsz+uP6ypf/ihHZDAXyKqCisEXs/ZDvFAIFGRxMoNTmTbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785249528; c=relaxed/simple;
	bh=6kr4SeRQAcgZiXodvTdJXEkHit83UgFiPk5v/1OfyXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP9yJzgrCuLEtjvKfaslI5jnuVQYfH7z1m3eOuUOylnBEgqKeOXzG24Yc/SeLzSP3+eHdic2bo7SLelR/0jRo3KoIqjjm7fXYXlQHcB9gyomWc8COHToGigD0dk7NxaeTP+jiXJchgoy0R/GL0LfLnglrH0HPKIvqoZ4ngdV7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bcy0FZz5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bcy0FZz5"
Received: (qmail 80773 invoked by uid 106); 28 Jul 2026 14:38:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6kr4SeRQAcgZiXodvTdJXEkHit83UgFiPk5v/1OfyXY=; b=bcy0FZz503wNRtdvGpe2WuspO378ULT3HTxKGtC7kLxEuXRHdcCCCE57j5XJQEdbsQSNRtAVXw0OyoA6kdYkJRgLki+sUtx5TSqtNqevXF4xhBTH7/7A05433Q5HpHxmkVtAMRwXX5Py/xx/d38dHsGntZhzrFlFhwCPUFZHZ38WICYcMDXGEGrc8sd+8u6eoEG28/t5ctRzoZTwB3wt+YiTVYdADZd2wUaVnVRqOuFvgMCDiraCWl7uZkMtqDcWfoyAF4TfVDgZT21pjyEsOhOBzDd+2prLFw/t8Qd89x/JrLbYwNqfWLhK5DKvpJxoE0M9KYRoN2QhW7cbL+qISw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2026 14:38:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99702 invoked by uid 111); 28 Jul 2026 14:38:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2026 10:38:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 28 Jul 2026 10:38:45 -0400
From: Jeff King <peff@peff.net>
To: phillip.wood@dunelm.org.uk
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: [PATCH 2/2] t0014: generate deprecated command names dynamically
Message-ID: <20260728143845.GB41686@coredump.intra.peff.net>
References: <20260728143653.GB11894@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728143653.GB11894@coredump.intra.peff.net>

We have a few tests related to aliasing of deprecated commands. They use
whatchanged and pack-redundant because those are the only two deprecated
commands we have. Eventually those commands will be removed, at which
point these tests will be checking nothing useful (they'll just be
regular aliases, which we already cover in other tests).

We could remove them at that point, but the code to handle deprecated
commands will still remain. We probably do want to keep the tests around
for the eventual day that we deprecate more commands. So let's ask Git
for its list of deprecated commands, and if we don't have any, skip
those tests.

This also prevents an annoying corner case when your build directory
contains old build products. Right now those commands are marked as
deprecated builtins and treated specially; we allow aliases and never
look for them as dashed external commands. But after they are removed,
they aren't special anymore. If your directory happens to contain
hardlinks from the build of an older version, that confuses Git: it sees
the old hardlinks in place, thinks those are actual external commands,
and refuses to allow aliasing.

You can see that today like this:

  make
  make WITH_BREAKING_CHANGES=1 test

The first "make" creates git-whatchanged as a hardlink to Git, and the
second does not clean it up (it doesn't know about the whatchanged
command at all anymore). t0014 fails because Git won't create an alias
to the "external" whatchanged command.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0014-alias.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 9d7c737355..cbc447b481 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -27,10 +27,15 @@ test_expect_success 'looping aliases - internal execution' '
 	test_grep "^fatal: alias loop detected: expansion of" output
 '
 
-deprecated1=whatchanged
-deprecated2=pack-redundant
+test_expect_success 'detect deprecated commands' '
+	git --list-cmds=deprecated >deprecated &&
+	if read deprecated1 && read deprecated2
+	then
+		test_set_prereq HAVE_DEPRECATED
+	fi <deprecated
+'
 
-test_expect_success 'looping aliases - deprecated builtins' '
+test_expect_success HAVE_DEPRECATED 'looping aliases - deprecated builtins' '
 	test_config alias.$deprecated1 $deprecated2 &&
 	test_config alias.$deprecated2 $deprecated1 &&
 	cat >expect <<-EOF &&
@@ -89,7 +94,7 @@ test_expect_success 'can alias-shadow deprecated builtins' '
 	done
 '
 
-test_expect_success 'can alias-shadow via two deprecated builtins' '
+test_expect_success HAVE_DEPRECATED 'can alias-shadow via two deprecated builtins' '
 	# some git(1) commands will fail... (see above)
 	test_might_fail git status -h >expect &&
 	test_file_not_empty expect &&
-- 
2.55.0.749.g30c495c7a6
