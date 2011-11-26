From: Jeff King <peff@peff.net>
Subject: Re: what are the chances of a 'pre-upload' hook?
Date: Sat, 26 Nov 2011 17:55:20 -0500
Message-ID: <20111126225519.GA29482@sigill.intra.peff.net>
References: <CAMK1S_jaEWV=F6iHKZw_6u5ncDW0bPosNx-03W9bOLOfEEEY1Q@mail.gmail.com>
 <CAMK1S_gh_CsWc-DnbOuUwn+H1i3skm99xzDbWe-wxsKKS0Qw-w@mail.gmail.com>
 <20111125144007.GA4047@sigill.intra.peff.net>
 <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 23:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RURAQ-0000vp-QE
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 23:56:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754916Ab1KZWzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Nov 2011 17:55:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53524
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab1KZWzW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2011 17:55:22 -0500
Received: (qmail 8375 invoked by uid 107); 26 Nov 2011 23:01:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Nov 2011 18:01:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Nov 2011 17:55:20 -0500
Content-Disposition: inline
In-Reply-To: <7v7h2my0ky.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185958>

On Sat, Nov 26, 2011 at 02:34:53PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The easiest way would be something like a "trust remote hooks"
> > environment variable, off by default. Admins in situation (2) could set
> > it for their git-daemon (or webserver, or whatever, or
> > gitolite-over-ssh), once they decided it was safe.
> 
> Alice and Bob may work on the same project, and they may want to trust
> each other as participants of that project, but that does not mean Alice
> wants to give Bob a blanket access to places she owns that are not shared
> with the project members (e.g. her $HOME directory), so I am afraid "trust
> remote hooks" is not a workable solution for the casual sharing on sites
> that do not fall into either of your two classes.

Of course. My point isn't that such a feature would cover all cases, but
that it would give people a tool to make that decision for themselves,
instead of blanket-forbidding it.

> The real reason why the upload-hook violates the expectation of the users
> is because it would run as the user who fetches, I think. If it ran with
> the intersection of capabilities of the owner of the repository and the
> user who is fetching, I suspect that we would not have to worry about it.

Sure. And I think we would probably trust automatically a hook that is
owned by the executing uid. Or possibly root, though that could be
surprising in NFS root-squashed environments.

> What would happen if we allowed some hooks to run only when the process is
> running under a group-id that can write into the repository?  When Alice
> fetches from the repository, it would still run as her and would have an
> access to her $HOME, so this won't really work yet, but I am wondering if
> there is a workable alternative along this line.

I don't think so. It comes down to this: Alice is executing arbitrary
code from Bob's repository, which Bob (and maybe others) have access to
write. This is giving Bob permission to run arbitrary code as Alice's
user.

Checking things like group access doesn't matter. If Alice is in the
group, too, it doesn't make a difference; Bob can still write the files,
and Alice is still running the code under her UID.

I think the only solutions are:

  1. Alice accepts that she can trust Bob enough to run his arbitrary
     code.

  2. We use some technique to run the code as the repo owner's UID.

The usual methods for doing (2) are:

  a. setuid, though doing it right can be quite tricky (e.g., cleansing
     environment, file descriptors, etc). And it requires root
     cooperation.

  b. running a server with a socket as Bob, and triggering the hook code
     from the server

Bob could run a specialized server for (b) that listens on a unix socket
and triggers his hook. But why? Why not just do the whole thing over
git-daemon or smart http, which already exist?

-Peff
