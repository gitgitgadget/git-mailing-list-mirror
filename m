From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: files are disappearing in git
Date: Fri, 25 Nov 2005 11:12:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511251022360.13959@g5.osdl.org>
References: <20051123142303.GJ22568@schottelius.org>
 <Pine.LNX.4.64.0511230917130.13959@g5.osdl.org> <20051124084633.GA3361@schottelius.org>
 <43866EDA.9050203@michonline.com> <20051125103048.GB30691@schottelius.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ryan Anderson <ryan@michonline.com>, Git ML <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 25 20:13:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Efizd-0007KG-Am
	for gcvg-git@gmane.org; Fri, 25 Nov 2005 20:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVKYTMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 Nov 2005 14:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKYTMQ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Nov 2005 14:12:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751313AbVKYTMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2005 14:12:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAPJC3nO016125
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 25 Nov 2005 11:12:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAPJC1Go013960;
	Fri, 25 Nov 2005 11:12:02 -0800
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051125103048.GB30691@schottelius.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12746>


Ok, 

  Nico gave me private access to the tree, so I quickly cloned it and 
started bisecting it to figure out where the problem was. I haven't looked 
at the source code, and all the commit messages seem to be in German 
(which I can kind of understand if I work at it, but not very well), but 
it definitely turns out none of that matters.

The problem is a bad merge. And in fact, that merge lost _more_ than just 
the three files under Code/Spikes/Statistik/, it also lost a file called 
Code/lw1/Client/Pics/icon/lw1-icon.png.

I don't quite see _how_ it lost them. The merge in question is a totally 
trivial in-index merge, and when I re-do it, I don't lose those files. In 
this case, all the lost files were from the "other branch" of the merge, 
and they were new to that branch. IOW, in git-merge-one-file parlance, it 
is that trivial "added in one" case.

Pasky - do you know of any historical cogito problems like this?

Nico: the files were added in commit

 - 9e9b91166bfca448a8f1ddeb4580d73ac8ea0986:
	Neuer Spike: Statistik ...

and they stayed around in that branch until commit (which is still good):

 - dcd70e89dc7b2280260628fd699aa906c319c68f:
	Bug 359 - Defektmeldungen ...

but they disappeared when the that branch was merged with commit

 - 056c65efea28066b7b241240f0d8421d3204b624
	Bug 195 - Tagesarbeitsplan: ...

and the result is the bad merge commit:

 - 228b94dd0a7aa1516eb867674cdf8c7c7b2bfd4c:
	Merge with /home/server/git/walderlift.git

After that merge, those new files are gone - they were never added by the 
merge.

Quite frankly, this is clearly a bug, and it looks very much like a really 
serious bug in cg-merge. It's not in the core git: even old versions of 
git should never have been able to generate that broken merge.

But when I try to do that same merge with current cogito, I can't make it 
break _either_. In all cases, regardless of how I do the merge, when I do 
(bad-merge is the merge in your tree, "cg-test" in this case is the merge 
I did using cogito):

	git-diff-tree -r bad-merge cg-test

I get

	:000000 100644 0000000000000000000000000000000000000000 5c8c47d855ee0f78a7fb81c4a49224b1607a88b7 A      Code/Spikes/Statistik/Project.dpr
	:000000 100644 0000000000000000000000000000000000000000 7bd2de9b7142999bc6bbadde06e73267d1b5ee0e A      Code/Spikes/Statistik/Statistik.pas
	:000000 100644 0000000000000000000000000000000000000000 a0fb45e2b906bdac7929cfd8174053015ab629b4 A      Code/Spikes/Statistik/Statistik.xfm
	:000000 100644 0000000000000000000000000000000000000000 24f8254c06ea5efc89944a3a9f52d2c79c841c0b A      Code/lw1/Client/Pics/icon/lw1-icon.png

ie the "bad merge" thing (commit 228b94dd0a7aa1516eb867674cdf8c7c7b2bfd4c 
in your tree) will not have those four files, and the good merge (whether 
I use the git "recursive" or git "resolve" merge, or use "cg-merge" to do 
it) will always have those four files.

So I do not see how that bad commit happened, especially since it's even 
a fairly recent commit (the date of the merge is 2005-11-17).

I wonder if there's a really old and broken version of cogito somewhere 
around. If so, it's on "srsyg03".

I also went through every single merge in your tree, and apart from two 
merges that had merge conflicts and were fixed up by hand (and that I thus 
didn't check), all other merges looked ok. So as far as I can tell it's 
only that 228b94dd0a7aa1516eb867674cdf8c7c7b2bfd4c merge that is bad.

(And the two commits that needed manual merging _look_ fine. No lost files 
at least, except for one of the merges losing "bitte_bitte_loesch_mich", 
which judging by it's name _should_ be lost ;)

Finally: Nico, I've deleted the trees on my machine, and you can remove my 
ssh key. I don't think I can tell you anything more.

			Linus
