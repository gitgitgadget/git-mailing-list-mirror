From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: [PATCH] git-p4: check for existence of repo dir before trying to create [Was: Asking again... [Re: how to properly import perforce history?]]
Date: Mon, 11 Jun 2007 16:51:40 -0400
Message-ID: <20070611205140.GN25093@menevado.ms.com>
References: <20070608202236.GJ25093@menevado.ms.com> <200706111656.33696.simon@lst.de> <20070611194450.GK25093@menevado.ms.com> <200706112159.34181.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Jun 11 22:52:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxqs7-0005Z1-P3
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 22:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752888AbXFKUvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 16:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbXFKUvp
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 16:51:45 -0400
Received: from pimtabh4.ms.com ([199.89.64.104]:35286 "EHLO pimtabh4.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755311AbXFKUvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 16:51:44 -0400
Received: from pimtabh4 (localhost.ms.com [127.0.0.1])
	by pimtabh4.ms.com (output Postfix) with ESMTP id 478A74800E;
	Mon, 11 Jun 2007 16:51:41 -0400 (EDT)
Received: from ny16im01.ms.com (unknown [144.14.206.242])
	by pivsbh2.ms.com (internal Postfix) with ESMTP id 288192B61;
	Mon, 11 Jun 2007 16:51:41 -0400 (EDT)
Received: from menevado.ms.com (menevado [144.14.26.134])
	by ny16im01.ms.com (Sendmail MTA Hub) with ESMTP id l5BKpeE03279;
	Mon, 11 Jun 2007 16:51:40 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id l5BKpeOn004839; Mon, 11 Jun 2007 16:51:40 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200706112159.34181.simon@lst.de>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 11062007 #321194, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49884>

On 06/11/07 15:59:30, Simon Hausmann wrote:
> On Monday 11 June 2007 21:44:50 you wrote:
> > On 06/11/07 10:56:33, Simon Hausmann wrote:
> > > *plug* You could try with git-p4 from http://repo.or.cz/w/fast-export.git
> > > . It should be just a matter of calling
> >
> > hmmm....  Failed with this:
> >
> > $ git clone http://repo.or.cz/w/fast-export.git
> > Initialized empty Git repository in /var/tmp/kgreen/dev/fast-export/.git/
> > /ms/dist/fsf/PROJ/git/1.5.2.1/bin/git-clone: line 381: cd:
> > /var/tmp/kgreen/dev/fast-export/.git/refs/remotes/origin: No such file or
> > directory
> > fatal: Not a valid object name HEAD
> >
> > I then tried the mirror I found at the git revision history site:
> >
> > $ git clone http://repo.or.cz/r/fast-export.git
> > Initialized empty Git repository in /var/tmp/kgreen/dev/fast-export/.git/
> > Getting alternates list for http://repo.or.cz/r/fast-export.git
> > Getting pack list for http://repo.or.cz/r/fast-export.git
> > Getting index for pack 66d95396fcacd053b385a4ed71edb2b1bc15e074
> > ...
> >
> >
> > Don't know if they're the same, but I'll give it a shot now...
> 
> The latter seems indeed like the right URL for a HTTP based clone off of 
> repo.or.cz. I would recommend using the git protocol though if possible :)
> 

Not possible unfortunately...

Anyway, grabbed git-p4 and tried it three ways:

1) git-p4 clone //depot/path/repo@all

  I don't like this because it creates a git repository under "repo" subdir.
  To make a long store short, we have a very strict namespace for
  development...  The path ends in src and I'd like the .git repository to be
  under src.  

So, I tried this one level up:

2) git-p4 clone //depot/path/repo@all src

	But that dies with a mkdir error because 'src' already exists.  I want to
	submit a patch, but wanted to check with you first to see if that's the
	desired behaviour (I don't think it should fail though) because maybe you
	want to stop someone from scribbling on an already present git repository?

	I would want to just go for a "if it doesn't exist yet, create it,
	otherwise, forge ahead" behaviour.  I attach the patch after my .sig...

3) Tried without clone:

$ git init
$ git-p4 sync //depot/path/repo@all

	This looks like it's pulling down all the revisions, but it doesn't
	actually put any code in there.  I'm left with the same situation as
	git-p4import.py.
	
	Actually, not even.  I don't even have the commit history...


I would like to get 3 working properly because it's clunky to do #2.  But with
the patch, #2 does what I want and gets me started...

Patch attached.  Please let me know what I'm doing wrong with #3 above...


Thanks

--Kevin


>From c14f906b255a310db0c674ce567fd776aad8f397 Mon Sep 17 00:00:00 2001
From: Kevin Green <Kevin.Green@morganstanley.com>
Date: Mon, 11 Jun 2007 16:48:07 -0400
Subject: [PATCH] git-p4: check for existence of repo dir before trying to create

When using git-p4 in this manner:

git-p4 clone //depot/path/project myproject

If "myproject" already exists as a dir, but not a valid git repo, it fails
to create the directory.

Signed-off-by: Kevin Green <Kevin.Green@morganstanley.com>
---
 git-p4 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-p4 b/git-p4
index e380c14..cababc7 100755
--- a/git-p4
+++ b/git-p4
@@ -1400,7 +1400,8 @@ class P4Clone(P4Sync):
             self.cloneDestination = self.defaultDestination(args)

         print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
-        os.makedirs(self.cloneDestination)
+        if not os.path.exists(self.cloneDestination):
+            os.makedirs(self.cloneDestination)
         os.chdir(self.cloneDestination)
         system("git init")
         self.gitdir = os.getcwd() + "/.git"
--
1.5.2.1
