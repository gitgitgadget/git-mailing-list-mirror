From: Blaisorblade <blaisorblade@yahoo.it>
Subject: git-merge-cache / StGIT - gitmergeonefile.py: merging one tree into another rather than two trees into merge base
Date: Sat, 10 Sep 2005 20:27:28 +0200
Message-ID: <200509102027.28812.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 10 20:31:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEA79-000603-2R
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 20:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVIJSaE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 14:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbVIJSaE
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 14:30:04 -0400
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95]:27570 "HELO
	smtp006.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932130AbVIJSaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 14:30:03 -0400
Received: (qmail 13691 invoked from network); 10 Sep 2005 18:29:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=v1XW9Jmbsvyt7Q1ziAwI7nIdw6FI5H5jdN0urzBTtedGnLCDy3e2xZbaQJwXv67NZBZqgqA9e4zvV30obEVahINa/enC5oZ0ZlbGuDWa0Ru7UjLLQLQKVTHobdACn7FyUSlLUD2AdcT2UUQZtsE9mCtOddqbfGUGSStdj+RZFZk=  ;
Received: from unknown (HELO zion.home.lan) (blaisorblade@62.11.72.160 with login)
  by smtp006.mail.ukl.yahoo.com with SMTP; 10 Sep 2005 18:29:50 -0000
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
User-Agent: KMail/1.8.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8257>

(Please CC me on replies as I'm not subscribed).

I experienced a (performance) problem with StGit, but I don't know if it's the 
culprit or if git-merge-cache is.

Today I was pushing my patch stack (which was against Linux 2.6.13) on top of 
the latest snapshot I have (i.e. upstream will likely have some mega of 
patches). And it was *really* slow (say it pushed 8 patches in 5 minutes).

After the analisys, it's more or less logical - it'd take more or less the 
same time to merge upstream changes against local ones. The problem is that 
it's not how things should go.

I looked with "top" at what was happening, and I saw a lot of time spent by 
either gitmergeonefile.py or git-update-cache --remove*. And looking at the 
merge algorithm, I realized it merges both HEAD and patch top into the patch 
bottom (or something like that).

I.e. if upstream rewrote everything, it will merge this rewrite into the patch 
bottom, together with the patch itself. So, the merge time will depend on the 
biggest of the two changed trees, not on the least one.

A more reasonable algorithm would be along "read-tree HEAD"; merge "stg diff 
-r /" (i.e. the current patch) in it.

I don't know if there's any real difference between cg-Xmergefile, 
gitmergeonefile.py and git-merge-one-file-script, and if that would matter in 
this case.

* About --remove, it was called on files which were present in stage1, removed 
in stage2 (i.e. upstream) and unchanged in stage3 (i.e. patch).

In the git-read-tree manpage (which is probably outdated), this is documented 
as follows:

       o  stage 1 and stage 3 are the same and stage 2 is different: 
           take stage 2 (some work has been done on stage 2)

But it didn't happen, which is strange.

Additional note: in StGIT, git-read-tree is called with stage1 which is not 
the merge base between stage2 and stage3.

It is passed the patch bottom, the current HEAD and the patch top.

For the first patch, the patch bottom is the merge base, but not otherwise; so 
differences between either stage1 or stage3, and stage2, include files 
changed in previous patches.

So, would stgit delete a file created in patch #1 when merge-applying patch 
#2?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
