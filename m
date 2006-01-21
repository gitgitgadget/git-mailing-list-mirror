From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: What is in git.git
Date: Sun, 22 Jan 2006 00:33:25 +0100
Message-ID: <200601220033.26321.Josef.Weidendorfer@gmx.de>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net> <200601211636.02340.lan@ac-sw.com> <7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 00:33:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0SEf-0005ac-JP
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 00:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWAUXdb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 18:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWAUXdb
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 18:33:31 -0500
Received: from mail.gmx.net ([213.165.64.21]:50921 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751226AbWAUXda (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jan 2006 18:33:30 -0500
Received: (qmail invoked by alias); 21 Jan 2006 23:33:28 -0000
Received: from p54968D0E.dip0.t-ipconnect.de (EHLO noname) [84.150.141.14]
  by mail.gmx.net (mp039) with SMTP; 22 Jan 2006 00:33:28 +0100
X-Authenticated: #352111
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9
In-Reply-To: <7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15028>

On Saturday 21 January 2006 20:37, you wrote:
> Alexander Litvinov <lan@ac-sw.com> writes:
> >> 1. Can I bind some branch instead of tag (commit) ?
> ... 
> If you mean by "binding a branch", to record how each subproject
> relates to the toplevel project (i.e. "the subproject bound to
> X/ subdirectory of the toplevel project comes from branch Y"),
> that information needs to be somewhere, but recording it in the
> commit object goes against the whole git philosophy.

The original gitlink proposal did exactly this: it recorded
the place where a subproject is bound by putting a gitlink into
a tree. This way, the binding point can be changed, and is subject to
versioning itself.

I just realized that this is not currently possible with the bind lines.
What about the following usage szenario:
- in a superproject, I use a subproject X implementing some lib by 
  binding it at X/. My Makefile recurses into X/ for this.
  This is recorded at commit point (A)
- later on, I realize I need another lib from a probject Y; I want
  to put the libs X and Y into subdirectory lib/ of my superproject;
  i.e. I bind Y at lib/Y/ and move the binding point of X to lib/X/.
  The Makefile is changed accordingly to build the subprojects.
  This is recorded at commit point (B)

A $GITDIR/bind alone will no work, as moving back to (A) would keep
the binding point of subproject, and make is broken.

I understand that "moving binding point of X from X/ to lib/X/" is not
representable within the index as a simple change. Is this the main issue
for your "against the whole git philosophy"?

I think it still is quite useful to put the binding point into bind lines of the
commit. Of course, moving a binding point has to go together with a new commit.

> You need to keep a file that describes how your repository is
> tracking the development histories of each subproject in
> $GIT_DIR/bind, that would look like:
> 
> 	master main=/ subpro=sub/

What about putting $GITDIR/bind information directly into reference files?

 $HOME/gitproj> cat .git/refs/heads/master
 92347432598...
 bind main=/
 bind subpro=sub/

This way, you can rename/copy heads, and the binding info will stay with
the commit.
This also is nice for subprojects that do not need the bind lines, but similar
to current cogito subproject proposal:

  92347432598...
  main=/
  subpro=sub/

would be the same superproject/subproject configuration without commiting
bind lines.

Josef
