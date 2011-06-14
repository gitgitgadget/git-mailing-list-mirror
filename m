From: Jeff King <peff@peff.net>
Subject: Re: Git is not scalable with too many refs/*
Date: Tue, 14 Jun 2011 15:47:49 -0400
Message-ID: <20110614194749.GA1567@sigill.intra.peff.net>
References: <BANLkTimnCqaEBVreMhnbRBV3r-r1ZzkFcg@mail.gmail.com>
 <7vtybtm3dl.fsf@alter.siamese.dyndns.org>
 <BANLkTimNoh3-Jde_-arzwBa=aUR+KK3Xhw@mail.gmail.com>
 <201106141202.46720.johan@herland.net>
 <20110614170214.GB26764@sigill.intra.peff.net>
 <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Ericsson <ae@op5.se>,
	NAKAMURA Takumi <geek4civic@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 21:47:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWZaf-0001t4-Po
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 21:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729Ab1FNTrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 15:47:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51821
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753553Ab1FNTrv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 15:47:51 -0400
Received: (qmail 30221 invoked by uid 107); 14 Jun 2011 19:48:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Jun 2011 15:48:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2011 15:47:49 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin0CjnM_hMaEpMroZdDhhavaoKAv00_4xBqeHj9biToVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175795>

On Tue, Jun 14, 2011 at 12:20:29PM -0700, Shawn O. Pearce wrote:

> > We would want to store the cache in an on-disk format that could be
> > searched easily. Possibly something like the packed-refs format would be
> > sufficient, if we mmap'd and binary searched it. It would be dirt simple
> > if we used an existing key/value store like gdbm or tokyocabinet, but we
> > usually try to avoid extra dependencies.
> 
> Yea, not a bad idea. Use a series of SSTable like things, like Hadoop
> uses. It doesn't need to be as complex as the Hadoop SSTable concept.
> But a simple sorted string to string mapping file that is immutable,
> with edits applied by creating an overlay file that contains
> new/updated entries.
> 
> As you point out, we can use the notes tree to tell us the validity of
> the cache, and do incremental updates. If the current cache doesn't
> match the notes ref, compute the tree diff between the current cache's
> source tree and the new tree, and create a new SSTable like thing that
> has the relevant updates as an overlay of the existing tables. After
> some time you will have many of these little overlay files, and a GC
> can just merge them down to a single file.

I was really hoping that it would be fast enough that we could simply
blow away the old mapping and recreate it from scratch. That gets us out
of writing any journaling-type code with overlays. For something like
svn revisions, it's probably fine to take an extra second or two to
build the cache after we do a fetch. But it wouldn't scale to something
that was getting updated frequently.

If we're going to start doing clever database-y things, I'd much rather
use a proven key/value db solution like tokyocabinet. I'm just not sure
how to degrade gracefully when the db library isn't available. Don't
allow reverse mappings? Fallback to something slow?

> The only problem is, you probably want this "reverse notes index" to
> be indexing a portion of the note blob text, not all of it. That is,
> we want the SVN note text to say something like "SVN Revision: r1828"
> so `git log --notes=svn` shows us something more useful than just
> "r1828". But in the reverse index, we may only want the key to be
> "r1828". So you need some sort of small mapping function to decide
> what to put into that reverse index.

I had assumed that we would just be writing r1828 into the note. The
output via git log is actually pretty readable:

  $ git notes --ref=svn/revisions add -m r1828
  $ git show --notes=svn/revisions
  ...
  Notes (svn/revisions):
      r1828

Of course this is just one use case.

For that matter, we have to figure out how one would actually reference
the reverse mapping. If we have a simple, pure-reverse mapping, we can
just generate and cache them on the fly, and give a special syntax.
Like:

  $ git log notes/svn/revisions@{revnote:r1828}

which would invert the notes/svn/revisions tree, search for r1828, and
reference the resulting commit.

If you had something more heavyweight that actually needed to parse
during the mapping, you might have something like:

  $ : set up the mapping
  $ git config revnote.svn.map 'SVN Revision: (r[0-9]+)'

  $ : do the reverse; we should be able to build the cache on the fly
  $ git notes reverse r1828
  346ab9aaa1cf7b1ed2dd2c0a67bccc5b8ec23f7c

  $ : so really you could have a similar ref syntax like, though
  $ : this would require some ref parser updates, as we currently
  $ : assume anything to the left of @{} is a real ref
  $ git log r1828@{revnote:svn}

The syntaxes are not as nice as having a real ref. In the last example,
we could probably look for the contents of "@{}" as a possible revnote
mapping (since we've already had to name it via the configuration), to
make it "r1828@{svn}". Or you could even come up with a default set of
revnotes to consider, so that if we lookup "r1828" and it isn't a real
ref, we fall back to trying r1828@{revnote:svn}.

I dunno. I'm just throwing ideas out at this point.

-Peff
