From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Merges without bases
Date: Sat, 27 Aug 2005 16:49:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508271544100.23242@iabervon.org>
References: <1125004228.4110.20.camel@localhost.localdomain> 
 <7vvf1tps9v.fsf@assigned-by-dhcp.cox.net>  <46a038f905082602176f9eef5d@mail.gmail.com>
  <Pine.LNX.4.63.0508261150320.23242@iabervon.org> <46a038f90508262348b25d1c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Darrin Thompson <darrint@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 22:47:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E97Z3-0006uo-My
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 22:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVH0UqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 16:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVH0UqF
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 16:46:05 -0400
Received: from iabervon.org ([66.92.72.58]:24583 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750751AbVH0UqE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 16:46:04 -0400
Received: (qmail 5224 invoked by uid 1000); 27 Aug 2005 16:49:43 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Aug 2005 16:49:43 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508262348b25d1c8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7852>

On Sat, 27 Aug 2005, Martin Langhoff wrote:

> On 8/27/05, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > The problem with both of these (and doing it in the build system) is that,
> > when a project includes another project, you generally don't want whatever
> > revision of the included project happens to be the latest; you want the
> > revision of the included project that the revision of the including
> > project you're looking at matches. That is, if App includes Lib, and
>
> Exactly - so you do it on a tag, or a commit date with cvs. With Arch,
> GIT and others that have a stable id for each commit, you can use that
> or the more user-friendly tags.

I'm thinking of cases like openssl, openssh, and libcrypto. Openssl and
openssh both use libcrypto but not each other (looking at the ldd output,
rather than packaging). However, it would be too much of a pain to work
directly on libcrypto without working through some other package, because
the library doesn't have its own applications. Furthermore, if you're
doing much to libcrypto, you're likely doing it in the context of a
particular application (say, for example, ssh needs a new cipher that
isn't supported for SSL at the time). You'd want to make simultaneous
changes to libcrypto to implement the new feature and to openssh to use
it; neither can be validated until the other is written, which means that
you'll have both projects checked out and dirty (in the cache sense) at
the same time, and be building the using project.

It would also be good to be able to check in this whole thing through the
version control system, rather than partially through a change to the
build system. That is, if I change the included libcrypto, commit it, and
commit the including openssh, the system as a whole should understand that
I want to change which commit of libcrypto gets used. Similarly, it would
be good to merge changes into the libcrypto used by openssh with the same
procedure used to merge changes to openssh itself, including supporting
non-fast-forward when there's a local version in use.

(Of course, currently, libcrypto is strictly part of openssl, because it
would be too much of a pain with the present version control to make it
independant, and openssh depends on openssl, despite not even linking
against -lssl, because openssl got libcrypto first.)

> The good thing here is that a makefile will know how to handle the
> situation if the external lib is hosted in Arch, in SVN, or Visual
> SourceSafe. If your external lib is only available as a tarball in a
> url, you can fetch that and uncompress it too. Arch configurations are
> _cute_ but useless in any but the most narrow cases.

Certainly, if it's sufficiently external to be in a different SCM it
should be handled by the build system. Actually, if it's even nearly that
external, it's probably going to be handled best by requiring people to go
get it themselves.

I find it odd that you say that the standard approach is to have the build
system fetch a version of the included package; my experience is that
projects either just report (or fail to report) a dependancy on having the
other package or they copy the project into their project. The former
means they can't change it (which is generally good, unless it becomes
necessary), while the latter causes update problems (c.f. zlib).

I think that Arch configurations and the CVS equivalent are, in fact,
useless, but that this is only due to implementation being insufficiently
clever, not due to the concept being inherently bad; I feel the same way
about distributed development under Arch, which is really nice under git,
so I have hope that something better could be done.

	-Daniel
*This .sig left intentionally blank*
