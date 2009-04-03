From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GPG signing for git commit?
Date: Fri, 3 Apr 2009 15:54:10 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0904031535140.3915@localhost.localdomain>
References: <1238793954.19982.14.camel@hyperair-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chow Loong Jin <hyperair@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpsJt-0003fv-3U
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 00:57:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbZDCWzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 18:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbZDCWzZ
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 18:55:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59575 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753017AbZDCWzY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Apr 2009 18:55:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n33MsAbp000848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Apr 2009 15:54:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n33MsATq029774;
	Fri, 3 Apr 2009 15:54:10 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1238793954.19982.14.camel@hyperair-laptop>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.437 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115563>



On Sat, 4 Apr 2009, Chow Loong Jin wrote:
> 
> It crossed my mind that currently git commits cannot actually be
> verified to be authentic, due to the fact that I can just set my
> identity to be someone else, and then commit under their name.

You can't do that.

Well, you can, but it's always going to be inferior to just adding a tag. 

The thing is, what is it you want to protect? The tree, the authorship, 
the committer info, the commit log, what?

And it really does matter. Because the signature must be over some part of 
the commit, and since the SHA1 of the commit by definition contains 
everything, then the _safest_ thing is always to sign the SHA1 itself: 
thus a tag.

Anything else is always bound to only sign a _part_ of the commit. What 
part do you feel like protecting? Or put another way, what part do you 
feel like _not_ protecting?

So the way git does signatures protects everything. When you do a tag with 
"git tag -s" on a commit, you can absolutely _know_ that nobody will ever 
modify that commit in any way without the tag signature becoming invalid. 

And perhaps equally interestingly, that signature is now also easily 
separable from the history - which is interesting if you want to 
distribute your cryptographic parts separately (for example, you only use 
it _internally_ within a company or group, to mark some group-specific 
issues).

Also, related to that "separable" - the person signing on something is not 
necessarily the person marked as author, or even committing it anyway. One 
of the guiding goals for git was always that it should work well with 
"outside" flows, ie others passing patches around or using other SCM's to 
manage their own flow. 

Finally, on that same "separable" notion - imagine a big rewrite operation 
for whatever reason - like a big import into git, or a project re-writing 
their history because they ended up importing more history from old 
sources (or because they wanted to split a big project into subprojects). 
All of those invalidate any cryptographic signatures.

And all of those are events that you may still want to _update_ the 
signatures, but do you want to trust the one doing the conversion with the 
private keys? Obviously not. You could "wrap" the signing in a new 
"conversion signature", and have a signature to try to imply that the 
person doing the conversion "signs" the conversion. But the fact is, that 
doesn't mean the same thing.

With separate signatures (ie the "git tag -s" model), you can ask the 
people who signed the original repository to consider re-signing the 
rewritten one. See? Safe, flexible, and much superior.

The exact same thing goes for keys that get invalidated because they ended 
up being shown to be too weak or just flawed some other way, btw. That is 
a reason to re-sign, _without_ the repository necessarily changing.

You can do _none_ of these things sanely if you put the signatures into 
the commits themselves. 

So don't do it.

Btw, there's a final reason, and probably the really real one. Signing 
each commit is totally stupid. It just means that you automate it, and you 
make the signature worth less. It also doesn't add any real value, since 
the way the git DAG-chain of SHA1's work, you only ever need _one_ 
signature to make all the commits reachable from that one be effectively 
covered by that one. So signing each commit is simply missing the point. 

IOW, you don't _ever_ have a reason to sign anythign but the "tip". The 
only exception is the "go back and re-sign", but that's the one that 
requires external signatures anyway.

So be happy with 'git tag -s'. It really is the right way.

		Linus
