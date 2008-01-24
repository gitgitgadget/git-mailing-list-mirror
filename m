From: Sam Vilain <sam@vilain.net>
Subject: Re: Odd number of elements in anonymous hash
Date: Fri, 25 Jan 2008 12:10:02 +1300
Message-ID: <47991ACA.7010507@vilain.net>
References: <200801081738.56624.devurandom@gmx.net> <200801240037.33908.devurandom@gmx.net> <4797E894.8060706@vilain.net> <200801241513.45088.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jan 25 00:12:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIBFc-0003hM-Gf
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 00:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbYAXXMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 18:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754139AbYAXXMU
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 18:12:20 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:51925 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbYAXXMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 18:12:18 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1003)
	id 00F5D21D152; Fri, 25 Jan 2008 12:12:15 +1300 (NZDT)
FCC: imap://sam@localhost/INBOX/Sent
X-Identity-Key: id4
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; uuencode=0
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <200801241513.45088.devurandom@gmx.net>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71668>

Dennis Schridde wrote:
>>> Server: git config:
>>> ------
 [...]
>>> [svn-remote "svn"]
>>>         useSvnsyncProps = 1
>>>         url = file:///var/svn/warzone2100
>>>         fetch = trunk:refs/remotes/trunk
>>>         branches = branches/*:refs/remotes/*
>>>         tags = tags/*:refs/remotes/tags/*
>>> ------
 [...]
>>> Local config:
>>> ------
 [...]
>>> [remote "origin"]
>>>         url = git://git.kynes.de/org.gna.warzone2100.git
>>>         fetch = +refs/heads/*:refs/remotes/origin/*
>> You need to make that:
>>
>>   fetch = refs/remotes/*:refs/remotes/*
>>
>> And re-run 'git fetch' to use git-svn fetch on the cloned repository.
>> git-svn is expecting the refs/ space to be populated in the same way
>> that it is on the repository doing the initial fetch.
> Thanks a lot!
> That worked!
> 
> Possibly you should update the manpage, so no others run into this.
> It currently just says:
>        # Tell git-svn which branch contains the Subversion commits
>                git update-ref refs/remotes/git-svn origin/master
> Which is apparently not sufficient (or outdated?).

Indeed, that would be helpful.

Subject: [PATCH] git-svn(1): update instructions for resuming a git-svn clone

git-svn expects its references under refs/remotes/*; but these will
not be copied or set by "git clone"; put in this man page the manual
fiddling that is required with current git-svn to get this to work.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 Documentation/git-svn.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index e1a1d46..b1d527f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -456,10 +456,13 @@ have each person clone that repository with 'git clone':
 ------------------------------------------------------------------------
 # Do the initial import on a server
 	ssh server "cd /pub && git-svn clone http://svn.foo.org/project
-# Clone locally
-	git clone server:/pub/project
-# Tell git-svn which branch contains the Subversion commits
-	git update-ref refs/remotes/git-svn origin/master
+# Clone locally - make sure the refs/remotes/ space matches the server
+	mkdir project
+	cd project
+	git-init
+	git remote add origin server:/pub/project
+	git config --add remote.origin.fetch=+refs/remotes/*:refs/remotes/*
+	git fetch
 # Initialize git-svn locally (be sure to use the same URL and -T/-b/-t options as were used on server)
 	git-svn init http://svn.foo.org/project
 # Pull the latest changes from Subversion
-- 
1.5.3.5
