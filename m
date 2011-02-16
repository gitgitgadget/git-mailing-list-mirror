From: Jeff King <peff@peff.net>
Subject: Re: Need help grasping some concepts
Date: Tue, 15 Feb 2011 21:48:32 -0500
Message-ID: <20110216024832.GB7085@sigill.intra.peff.net>
References: <AANLkTi=RfK13jUiu+tT21M-dm65tPrkr+s8asa+nZdak@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing List <git@vger.kernel.org>
To: =?utf-8?B?Sm/Do28gUC4=?= Sampaio <jpmelos@jpmelos.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 03:48:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpXRa-0008VS-3L
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 03:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab1BPCsj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Feb 2011 21:48:39 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52271 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583Ab1BPCsf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 21:48:35 -0500
Received: (qmail 2648 invoked by uid 111); 16 Feb 2011 02:48:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 02:48:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 21:48:32 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=RfK13jUiu+tT21M-dm65tPrkr+s8asa+nZdak@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166915>

On Tue, Feb 15, 2011 at 10:19:27PM -0200, Jo=C3=A3o P. Sampaio wrote:

> 1) What are plumbing and porcelain functions, methods, APIs... What's
> the meaning of that classification and difference between the two?

Git doesn't provide a linkable C API. Instead, the only official API is
the interface provided by the commands, which often have options made
for scripting around them. In the beginning, this included all of the
commands known as "git-core", and it was assumed that people would
script around them to write a nice version control system. Git-core was
to be the "plumbing", and the wrapper VCS would be the "porcelain", jus=
t
as plumbing pipes in your bathroom do all the hardwork under the
porcelain fixtures like your sink, tub, and toilet.

Over time, git-core got more user-friendly and people decided to use it
directly as a version control system. New commands were introduced that
duplicated some functionality, but in a much easier way. For example,
there is nothing that "git add" can do that you can't do by scripting
"git update-index". But its interface is much easier to use.

These new commands became known as porcelain commands, while the
low-level commands were marked as plumbing commands (and the "git-core"
name was dropped to just "git"). Porcelain commands are generally used
by users, and their interface is subject to change as we think of more
convenient ways for users to interact with them. Plumbing commands
promise to have a stable interface, making them safer to use in scripts=
=2E

> 2) What's going on about cache-tree not being able to handle empty
> trees, or something like that? You mean Git doesn't store empty
> directories in repositories?

No, it doesn't. The git data structure can conceptually handle it prett=
y
easily, but there is some work to be done to handle it in the index.
Plus there are some corner cases about when to create and destroy such
directories (e.g., you may switch from a commit with an empty directory
to a commit without it, but there are untracked files in the directory.
What should happen to those files?).

> 3) And what are symbolic references? Are they just an alias I can
> attach to branches and tags, like symbolic links in Linux that I can
> attach to folders and files?

Sometimes we want to make a reference not to a particular sha1, but to
another reference. The main example is the "HEAD" reference. It is a
pointer to a reference which contains the branch tip, and when we updat=
e
HEAD via "git commit", we are actually updating the pointed-to branch
tip.

Early on, this was done using a symbolic link in the .git directory. Bu=
t
not all platforms have symbolic links. So now we have symbolic refs,
which are basically text files that work like symbolic links.

-Peff

PS Those answers are all off the top of my head without doing any
research in the archive, and some of those things predate me working on
git. And I tried to explain them in a succint way that would make sense
to a newer user. So please take the historical accuracy of my "in the
beginning" stories with a grain of salt.
