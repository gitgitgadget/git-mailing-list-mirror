From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How to remove invalid remote repository
Date: Tue, 5 Jun 2007 13:18:14 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706051308090.4921@woody.linux-foundation.org>
References: <8A00BB77B01133479F4A56D932A1132202906FD8@EX-401.mail.navisite.
 com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Seitz <seitz@neopathnetworks.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 22:18:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvfU8-0006Sv-BL
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 22:18:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbXFEUSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762954AbXFEUSX
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 16:18:23 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59990 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755761AbXFEUSX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 16:18:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l55KIKwb029228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jun 2007 13:18:21 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l55KIEQZ002083;
	Tue, 5 Jun 2007 13:18:14 -0700
In-Reply-To: <8A00BB77B01133479F4A56D932A1132202906FD8@EX-401.mail.navisite.com>
Received-SPF: neutral (207.189.120.55 is neither permitted nor denied by domain of torvalds@linux-foundation.org)
X-Spam-Status: No, hits=-2.712 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.180 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49225>



On Tue, 5 Jun 2007, Matt Seitz wrote:
>
> I mistakenly entered the wrong directory name for "git remote add" (I
> entered the working tree directory name instead of the ".git" directory
> name). 

Now, that should be fine. You don't have to add the .git name, git will 
figure it out on its own.

> So "git fetch" fails with:
> 
> fatal: 'origin': unable to chdir or not a git archive
> fatal: The remote end hung up unexpectedly

Well, this is because you apparently didn't call the remote "origin", but 
something else. So when you do

	git fetch

without giving any remote name at all, git will *default* to using 
"origin" as a remote, but since no such remote name exists, it will try to 
use that remote as a pathname (which is admittedly a bit silly, but git 
doesn't know that), and so what happened was that it was trying to fetch 
from the git repository "origin", but no such git repository existed, and 
thus it says:

	fatal: 'origin': unable to chdir or not a git archive

In fact, the remote name you added seems to be "root-etc", juding from 
your config file (which I've recreated here by looking at your "git 
config -l" output - things like whitespace may be off):

	[core]
		repositoryformatversion=0
		filemode=true
		bare=false
		logallrefupdates=true

	[gui]
		geometry=811x591+781+0 107 172

	[remote "root-etc"]
		url=/root/git/etc
		fetch=+refs/heads/*:refs/remotes/root-etc/*

> So, I tried removing the remote tracking branches:
> 
> git branch -d -r root-etc/master
> 
> But that failed with:
> 
> error: remote branch 'root-etc/master' not found.

The easiest way to remove the remote is _literally_ by just editing the 
".git/config" file. It's not magic, and the syntax really is as trivial as 
it looks, and it's perfectly ok to just fire up an editor and fix it up. 

In this case, the easiest fix is to not delete that remote entry at all 
(it's a fine entry, afaik), but you have to tell git that your local 
"master" branch should track it.  You do that by just adding

	[branch "master"]
		remote = root-etc
		merge = refs/heads/master

which tells git that when you are on the "master" branch, and do a "git 
fetch", it should fetch from that "root-etc" remote (and if you doa 
"pull", which implies also merging, it should merge the 
"refs/heads/master" branch from that remote into your local master).

> So I then tried recreating the remote reference:
> 
> git remote add root-etc /root/git/etc/.git
>
> But that failed with:
> 
> remote root-etc already exists

Right. It already does, because you already have it, and your previous add 
already worked. The only issue is that since you didn't tell that your 
current branch should be hooked up with that particular remote, so git 
ended up using the default (which is called "origin", not "root-etc").

		Linus
