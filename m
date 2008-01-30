From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Tue, 29 Jan 2008 23:22:01 -0500
Message-ID: <20080130042201.GO24004@spearce.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jan 30 05:22:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK4TQ-0002t6-8S
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 05:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312AbYA3EWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 23:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751658AbYA3EWK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 23:22:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47869 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbYA3EWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 23:22:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JK4SQ-00035G-QC; Tue, 29 Jan 2008 23:21:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4A0A820FBAE; Tue, 29 Jan 2008 23:22:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080129190845.GC30093@artemis.madism.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72020>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Tue, Jan 29, 2008 at 04:10:00AM +0000, Shawn O. Pearce wrote:
> > * PGP public key storage:
> > 
> >   Use a "hidden" ref called "refs/access-keys" to store a commit.
> >   The access control change log is a normal Git commit chain.
> 
>   This won't work well, because I don't think GnuPG is able to check
> some signature against an armored GPG public Key (at least I didn't
> found a way to do that). You have to create one pubring per submitter,
> wich is kind of a waste in fact, and the format is horribly binary.

Gaaah.

I hate tools that build their own little internal databases of
objects, and don't let you store their data in other random places,
like in any random file format you choose[*1*].  ;-)

I just read the GnuPG manual and you are obviously correct.  The only
way to get GnuPG to process a key is to load it onto a keyring.
We could extract the armored (or binary) public key and load it
onto a temporary keyring created just for the purpose of verifying
this connection, but that's rather messy.
 
>   I don't even know if you really need the versionning of this
> pseudo-keyring, and if a .git/keyring.gpg isn't enough.

Well, I don't know about that.

People come and go on a project.  It would be nice if there was
a reasonably trusted store available as part of the project, that
one can verify using a current trusted project member's public key,
and obtain prior project member's public keys out of.  But maybe the
Debian folks just doesn't worry about this as it isn't a real issue.

In the case of access control however I need to have a full history
of who had access, during what time periods.  If someone has their
access revoked, I need to know when it was revoked, and by whom.
Git commit chains make for a nice log of such activity.  Obviously
access changes don't need to be reflected through a GnuPG keyring,
and can be as simple as a text file listing the allowed users.

But as a remote administrator for my project (think repo.or.cz!)
how do I add new users to the keyring.gpg on the server?  Being
able to use the existing send-pack/receive-pack infrastructure to
transport the new public key has nice advantages.  Web UIs are
cool, but some of us are command line oriented animals.

>   As a side note, you don't really need to use GIT_PUSH_*. It doesn't
> make anything safer (as the UIDs of a given public key are public
> information anyways), you just want to know which key signed that data,
> and the signature holds that information. Hence if you still want to
> have a flat-file based keyring (which I repeat I don't think gpg
> supports directly -- and that's really a shame) you'd better index them
> per key fingerprint than by author name.

Yea, I know, you haven't told me anything I didn't already know.

Having GIT_PUSHER_{NAME,EMAIL} makes it easier for a hook to
obtain information about this person and use it in an automated
email message.  Think a post-receive hook that automatically sends
out announcement emails.

Having G_P_{NAME,EMAIL} makes it easier for the branch reflogs on the
server to have names in them.  If you look at your local reflogs they
are driven off GIT_COMMITTER_{NAME,EMAIL} and thus report something
meaningful about who did a change.  But when we are in receive-pack
and we update a reflog we don't really have this information, do we?

Having G_P_{NAME,EMAIL} makes it easier to write a hook that looks
up access control data and makes access control decisions based upon
symbols we like to refer to other water transport devices with.
I'd much rather refer to you by your given name 'Pierre' than by
your GPG key id BC6AFB5BA1EE761C.  Especially if I have to list
you in an access control file with 50 other people that lists which
branches you are allowed to push changes into, and which ones you
are restricted from.

Yes, I know the key ids are unique enough for our needs.  But dammit,
they just aren't friendly to work with when you are storing log
records for later inspection, or maintaing an access list.

There is after all reason we have a "tagger" field with a human
readable name on it, rather than relying solely on the GPG key id
of the signature.

>   And then you just need to call gpg this way:
> 
> $ gpg --keyring path/to/the/keyring.gpg --quiet --batch --status-fd 1 --verify some-file.tar.gz.gpg 2>|/dev/null
> [GNUPG:] SIG_ID dw0VliO0DFjOQA3HUSHijYekQYY 2008-01-29 1201633002
> [GNUPG:] GOODSIG BC6AFB5BA1EE761C Pierre Habouzit <pierre.habouzit@polytechnique.edu>
> [GNUPG:] VALIDSIG 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C 2008-01-29 1201633002 0 3 0 17 2 00 72B4C59ADA78D70E055C129EBC6AFB5BA1EE761C
> [GNUPG:] TRUST_ULTIMATE
> 
>   And if the key is not in your keyring this looks like:
> $ GNUPGHOME=/tmp gpg --verify --status-fd 1 some-file.tar.gz.gpg 2>/dev/null
> [GNUPG:] ERRSIG BC6AFB5BA1EE761C 17 2 00 1201633002 9
> [GNUPG:] NO_PUBKEY BC6AFB5BA1EE761C
>                    ^^^^^^^^^^^^^^^^
>             that's the key id you look for.

Urgh.  So then we need to go and extract that key, load it onto a
temporary keyring, then reinvoke gpg with the temporary keyring,
just to verify the short command input we received?  Ouch.

OK, maybe I'm making it sound worse than it really will be.

I'm currently finishing a side-band-64k protocol extension to the
send-pack/receive-pack pair.  My next task after I flush those
RFC patches out to the list tonight will be to prototype at least
some of the auth1 extension I described.  I'll maybe try to keep
it really simple initially, which means doing what you suggested
above and using a .git/keyring.gpg for the repository.  Its not
easily remotely administered, but its only a damn proof of concept.



*1* If you don't get this joke, well, uh, I can't help you.
    Oh, ASCII formatted Git packfiles are on the way!  :)

-- 
Shawn.
