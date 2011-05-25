From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] Add documentation for virtual repositories
Date: Wed, 25 May 2011 12:07:08 -0400
Message-ID: <20110525160708.GE8795@sigill.intra.peff.net>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
 <1306284392-12034-3-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed May 25 18:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPGcR-00010P-9g
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 18:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933038Ab1EYQHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 12:07:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35898
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757457Ab1EYQHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 12:07:11 -0400
Received: (qmail 1533 invoked by uid 107); 25 May 2011 16:07:10 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 12:07:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 12:07:08 -0400
Content-Disposition: inline
In-Reply-To: <1306284392-12034-3-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174420>

On Tue, May 24, 2011 at 05:46:32PM -0700, Jamey Sharp wrote:

>  Documentation/Makefile                 |    2 +-
>  Documentation/git-http-backend.txt     |    4 +-
>  Documentation/gitvirtual.txt           |   76 ++++++++++++++++++++++++++++++++
>  contrib/completion/git-completion.bash |    2 +-

Maybe it would make sense to mention your new options to upload-pack and
receive-pack in their manpages; the description can be short, but refer
the user to gitvirtual.

> +Given many repositories with copies of the same objects (such as
> +branches of the same source), sharing a common object store will avoid
> +duplication.  Alternates provide a single baseline, but don't handle
> +ongoing activity in the various repositories.  Furthermore, operations
> +such as linkgit:git-gc[1] need to know about all of the refs.

It's not quite true that alternates provide only a single baseline. They
can be updated and objects consolidated over time (e.g., with a nightly
repack). The problem is that they require management to do so (this is
also a benefit, if you want a sharing policy besides "all repos have all
objects").

> +linkgit:git-upload-pack[1] and linkgit:git-receive-pack[1] rewrite the
> +names of refs and heads as specified by the --ref-prefix and --head
> +options.  For instance, --ref-prefix=`virtual/reponame/` will use
> ++pass:[refs/virtual/reponame/heads/*]+ and
> ++pass:[refs/virtual/reponame/tags/*]+.  git-upload-pack and
> +git-receive-pack will ignore any references that do not match the
> +specified prefix.

Thinking on the whole idea a bit more, is there a reason to restrict
this to upload-pack and receive-pack? Sure, they are the most obvious
places to use it for hosting, but might I not want to be able to do:

  cd /path/to/mega-repository.git
  git --ref-prefix=virtual/repo1 log master

to do server-side scripting inside the virtual repos (or more likely,
setting GIT_REF_PREFIX at the top of your script).

> +The --ref-prefix and --head options provide quite a bit of flexibility
> +in organizing the refs of virtual repositories within those of the
> +underlying repository.  In the absence of a strong reason to do
> +otherwise, consider following these conventions:
> +
> +--ref-prefix=`virtual/reponame/`::
> +	This puts refs under `refs/virtual/reponame/`, which avoids a
> +	namespace conflict between `reponame` and built-in ref
> +	directories such as `heads` and `tags`.
> +
> +--head=`virtual-HEAD/reponame`::
> +	This puts HEADs under `virtual-HEAD/` to avoid namespace
> +	conflicts with top-level filenames in a git repository.

I'm curious if you have a use for this much flexibility. In particular,
why do the HEAD and refs prefixes need the ability to be separate? Also,
what about other non-HEAD top-level refs? IOW, a true "virtual
repository" to me would just be:

  GIT_REF_PREFIX=refs/virtual/repo1

and then _every_ ref resolution would just prefix that, whether it was
in refs/ or not. So you would have:

  .git/refs/virtual/repo1/HEAD
  .git/refs/virtual/repo1/refs/heads/master
  .git/refs/virtual/repo1/refs/tags/v1.0

and so on. And this fits in with the idea of it not just being an
upload-pack and receive-pack thing. I could do:

  GIT_REF_PREFIX=refs/virtual/repo1; export GIT_REF_PREFIX
  git fetch some-remote

and it would write to .git/refs/virtual/repo1/FETCH_HEAD.

So the virtual repository is basically just a "chroot" of the ref
namespace. And it's dirt simple to implement, because you do the
translation at the refs.c layer.

> +SECURITY
> +--------
> +
> +Anyone with access to any virtual repository can potentially access
> +objects from any other virtual repository stored in the same underlying
> +repository.  You can't directly say "give me object ABCD" if you don't
> +have a ref to it, but you can do some other sneaky things like:
> +
> +. Claiming to push ABCD, at which point the server will optimize out the
> +  need for you to actually send it. Now you have a ref to ABCD and can
> +  fetch it (claiming not to have it, of course).
> +
> +. Requesting other refs, claiming that you have ABCD, at which point the
> +  server may generate deltas against ABCD.
> +
> +None of this causes a problem if you only host public repositories, or
> +if everyone who may read one virtual repo may also read everything in
> +every other virtual repo (for instance, if everyone in an organization
> +has read permission to every repository).

Well, this text is obviously correct and written by a very smart person.
;)

You might want to mention that if you do need to handle these security
concerns, then the alternates route, even though it creates more
management headache, is going to be more flexible with respect to which
objects are shared.

In fact, given what I said at the very top of the email, I wonder if the
documentation would be better structured as "here are two methods for
sharing objects, here are reasons why you might choose one or the other,
and here is how to use each".

-Peff
