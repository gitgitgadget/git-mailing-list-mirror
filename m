From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] patch-ids.c: cache patch IDs in a notes tree
Date: Sun, 12 May 2013 10:08:51 +0100
Message-ID: <20130512090850.GH2299@serenity.lan>
References: <9d9e56d323b40fe9ea2a6484e35f0afcd3a3a85b.1368301939.git.john@keeping.me.uk>
 <CA+55aFyn0+Q4CA6yQZipaCRB0w9cW4YpuL3XuxU2JR5QPp98XQ@mail.gmail.com>
 <20130511214900.GF2299@serenity.lan>
 <CA+55aFzinmXA2HtA3hmN1VVOcLPWedfqJRws0RJMEc1By1VLLg@mail.gmail.com>
 <alpine.DEB.1.00.1305111846160.8213@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 12 11:09:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbSHJ-00074B-Nv
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 11:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab3ELJJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 05:09:08 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49077 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054Ab3ELJJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 05:09:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0BD93CDA5B7;
	Sun, 12 May 2013 10:09:06 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XPMGht19RD8V; Sun, 12 May 2013 10:09:03 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id BA745CDA57C;
	Sun, 12 May 2013 10:09:02 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 93295161E0BC;
	Sun, 12 May 2013 10:09:02 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mNHwHPvldd1m; Sun, 12 May 2013 10:09:00 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C36E8161E20B;
	Sun, 12 May 2013 10:08:53 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1305111846160.8213@s15462909.onlinehome-server.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224029>

On Sat, May 11, 2013 at 06:57:02PM -0500, Johannes Schindelin wrote:
> On Sat, 11 May 2013, Linus Torvalds wrote:
> 
> > [...] I really think caching patch ID's should be something people
> > should be aware of is fundamentally wrong, even if it might work.
> 
> Given the incredible performance win, I would say it is still worth
> looking into.
> 
> If you store also a hash of Git version and diff options (may even be the
> hash of the raw bytes of the diff options if you do not plan to share the
> ref between machines) with the patch ID, you can make it safe.
> 
> That hash would be generated at patch_id init time and
> load_cached_patch_id() would check this hash in addition to the return
> value of get_sha1() (and ignore the note if the version/diff options
> differ).

I was thinking about this overnight, glad to see someone else had the
same idea :-)

It's slightly annoying because the diff options can be customized after
we return from init_patch_ids() so we either need a new
setup_patch_ids() function to be run after init once diff options have
been set or to set it lazily.  I'll try introducing a setup function.

> If you are following git.git slavishly, maybe hashing just the major/minor
> Git version would be in order to avoid frequent regeneration of identical
> patch IDs.

I think just storing the version is quite good here, and it avoids pain
when a topic that affects patch IDs is working its way through pu and
next.

> > And quite frankly, if you do rebases etc so much that you think patch
> > ID's are so important that they need to be cached, you may be doing
> > odd/wrong things.
> 
> AFAICT John actually gave a very valid scenario that validates his use
> case: git-gui patches are best tested in the git.git scenario but have to
> be contributed via git-gui.git. It's not John's fault that this typically
> requires a lot of rebasing between vastly divergent histories.

Actually, I don't think that use case is valid.  Because it's a subtree
merge I can be absolutely certain that nothing on the LHS of
master...git-gui/master is patch identical to anything on the RHS since
all the paths are different.  So doing "git log --cherry-mark" in that
case is completely useless.  I think my script should be able to learn
that, which gets rid of the really horrible case I was seeing, but it
would be nice to improve the "fast enough" cases as well if it can be
done without too much effort.
