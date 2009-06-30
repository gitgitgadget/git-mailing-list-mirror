From: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
Subject: git svn and multiple cloned repositories
Date: Tue, 30 Jun 2009 14:23:30 +0200
Message-ID: <h2d043$4tm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 30 14:46:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward1.uio.no ([129.240.10.70])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLchk-0008N3-Tm
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:44:56 +0200
Received: from exim by mail-out1.uio.no with local-bsmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLcNN-0001Q8-7m
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:23:53 +0200
Received: from mail-mx2.uio.no ([129.240.10.30])
	by mail-out1.uio.no with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLcNN-0001Q4-6f
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:23:53 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp  (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1MLcNL-0005RM-HW
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 14:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbZF3MXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 08:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbZF3MXk
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 08:23:40 -0400
Received: from main.gmane.org ([80.91.229.2]:48912 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbZF3MXj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 08:23:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MLcNC-0000O2-7K
	for git@vger.kernel.org; Tue, 30 Jun 2009 12:23:42 +0000
Received: from 1ba55-2-88-173-28-134.fbx.proxad.net ([88.173.28.134])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 12:23:42 +0000
Received: from Bruno.Harbulot by 1ba55-2-88-173-28-134.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 12:23:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 1ba55-2-88-173-28-134.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.21 (Macintosh/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3, uiobl=NO, uiouri=_URIID_)
X-UiO-Scanned: 46647E30DBD8D492AF052693C7C506497BB76829
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 80 minaction 2 bait 0 mail/h: 68 total 2547475 max/h 849 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122510>

Hello,


I participate in a few open-source projects for which I provide patches 
sometimes, but most of these projects use Subversion. git-svn is very 
convenient for trying out patches without interfering with the main 
branch (so as to submit them when they're ready). I presume many 'git 
svn' users do something like this too.

However, I'd like to keep multiple copies of this repository (on a few 
machines, including one on a backup server) with the appropriate SVN 
metadata. I'd also like to be able to do 'git svn fetch' on only one of 
these cloned repositories (perhaps via crontab on the server) and to be 
able to push/pull this SVN metadata along with the commits between the 
cloned git repositories.


Is there a recommended way to do this?


I have found 3 ways of achieving this, but none of them seem ideal:

1. Copying the entire cloned repository as regular files and doing 'git 
svn fetch' regularly on each copy.

    - Doing the initial "git svn clone" on one machine (machine1).
    - Copying the cloned repository onto the backup machine 
(backup-server), using tar for example.
    - Adding the repository on 'backup-server' as a remote repository on 
'machine1' (so that I can push my own branches).
    - Doing 'git svn fetch' regularly on both 'machine1' and 
'backup-server'.

This works, but this duplicates the interactions with the SVN server 
(for as many clones I have locally). This is what I'd like to avoid.


2. Transferring the SVN references by hand.

    - On 'backup-server':
      - git --bare init
      - git --bare svn init -s --prefix=svn/ https://project.example.com/svn
      - git --bare svn fetch
    - On 'machineX':
      - git clone ssh://backup-server/~/Project.git/
      - ssh backup-server "cd Project.git ; tar czf - svn refs/remotes 
info/refs packed-refs" | tar xvzf - -C .git/
      - Edit packed-refs to change "refs/heads/master" into 
"refs/remotes/origin/master".
      - git svn init -s --prefix=svn/ https://project.example.com/svn
      - git svn fetch


3. Using 'git clone --mirror' (only works with --bare option).

(same as 2. on backup-server)
    - git clone --mirror ssh://backup-server/~/Project.git
    - mv Project.git .git
    - Edit .git/config by hand to remove the bare repository option
    - git svn init -s --prefix=svn/ https://project.example.com/svn
    - git svn fetch
(I sill have to use 'git svn fetch' regularly with this).




Best wishes,

Bruno.
