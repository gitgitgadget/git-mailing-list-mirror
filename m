From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Signed git-tag doesn't find default key
Date: Fri, 20 Oct 2006 09:32:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610200922170.3962@g5.osdl.org>
References: <200610201004.17263.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 18:32:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaxIL-0005s0-Ci
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 18:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992624AbWJTQcX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 12:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992633AbWJTQcX
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 12:32:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16787 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992624AbWJTQcW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 12:32:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9KGWIaX022998
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 20 Oct 2006 09:32:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9KGWH9L024723;
	Fri, 20 Oct 2006 09:32:17 -0700
To: Andy Parkins <andyparkins@gmail.com>
In-Reply-To: <200610201004.17263.andyparkins@gmail.com>
X-Spam-Status: No, hits=-0.472 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29504>



On Fri, 20 Oct 2006, Andy Parkins wrote:
> 
> I did this:
> 
> $ git tag -s adp-sign-tag
> gpg: skipped "Andy Parkins <andyparkins@gmail.com>": secret key not available
> gpg: signing failed: secret key not available
> failed to sign the tag with GPG.

I would suggest one of two things:

 - specify the signing entity explicitly:

	git tag -u "andyparkins@gmail.com" adp-sign-tag

 - or just add a new alternate user ID to match the full git user ID.

Currently, your pgp key has the full ID "Andy Parkins (Google) 
<andyparkins@gmail.com>", and the way gpg matches ID's, that will _not_ 
match an ID of "Andy Parkins <andyparkins@gmail.com>"

But you can just do something like

	gpg --edit-key andyparkins@gmail.com

and then do an "adduid", and then add your UID _without_ the "(Google)" in 
there, and that should solve all your problems.

> So when git-tag looks for "Andy Parkins <andyparkins@gmail.com>"; it's not 
> found.  The answer is (I think) to search only on the email address when 
> looking for a key.  I've simply changed git-tag to have
> 
> username=$(git-repo-config user.email)
> 
> However, this is clearly wrong as what it actually wants is the committer 
> email.  Am I safe to simply process the $tagger variable to extract it?

You're probably better off with something like

	git var GIT_COMMITTER_IDENT | sed 's/\(.*\)<\(.*\)>\(.*\)/\2/'

which should work, but see above: I think you literally are better off 
just adding an alias to your PGP key that doesn't have the comment field.

That said, I've never understood why gpg matches on the comment field. 
Dammit, it _should_ find the key anyway. Stupid program.

		Linus
