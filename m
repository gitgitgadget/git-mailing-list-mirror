From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sun, 18 Feb 2007 02:15:06 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180210490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net> <7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
 <20070217232603.GB30839@coredump.intra.peff.net> <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:15:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIae2-0008Tg-7E
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992972AbXBRBPJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992975AbXBRBPJ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:15:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:41909 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S2992972AbXBRBPI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:15:08 -0500
Received: (qmail invoked by alias); 18 Feb 2007 01:15:06 -0000
X-Provags-ID: V01U2FsdGVkX1+Bw9g0wXSBu9CXFhEdmAvHT61+yQQRr3g0OSFl/Y
	XI2w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40045>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 17 Feb 2007, Junio C Hamano wrote:
> > ...
> >> But I think Jeff is right.  It would make sense to let apply
> >> and perhaps 'diff', if we can somehow merge 'diff2' into it,
> >> still read from $HOME/.gitconfig if available.
> >
> > Yes, especially if you are soo used to colours as I grew to be used to 
> > them. This was literally one of the reasons I wrote diff2 in the first 
> > place. Another was --color-words.
> 
> True.  Paches welcome ;-).

I sent it out already... It was titled "[PATCH] Add `git diff2`, a GNU 
diff workalike" ;-)

> > BTW any good ideas how to make diff fall back to diff2, so that no similar 
> > case falls back to diff-index?
> >
> > I am really wondering if you can have a syntax which Does The Right Thing 
> > at all times. Maybe we can teach diff that exactly two arguments, which 
> > both exist in the filesystem, and at least one of them is not tracked, 
> > then please use diff2? I wonder how often you do something like
> >
> > 	git diff object.c object-refs.c
> >
> > and how confusing it would be that it could mean two things, diff2 _and_ 
> > diff-index?
> 
> I _think_ the case I would want to use diff2 are:
> 
>  (1) I am totally outside a git repository.
> 
> or
> 
>  (2) I am inside a git repository but I want to compare two
>      specific managed files, say GIT-VERSION-GEN and
>      git-gui/GIT-VERSION-GEN.
> 
> Now, (1) can be had by moving the RUN_SETUP bit out of entry for
> "diff" in git.c, and do it only when we know we are in a repo
> (maybe using "setup gently").  If we are outside of a
> repository, any of the existing diff-* brothers do not make much
> sense --- we can always do diff2.
> 
> For (2), I _think_ it may be useful sometimes but not very
> often, so how about a specific option that you require upfront?
> 
> 	git diff --fs --color-words GIT-VERSION-GEN git-gui/GIT-VERSION-GEN
> 
> I can do almost that with
> 
> 	git diff --color-words :GIT-VERSION-GEN :git-gui/GIT-VERSION-GEN
> 
> but, it compares indexed ones, not from the working tree, so it
> is not exactly the same.  However, the difference may not make
> practical difference in this particular example, though.  When I
> want to know the differences between two tracked files, it is
> usually becausel I want to see if there are similarities to be
> consolidated, and I would do that before starting to alter
> working tree files.
> 
> Also, strictly speaking, there is third one:
> 
>  (3) I am inside a git repository but I want to compare files
>      that do not have anything to do with the project I am
>      currently working on:
> 
> 	git diff --fs /etc/skel/profile $HOME/.profile
> 
> while I do not think this usage makes any sense, an explicit
> flag upfront saves you from wondering what the user meant.

And there is always

  (4) I am inside a git repository and want to compare one tracked file 
      with one non-tracked file, and
  (5) I am outside of a git repository, but want to compare one tracked 
      file (by absolute path) with an arbitrary other file.

The longer I think about it, the more I am convinced that trying to 
integrate diff2 into diff _will_ lead to errors due to my trained, but 
disobeying, fingers.

I also debated with myself calling it diff-two or diff-direct (both not 
really convincing), or even diff-file (too similar to diff-files), but I 
could not come up with a better name than diff2. Which is also very easy 
to write, I have to say.

Ciao,
Dscho
