From: Theodore Tso <tytso@mit.edu>
Subject: Re: Confusion about diffing branches
Date: Mon, 27 Aug 2007 16:29:49 -0400
Message-ID: <20070827202949.GA3951@thunk.org>
References: <20070826233555.GA7422@mediacenter.austin.rr.com> <7v6431omn8.fsf@gitster.siamese.dyndns.org> <20070827014056.GB7422@mediacenter.austin.rr.com> <7vlkbxmp50.fsf@gitster.siamese.dyndns.org> <20070827075009.GA31438@glandium.org> <38b2ab8a0708270621l63f3da56j4667014e62a5de92@mail.gmail.com> <20070827170504.GH4680@thunk.org> <7vmywczyfp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Moreau <francis.moro@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 22:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPlF9-0007No-KY
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 22:31:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbXH0UaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 16:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbXH0UaI
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 16:30:08 -0400
Received: from THUNK.ORG ([69.25.196.29]:48845 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932884AbXH0UaE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 16:30:04 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1IPlMU-0001Pp-Ia; Mon, 27 Aug 2007 16:39:02 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.63)
	(envelope-from <tytso@thunk.org>)
	id 1IPlDZ-0004Ko-8p; Mon, 27 Aug 2007 16:29:49 -0400
Content-Disposition: inline
In-Reply-To: <7vmywczyfp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56879>

On Mon, Aug 27, 2007 at 10:20:42AM -0700, Junio C Hamano wrote:
> If you wanted to, you could:
> 
> 	$ git format-patch a a

Umm.... dare I ask why this works, or how someone would be expected to
know this?  Or is the answer, "Meditate deeply on builtin-log.c,
grasshopper"?  :-)

> might have been better.  It is (1) too late to change now, and
> (2) for too small or perhaps negative a gain.
> 
> The reason why I say (2) is because _I_ think it is far more
> common and frequent to want to get "patches the other guy does
> not have" than "everything since nothingness up to this point".

I agree, "patches the other guy does not have" is usually the more
common desired result.  The problem is that it breaks the regularity
of git's command line parsing, which is particularly painful given
that users are told to read the man page for git-rev-list and
git-rev-parse in order to understand all of the many, many options
that might be valid.  The fact that the man pages expect the user to
do this kinda implies that there is a regularity and orthogonality to
git's command structure --- which there is, mostly --- which makes the
git-format-patch "hack" that much more surprising.

So it's just one of those things which is surprising to someone who
hasn't been fingers deep in the guts of the git implementation for
years and years.  I think it took me a good hour or two of searching
before I was able to even figure out how the special case for
git-format-patch was getting implemented; it certainly wasn't well
documented in the code last year when I went searching to figure out
what the !@#@? was going on.

> Oops.  I think I have a solution.
> 
> 	$ git format-patch a a
> 
> does not do _ROOT_ commit.  So you have to say
> 
> 	$ git format-patch --root a a

Wow, I had no idea that --root would even be accepted by
git-format-patch.  It's not mentioned in the documentation, and a grep
of Documentation/*.txt shows that --root is only mentioned in the man
pages for git-blame, git-fsck, and git-diff-tree.  I assume it's the
latter which is getting used here, but there isn't even a mention in
the git-format-patch man page that options from git-diff-tree might be
applicable.  

I presume this is another, "meditate deeply on builtin-log.c and
revision.c, and understand that they implement many diverse builtin
commands, grasshopper" situation....

> for the above example to work.  Why not tweak the option parser
> so that:
> 
> 	$ git format-patch --root a
> 
> to do what you want?  Without --root and with a single positive
> commit, it can keep doing the traditional "what I did since I
> forked from that guy's history".

That seems to make a lot of sense; given the fact that the current
behaivor does make sense and is convenient, the big complaints were
always (1) not documenting clearly that this was an exception which
might be surprising (i.e., hanging a latern[1] on it), and (2) that
there wasn't a way to do the alternate expected behavior.  --root
handles the second, and an explanation in the man page saying that
yes, this is a little non-standard wrt to git-rev-list, but it's
convenient, and let the user know that he should just give us a pass
on it the non-orthoganlity.

					- Ted

[1] 
Daniel:   The mountain... blows up?
Martin:   No possible hope for survival! Cool huh? I just wrote it 
	  based on what's going on with the gate. I love it when art 
	  imitates life. 
Mitchell: Hang on. We're alive in the next scene.
Martin:   Oh, I just haven't fixed that part yet. I'm thinking I can 
	  back-sell it and say you were beamed out at the last second.
Daniel:   "Beamed out?"
Martin:   Sure, why not?
Teal'c:   Is that not too convenient?
Martin:   Not if you hang a lantern on it.
Daniel:   What's that?
Martin:   It's a writer's term. Another character points out how
	  convenient it is. Doctor Levant can say, "Wow, that was
	  great timing."  That way, the audience knows I intended for
	  it to be convenient, and we move on.
