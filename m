From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Tue, 3 Apr 2012 06:07:04 -0400
Message-ID: <20120403100704.GC14483@sigill.intra.peff.net>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <4F77209A.8050607@gmail.com>
 <20120402214049.GB28926@sigill.intra.peff.net>
 <7vvclhdbew.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Bo Chen <chen@chenirvine.org>,
	Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 12:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SF0eR-0005Hy-6N
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 12:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab2DCKHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 06:07:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44148
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889Ab2DCKHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 06:07:07 -0400
Received: (qmail 27963 invoked by uid 107); 3 Apr 2012 10:07:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Apr 2012 06:07:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Apr 2012 06:07:04 -0400
Content-Disposition: inline
In-Reply-To: <7vvclhdbew.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194611>

On Mon, Apr 02, 2012 at 03:19:35PM -0700, Junio C Hamano wrote:

> >   1. You really have 100G of data in the current version that doesn't
> >      compress well (e.g., you are storing your music collection). You
> >      can't afford to store two copies on your laptop (because you have a
> >      fancy SSD, and 100G is expensive again).  You need the working tree
> >      version, but it's OK to stream the repo version of a blob from the
> >      network when you actually need it (mostly "checkout", assuming you
> >      have marked the file as "-diff").
> 
> This feels like a good candidate for an independent project that allows
> you fuse-mount from a remote repository to give you an illusion that you
> have a checkout of a specific version.  Such a remote fuse-server would be
> an application that is built using Git, but I do not think we are in any
> business on the client end in such a setup.

I think this is backwards. The primary item you want on the laptop is
the working directory, because you will be accessing and manipulating
the files. That must always work, whether the network is connected or
not. You occasionally will want to perform git operations. Most of these
should succeed when disconnected, but it's OK for some operations (like
checking out an older version of a large blob) to fail.

But if you are mounting a remote repository and pretending that you have
a local checkout, then just accessing the files either requires a
network, or you end up caching most of the remote repository.

It would make more sense to me to clone a bare repository of what's
upstream, and then fuse-mount the local bare repository to provide a
fake working directory. And I believe somebody made such a fuse
filesystem in the early days of git. However, I recall that it was
read-only. I'm not sure how you would handle writing to the git-mounted
directory.

> Or you can split out the really large write-only blobs out of SCM control.
> Every time you introduce a new blob, throw it verbatim in an append-only
> directory on a networked filesystem under some unique ID as its filename,
> and maintain a symlink into that networked filesystem under SCM control.
> 
> I think git-annex already does something like that...

Yes, and git-media basically does this, too. But it's awful to use,
because the user has to be constantly aware of these special links and
managing them. You can't just store a symlink into the networked
filesystem. For one thing, the path may be different on each client
machine, so a simple symlink doesn't work.  For another, symlinks into a
blob repository mean that the files must be read-only (since they are
basically blob-equivalents). So you don't really get your own copy of
the file; you can _replace_ it and update the symlink, but you can't
actually modify it.

So what things like git-media end up doing is to try to insert
themselves between git and the user, and transparently convert the file
into its unique ID on "git add" and tweak the working directory to
contain the actual file on checkout. And it kind of works, but there are
a lot of rough edges (I don't recall the details, but they came up in
past discussions; clean and smudge filters almost get you there, but not
quite).

Basically what I'm proposing to do is to just move that logic into git
itself, so it can just happen at the blob storage level. I don't think
it would even be that much code inside git; you'd want the interface to
be pluggable, so all of the heavy lifting would happen inside of a
helper (so really, this isn't necessarily even "network alternates" as
much as "pluggable alternates").

-Peff
