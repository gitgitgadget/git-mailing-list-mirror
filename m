From: Luke Lu <git@vicaya.com>
Subject: Multiple shared repositories (including svn) workflow
Date: Sat, 5 Jan 2008 00:54:04 -0800
Message-ID: <DA45FDDC-BEEB-47F6-A2B6-4FE4FFEF8B0D@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 09:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB4ng-0002fZ-Vp
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 09:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYAEIyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 03:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbYAEIyN
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 03:54:13 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:2153 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbYAEIyM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 03:54:12 -0500
Received: by rv-out-0910.google.com with SMTP id k20so6401361rvb.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2008 00:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer:sender;
        bh=9JMifA8u8PDJQ+0Go27qn4Deuo4GzgerT3qEsW2UQro=;
        b=mLUOJ5Fq0SJW9C0AuCr/OrkqJAqooM/s9nSPWopKGZI0XOPkOdv6VMWK6OuT6MX3X7G4nOnCBIPUKCW3JLbEkC4ekVlu/kkRQRdc1XzLyb6vVizpRGwtW6wQaCQR7ejtRQe/HFvjsJzvyiJTKYu5qlseiGaioj9gCCgrhXhcJcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer:sender;
        b=oFXxVRxmzQXdJ9cgPzasctAQNdzNj287u618XTWfSoADA+IuHUE7G4NaiagW4aqNMZynWnC4k7Aw7vT/2VdMf9TejjFrJOAgVnLHjuyKzFXrk4Kzr8ad25HkvlbKlF7u7aDupfdn++0zmRqPGn8GahyeEs5aPm8I44SzGfYQi7c=
Received: by 10.141.49.6 with SMTP id b6mr5256542rvk.68.1199523249462;
        Sat, 05 Jan 2008 00:54:09 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id b34sm2060428rvf.22.2008.01.05.00.54.06
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Jan 2008 00:54:07 -0800 (PST)
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69654>

We have an existing project using subversion. Half of the committers  
want to use git for its features and speed, another half (mostly  
editors, graphic designers etc.) want to continue use svn for the  
usual reasons -- advanced features of git doesn't really buy them  
much. They just want to work as usual, especially with the ease of  
TortoiseSVN (some swear by it). After some thought and experiment, I  
proposed the following workflow:

0. People who want to use svn can continue using svn as usual.

1. A maintainer uses git-svn to convert the subversion project into git:
    git svn clone -s <project_url> project

2. He then creates a bare git repo as the "current" or "official"  
tree for the brave git users.
    git clone --bare project project.git
    project.git is then hosted on server, say, scm

3. Git users clone the "current" repo
    git clone git://scm/repos/project.git
    and work merrily ever after.

4. A maintainer (people or a cron job) would keep both official trees  
synced:
    a. He needs to add a git remote for the git-svn repo created at  
step 1:
       git remote add project ssh://scm/repos/project.git
    b. To sync commits from git to svn:
       git fetch && git rebase project/master
       git svn rebase
       git svn dcommit
    c. To sync from svn to git:
       git svn rebase
       git rebase project/master
       git push project

Preliminary tests showed that it seems to work well. Any problems  
that I didn't foresee?

Anyway, I've been using git for only a few months. There might/must  
be better ways to do it. As a user coming from cvs and svn, it seems  
to me that the most confusing command is actually "git pull" as it  
doesn't work with such workflow at all (conflicts with confusing  
messages, until you really understand the implications of rebase). It  
seems to me that if we create a new "git update" command which is  
essentially "git fetch && git rebase <remotebranch>", it would  
greatly alleviate such confusions. Some lessons learned from the  
short experience:

1. commit first, ask question later.
2. rebase is the new update
3. reset --hard and reflog are your friends.

Again, comments welcome.

__Luke
