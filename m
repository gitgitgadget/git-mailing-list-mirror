From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-cvsimport doesn't quite work, wrt branches
Date: Tue, 13 Jun 2006 10:20:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606131008470.5498@g5.osdl.org>
References: <87irn5ovn6.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Yann Dirson <ydirson@altern.org>, Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jun 13 19:21:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqCZt-0004at-3t
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 19:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWFMRVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 13:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWFMRVS
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 13:21:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52138 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932205AbWFMRVR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 13:21:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5DHKBgt026131
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Jun 2006 10:20:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5DHKA6P001697;
	Tue, 13 Jun 2006 10:20:10 -0700
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87irn5ovn6.fsf@rho.meyering.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21787>


On Tue, 13 Jun 2006, Jim Meyering wrote:
>
> Here's a test case that shows how git-cvsimport is misbehaving.
> The script below demonstrates the problem with git-1.3.3 as
> well as with 1.4.0.rc2.g5e3a6.  As for cvsps, I'm using version 2.1.

Well, it's a cvsps problem. 

Big surprise.

Sadly, it also seems to be one that isn't fixed by the patches _I_ have, 
and looking at Yann's set of patches, I don't think they fix it either.

This is what (my version of) CVSps reports for your repository:

	---------------------
	PatchSet 1 
	Date: 2006/06/13 10:06:42
	Author: torvalds
	Branch: HEAD
	Tag: (none) 
	Log:
	.
	
	Members: 
	        on-br:INITIAL->1.1 
	        on-trunk:INITIAL->1.1 
	
	---------------------
	PatchSet 2 
	Date: 2006/06/13 10:06:44
	Author: torvalds
	Branch: B
	Ancestor branch: HEAD
	Tag: (none) 
	Log:
	.
	
	Members: 
	        on-br:1.1->1.1.2.1 
	
	---------------------
	PatchSet 3 
	Date: 2006/06/13 10:06:46
	Author: torvalds
	Branch: HEAD
	Tag: (none) 
	Log:
	.
	
	Members: 
	        on-br:1.1->1.2(DEAD) 


and note how the "on-br" file is part of the initial PatchSet 1.

So CVSps basically tells git-cvsimport that commit 2 (on branch B) is 
based on commit 1, and doesn't say that "on-trunk" has gone away, so the 
resulting git repository has branch B containing "on-trunk" version 1.1, 
and "on-br" version 1.1.2.1.

CVS branches obviously sometimes confuse CVSps. Sadly, they also confuse 
_me_, so I don't see how to fix this particular CVSps bug, because I'm as 
confused as CVSps is ;)

We'd need to have CVSps tell git that the "on-trunk" file was never added 
to branch B: the simplest way to do that would be to say that it has 
become (DEAD) in PatchSet 2 (which is not technically true in CVS terms, 
but _is_ technically true on git terms - on branch B, that file is 
obviously dead).

Yann? Pavel? Anybody? Ideas?

		Linus
