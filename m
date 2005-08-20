From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "Publishing your work" questions?
Date: Sat, 20 Aug 2005 08:52:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508200821220.3317@g5.osdl.org>
References: <200508201457.00725.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 17:53:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6VeA-00019i-QZ
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 17:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbVHTPwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 20 Aug 2005 11:52:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVHTPwf
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 11:52:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19643 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932405AbVHTPwf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2005 11:52:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7KFqPjA015322
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 20 Aug 2005 08:52:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7KFqPI8017124;
	Sat, 20 Aug 2005 08:52:25 -0700
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200508201457.00725.alan@chandlerfamily.org.uk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 20 Aug 2005, Alan Chandler wrote:
>=20
> If I switch over to git, I assume I run git-daemon from inetd.

Yes. Use the "--inetd" flag, and open port 9418 instead.

> a) Is this what the git://my.domain.com/path/to/repository url refers=
 to=20
> (neither get-pull-script nor git-fetch-script man pages actually say =
what=20
> this form means) ?

Yes.

> b) I can't find any mention in the documentation of what the default =
port=20
> should be. What is it?

The default one is 9418, although you can use "--port=3Dxxx" to set it =
to
something else. Obviously, if you put it at some other port, you either
need to re-compile the client side with the new port number (it's
DEFAULT_GIT_PORT in cache.h) or need to use

	git://my.domain.com:<port>/path/to/repository

> c) Is git-daemon multithreaded (ie do I use nowait in inetd.conf)?

Yup, it's entirely safe to run tons of them concurrently.

You can also run the git deamon without inetd, and it will do it's own=20
serving. That normally limits it to 25 connections at a time.

> d) Is it possible to ensure that external accesses can't access anywh=
ere in my=20
> filesystem?=20

Yes. The first thing the git-deamon will do is to chdir to the argument=
=20
(and add ".git" to the end if it can't find the exact path), and then l=
ook=20
up a file called "git-daemon-export-ok". If that file does not exist, i=
t=20
will exit.

This means, btw, that it will _not_ export any random git directory by=20
default, much less anything else. You literally have to mark your git=20
directories for export explicitly by doing a "touch git-daemon-export-o=
k"=20
in the .git directory.

See "daemon.c: upload()" for some of the details.

> e) If I put my public key in ~git/.ssh/authorized_keys on the server,=
 I can=20
> act as user git on the server via ssh. =A0Does git push support this?=
 =A0

Yes. That's the normal way to do it. The anonymous "git://" protocol ca=
n=20
only do reads (adn it is entirely anonymous). For pushes, you _have_ to=
=20
use ssh, either through

	git push my.domain.com:/path/to/repository

or

	git push ssh://my.domain.com/path/to/repository

(and you can obviously shorthand the format by putting it into your=20
=2Egit/remotes/ files, so that you can do things like "git push public"=
=2E)

> f) If I can do e), then perhaps [need to read the docs a bit harder] =
I can set=20
> up my user git on the machine to use git-receive-pack as its login sh=
ell. =A0
> Will this work? - the tutorial talks about needing .bashrc to set up =
the=20
> $PATH environment, but are there any other hidden gotchas?

There shouldn't be any other gotchas. But no, you can't _quite_ use=20
git-receive-pack as the login shell. Why? Because if you have it as you=
r=20
login shell, it will get the wrong arguments: it will get:

	0: git-receive-pack
	1: -c
	2: git-receive-pack '/path/to/repository'

and you'd need to have some ultra-simple shell that took this, verified
the proper arguments, and turned it into an

	execvp(git-receive-pack, /path/to/repository, NULL);

But yes, you _should_ be able to do it with that ultra-simplistic login=
=20
shell. Probably just a 5-liner main() function or something.

			Linus
