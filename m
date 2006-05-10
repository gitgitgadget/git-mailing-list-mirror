From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Implementing branch attributes in git config
Date: Wed, 10 May 2006 16:55:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605101629230.3718@g5.osdl.org>
References: <1147037659.25090.25.camel@dv>  <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org>  <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE>
  <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE> 
 <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org>  <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE>
  <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org> 
 <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com> 
 <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
 <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sean <seanlkml@sympatico.ca>, junkio@cox.net,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 11 01:58:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdyZB-00073a-5z
	for gcvg-git@gmane.org; Thu, 11 May 2006 01:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWEJX5g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWEJX5g
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 19:57:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965090AbWEJX52 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 19:57:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4ANtgtH021238
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 10 May 2006 16:55:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4ANtft7030383;
	Wed, 10 May 2006 16:55:41 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90605101617x1aa9bd2du959ead77ebf61795@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19898>



On Thu, 11 May 2006, Martin Langhoff wrote:
> 
> Apologies -- I didn't want to know it, but I do wonder what the gain
> behind the change is.

I think we can do better in a few pretty important regards:

 - having the information in one place. I agree that the multi-file 
   approach works fine for shell scripts (although I disagree that the new 
   one would be harder - you just use git-repo-config instead), but I 
   think it's quite confusing from a new user perspective.

   I bet that even without any tools, new users can be told to just open 
   ".git/config", and guess how hard a time they would have to add a new 
   branch, if they already had one that said

	[branch "origin"]
		remote = git://git.kernel.org/pub/scm/git/git.git
		branch master

   which would tell you that the local branch "origin" is really branch
   "master" at that remote git repository.

   Yeah, I'm not sure what the actual config rules would be, but think it 
   would be a hell of a lot more intuitive than what we have now. 

   What we have now _works_. It works really well. No question about that. 
   It's just pretty hard to explain. The above syntax wouldn't even need 
   any explanation. You could just tell people to look into their config 
   files.

 - I think we'll have a much easier time (from a purely technical angle) 
   to add special attributes to the local branches. Add a "read-only" 
   specifier? It's _obvious_:

	[branch "origin"] 
		remote = git://git.kernel.org/pub/scm/git/git.git
		branch master
		readonly

   and it's absolutely trivial to parse. And part of the important thing 
   is that this all makes 100% sense EVEN IF IT'S NOT A REMOTE REPO!

   So imagine that it's a purely local branch, but you want to protect it. 
   Solution?

	[branch "July Snapshot"]
		readonly

   and you're done. In contrast, even if you ended up just extending the 
   file format for the .git/remotes/July\ Snapshot file, and just added a 
   "readonly" line to it, it wouldn't make _sense_. Whaa? "remotes"? In 
   contrast, in the .git/config file, it makes a ton of sense, and in fact 
   it's totally obvious.

   (Actually, we should probably have the .git/config file syntax separate 
   local branches like "master" from remote branches like "origin", so it 
   might be more like

	[remote "origin"]
		url = git://git.kernel.org/pub/scm/git/git.git

    which just tells that the _word_ "origin" corresponds to a 
    shorthand for a particular remote repository

	[branch "origin"]
		remote = origin
		branch = master

   or something to show that your _local_ branch named "origin" 
   corresponds to a particular remote (which could be a shorthand like the 
   above, or just spelled out), and a particular branch _at_ that remote 
   repository)

   Anyway, the point is, I think our current .git/remotes/xyzzy files 
   actually mix two different concepts, and they also end up doing it 
   pretty badly. They _work_, but because of the mix-ups, they aren't all 
   that they could be, and it's fundamentally impossible to make them so, 
   because the mixup really is that "origin" means TWO DIFFERENT THINGS 
   (the local branch, and the remote that it corresponds to)

 - Finally, I think it opens the possibility for some other things. For 
   example, once you accept that different branches might want attributes 
   like "readonly", you realize that some other attributes also make 
   sense. Like adding the default pull source per local branch, etc.

Again, I'm not saying that we can't work with the .git/remotes/ files. But 
I think it gets increasingly ugly, and the confusion gets increasingly 
worse.

> But it is a bit of a loss for perl/shell porcelains, and for users
> that abuse the contents of .git directly on a regular basis...

I really disagree. 

The .git/config file is _easier_ to edit by hand than the remotes. It's 
easier to copy-paste within one file than it is to work with two different 
files (and let's face it, copy-paste is usually what at least I would do 
for something like this). And it's _easier_ to just always open one file, 
and search within that one, than try to remember what file it was.

Now, C programs can very easily use the config library, and shell programs 
can equally easily query the variables with "git repo-config". I really 
doubt it's very hard for perl either, but I'm not a perl person, so maybe 
I don't see why this is hard.

		Linus
