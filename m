From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Mon, 12 Sep 2005 11:37:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509121128170.3242@g5.osdl.org>
References: <m3mzmjvbh7.fsf@telia.com>  <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
  <20050911185711.GA22556@mars.ravnborg.org>  <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
  <20050911194630.GB22951@mars.ravnborg.org>  <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
  <52irx7cnw5.fsf@cisco.com>  <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
 <12c511ca050912112266470d8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Roland Dreier <rolandd@cisco.com>, Sam Ravnborg <sam@ravnborg.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:39:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEtBa-0004XS-A4
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 20:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbVILShj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbVILShj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 14:37:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932083AbVILShi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 14:37:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8CIbIBo009034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Sep 2005 11:37:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8CIbDrD010484;
	Mon, 12 Sep 2005 11:37:15 -0700
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca050912112266470d8b@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.115 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8414>



On Mon, 12 Sep 2005, Tony Luck wrote:
> 
> Should the git daemon take a look at objects/info/alternates to check
> that if it exists, it points to a repository that also has a
> "git-daemon-export-ok" file?

I considered it, but decided against the complexity. I just don't see the 
point. The "git-daemon-export-ok" is not so much about security as about 
_accidental_ exposure. 

Remember: the security is in the writing. If you allow "bad people" enough
capabilities that they can create their own git archive and can read the
target archive, those "bad people" could just export the target archive
some other way in the first place (ie they could have just copied the
files over to their own area).

And there are actually real downsides to requiring "git-daemon-export-ok" 
from a security standpoint. In particular, imagine that a company has a 
"master archive", and wants to export just a particular "public branch" 
from that master archive. The way you can do that right now is to create a 
dummy git archive, that is empty except for having one head (symlink to 
the public branch head in the master) and an "alternates" pointer to the 
master.

See? You don't actually want to expose the master archive itself: so 
requiring that one to also have "git-daemon-export-ok" would actually 
_defeat_ the security in the system. 

So the git approach to security is that you secure the writing side.  
That's where you use ssh. And even if you happen to run git-daemon, it
will never export anything that you didn't explicitly mark for export, so
it defaults to a "nothing exported" mode. But once you mark a project for
public export, the branches exposed there really are public.

(And the branches _not_ exposed there are private. Sure, if you can guess
the SHA1 ID's, you can make git-daemon export them, but the point is that
git-daemon will never expose any SHA1's from other projects unless they
have the "git-daemon-export-ok" flag set. And the thing is, if you know
the SHA1's, you already know the contents and you had a leak some other
way, so..).

			Linus
