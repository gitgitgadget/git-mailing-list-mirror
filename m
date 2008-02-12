From: Voltage Spike <voltspike@gmail.com>
Subject: Merge-Recursive Improvements
Date: Tue, 12 Feb 2008 15:16:33 -0700
Message-ID: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 23:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3RD-00083l-7B
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755987AbYBLWQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 17:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755228AbYBLWQi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:16:38 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:45689 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbYBLWQh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 17:16:37 -0500
Received: by wf-out-1314.google.com with SMTP id 28so246521wff.4
        for <git@vger.kernel.org>; Tue, 12 Feb 2008 14:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        bh=x7YPQ6OQ2oiIUbIDtw1Rg+2jsucdjmSwc/Pzq53pDU0=;
        b=GPVCfRemhh9msw65+CeK9qWFUSVw6QRvvHIXBxyAKB6guuPTWdPne8N2m3qd7JGVzv7UuByH+8cyjeGSH1UYlVJMeavenQKefu2kfiITCQkNVOXnIig1VxHcai02bQmBB5Ym1sFG7qxP4AaxQXDes0uXNNdttLZpPaSN6lWAff0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=L7spauZh6aUybYHnJIqObJDVik4rql/k6tOaw3yxcJzFroCLxX5YcvPfLv+l+zzpZwxnbs6OD+6HVYGLWnzzyQj0Hr0HbNNh+2wxImFBro4p2P+ZRmu88VgJ4h5QxhW0d6xZWEsLn3ci5wAdIPh8RrU00y0JKhdHlF5CWuu3NSI=
Received: by 10.142.242.8 with SMTP id p8mr1486203wfh.232.1202854595738;
        Tue, 12 Feb 2008 14:16:35 -0800 (PST)
Received: from ?172.16.10.31? ( [199.0.156.179])
        by mx.google.com with ESMTPS id 24sm1259985wff.10.2008.02.12.14.16.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Feb 2008 14:16:34 -0800 (PST)
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73703>

I would like to make a series of significant improvements to the
merge-recursive mechanism in git, but I was hoping to solicit some early
feedback before submitting patches.

First, git is overly zealous at merging differences and two functions  
added
at the same point in a file become intertwined during the merge. A  
trivial
example of this behavior:

   <<<<<<< HEAD:file.txt
   void newfunc1()
   =======
   void newfunc2()
   >>>>>>> merge:file.txt
   {
     int err;
   <<<<<<< HEAD:file.txt
     err = doSomething();
   =======
     err = doSomethingElse();
   >>>>>>> merge:file.txt

Second, git doesn't tell me the original code inside the conflict  
markers so
I almost always resort to "MERGE_HEAD...ORIG_HEAD" and
"ORIG_HEAD...MERGE_HEAD" diffs to see what was going on. I could use an
external diff tool (yuck), but I would like to modify the conflict  
markers
to resemble those of Perforce:

   >>>>>>> merge-base:file.txt
   Original code.
   ======= HEAD:file.txt
   Head code.
   ======= merge:file.txt
   Merged code.
   <<<<<<<

Third, git doesn't appear to have any sense of context when performing a
merge. Another contrived example which wouldn't be flagged as a merge
conflict:

   ptr = malloc(len); // Added in HEAD.
   init();            // Included in merge-base.
   ptr = malloc(len); // Added in "merge".

Fourth, git doesn't provide a mechanism for merges to ignore whitespace
changes.

I resolved issues the first and the fourth through the introduction  
of new
configuration variables and trivial modifications to the manner in  
which we
call xdl_merge. I suspect the second and third issue may also be  
simple to
solve but would require that I modify libxdiff directly.

Are these changes something other people might be interested in? (It  
seems
odd that nobody is complaining about these really irritating flaws.)  
Should
I concern myself with writing a custom merge driver rather than  
modify core
behavior (even if the change is configurable)?  If I should focus on an
external driver, under what circumstances would merge.*.recursive  
come into
play (i.e., when do I have to worry about poor behavior for an "internal
merge")?

Thank you in advance for the feedback.
