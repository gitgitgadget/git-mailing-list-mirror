Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C441A2560
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856503; cv=none; b=Vqwbxvza7/qqKDOCE5ooJGOonCodl8bGg64nBR4vDaRbE/Pmbq2LunchAs2UA42fJSNRwNex7kWNo20h6zUfGuAW9wgmKh8J/2nGg3KyK8ooUwjvh6MrE7UvC85Qc9KqSbYmn/YstVfJVsT6XKIxuiIdie+4bYndhbNhxWFBJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856503; c=relaxed/simple;
	bh=YaUipSDzExhyd72Z+jSdxjfUwMBX6l3tfqnPSetyyfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vritpq9IyHBJrjqHh1NjbFiBtlrfEpsO0booQChQz0u2Mdvt0Ct8WBa1ZsIxdAc/U983pEVgr+n9kBOxHvPeJOscRVo83NnQPqjePPLnOJAsFqR/a4kmJorNSzY5KSvX+3PaPe1wOBpu+NBi/qNmgmBxEmLnHIgVtI9pq+xgYBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 25409 invoked by uid 109); 28 Aug 2024 14:48:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 14:48:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27523 invoked by uid 111); 28 Aug 2024 14:48:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 10:48:16 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 10:48:14 -0400
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: [PATCH 7/6] CodingGuidelines: mention -Wunused-parameter and UNUSED
Message-ID: <20240828144814.GB4020916@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
 <20240828040049.GF3999193@coredump.intra.peff.net>
 <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cQLr+vAzkt8UJNVCeE8osGEcEfFunG36oqxa0k8JamJzQ@mail.gmail.com>

On Wed, Aug 28, 2024 at 01:56:13AM -0400, Eric Sunshine wrote:

> > And since the code base is now at a spot where we compile cleanly with
> > -Wunused-parameter, turning it on will make it the responsibility of
> > individual patch writers going forward.
> [...]
> What is the expectation regarding newcomers to the project or even
> people who have not been following this topic and its cousins?
> Documentation/CodingGuidelines recommends enabling DEVELOPER mode,
> which is good, but this change means that such people may now be hit
> with a compiler complaint which they don't necessarily know how to
> deal with in the legitimate case #3 (described above). Should
> CodingGuidelines be updated to mention "UNUSED" and the circumstances
> under which it should be used?

Yeah, I agree some guidance is in order. How about this on top? I didn't
go into the decision tree of when you should remove the parameter versus
using it versus annotating it. I think in general that the first two are
pretty obvious when they are appropriate, and we just need to focus on
the annotating option.

-- >8 --
Subject: [PATCH] CodingGuidelines: mention -Wunused-parameter and UNUSED

Now that -Wunused-parameter is on by default for DEVELOPER=1 builds,
people may trigger it, blocking their build. When it's a mistake for the
parameter to exist, the path forward is obvious: remove it. But
sometimes you need to suppress the warning, and the "UNUSED" mechanism
for that is specific to our project, so people may not know about it.

Let's put some advice in CodingGuidelines, including an example warning
message. That should help people who grep for the warning text after
seeing it from the compiler.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/CodingGuidelines | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index ccaea39752..d0fc7cfe60 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -258,6 +258,13 @@ For C programs:
    ensure your patch is clear of all compiler warnings we care about,
    by e.g. "echo DEVELOPER=1 >>config.mak".
 
+ - When using DEVELOPER=1 mode, you may see warnings from the compiler
+   like "error: unused parameter 'foo' [-Werror=unused-parameter]",
+   which indicates that a function ignores its argument. If the unused
+   parameter can't be removed (e.g., because the function is used as a
+   callback and has to match a certain interface), you can annotate the
+   individual parameters with the UNUSED keyword, like "int foo UNUSED".
+
  - We try to support a wide range of C compilers to compile Git with,
    including old ones.  As of Git v2.35.0 Git requires C99 (we check
    "__STDC_VERSION__"). You should not use features from a newer C
-- 
2.46.0.754.g24c813f009

