Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE930256D
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 03:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722570685; cv=none; b=nhm/l2OxP1HRYWHWtP3A/7u6xybsm2Vr3xkyMAs6L0OeYiLtusMpumOi/FOahSW3XynAnWcRH0SlaAc9d/KnwZZhCsPWyVvzADKyAjj5TcP90iv6I6IEnwz83Ht830a6+GKQZNVAw2ShSSF0Wzu17lSVUlg68K4cEfQoB0h9XZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722570685; c=relaxed/simple;
	bh=861naQct1K8vJsAFyBfBSnMCKfDgRcJKmd5sW1p59xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JuziMcrqUPATlZXJvn+JDDi08bLezegqCkwF2IX3lfdDT4HsIWTgj9+MY75LNHIvw3R4ezszIGV6Nue0kZnR8z1o8cSLeaDyoDbTpr5nPSgLtI2EHx9SZ1VZiP/8UJXrV8V91AUUDl6tTwYw+6LlZ8OkhyL3QKap6svM2DB2b30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26863 invoked by uid 109); 2 Aug 2024 03:51:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Aug 2024 03:51:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7091 invoked by uid 111); 2 Aug 2024 03:51:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Aug 2024 23:51:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 1 Aug 2024 23:51:21 -0400
From: Jeff King <peff@peff.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: quiltimport mode detection oddity
Message-ID: <20240802035121.GB1246312@coredump.intra.peff.net>
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
 <xmqqed77hifn.fsf@gitster.g>
 <20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>

On Thu, Aug 01, 2024 at 06:07:06PM -0700, Andrew Morton wrote:

> > So, the patch removes autoconf.h file from that directory.  The
> > "extended header" part between "diff --git" and "--- a/..." has
> > "deleted file mode 100664" and that is where the warning comes.
> 
> yup yup.  The patch says "remove this file which has mode 100664".
> 
> The file has mode 100664.
> 
> quiltimport says it had mode 100644.  Incorrectly, I suggest.

It's definitely a weird case. Git does not record full modes, but just
cares about the execute bit. So it normalizes modes for regular files to
100644 or 100755. You can see that with a simple example:

  git init
  echo foo >file
  chmod 664 file
  git add file
  git commit -m 'add file'

  git ls-files -s

  cat >patch <<\EOF
  diff --git a/file b/file
  deleted file mode 100664
  --- a/file
  +++ /dev/null
  @@ -1 +0,0 @@
  -foo
  EOF
  ls -l file
  git apply patch

Even though the filesystem has 100664, the index records 100644 (which
you can see from the "ls-files" output). And then when we apply the
patch, we get the "file has type 100644, expected 100664" message.
AFAICT, it has been that way forever (I tried as far back as git 1.6.6).
So this is nothing new, and I don't think Git would ever produce a patch
that said "file mode 100664" itself (I'm assuming in your case the patch
is coming from quilt).

Given that, I think it is reasonable for git to also normalize the mode
of the patches it reads, so that we are consistently working in the
world of simplified modes. I.e., this:

diff --git a/apply.c b/apply.c
index 142e3d913c..3d50fade78 100644
--- a/apply.c
+++ b/apply.c
@@ -995,6 +995,7 @@ static int parse_mode_line(const char *line, int linenr, unsigned int *mode)
 	*mode = strtoul(line, &end, 8);
 	if (end == line || !isspace(*end))
 		return error(_("invalid mode on line %d: %s"), linenr, line);
+	*mode = canon_mode(*mode);
 	return 0;
 }
 

which makes the warning go away in the example above. But I'm not sure
if there could be other fallout. E.g., is there a mode for git-apply to
just touch the working tree and not the index, where we'd perhaps want
to retain the original to compare against the filesystem mode? I don't
think so.

Alternatively (or maybe in addition), I wonder if quilt should similarly
canonicalize the mode. git-apply is certainly meant to work with patches
generated elsewhere, but normal patches don't have modes in them at all.
The "deleted file mode" line is git-ism, so here we have something which
is implementing the git line in a (slightly) incompatible way.

-Peff
