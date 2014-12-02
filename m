From: Jeff King <peff@peff.net>
Subject: Re: http-protocol question
Date: Tue, 2 Dec 2014 00:33:32 -0500
Message-ID: <20141202053331.GA31516@peff.net>
References: <CAGyf7-HmvvHQZkyLgKAs2rrZTTLFkBa8s828hbS9LedLNb2fWA@mail.gmail.com>
 <20141202033416.GY6527@google.com>
 <CAGyf7-GZbRBN4O_yNgrmJCya=6f8XQ4O8m7WBa1k8Ve196ajYQ@mail.gmail.com>
 <20141202044522.GZ6527@google.com>
 <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 06:33:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvg5f-0006zO-Eo
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 06:33:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbaLBFdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2014 00:33:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:46957 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752714AbaLBFdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2014 00:33:31 -0500
Received: (qmail 19085 invoked by uid 102); 2 Dec 2014 05:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Dec 2014 23:33:31 -0600
Received: (qmail 13028 invoked by uid 107); 2 Dec 2014 05:33:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 Dec 2014 00:33:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2014 00:33:32 -0500
Content-Disposition: inline
In-Reply-To: <CAGyf7-Gx1VU-1OicCHG0sStUnNXy_0Y8VYUP+PZjpN6nz7dTrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260536>

On Tue, Dec 02, 2014 at 04:04:11PM +1100, Bryan Turner wrote:

> > Can you say more about the context?  For example, was this actually
> > happening, or is this for the sake of understanding the protocol
> > better?
> 
> I ask because it's actually happening. Heavy CI load sometimes has
> builds fail because git clone dies with "not our ref". That's the
> specific context I'm working to try and address right now. Some teams
> use rebase-heavy workflows, which also evades the check_non_tip easing
> and fails with "not our ref", so I can't be 100% certain it's ref
> deletion in specific causing it (but I guess which of those it is is
> probably largely academic; as long as hosting spans multiple requests
> it seems like this type of race condition is unavoidable).

There is a practical reason to care. Ref deletion will also delete the
reflog, leaving no trace of the reachability. Whereas a non-fast-forward
push could be resolved by looking in the reflog.

One problem with hunting for sha1s in the reflog is that upload-pack
does not know which ref the client thinks they are requesting. So a
search would involve looking in _every_ reflog, which could be
expensive. It might not be too painful if you do the search only after
hitting a "not our ref" condition, which should in theory be rare. A
malicious client could convince you to grep your reflogs repeatedly, but
that is hardly the only way to convince upload-pack to chew CPU. Asking
it to make a pack comes to mind. :)

> I'm trying to decide if there is something I can enable or tune to
> prevent it, and the type of twilighting hinted at by the http-protocol
> documentation seemed like it could be just the thing.

For a public repository, it might make sense to provide a config option
to loosen the is_our_ref check completely (i.e., to just has_sha1_file).
But such an option does not yet exist.

-Peff
