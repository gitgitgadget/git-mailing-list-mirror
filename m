From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 11:33:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701301123300.3611@woody.linux-foundation.org>
References: <17855.35058.967318.546726@lisa.zopyra.com> <epo1tn$9sl$1@sea.gmane.org>
 <17855.35845.922009.364704@lisa.zopyra.com> <20070130182237.GC26415@spearce.org>
 <17855.36470.309129.391271@lisa.zopyra.com>
 <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
 <17855.38543.761930.929267@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 20:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBykh-0008Qd-2d
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbXA3TeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbXA3TeW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:34:22 -0500
Received: from smtp.osdl.org ([65.172.181.24]:44392 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbXA3TeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:34:21 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0UJXw1m020414
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 11:33:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0UJXwAI026706;
	Tue, 30 Jan 2007 11:33:58 -0800
In-Reply-To: <17855.38543.761930.929267@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38195>



On Tue, 30 Jan 2007, Bill Lear wrote:
>
> Hmm, so I did this:
> 
> % cd /repos/git/project
> % GIT_DIR=. git branch
>   topic
> 
> And then, tried it all again:
> 
> % cd ..
> % rm -rf project
> % mkdir project
> % cd project
> % git --bare clone --shared
> % GIT_DIR=. git fetch git://source/public/project

Heh. That's not doing what you seem to expect.

If you don't give it a branch to fetch into, "git fetch" will not populate 
*any* branch. It does fetch the data:

> warning: no common commits
> remote: Generating pack...
> remote: Done counting 1148 objects.
> remote: Deltifying 1148 objects.
> remote:  100% (1148/1148) done
> Unpacking 1148 objects
> remote: Total 1148, written 1148 (delta 632), reused 1020 (delta 534)
>  100% (1148/1148) done

but it never wrote it into a branch, since you didn't tell it where it 
should go.

It didn't go away entirely, though: it's referenced by FETCH_HEAD, and 
this is actually the *common* thing for fetch usage when you use it to 
just them merge the fetched result into your current head. That is, for 
example, what I do all the time (except the "fetch+merge" thing is usually 
just called "git pull" ;)

> % GIT_DIR=. git branch
> [eh?  No branches??]

Right.

> % cat HEAD
> ref: refs/heads/master

.. and again, this is fine, but it just means that since no "master" 
branch exists, you have an empty HEAD with no commits.

> So, where are my branches?  And don't tell me I don't need no
> steenking branches...

You absolutely need some steenking branches, but you need to tell git 
which branch you want to use.

So either use

	git --bare fetch git://source/public/project topic:master

(to tell git to fetch the remote 'topic' into the local 'master')

OR, if you just prefer using the 'topic' name - which is certainly not 
wrong at all, do

	git --bare fetch git://source/public/project topic:topic
	git --bare symbolic-ref HEAD refs/heads/topic

where that second line is important: it's the one that tells that you want 
HEAD to be pointing to the 'topic' branch.

[ You could have done that second line before the fetch, and really 
  considered it part of the "create repository" sequence, rather than the 
  "fetch" sequence ]

Or something like that.

		Linus
