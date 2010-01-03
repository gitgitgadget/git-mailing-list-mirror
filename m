From: Jeff King <peff@peff.net>
Subject: Re: suppress fatal pathspec errors from "git add"?
Date: Sun, 3 Jan 2010 03:28:05 -0500
Message-ID: <20100103082804.GA23748@sigill.intra.peff.net>
References: <d7ac1a680912311324i85b7a5anadaf2ac13f215873@mail.gmail.com>
 <20100103074058.GB23031@sigill.intra.peff.net>
 <7vk4vz38v0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: aaron smith <beingthexemplarylists@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 03 09:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRLpH-0005GU-46
	for gcvg-git-2@lo.gmane.org; Sun, 03 Jan 2010 09:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab0ACI2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Jan 2010 03:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438Ab0ACI2J
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jan 2010 03:28:09 -0500
Received: from peff.net ([208.65.91.99]:51034 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751096Ab0ACI2J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jan 2010 03:28:09 -0500
Received: (qmail 740 invoked by uid 107); 3 Jan 2010 08:32:51 -0000
Received: from 97-81-72-200.dhcp.athn.ga.charter.com (HELO sigill.intra.peff.net) (97.81.72.200)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 03 Jan 2010 03:32:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 03 Jan 2010 03:28:05 -0500
Content-Disposition: inline
In-Reply-To: <7vk4vz38v0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136071>

On Sun, Jan 03, 2010 at 12:12:19AM -0800, Junio C Hamano wrote:

> If your primary activity that happens in the work tree were:
> 
> 	while :
>         do
>         	file=$(date +"random-%H%M%S")
>                 >"$file"
>                 rm -f "$file"
> 	done
> 
> and your add were done in
> 
> 	while sleep 3600
>         do
> 		git add $(for i in *; do test -e $i && echo $i; done)
>                 git commit -m "hourly snapshot"
> 	done
> 
> totally asynchronously without coordinating with what the primary activity
> is doing, your "test -e && echo" can race with a concurrent "rm".

Of course. But in such a situation, you are almost certainly better off
doing "git add -A". The external loop is really only useful if you want
to add a subset of the files that may or may not exist for some reason.
Which is getting pretty specific and crazy.

I haven't checked to see whether "add -A" has a race in discovering
files versus actually adding them (I suppose there has to be one...even
if we open() immediately and use fstat() and friends for everything
else, there still must be a race between getting the name from readdir()
and calling open()).

And I can see that as a potentially useful workflow: you are doing
regular snapshots of a set of files which are being changed by an
outside force. You care about errors, but not files disappearing between
readdir() and stat(). The "find" command has an "--ignore-readdir-race"
option, which is what you would want.

But that is not "--ignore-errors should also ignore missing files". It
is "I want to ignore missing files but not other errors".

> Even though I think it is an insane use pattern that we shouldn't bother
> to bend too much backwards to support it, --ignore-errors were added
> primarily for a similar use case (i.e. by the time we try to read it, it
> is either gone or it cannot be read by the user who runs "git add"), so in
> that sense it _might_ make sense to ignore all errors with the option.  If
> we choose to go in that direction, it would also make tons of sense to
> update the documentation of the option to caution more strongly that its
> use is a sign of insanity and is discouraged at the same time.

I tracked down the original thread and it looks like the motivation was
to handle repositories with a mixed set of readable and inaccessible
(due to permissions) files:

 http://article.gmane.org/gmane.comp.version-control.git/75676

So I think it's not _totally_ insane there. You would do "git add
--ignore-errors ." instead of having to manually write the shell loop of
accessible items (though personally, I think I would just write the
shell loop in that situation).

That's just my two cents on the matter. I'm not personally planning on
writing patches for either case.

-Peff
