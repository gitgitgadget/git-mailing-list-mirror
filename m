From: worley@alum.mit.edu (Dale R. Worley)
Subject: Using filter-branch without messing up the working copy
Date: Thu, 3 Oct 2013 11:07:09 -0400
Message-ID: <201310031507.r93F79ci003282@hobgoblin.ariadne.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 03 17:14:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRkbl-0000nW-Np
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 17:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958Ab3JCPOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 11:14:22 -0400
Received: from qmta11.westchester.pa.mail.comcast.net ([76.96.59.211]:56404
	"EHLO QMTA11.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754956Ab3JCPOT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Oct 2013 11:14:19 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Oct 2013 11:14:19 EDT
Received: from omta23.westchester.pa.mail.comcast.net ([76.96.62.74])
	by QMTA11.westchester.pa.mail.comcast.net with comcast
	id YbCh1m0021c6gX85Bf7Bql; Thu, 03 Oct 2013 15:07:11 +0000
Received: from hobgoblin.ariadne.com ([24.34.72.61])
	by omta23.westchester.pa.mail.comcast.net with comcast
	id Yf7A1m0151KKtkw3jf7Bvj; Thu, 03 Oct 2013 15:07:11 +0000
Received: from hobgoblin.ariadne.com (hobgoblin.ariadne.com [127.0.0.1])
	by hobgoblin.ariadne.com (8.14.7/8.14.7) with ESMTP id r93F799h003283
	for <git@vger.kernel.org>; Thu, 3 Oct 2013 11:07:10 -0400
Received: (from worley@localhost)
	by hobgoblin.ariadne.com (8.14.7/8.14.7/Submit) id r93F79ci003282;
	Thu, 3 Oct 2013 11:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1380812831;
	bh=Qq23EtaKXxGE7Mhla4IrXAno9RnEQENP9vQqA5jDnH0=;
	h=Received:Received:Received:Received:Date:Message-Id:From:To:
	 Subject;
	b=QXZW5LOFixMApJD2JT7tzkJNBoJAWrqBQNyiuHYYbo/dpotH07DmgJYtPUjatI3kc
	 cLC8E+VDWREMv8PW2YsbG0JaYOYAn8r35GbVXDvrGIu11ExPJuo4DQcdwTB+So98nA
	 5sSjHaGMpFPsBZUecnRLdHld5o2mjIYOAQoLrnFLHx9a0DO4iRn6TQsmnraZ0/mn0T
	 Zsj3KIaSBkUWY6lAPcXN6vAJyAwX4CozNboEDybEjq1mKngpuFn9WD/M37TcRP0yqf
	 W6fNZF/nCNnPdWtJs88GhB0JnEekQ9qhMWsRsgGmcNSo8aWhWO2cLDHW3mVyPkP4Et
	 L0Y3y7JTu2R8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235684>

I'm working on using "git filter-branch" to remove the history of a
large file from my repository so as to reduce the size of the
repository.  This pattern of use is effective for me:

1. $ git filter-branch --index-filter 'git rm --cached --ignore-unmatch core.4563' HEAD

2. edit .git/packed-refs to remove the line
   "c6589bef2c776277407686a3a81c5a76bfe41ba2 refs/original/refs/heads/hobgoblin"
(so that there is no reference to the old HEAD)

3. git gc --quiet --aggressive

The difficulty I am having is that I do not want to disturb the
working copy while doing this.  The working copy is my entire home
directory, because I am using the repository as a historical backup
system for my home directory.  Currently, Git will not execute
filter-branch if there are unstaged changes in the working copy,
despite the fact that "git filter-branch --index-filter" does not
touch the working copy itself.  (In this case, the file to be deleted,
"core.4563", is not now in the working copy.)

A further difficulty is that the repository is "remote", the .git
directory is not in my home directory, and core.worktree is
"/home/worley".

The best set of steps I have found that accomplishes my goals is to
(1) "disconnect" the repository from the working copy by removing the
core.worktree value, (2) use "git checkout -q -f master" to create in
the repository's location an entire copy of my home directory, (3)
perform the above filtering steps, (4) "reconnect" the repository by
adding the core.worktree value, and (5) deleting the temporary working
copy files.

Surely there is a better way than this.

Dale
