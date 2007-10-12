From: mfwitten@MIT.EDU
Subject: Imports without Tariffs
Date: Fri, 12 Oct 2007 16:36:29 -0400
Message-ID: <1C0D32ED-59F7-43D4-88B1-D7A9E754D639@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 12 22:47:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgRKp-0008ET-In
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 22:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757377AbXJLUlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 16:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757491AbXJLUlu
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 16:41:50 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:33174 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757017AbXJLUlt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Oct 2007 16:41:49 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Oct 2007 16:41:49 EDT
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9CKaVer027197
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 16:36:31 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9CKaU2w006894
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 12 Oct 2007 16:36:31 -0400 (EDT)
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60705>

[INTRO]

	Hello,
	
	I have come across a problem that could be easily addressed
	in order to improve interoperability between CVS and git.
	
	
	I'm new to using git (and a novice with SCMs in general),
	and I really enjoy the way that git allows me to think.
	
	Unfortunately, I am forced to deal with CVS (for one of
	my classes), but I have been courageously trying to use
	git behind the scenes, as I can already tell CVS is a
	nightmare.
	

[SCENARIO]
	
	I would like to do the following sequence:
		
		(1) Checkout a CVS repository as a git working tree.
				
			=> git cvsimport -A /path -a -k -v -r cvs -C work module
			
		(2) Edit the git working tree and make commits there.
				
			=> cd work
			=> vim ... # emacs can go live with CVS ;-P
			=> git commit -a -m ...
				
		(3) Export my git working tree commits back to CVS.
			
			=> cd ..; cvs co modules; cd modules
			
			=> for each pertinent git commit hash, HASH:
				GIT_DIR=../work/.git git-cvsexportcommit -vc HASH
				
		(4) Update my git working tree from CVS (at some later time).
			
			=> cd ../work
			=> git cvsimport -a -k -v -r cvs -C . module
		
[PROBLEM]
	
	git-cvsimport creates new hash IDs for the same ol' commits.
	
	
	Running git-cvsimport does indeed do an incremental update of
	the 'cvs' remote in the 'work' git repository.
	
	However, the updates are brought in as brand new git commits
	with the CVS dates in the log (though changed to UTC +0000!!).
	
	Therefore, when the updated 'cvs' remote branches are merged into
	my local branches, git treats the commits I made with cvsexportcommit
	as separate history; thus, history is duplicated and merge commits
	appear where they shouldn't.

[PARTIAL SOLUTION]
	
	The trick is to populate the 'cvs' remote branches with commits that
	have the right hash IDs.
	
	I thought I could do this by hand.
	
	I updated the cvsexportcommit/cvsimport sequence by pushing
	my local branches into their respective 'cvs' remote branches,
	before running that last cvsimport:
		
		=> for each pertinent git commit hash, HASH:
			GIT_DIR=../work/.git git-cvsexportcommit -vc HASH
		
		=>=>=> git push . refs/heads/master:refs/remotes/cvs/master
		
		=> git cvsimport -a -k -v -r cvs -C . module
	
	Of course, git-cvsimport still adds the commits to the 'cvs'
	remote branches, duplicating (log) histories.
	
	The difference is that the 'cvs' remote branches become descendants
	of the local branches, causing a fast-forward merge with the local
	branches; this removes the split histories, but still duplicates
	information in an even dumber way, as changes are undone and then
	redone.

[SOLUTION]
	
	The trick is to make both git-cvsimport and the user smarter
		---- A TALL ORDER!
	
	
	To make things simple, I think all of the necessary machinery
	should be put into git-cvsimport.
	
	The user should first git-cvsexportcommit as necessary.
	
	Then the user should tell git-cvsimport to push from the pertinent git
	branches into the pertinent cvsimport branch. To make things even  
simpler,
	I think that git-cvsimport should make the -r option mandatory; then
	git-cvsimport would simply do the pushing as I did:
		
		git push . refs/heads/<branch1>:refs/remotes/<remote>/<branch2>
	
	Then git-cvsimport would mark for each pushed-into branch the timestamp
	for when the push occurred. These marks could be put in some special  
file,
	say .git/CVSIMPORT.
	
	The next time git-cvsimport is used as normal, it can consult this  
file for
	timestamps, rather than relying on git log timestamps, to determine  
if creat-
	ing a new commit is necessary.

[CONCLUSION]
	
	I feel that not much is being put into converting between git and  
CVS, which
	is unfortunate, because a lot of stuff is in CVS out there; here at  
MIT,
	*all* CS students have to use CVS for at least one semester of  
grueling programming
	labs.
	
	If conversion between git and CVS is hard, many students will just  
learn
	what seems easiest---CVS---and they'll decide to use CVS for their  
projects
	later on (I've already seen this happen); that's not a future I want  
to have!
	
	Sincerely,
	Michael Witten
	
[OTHER PROBLEMS]
	
	(1) git-cvsimport creates log entries with UTC times; maybe that's  
correct.
	(2) git-cvsimport's -A argument must be a full path.
	(3) git-cvsexportcommit should automatically handle contiguous commits.
	(4) git-cvsimport is written in the most unmaintainable perl ever!
