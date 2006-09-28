From: Theodore Tso <tytso@mit.edu>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 21:36:11 -0400
Message-ID: <20060928013611.GC7469@thunk.org>
References: <Pine.LNX.4.64.0609271606050.3952@g5.osdl.org> <20060928001241.62887.qmail@web51013.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 03:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSkpR-0003wn-Qk
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 03:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031163AbWI1BgW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 21:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031320AbWI1BgW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 21:36:22 -0400
Received: from thunk.org ([69.25.196.29]:25491 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1031163AbWI1BgV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 21:36:21 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1GSkrI-00046x-8i; Wed, 27 Sep 2006 21:38:40 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.60)
	(envelope-from <tytso@thunk.org>)
	id 1GSkot-0003XC-5Z; Wed, 27 Sep 2006 21:36:11 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27962>

On Wed, Sep 27, 2006 at 05:12:41PM -0700, Matthew L Foster wrote:
> 
> Ignoring the separate issue of replication for a momment, can
> someone respond to my time integrity question about whether a future
> version of git could trust/prefer its local time rather than a
> remote/sub/parent (non replicated) git server's timestamp? 

No, it can't.  In order to do that it would have to change the commit,
and that would be rewriting history.

Consider a more complicated case of replication, where git is used
exclusively, so that a patch gets commited by developer A, pushed to
device driver maintainer B, which then gets pushed to subsystem
maintainer C, which then pushed to Linus's private tree, and then
Linus pushes it to the publically visible repository.  Now assume for
the sake of argument that developers A, B, and C all keep publically
visible repositories, all of which are accessible via gitweb.cgi, and
assume for the sake of argument that the patch is pushed exclusively
via git.  

In that case, the time that the changeset was made is the time that
developer A created the commit.  That is, of course, the time on his
local machine, which may or may not be accurate.  And of course, the
e-mail address which he gives may or may not be accurate as well.
There can be no integrity guarantees because we are not using
cryptography.  There are no time notaries, no public key signatures.
Both the time and the author name/e-mail are merely metadata which is
attached to the patch, and the time, author name/e-mail, and patch are
hashed together to form a SHA checksum of the commit.  So while we
don't have any kind of assurance about the time or author e-mail, what
we *do* have is an assurance that a commit's name --- which is the SHA
checksum --- refers to a specific patch, and with a specific claimed
timestamp and claimed e-mail name.  So if we refer to a particular
commit by that SHA hash value, we do know globally that we are always
referring to the same commit.  Changing the time would change the SHA
hash, which would make it impossible for two machines to know whether
or not a commit is the same or not.

More to the point, that particular commit will travel from developer
A, to B, to C, to Linus, to public repository on master.kernel.org.
During that whole time, it is invariant.  It cannot change, including
the commit timestamp.  Now, at each stage, as the patch gets pushed
along, all of the information ---- the patch itself, the claimed time,
and the claimed author date --- are used to evalute the patch and
decide whether or not the patch should be pushed higher up the trust
hierarchy.  In Linus, the most important thing which is used is an
evaluation of the patch itself.  If the patch is good, the fact that
the commit time might be six months in the past isn't necessarily a
problem.  

And of course, the commit time might be *right*.  It could be that
developer A did do the work six months ago, but merely sat on it for a
while before submitting it to maintainer B, and maybe maintainer B sat
on it because rc1 had passed and he was being a good doobie and not
forwarding patches on so that tree could stablize, and by the time rc7
was released, he had gotten tired of waiting, so pushed it on to
lieutenant C, and it finally got pushed to Linus after 2.6.18 was
released, many months later.  

> How do we fix gitweb.cgi, ref-log? 
> How useful is gitweb.cgi if timestamps are
> all over the place? It does not make sense that commit order is
> currently out of sync with time order in the main linux kernel tree
> git repo on kernel.org. 

Your problem is that you are putting too much faith in the time stamp.
It's there as a help, but it is no more trustworthy than the author
name or the patch description --- which is to say, if people in the
git hierarchy are happy with the commit, it will get pushed, and if
they aren't it won't.  And most people don't care about the time; they
care about whether the patch is correct.  Now, the time is mostly
correct, so if you look at the patch dependencies you can usually
determine when a patch was likely committed to the first local
repoistory to within a few hours in all likelihood.

Now, I could imagine a system where every changeset also had metadata
associated with it that involved a receipt from a time notary, and a
digital signature so that each patch could be cryptographically shown
to have come form some individual (or at least someone who posses that
particular individual's key).  This would add a lot more overhead to
the SCM, but at least it's theoretically possible.  The question is it
worth it?

At least within the Linux commmunity, the most important thing is
whether or not the patch is good, not whether it is cryptographically
signed by some particular developer.  And times are considered even
less important --- and given that a time notary is complex, and
requires out of band facilities such as publishing lists of checksums
and checksums of checksums in publically norepudiable places such as
classifie dadds in the New York Times, LA Times, and Washington Post,
it won't be something which is zero cost, either.  And given that no
one cares enough about times to spend that kind of resources, I very
much doubt git will ever support time notary support.

> Why must each and every repo be dependent on
> time being set properly on all other git servers? 

They don't.

> How useful is change history or commit order without some concept of
> (local) time order?

Very useful.  :-)

							- Ted
