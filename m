From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Moving "git remote add --mirror blah" functionality to
 "git clone --bare --origin=blah"
Date: Wed, 23 Apr 2008 12:56:41 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804231210000.19665@iabervon.org>
References: <480EF334.1090907@gnu.org> <7vhcdstv0f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:57:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoiHl-0003ZK-OQ
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 18:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbYDWQ4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 12:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbYDWQ4r
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 12:56:47 -0400
Received: from iabervon.org ([66.92.72.58]:46252 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752223AbYDWQ4q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 12:56:46 -0400
Received: (qmail 5162 invoked by uid 1000); 23 Apr 2008 16:56:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Apr 2008 16:56:41 -0000
In-Reply-To: <7vhcdstv0f.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80230>

On Wed, 23 Apr 2008, Junio C Hamano wrote:

> *1* In that sense, a more sensible order than rewriting "clone" in C in
> its current form would be to make necessary enhancements to the components
> in this sequence that need to implement clone, figure out how they should
> fit together and first make "clone" a four-liner shell script. Then
> rewriting the result in C may become more trivial.

clone can't be a four-liner shell script, because it has to come up with 
the name of the working directory for a non-bare clone, which doesn't make 
sense for any other program. Currently, a local clone is special in that 
it duplicates all of the objects without checking whether the destination 
already has them (because it can't have anything) or whether they're 
actually needed; fetch could do some similar stuff, but couldn't do quite 
that much optimization, because it's not likely the same special case.

Something needs to get the code to figure out the remote HEAD, and it 
shouldn't be "remote" for clone's use, because then clone would take an 
extra connection, since "fetch" obviously has to connect and "remote" 
would run before it and in a separate process.

It also needs to support --reference (list another repository's refs as 
your refs, because you have that repository as an alternate but don't have 
your own refs that use its objects), which is sort of plausible for fetch 
but much less useful.

Aside from that, it's obviously got quite a few lines of option parsing to 
get the right arguments to the things it calls, as well as determining 
whether to check out a branch (depending on what we did with the origin) 
and such.

	-Daniel
*This .sig left intentionally blank*
