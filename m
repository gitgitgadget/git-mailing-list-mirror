From: Jeff King <peff@peff.net>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 17:21:06 -0400
Message-ID: <20090528212106.GA14874@coredump.intra.peff.net>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <m3y6siboij.fsf@localhost.localdomain> <alpine.LFD.2.01.0905270922250.3435@localhost.localdomain> <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain> <alpine.LFD.2.00.0905271312220.3906@xanadu.home> <20090527215314.GA10362@coredump.intra.peff.net> <alpine.LFD.2.00.0905271834280.3906@xanadu.home> <20090528200039.GI13499@coredump.intra.peff.net> <alpine.LFD.2.00.0905281608060.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christopher Jefferson <caj@cs.st-andrews.ac.uk>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 28 23:21:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9n2d-0001kD-DE
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 23:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761708AbZE1VVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 17:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760629AbZE1VVN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 17:21:13 -0400
Received: from peff.net ([208.65.91.99]:48364 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759432AbZE1VVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 17:21:13 -0400
Received: (qmail 23375 invoked by uid 107); 28 May 2009 21:21:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 17:21:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 17:21:06 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905281608060.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120232>

On Thu, May 28, 2009 at 04:54:28PM -0400, Nicolas Pitre wrote:

> > I'm not sure what you mean by "out there", but I just exactly descr=
ibed
> > the data pattern of a repo I have (a few thousand 5 megapixel JPEGs=
 and
> > short (a few dozens of megabytes) AVIs, frequent additions, infrequ=
ently
> > changing photo contents, and moderately changing metadata). I don't=
 know
> > how that matches other peoples' needs.
>=20
> How do diffing =C3=A0 la 'git diff' JPEGs or AVIs make sense?

It is useful to see the changes in a text representation of the
metadata, with a single-line mention if the image or movie data has
changed. It's why I wrote the textconv feature.

> Also, you certainly have little to delta against as you add new photo=
s=20
> more often than modifying existing ones?

I do add new photos more than modifying existing ones. But I do modify
the old ones (tag corrections, new tags I didn't think of initially,
updates to the tagging schema, etc), too.

The sum of the sizes for all objects in the repo is 8.3G. The fully
packed repo is 3.3G. So there clearly is some benefit from deltas, and =
I
don't want to just turn them off. Doing the actual repack is painfully
slow.

> I still can't see how diffing big files is useful.  Certainly you'll=20
> need a specialized external diff tool, in which case it is not git's=20
> problem anymore except for writing content to temporary files.

Writing content to temporarily files is actually quite slow when the
files are hundreds of megabytes (even "git show" can be painful, let
alone "git log -p"). But that is something that can be dealt with by
improving the interface to external diff and textconv to avoid writing
out the whole file (and is something I have patches in the works for,
but they need finished and cleaned up).

> Rename detection: either you deal with the big files each time, or yo=
u=20
> (re)create a cache with that information so no analysis is needed the=
=20
> second time around.  This is something that even small files might=20
> possibly benefit from.  But in any case, there is no other ways but t=
o=20
> bite the bullet at least initially, and big files will be slower to=20
> process no matter what.

Right. What I am proposing is basically to create such a cache. But it
is one that is general enough that it could be used for more than just
the rename detection (though arguably rename detection and deltificatio=
n
could actually share more of the same techniques, in which case a cache
for one would help the other).

> Looks to me like you wish for git to do what a specialized database=20
> would be much more suited for the task.  Isn't there tools to gather=20
> picture metadata info, just like itunes does with MP3s already?

Yes, I already have tools for handling picture metadata info. How do I
version control that information? How do I keep it in sync across
multiple checkouts? How do I handle merging concurrent changes from
multiple sources? How do I keep that metadata connected to the pictures
that it describes? The things I want to do are conceptually
no different what I do with other files; it's merely the size of the
files that makes working with them in git less convenient (but it does
_work_; I am using git for this _now_, and I have been for a few years)=
=2E

> But being able to deal with large (1GB and more) files remains a tota=
lly=20
> different problem.

Right, that is why I think I will end up building on top of what you do=
=2E
I am trying to make a way for some operations to avoid looking at the
entire file, even streaming, which should drastically speed up those
operations.  But it is unavoidable that some operations (e.g., "git
add") will have to look at the entire file. And that is what your
proposal is about; streaming is basically the only way forward there.

-Peff
