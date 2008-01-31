From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Wed, 30 Jan 2008 23:30:56 -0500
Message-ID: <20080131043056.GX24004@spearce.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org> <20080130083315.GB8698@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 05:31:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKR5V-0007le-Cp
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 05:31:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbYAaEbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 23:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbYAaEbN
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 23:31:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49551 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbYAaEbM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 23:31:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JKR4Y-0001ol-TV; Wed, 30 Jan 2008 23:30:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1806520FBAE; Wed, 30 Jan 2008 23:30:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080130083315.GB8698@artemis.madism.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72100>

Pierre Habouzit <madcoder@debian.org> wrote:
> On Wed, Jan 30, 2008 at 04:22:01AM +0000, Shawn O. Pearce wrote:
> > [...] But maybe the
> > Debian folks just doesn't worry about this as it isn't a real issue.
> 
>   It is, we have since recently the princple of "Debian Maintainers",
> people that are only allowed to upload their own package, and the
> keyring used for that purpose is versionned using a custom development
> of ours called jetring (by Joey Hess and al.), I suppose the sources are
> somewhere around, and it has an internal ascii-armored database IIRC
> _and_ a gpg-usable keyring, I think. Or is able to generate the keyring
> at least.

I looked at jetring earlier today, after you posted the URL in
your other email.  Its an interesting tool for distributed keyring
management.  I can see why the Debian folks use it, but it does seem
a little awkward if one has to create those change files by hand.
 
>   But for the case I discussed, indeed, I'd use
> /usr/share/keyrings/debian-keyring.gpg anyways, and won't be the one
> updating it. That's why your developpement should be able to allow
> checking against another keyring. IOW I'm less and less sure that you
> want to manage the keyring _necessarily_ inside the git tree, and that
> allowing any external way to manage a keyring (inside a git tree beeing
> one of the options) is the most flexible way.

Of this you have convinced me.

If we get any sort of push authorization based upon PGP signatures
implemented we should be validating against a keyring that is
configured by a receive.keyring configuration option, and that
defaults to $GIT_DIR/receive-keyring.gpg or something suitable.
If you want to point receive-pack at an existing keyring on your
system, you can and should do so.
 
> > Having GIT_PUSHER_{NAME,EMAIL} makes it easier for a hook to
> > obtain information about this person and use it in an automated
> > email message.  Think a post-receive hook that automatically sends
> > out announcement emails.
> 
>   okay, that makes sense. Sorry about the obvious parts, it sensed like
> you didn't used gpg on a regular basis, hence wasn't sure of what you
> already knew or not. I agree that for the sake of logging GIT_PUSHER_*
> are nice, since as you can see on the CLI examples I gave, gpg says that
> the email associated to my key is pierre.habouzit@polytechnique.edu
> whereas I ususally contribute to open source projects using
> madcoder@debian.org ;)

A repository owner may require that to push your GIT_PUSHER_*
values must match the data found in your PGP key on their keyring,
just to keep their logs in a particular way.  Others may not care
and would allow anything, so long as the signature was validated
by a key on the keyring.  But I think that level of checking is
something we leave up to the repository owner.

Which leads me to three variables:

	GIT_PUSHER_NAME
	GIT_PUSHER_EMAIL
	GIT_PUSHER_KEYID

the latter being important if you really wanted to enforce the
$GIT_PUSHER_EMAIL matching the data within the public key used.

-- 
Shawn.
