From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 20:29:15 -0500
Message-ID: <20090217012915.GB24822@coredump.intra.peff.net>
References: <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com> <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302> <4999BD54.8090805@gmail.com> <7vprhidpnc.fsf@gitster.siamese.dyndns.org> <20090216224330.GA23764@sigill.intra.peff.net> <7vhc2uezl7.fsf@gitster.siamese.dyndns.org> <20090217002352.GA23507@coredump.intra.peff.net> <7vocx1evvs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 02:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZEnO-0000Ws-6b
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 02:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbZBQB3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 20:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbZBQB3S
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 20:29:18 -0500
Received: from peff.net ([208.65.91.99]:60981 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbZBQB3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 20:29:18 -0500
Received: (qmail 24734 invoked by uid 107); 17 Feb 2009 01:29:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Feb 2009 20:29:37 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2009 20:29:15 -0500
Content-Disposition: inline
In-Reply-To: <7vocx1evvs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110291>

On Mon, Feb 16, 2009 at 04:43:03PM -0800, Junio C Hamano wrote:

> That sounds similar to saying "I left my editor open without saving my
> changes, and accidentally opened another instance of an editor from a
> different terminal and edited the same file, the result is a mess".  The
> editors protect users from such a situation by locking the file they are
> editing.

It is definitely similar.

> Perhaps operations that detaches HEAD (rebase and perhaps sequencer) can
> all agree to use a single marker file that says "Do not mess with these
> refs via push or fetch" and make receive-pack and fetch honor that?  Then
> the issue you raised in your earlier message about receive-pack having to
> know random states random set of tools leave will be alleviated.  We need
> to make sure that the marker is cleaned up correctly when the command is
> done with the lock, of course.

I think such a marker is a fine idea in general, because it would be
nice to be able to say "what is all state in the repo that I might care
about" (which I think has been talked about several times). In fact, I
have had a similar problem _without_ pushing just by leaving and coming
back in the middle of operations, especially failed ones (e.g., "git
am", realize the patch doesn't apply, forget to --abort, then make more
commits, realize only when you try to "git am" something else, but now
aborting will intermediate work).

I'm not sure that supporting it in receive-pack is necessary. The
current rebase code already detects the situation; it just doesn't
handle it as gracefully as it might. And it doesn't close _all_
possibility for danger, as the example you gave previously shows; the
user can still be surprised by the ref changing.

Whereas improving the local tool support for "rebase --abort" and "am
--abort" to help a user recover from such a situation means that we help
not only the situation of somebody pushing, but also local "I forgot
and changed the repo" situations.

> > I am really just proposing that the "ref was not what we expected"
> > message to better indicate what is going on, and how the user might get
> > out of it. Do you not agree with that?
> 
> The recovery recipe you described looked good.

OK. I'll look at working up a patch.

-Peff
