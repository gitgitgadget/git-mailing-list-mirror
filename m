From: Jeff King <peff@peff.net>
Subject: Re: Transparently encrypt repository contents with GPG
Date: Fri, 13 Mar 2009 13:13:12 -0400
Message-ID: <20090313171312.GB16504@sigill.intra.peff.net>
References: <978bdee00903121419o61cd7a87rb55809796bd257d7@mail.gmail.com> <fabb9a1e0903121434u4a3d71bdi6277071f54557a7e@mail.gmail.com> <49BA39A1.9090203@drmicha.warpmail.net> <200903131215.49336.trast@student.ethz.ch> <fabb9a1e0903130417x36121bd5ya8b323e0a80bbd8f@mail.gmail.com> <49BA6606.1070403@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthias Nothhaft <matthias.nothhaft@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiAzw-0007hB-N1
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 18:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759189AbZCMRNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 13:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759175AbZCMRNQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 13:13:16 -0400
Received: from peff.net ([208.65.91.99]:60101 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758435AbZCMRNP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 13:13:15 -0400
Received: (qmail 8683 invoked by uid 107); 13 Mar 2009 17:13:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 13 Mar 2009 13:13:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Mar 2009 13:13:12 -0400
Content-Disposition: inline
In-Reply-To: <49BA6606.1070403@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113210>

On Fri, Mar 13, 2009 at 02:56:22PM +0100, Michael J Gruber wrote:

> Sverre was being prophetic with the somehow. Here's a working setup
> (though I still don't know why not to use luks):
> 
> In .gitattributes (or.git/info/a..) use
> 
> * filter=gpg diff=gpg
> 
> In your config:
> 
> [filter "gpg"]
>         smudge = gpg -d -q --batch --no-tty
>         clean = gpg -ea -q --batch --no-tty -r C920A124
> [diff "gpg"]
>         textconv = decrypt
> 
> This gives you textual diffs even in log! You want use gpg-agent here.

This is not going to work very well in general.  Smudging and cleaning
is about putting the canonical version of a file in the git repo, and
munging it for the working tree. Trying to go backwards is going to lead
to problems, including:

  1. Git sometimes wants to look at content of special files inside
     trees, like .gitignore. Now it can't.

  2. Git uses timestamps and inodes to decide whether files need to be
     looked at all to determine if they are different. So when you do
     a checkout and "git diff", everything will look OK. But when it
     does actually look at file contents, it compares canonical
     versions. And your canonical versions are going to be _different_
     everytime you encrypt, even if the content is the same:

       echo content >file
       git add file
       git diff ;# no output
       touch file
       git diff ;# looks like file is totally rewritten

     So you will probably end up with extra cruft in your commits if you
     ever touch files.

> Now for Sverre's prophecy and the helper I haven't shown you yet: It
> turns out that blobs are not smudged before they are fed to textconv!
> [Also, it seems that the textconv config does allow parameters, bit I
> haven't checked thoroughly.]

I don't think they should be smudged. Smudging is about converting for
the working tree, and the diff is operating on canonical formats. If
anything, I think the error is that we feed smudged data from the
working tree to textconv; we should always be handing it clean data (and
this goes for external diff, too, which I suspect behaves the same way).

I haven't looked, but it probably is a result of the optimization to
reuse worktree files.

-Peff

PS If it isn't obvious, I don't think this smudge/filter technique is
the right way to go about this. But one final comment if you did want to
pursue this: you are using asymmetric encryption in your GPG invocation,
which is going to be a lot slower and the result will take up more
space. Try using a symmetric cipher.
