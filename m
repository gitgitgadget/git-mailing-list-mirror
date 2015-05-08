From: Jeff King <peff@peff.net>
Subject: Re: t0005-signals.sh fails with ksh
Date: Fri, 8 May 2015 17:14:54 -0400
Message-ID: <20150508211453.GA11594@peff.net>
References: <31108626.20150508231514@gmail.com>
 <xmqq1tiqkdue.fsf@gitster.dls.corp.google.com>
 <20150508205548.GB13457@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: evgeny <illumsoft.org@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 23:15:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqpbp-00038J-QX
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 23:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273AbbEHVO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 17:14:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:55879 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752045AbbEHVO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 17:14:56 -0400
Received: (qmail 26103 invoked by uid 102); 8 May 2015 21:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 16:14:56 -0500
Received: (qmail 23720 invoked by uid 107); 8 May 2015 21:15:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 May 2015 17:15:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2015 17:14:54 -0400
Content-Disposition: inline
In-Reply-To: <20150508205548.GB13457@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268669>

On Fri, May 08, 2015 at 04:55:48PM -0400, Jeff King wrote:

> > Does this work if you did
> > 
> > 	OUT=$( ( (large_git ; echo $? 1>&3) | : ) 3>&2 ) &&
> > 
> > instead?
> 
> It does for me. I've tested our suite with mksh before, and it passed
> (that's why the earlier check already covers ksh). But using the ksh I
> get from "apt-get install ksh" on Debian (ksh93, it looks like?) fails
> as described. The change above prevents the shell from crashing, and
> then if we also massage the code, the test passes (i.e., the patch
> below).
> 
> I'm on the fence, though, on declaring ksh93 to be unsupported. I don't
> know how many other instances of this are in our test suite, and it's
> one more maintenance headache to deal with. Are there really platforms
> with no actual POSIX shell (on Solaris, for example, the xpg6 shell is a
> much better choice)?

Hmph. I just ran the whole suite with SHELL_PATH=ksh. There are about 35
failures overall, and they are not all related. For instance, in t4014,
it looks like a variable assignment just goes missing (whether it is
because it is a one-shot against a function, or because it contains a
bunch of utf8 characters, I'm not sure). We might be able to work around
that. But some of the other failures leave me quite confused.

Here's an oddity I isolated based on a failure in t5502:

  $ git init foo && cd foo
  Initialized empty Git repository in /home/peff/foo/.git/

  $ (cd .git/objects && ls)
  info pack

OK, makes sense. Now...

  $ mkdir subdir && cd subdir
  $ ls ../.git/objects
  info  pack
  $ cd ../.git/objects
  ksh: cd: /home/peff/foo/git/objects: [No such file or directory]

Um, what? Apparently using "../.foo" will eat the "." off of "foo"?

-Peff
