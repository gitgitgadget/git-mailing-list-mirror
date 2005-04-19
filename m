From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Re: Darcs and git: plan of action
Date: Tue, 19 Apr 2005 02:55:05 +0200
Message-ID: <7iy8bf7fh2.fsf@lanthane.pps.jussieu.fr>
References: <7ivf6lm594.fsf@lanthane.pps.jussieu.fr>
	<20050418122011.GA13769@abridgegame.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Git Mailing List <git@vger.kernel.org>
X-From: darcs-devel-bounces@darcs.net Tue Apr 19 02:51:30 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNgxd-0005ka-73
	for gcvdd-darcs-devel@m.gmane.org; Tue, 19 Apr 2005 02:51:29 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DNh1D-0005RY-Li; Mon, 18 Apr 2005 20:55:11 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50) id 1DNh1A-0005PD-CE
	for darcs-devel@darcs.net; Mon, 18 Apr 2005 20:55:08 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3J0t7rm044720
	; Tue, 19 Apr 2005 02:55:07 +0200 (CEST)
X-Ids: 164
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id
	j3J0t5Ti006949 ; Tue, 19 Apr 2005 02:55:05 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DNh17-0001Xy-DO; Tue, 19 Apr 2005 02:55:05 +0200
To: darcs-devel@darcs.net
In-Reply-To: <20050418122011.GA13769@abridgegame.org> (David Roundy's
	message of "Mon, 18 Apr 2005 08:20:21 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.164]);
	Tue, 19 Apr 2005 02:55:07 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 426456EB.000 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

[Using git as a backend for Darcs.]

> The problem I have with this is that "other" repository formats (e.g. git)
> store "tree versions", not "changes", and I think it would be fragile to
> try to store "changes" (in the darcs sense) in them.

Not really; a Darcs patch is just a pair of two git versions (from and
to).  Which is why Darcs needs to support arbitrarily formatted patch
ids -- a patch originating from git will be identified by a pair of
git hashes.

Obviously, we'll need to think harder when pushing from darcs into git
(we'll need to preserve the Darcs patch id somehow), but it's premature
to worry about that right now.

>>  1. remove the assumption that patch IDs have a fixed format.  Patch
>>     IDs should be opaque blobs of binary data that Darcs only compares
>>     for equality.

> I'm not really comfortable with this,

Why?

>>  3. allow a patch to have multiple IDs; if the IDs associated to two
>>     patches are not disjoint, then the patches are the same patch.
>
> This I find a bit confusing.  So a patch can have two IDs, presumably
> something like a "darcs ID" and a "git ID"? I can see that this might
> simplify some things, but am not sure how it would work.  The IDs would
> have to have a hierarchy, so that you wouldn't ever end up with the "same"
> patch having disjoint IDs in two cases.

It's a case of ``don't do that''.

Suppose I record a patch in Darcs; it gets a Darcs id.  I push it into
git, at which point it gets a git id, whether we want it to or not.
What do we do when we pull that patch back into darcs?

Either we arbitrarily discard one of the ids (which one?), or we keep
both.  If there's more pulling/pushing going on on the git side, we
definitely need to keep both.

> Here's where I think I'd differ.

Same to you ;-)

> I think when dealing with git (and probably also with *any* other
> SCM (arch being a possible exception), we need to consider the
> exchange medium to be not a patch, but a tag.

We're thinking in opposite directions -- you're thinking of the alien
versions as integrals of Darcs patches, I'm thinking of Darcs patches
as derivatives of alien versions.

  You:  alien version = Darcs tag

  Me:   Darcs patch = pair of successive alien versions

My gut instinct is that the second model can be made to work almost
seamlessly, unlike the first one.  But that's just a guess.

> if we want long-term stability we might need to mummify a variant of
> the diff algorithm that we agree not to change,

Good point, noted.

> But avoiding "mv" patches would be downright silly.

Aye, that will require some metadata on the git side (the hack,
suggested by Linus, of using git hashes to notice moves won't work).
Happily, it's premature to worry about that, too.

                                        Juliusz
