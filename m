From: Jeff King <peff@peff.net>
Subject: Re: False positives in git diff-index
Date: Wed, 5 Jan 2011 03:08:02 -0500
Message-ID: <20110105080802.GA15997@sigill.intra.peff.net>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com>
 <20110105054825.GC5884@sigill.intra.peff.net>
 <AANLkTimQCMr+emw=rXdBKKnD_W9G981zCkboKgiDWxPF@mail.gmail.com>
 <20110105061515.GA12163@sigill.intra.peff.net>
 <AANLkTimFbodDe=DMj5kkR749sG8bDTxyjDCtOEvmDkRd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 09:08:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaOPo-0002HZ-Uj
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 09:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab1AEIIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 03:08:11 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50737 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298Ab1AEIIL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 03:08:11 -0500
Received: (qmail 30400 invoked by uid 111); 5 Jan 2011 08:08:08 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 05 Jan 2011 08:08:08 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jan 2011 03:08:02 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimFbodDe=DMj5kkR749sG8bDTxyjDCtOEvmDkRd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164556>

On Wed, Jan 05, 2011 at 07:46:19AM +0000, Alexander Gladysh wrote:

> ----> Rebuilding manifest...
> Making manifest for .
> Generating index.html for .
> :100644 100644 483a7292436daecc9bea0ab265ee19d587b14298
> 0000000000000000000000000000000000000000
> M	cluster/localhost-ag/rocks/index.html
> :100644 100644 fcb9ff896fd1a1bd15663fa9be19b250789d4a25
> 0000000000000000000000000000000000000000
> M	cluster/localhost-ag/rocks/manifest
> 
> These are the two files, which are overridden with identical content.
> (See below, looks like I realized who to blame.)
> 
> If I read this correctly, Git tells me that the files are deleted. No?

No, it just means that the files are stat-dirty with respect to the
index. For example:

  $ git init
  $ touch file && git add file && git commit -m one
  $ touch file
  $ git diff-files
  :100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 M      file
  $ git update-index --refresh
  $ git diff-files
  <no output>

But in your case, the stat information should be up to date, since you
just ran update-index. But see below.

> > Are you running on top of any special filesystem that might not meet the
> > consistency guarantees we expect (though in that case, I would assume my
> > trivial script would have reproduced).
> 
> And here I have to say "Oops".
> 
> My apologies, I should have realized this before: my project is
> mounted on VMWare's HGFS.
> 
> (That is: VMWare Fusion Ubuntu Guest -> HGFS -> OS X 10.6 Host files.)
> 
> The problem is not reproduced if I copy the project to the native fs
> in the guest machine.
> 
> But the problem is also not reproduced if I execute your script on the HGFS.
> 
> So, does that mean that HGFS violates consistency guarantees?

Hmm. That could be the problem.  It may not violate traditional
consistency guarantees, but I wonder if it is returning slightly
different stat information between the program runs. That would mean
"git status" does an index refresh and puts some stat information in the
index, but the followup "git diff-index" might see different stat
information.

That's just a theory, though. You might try the patch below:

diff --git a/read-cache.c b/read-cache.c
index 4f2e890..1b415a3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -283,6 +283,8 @@ int ie_match_stat(const struct index_state *istate,
 		return DATA_CHANGED | TYPE_CHANGED | MODE_CHANGED;
 
 	changed = ce_match_stat_basic(ce, st);
+	if (changed)
+		fprintf(stderr, "changed (%u): %s\n", changed, ce->name);
 
 	/*
 	 * Within 1 second of this sequence:

The number in parentheses is the bitwise-or of the things git found that
caused the stat information to be stale (the actual flags are the
*_CHANGED defines in cache.h, but I was too lazy to write a
pretty-printer). If you can get the output from diff-files for the error
case, we can at least see why git thinks the cache is stale.

-Peff
