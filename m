From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git email submissions
Date: Wed, 16 Nov 2005 08:59:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511160847250.13959@g5.osdl.org>
References: <437B4472.1080401@pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 18:04:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcQd0-0004Xc-TI
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 17:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVKPQ7Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 11:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVKPQ7Q
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 11:59:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17556 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030401AbVKPQ7P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 11:59:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAGGx4nO020650
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 16 Nov 2005 08:59:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAGGx0JF032363;
	Wed, 16 Nov 2005 08:59:02 -0800
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <437B4472.1080401@pobox.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12029>



On Wed, 16 Nov 2005, Jeff Garzik wrote:
> 
> For people without _any_ hosting, it would be nice to give them a method to
> submit some git changes via email.

Well, as long as you don't expect me to take those things..

BK had it with "bk send"/"bk receive", I used it a couple of times and 
refuse to do it again.

> - what form would the emails take?  MIME-attach a .pack file, plus a
> GPG-signed sha1sum in a separate attachment?

Yes, that sounds sane. You also need to specify the head(s) of the 
pack-file (maybe that's what you meant by the GPG-signed sha1sum).

> - what's the easiest user interface for selecting the changes?  for my usage,
> it would be
> 
> 	GIT_GPG_AUTHOR=jgarzik... \
> 	GIT_DEF_HEADERS=./email.headers \
> 	git-mkmail --sign master..upstream > email.rfc822
> 	Enter GPG passphrase:

Sounds sane.

> - what user interface does a kernel maintainer use, to merge changes submitted
> using this method?

As long as it's not me, I'd suggest doing something like

	git getmail <path-to-git-repo> < raw-email

Why? Because a lot of email clients know how to pipe the email to a 
program, so you might use this from within the email client by just doing

	| git getmail myrepo

and please also have an option to make it do the equivalent of a "fetch" 
rather than a "pull" (ie to "get" it as a separate branch without the 
merge):

	| git getmail -b garzik myrepo

or something. 

More importantly, the "git-getmail" (or whatever) scipt must absolutely be 
anal and verify that the pack is "complete". Since you don't have the git 
protocol to do the interactive "find the common parent" thing, it's easy 
for the other end to specify a commit you don't actually have, and make a 
pack that is perfectly valid, but which wouldn't have full connectivity to 
what the person that pulls is trying to get.

The minimal thing to do is to run a "git-fsck-cache" after the fetch and 
before the merge (if any). If the destination repo is regularly packed, it 
should even be fast (for example, since I repack my repo pretty regularly, 
a non-full fsck usually takes just a fraction of a second for me).

			Linus
