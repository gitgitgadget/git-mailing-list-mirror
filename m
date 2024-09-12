Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C619EEA1
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726137804; cv=none; b=M1U/AGgVDvRtrPy7/Q5uqvPm+ucc8qjyQx73cmj5b0dHrcraDI9yRRRdtUf8Idh4UPomIjQkPYIGLtJP0xScy5j3gbDgclvPr8GRwp8kkxcdXQaiBbXsYRreu0svZ7sk47/zZvlwqqcC8iFP9Rp0viGDyVKjJhzgFOQ27OAXo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726137804; c=relaxed/simple;
	bh=ucni6qcXIjGN3x8LmQuwBUaFG9XXvylH+cyUIwlE2qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m79i5awibP8SJwYNDA6qVyb29eWZGrb9CKrI5kucYBxSFzxC6KkDY9ULL5U4bdHMXuA9rOTye5SzuQfGQnk/iFERFGOErGwz050l1pispA4qxPuU/4kNYnt3B7loA52dFJFqNkd8cM6R6IHN7HZBIk6MbHIvu8CW7qUXYscDPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17424 invoked by uid 109); 12 Sep 2024 10:43:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Sep 2024 10:43:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23882 invoked by uid 111); 12 Sep 2024 10:43:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2024 06:43:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 12 Sep 2024 06:43:19 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Cai via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 1/3] builtin: add a repository parameter for builtin
 functions
Message-ID: <20240912104319.GA593177@coredump.intra.peff.net>
References: <pull.1778.git.git.1725555467.gitgitgadget@gmail.com>
 <pull.1778.v2.git.git.1726001960.gitgitgadget@gmail.com>
 <9aaf966254493678d3e25b93cb11017c814d3087.1726001961.git.gitgitgadget@gmail.com>
 <xmqqed5rdw61.fsf@gitster.g>
 <xmqqfrq56gqm.fsf@gitster.g>
 <ZuK4RXMfherFBIxP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuK4RXMfherFBIxP@pks.im>

On Thu, Sep 12, 2024 at 11:45:47AM +0200, Patrick Steinhardt wrote:

> > It turns out to be an "ar" archive full of *.o files.  Perhaps
> > creation of libgit.a was interrupted, then later somebody said
> > "git add .", and the file somehow ended up as a part of Git.
> > 
> > I've applied the series after removing the cruft.
> 
> I've noticed that something leaves behind this garbage from time to
> time. It's a shame that its name is just random gibberish, because that
> makes it impossible to set up a gitignore rule for it.

I've seen it once or twice, too. It's always st[A-Za-z0-9]{6}, at least
on my system. Doing this:

diff --git a/Makefile b/Makefile
index 91f65d7dc5..b58312edab 100644
--- a/Makefile
+++ b/Makefile
@@ -2860,7 +2860,7 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
 		$(filter %.o,$^) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
-	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
+	$(QUIET_AR)$(RM) $@ && ($(AR) $(ARFLAGS) $@ $^ & sleep 0.01; kill $$!) && false
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^

and then running "make" several times got me:

  Untracked files:
  	st5AOnzl
  	st8gTTvD
  	stJABM4u
  	stKA7riS
  	stLZ4yDr
  	stMWJCVY
  	stjYXpN0
  	stwcX3kZ

I don't think we'd want to put anything in the tracked .gitignore, since
it involves system-specific details. But I think that:

  /st[0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z]

in your .git/info/excludes (or user-level gitignore) would work if you
want, and is probably not too likely to hit false positives (since it
lacks an extension).

I do feel like I have only started seeing it in the last month or so. I
wonder if a new version of binutils changed behavior or something.

-Peff
