Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C3746E
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710568619; cv=none; b=o9wKVMsskuqfTXBJ0vyhm1TUpBXqWLXbzgL776rHrZ9SA0cJVz+5Kxab3WrKLfMwbWTPiI93Kg7DhXNtyXorBGamTXCt+lLjL41s+M7Lhv5H3F0UWOW7NkyzNGHvT3Lb2KoTFk0Zbg329YQuzsOJg+GClCn01RylMt+My2EnDug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710568619; c=relaxed/simple;
	bh=nJWPy9xlX3vv3HxR4Lmdu3YtiuJVCKxd/CgtkiTbBaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXKKhYI416A5g26xD38xEbDWhVGDhupx0znm2Cnz+R4utzCCjpIX/qQ5z4HcMh9OogJ3aEQiDvn1k/yY99uE51OqZjgUWekIGehKjv9QAcSSw29anASuW5tcAoHUKSZXVgeu2E74FmdailZwULCHzaxCFw262YkHU3qLyvlJub4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5425 invoked by uid 109); 16 Mar 2024 05:50:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Mar 2024 05:50:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7076 invoked by uid 111); 16 Mar 2024 05:50:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Mar 2024 01:50:18 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 16 Mar 2024 01:50:13 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Dragan Simic <dsimic@manjaro.org>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Message-ID: <20240316055013.GA32145@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
 <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
 <20240315081041.GA1753560@coredump.intra.peff.net>
 <xmqqr0gbtsdz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqr0gbtsdz.fsf@gitster.g>

On Fri, Mar 15, 2024 at 08:40:56AM -0700, Junio C Hamano wrote:

> > That's assuming we don't want to go the commentString route, which would
> > require a bit more re-working of the patch. I'm also open to a more
> > clever or pretty multi-byte example if we have one. ;)
> 
> Adding core.commentString can be done long after the dust settles
> and I would expect that most of the changes in the patch would not
> have to be updated.  The parts that use comment_line_str variable do
> not have to change, the documentation needs "core.commentString is a
> synonym for core.commentChar, the latter of which is understood by
> older versions of Git (but they may use only the first byte of the
> string)" or something, but other than that, the existing text after
> this patch does not have to be updated.  If we add a proper synonym
> support to the config machinery, that would be a sizable project,
> but otherwise it would be just another "if (!strcmp()) var = val".

Yeah, I agree we could add core.commentString on top of what's here, as
long as we're OK with core.commentChar starting to accept strings in the
meantime. Which is probably reasonable, and in which case the code
portion of the patch really is just:

diff --git a/config.c b/config.c
index 92c752ed9f..13fb922bf5 100644
--- a/config.c
+++ b/config.c
@@ -1560,7 +1560,8 @@ static int git_default_core_config(const char *var, const char *value,
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
-	if (!strcmp(var, "core.commentchar")) {
+	if (!strcmp(var, "core.commentchar") ||
+	    !strcmp(var, "core.commentstring")) {
 		if (!value)
 			return config_error_nonbool(var);
 		else if (!strcasecmp(value, "auto"))

(the real work of course being in docs and tests).

If we wanted to distinguish them more (say, core.commentChar remains
as-is but core.commentString allows strings and takes precedence), then
we'd need to do it now to avoid flip-flopping between versions. I don't
see a huge benefit in restricting commentChar though.

> Stepping back a bit, one thing that we do need to mention in this
> round is what happens when you use multi-byte sequence and have it
> accessed by existing versions of Git.  "use only the first byte" I
> wrote above came out of thin air without experimenting or reading
> the code, but something like that ought to be part of the "Note
> that" paragraph above.
> 
> 	(default '#'). Note that this variable can be a string like
> 	`//` or `⁑⁕⁑`; it doesn't have to be a single ASCII character.
> 	Also note that older versions of Git used only the first byte
> 	(not necessarily a character) of the value of this variable,
> 	so you may want to be careful if you plan to use versions of
> 	Git older than 2.45.

The current code barfs for anything larger than a byte:

  $ git.v2.44.0 -c core.commentchar=foo stripspace -s
  error: core.commentChar should only be one ASCII character
  fatal: unable to parse 'core.commentchar' from command-line config

I'm mixed on these sorts of version-specific notes in the documentation.
For people who aren't mixing versions, the history is useless noise
(whose value decreases as time goes on and 2.45 becomes "old" itself).
For people who do use older versions, they'd quickly get an error like
the one above.

So I dunno. I'm not strictly opposed, but if this is something we think
is worth warning about, then that implies to me that it is worth
providing a more ergonomic solution like core.commentString.

-Peff
