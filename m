From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with a push
Date: Mon, 11 Jun 2007 17:40:20 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706111727240.14121@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
 <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706111832070.4830@www.mintpixels.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: plexq@plexq.com
X-From: git-owner@vger.kernel.org Tue Jun 12 02:41:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxuRR-0003oM-1l
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 02:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbXFLAky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 20:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbXFLAky
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 20:40:54 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40190 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752485AbXFLAkx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2007 20:40:53 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5C0ePE5004442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 11 Jun 2007 17:40:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5C0eKCe000480;
	Mon, 11 Jun 2007 17:40:20 -0700
In-Reply-To: <Pine.LNX.4.64.0706111832070.4830@www.mintpixels.com>
X-Spam-Status: No, hits=-2.705 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49904>



On Mon, 11 Jun 2007, Alex R.M. Turner wrote:
> 
> Cool - that totally makes sense, HEAD is a link to master. so updating 
> HEAD failed because it was already up to date.

Yes. Well, strictly speaking it failed because it _wasn't_ up-to-date 
*before* the push (so "git push" thought it should update it), but it had 
become up-to-date (through the symref link) by the time it was actually 
its turn to be updated.

> The command was simply:
> 
> git push

Ok, as Junio points out, it's then just the fact that both repositories 
had the same "remote" refs, and then the default of just updating 
everything in common kicks in.

That default used to make sense back when, but it doesn't make sense for 
remotes, since those are generally "local" to each repo.

> This repo was cloned from one on another server (the server I use to 
> backup everything) with a git clone command:

Yeah. Normally you'd (well, _I_ would) only push to bare repositories, and 
normally you wouldn't make those bare repositories have "remotes" entries, 
which is why you're the first to apparently even notice this insanity.

It wasn't your fault, it's simply bad defaults for git behaviour.

The behaviour for "git pull" has improved _immensely_ over the last few 
months, but "git push" still does the same thing it always did, because 
fewer people care about pushing than pulling, and because the old "git 
push" behaviour of just updating all the branches in common actually 
happens to be the right thing when you do *not* make the central 
repository contain remote branches of its own.

> Based on all this, what is the correct way to update my core repo on my 
> server? (I'm sorry - I'm pretty new to git, so I haven't quite cottoned on 
> to some aspects yet).

With the current git model, I would suggest:

 - for "central" repositories, use a bare repository, and don't create 
   "remotes" branches in that central repository at all.

 - for other repositories, don't push into them, just _pull_ into them 
   (because that also knows about updating the working tree etc: pushing 
   is really meant to be done only into bare and central ones that don't 
   actually have any work happening in them, and _cannot_ have any work 
   happening in them because they don't even have a working directory 
   associated with them)

That said, I don't think that's necessarily the right answer in the longer 
run. It's how git people do things, but it's not necessarily the *best* 
way of doing things. I think the better solution in the longer term is to 
simply improve how "git push" works:

 - we should probably do the same kinds of .git/config file entries for 
   pushing as we do for fetching, and just get rid of the old implicit 
   model, and instead have a nice refspec pattern model for what gets 
   pushed instead.

   I _think_ the refspec cleanup work by Daniel makes this something we 
   can almost already do. Daniel?

 - we should also likely have some way to specify what happens when you 
   push into a branch that is currently checked out and has a working tree 
   associated with it.

   This was briefly discussed a few weeks ago, but nobody cared enough, I 
   suspect.

anyway, I think the _proper_ thing to do would be to associate each 
[remote] entry in the config file with a "push" refspec pattern, the way 
we do for "fetch" already.

		Linus
