Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864D29BD81
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767694570; cv=none; b=XzwM7mb/CJLoMkccic3QX4nwqMolvsQROkGq+L+srPS3DmL2TZU8m7no8sHFiDNHtMzuqsDPDHqK+ldej7LU/yBdI3tJMv+z/y3K2C+hlOJJq3bwIR06iunRO4RJHZS1WgFM1MHFHieonwlOiJor8ges+Qyi6GwgzDzjsaK9SE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767694570; c=relaxed/simple;
	bh=V2XblLBJgvzRi2kGxQSWCvp/KiSasH5oaOKnla44kM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS/9W5JbHNzq9k6t7FU3gCM3WwlIOBghCgr7rWiqQdrPVEJObgIk0Sa74J/+3rN2jwNJtLWNErbgGeQhnq8q7HxsLrnoHmpZvDoYOgzBBUrioLQ+i+/M+0h/4vEAK2WYZVLTkR3TC9EjAVPawfjlEj3R1nb3NtAFEEfRzaadCBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=c8KBFtOG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="c8KBFtOG"
Received: (qmail 600961 invoked by uid 109); 6 Jan 2026 10:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=V2XblLBJgvzRi2kGxQSWCvp/KiSasH5oaOKnla44kM0=; b=c8KBFtOGL/7MNwKZSeeVNPPE5OaGIbtlaHcJRYUSAMezJ4GCmnrtdNva6vA9PeqwxTp+gVzGgLi+LtT5EYbj/JmVTZyoBvLZeNRmgmTUdy33jqOYufvNuz1jzT2ppFdVUG8SAwt8541YKhLkf11kJ/M6P0VCJgzrNQ5MYaRYRY0OhMd36X0tnikgSrs4m9McFdaPdU/TZXJO6NRAQsfrloAJktj0fdYRM5n+rXxxMNWVIu6HKqlBL5Xxrjvbpm7U8ravnBoBCxTonNMYgbgIHCReKD1uq8ZkI2edh0cQhAp+yK3d1DqcsBX/oMsX024ymEF+taYIN9fDV1s4Yyx6eg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Jan 2026 10:16:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 789097 invoked by uid 111); 6 Jan 2026 10:16:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Jan 2026 05:16:09 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 6 Jan 2026 05:16:04 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] t/perf/run: preserve GIT_PERF_* from environment
Message-ID: <20260106101604.GB3727538@coredump.intra.peff.net>
References: <20260106101043.GA3723319@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260106101043.GA3723319@coredump.intra.peff.net>

If you run:

  GIT_PERF_LARGE_REPO=/some/path ./p1006-cat-file.sh

it will use the repo in /some/path. But if you use the "run" helper
script to aggregate and compare results, like this:

  GIT_PERF_LARGE_REPO=/some/path ./run HEAD^ HEAD p1006-cat-file.sh

it will ignore that variable. This is because the presence of the
LARGE_REPO variable in GIT-BUILD-OPTIONS overrides what's in the
environment. This started with 4638e8806e (Makefile: use common template
for GIT-BUILD-OPTIONS, 2024-12-06), which now writes even empty
variables (though arguably it was wrong even before with a non-empty
value, as we generally prefer the environment to take precedence over
on-disk config).

We had the same problem in perf-lib.sh itself, and we hacked around it
with 32b74b9809 (perf: do allow `GIT_PERF_*` to be overridden again,
2025-04-04). That's what lets the direct invocation of "./p1006" work
above.

And in fact that was sufficient for "./run", too, until it started
loading GIT-BUILD-OPTIONS itself in 5756ccd181 (t/perf: fix benchmarks
with out-of-tree builds, 2025-04-28). Now it has the same problem: it
clobbers any incoming GIT_PERF options from the environment.

We can use the same hack here in the "run" script. It's quite ugly, but
it's just short enough that I don't think it's worth trying to factor it
out into a common shell library.

In the long run, we might consider teaching GIT-BUILD-OPTIONS to be more
gentle in overwriting existing entries. There are probably other
GIT_TEST_* variables which would need the same treatment. And if and
when we come up with a more complete solution, we can use it in both
spots.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/perf/run | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/perf/run b/t/perf/run
index 073bcb2aff..13913db4a3 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -204,8 +204,18 @@ run_subsection () {
 get_var_from_env_or_config "GIT_PERF_CODESPEED_OUTPUT" "perf" "codespeedOutput" "--bool"
 get_var_from_env_or_config "GIT_PERF_SEND_TO_CODESPEED" "perf" "sendToCodespeed"
 
+# Preserve GIT_PERF settings from the environment when loading
+# GIT-BUILD-OPTIONS; see the similar hack in perf-lib.sh.
+git_perf_settings="$(env |
+        sed -n "/^GIT_PERF_/{
+                # escape all single-quotes in the value
+                s/'/'\\\\''/g
+                # turn this into an eval-able assignment
+                s/^\\([^=]*=\\)\\(.*\\)/\\1'\\2'/p
+        }")"
 cd "$(dirname $0)"
 . ../../GIT-BUILD-OPTIONS
+eval "$git_perf_settings"
 
 if test -n "$TEST_OUTPUT_DIRECTORY"
 then
-- 
2.52.0.664.g9f53c65b4c
