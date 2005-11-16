From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Wed, 16 Nov 2005 08:46:01 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 16 17:51:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcQQL-0006PV-4y
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 17:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbVKPQqO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 11:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVKPQqO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 11:46:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030411AbVKPQqN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 11:46:13 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAGGk9nO020147
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 16 Nov 2005 08:46:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAGGk2rj031985;
	Wed, 16 Nov 2005 08:46:07 -0800
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12028>



On Wed, 16 Nov 2005, Franck wrote:
> 
> I'm trying to clone a small part of a big repository. This repository
> contains several branchs that are useless for me. Actually this
> repository is the linux-mips one, and branchs are used to track each
> kernel minor version. That is to say it contains 4 branchs which are
> linux-2.0, linux-2.2, linux-2.4 and master (linux-2.6).
> 
> I'd like to clone this repository without grabbing linux-2.0,
> linux-2.2, linux-2.4 branchs. I tried several things like:
> 
>         $ git init-db
>         $ git fetch rsync://ftp.linux-mips.org/git/linux.git master

First off, "rsync://" will never do what you want. It uses rsync 
(surprised surprise) to grab the objects, so since it has no clue what the 
objects are, it has no choice but to just grab them all.

> But all tries download every objects of each branchs. I believe that's
> because of (a) the protocol used to access of the remote repo

Yes. Note that ftp.linux-mips.org does run the git daemon, so you can use 
"git://" instead of "rsync://" (that's how I pull from them when I sync).

>								 (b) the
> master branch has been created from linux-2.4 branch so its first
> commit object contains a branch 2.4 commit obj as parent object (let's
> call it the "father" object). Is that correct ?

Not having looked at that particular repo, I don't know. git can do it 
either way - either one long common history, or branches with totally 
unrelated histories. 

The fact that _some_ of the linux-mips repositories are based on mine 
makes me suspect that all their 2.6-based ones are rooted like mine is, 
but that may or may not be true.

Just try your above command line with "git://" instead.

(NOTE! Doing a full clone like the above is pretty expensive with git for 
the server side, so it might take a while before it starts feeding you 
stuff if it is under heavy load)

> So I downloaded the whole thing, and try to remove "father" object and
> right after run a 'git prune'. But unfortunately I can't find it
> anywhere in .git directory. I did:
> 
>         $ git-verify-pack < .git/objects/pack/*.idx
>         $ git-unpack-objects < .git/objects/pack/*.pack
> 
> But I can't find "father object" anywhere in .git/objects directory.
> Still it's referenced by .git/objects/pack/pack-....idx file.
> 
> Can anybody give me some advices ?

If you want to get rid of other branches, do:

	# Remove the branches
	git branch -D linux-2.0
	git branch -D linux-2.2
	git branch -D linux-2.4
	.. whatever other branches you don't want ..

	# Repack the repo
	git repack -a -d

	# Prune it all down
	git prune-packed
	git prune

and you should have a nice single pack that only contains the branch(es) 
that you're interested in.

		Linus
