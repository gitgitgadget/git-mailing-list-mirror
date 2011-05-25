From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 3/3] Add documentation for virtual repositories
Date: Wed, 25 May 2011 11:03:42 -0700
Message-ID: <20110525180341.GA2324@leaf>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
 <1306284392-12034-3-git-send-email-jamey@minilop.net>
 <20110525160708.GE8795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 20:04:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPIR7-0004zR-9x
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab1EYSDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 14:03:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45792 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab1EYSDy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 14:03:54 -0400
X-Originating-IP: 217.70.178.137
Received: from mfilter8-d.gandi.net (mfilter8-d.gandi.net [217.70.178.137])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 0DD53A8068;
	Wed, 25 May 2011 20:03:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at #File managed by puppet, do not edit
	locally
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter8-d.gandi.net (mfilter8-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id A7sEeYDr24j3; Wed, 25 May 2011 20:03:50 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B7211A8070;
	Wed, 25 May 2011 20:03:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110525160708.GE8795@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174440>

On Wed, May 25, 2011 at 12:07:08PM -0400, Jeff King wrote:
> On Tue, May 24, 2011 at 05:46:32PM -0700, Jamey Sharp wrote:
> 
> >  Documentation/Makefile                 |    2 +-
> >  Documentation/git-http-backend.txt     |    4 +-
> >  Documentation/gitvirtual.txt           |   76 ++++++++++++++++++++++++++++++++
> >  contrib/completion/git-completion.bash |    2 +-
> 
> Maybe it would make sense to mention your new options to upload-pack and
> receive-pack in their manpages; the description can be short, but refer
> the user to gitvirtual.

Fair enough.  We'll go ahead and document them (in patch 1/3 with a
reference to gitvirtual added in patch 3/3), and avoid making the pile
of undocumented upload-pack and receive-pack options larger. :)

> > +Given many repositories with copies of the same objects (such as
> > +branches of the same source), sharing a common object store will avoid
> > +duplication.  Alternates provide a single baseline, but don't handle
> > +ongoing activity in the various repositories.  Furthermore, operations
> > +such as linkgit:git-gc[1] need to know about all of the refs.
> 
> It's not quite true that alternates provide only a single baseline. They
> can be updated and objects consolidated over time (e.g., with a nightly
> repack). The problem is that they require management to do so (this is
> also a benefit, if you want a sharing policy besides "all repos have all
> objects").

True enough.  We wanted something that automatically worked without
background maintenance, but alternates can help if you keep moving
common objects to the alternate repository.

> > +linkgit:git-upload-pack[1] and linkgit:git-receive-pack[1] rewrite the
> > +names of refs and heads as specified by the --ref-prefix and --head
> > +options.  For instance, --ref-prefix=`virtual/reponame/` will use
> > ++pass:[refs/virtual/reponame/heads/*]+ and
> > ++pass:[refs/virtual/reponame/tags/*]+.  git-upload-pack and
> > +git-receive-pack will ignore any references that do not match the
> > +specified prefix.
> 
> Thinking on the whole idea a bit more, is there a reason to restrict
> this to upload-pack and receive-pack? Sure, they are the most obvious
> places to use it for hosting, but might I not want to be able to do:
> 
>   cd /path/to/mega-repository.git
>   git --ref-prefix=virtual/repo1 log master
> 
> to do server-side scripting inside the virtual repos (or more likely,
> setting GIT_REF_PREFIX at the top of your script).

Many git commands will need special handling for this, though.  For
instance, gc needs to know about all refs, not just a prefix of refs;
otherwise it will break the repository.  Or, for an example within a
single command, the checks for updating a currently-checked-out ref in a
repository need to use the repository's HEAD, not the virtual HEAD.
And similarly, git checkout with a ref-prefix set would construct a
repository where HEAD doesn't match the workdir.

Having this handled "transparently" for all git commands seems likely to
run into this kind of corner case, where parts of a git command run
correctly with ref-prefix but other parts or other invoked git commands
must not run with ref-prefix.

I do agree that some other git programs could learn to use ref-prefix,
and it makes sense to move the functionality into refs.c as a general
mechanism for those programs to use.  However, I don't think it makes
sense to transparently make all git programs use ref-prefix without
checking them individually to see if it makes sense.

> > +The --ref-prefix and --head options provide quite a bit of flexibility
> > +in organizing the refs of virtual repositories within those of the
> > +underlying repository.  In the absence of a strong reason to do
> > +otherwise, consider following these conventions:
> > +
> > +--ref-prefix=`virtual/reponame/`::
> > +	This puts refs under `refs/virtual/reponame/`, which avoids a
> > +	namespace conflict between `reponame` and built-in ref
> > +	directories such as `heads` and `tags`.
> > +
> > +--head=`virtual-HEAD/reponame`::
> > +	This puts HEADs under `virtual-HEAD/` to avoid namespace
> > +	conflicts with top-level filenames in a git repository.
> 
> I'm curious if you have a use for this much flexibility. In particular,
> why do the HEAD and refs prefixes need the ability to be separate? Also,
> what about other non-HEAD top-level refs? IOW, a true "virtual
> repository" to me would just be:
> 
>   GIT_REF_PREFIX=refs/virtual/repo1
> 
> and then _every_ ref resolution would just prefix that, whether it was
> in refs/ or not. So you would have:
> 
>   .git/refs/virtual/repo1/HEAD
>   .git/refs/virtual/repo1/refs/heads/master
>   .git/refs/virtual/repo1/refs/tags/v1.0

Ah, *now* I see what you meant by including the repeated "refs/", and
using that to allow putting HEAD in the same namespace makes sense.

We don't actually need the flexibility of putting HEAD in a different
place, and this layout makes sense, so we can change the ref-prefix
mechanism to drop the separate --head entirely.

> > +SECURITY
> > +--------
> > +
> > +Anyone with access to any virtual repository can potentially access
> > +objects from any other virtual repository stored in the same underlying
> > +repository.  You can't directly say "give me object ABCD" if you don't
> > +have a ref to it, but you can do some other sneaky things like:
> > +
> > +. Claiming to push ABCD, at which point the server will optimize out the
> > +  need for you to actually send it. Now you have a ref to ABCD and can
> > +  fetch it (claiming not to have it, of course).
> > +
> > +. Requesting other refs, claiming that you have ABCD, at which point the
> > +  server may generate deltas against ABCD.
> > +
> > +None of this causes a problem if you only host public repositories, or
> > +if everyone who may read one virtual repo may also read everything in
> > +every other virtual repo (for instance, if everyone in an organization
> > +has read permission to every repository).
> 
> Well, this text is obviously correct and written by a very smart person.
> ;)
> 
> You might want to mention that if you do need to handle these security
> concerns, then the alternates route, even though it creates more
> management headache, is going to be more flexible with respect to which
> objects are shared.
> 
> In fact, given what I said at the very top of the email, I wonder if the
> documentation would be better structured as "here are two methods for
> sharing objects, here are reasons why you might choose one or the other,
> and here is how to use each".

I think it makes sense to reference alternates in the gitvirtual page, but
I don't think it makes sense to put the full documentation for both in
the same page.

- Josh Triplett
