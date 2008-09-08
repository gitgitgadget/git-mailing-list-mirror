From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Alternates and push
Date: Mon, 8 Sep 2008 07:56:54 -0700
Message-ID: <20080908145654.GC10252@spearce.org>
References: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com> <20080906162030.GT9129@mit.edu> <7viqt9rvwm.fsf@gitster.siamese.dyndns.org> <20080907234118.GA8161@mit.edu> <7v4p4ri5t2.fsf@gitster.siamese.dyndns.org> <7viqt7gmtq.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0809080246520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@MIT.EDU>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KciCA-0003Na-Iw
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 16:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbYIHO44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 10:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753386AbYIHO44
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 10:56:56 -0400
Received: from george.spearce.org ([209.20.77.23]:39055 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbYIHO4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 10:56:55 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 61D733835C; Mon,  8 Sep 2008 14:56:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0809080246520.19665@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95256>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Sun, 7 Sep 2008, Junio C Hamano wrote:
> > 
> > Oops, I forgot to Cc Daniel.  Shawn also CC'ed because he will have the
> > same issue with the smart CGI based http-push he is building.

Not just the smart CGI based http-push thingy.  JGit is impacted
anytime we start talking about network transport.  ;-)
 
> > The sending end, however, has a safety to silently ignore malformed refs
> > it learns from the receiving end over the wire.  So the current sender
> > won't work with asterisk in there '*', nor full-pathname, because
> > typically it contains "/.git/" in the string, which would make it an
> > invalid refname to be ignored.
> > 
> > Also, the sending end remembers the objects we have per refname, so
> > sending two records with the same refname pointing at two different
> > objects will not work well either (the current code is loose and does not
> > check duplicates, but that is not a feature by design but is an accident).

Cute. Learn something new every day.

JGit doesn't do the check_ref_format(), but it does do duplicate
detection.  If the remote side sends us duplicate advertisements
JGit freaks out and aborts the transfer.  This is largely just a
function of JGit hashing the advertised refs for O(1) access later
on during processing.  We avoid a lot of ugly O(N^2) loops that way.

> I think we should use a really invalid ref name, like "^" or something 
> like that, so that it's clearly not an actually available ref, but just a 
> way for the remote to mention that it has the object, and the remote 
> doesn't have to try to make it unique.

I agree.  How about just calling all of these ".have"?

According to check_ref_format() it fails, so older clients will
just ignore it.  Attempts by bad clients to push or delete ".have"
should also fail automatically in receive-pack's own test at the
start of the update() function.

Using a constant name for all instances hides what the underlying
alternates really have, in case their branches aren't public, but
their databases are.  It also makes it easier for hashing clients
like JGit to collect these object IDs into a table of known objects,
but ignoring the name component.

Sadly no matter what we do here JGit's duplicate detection is in
direct opposite behavior with git.git's ignoring check_ref_format()
failures.  So we'll have to patch JGit no matter what we do.

-- 
Shawn.
