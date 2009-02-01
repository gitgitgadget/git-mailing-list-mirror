From: Jay Soffian <jaysoffian@gmail.com>
Subject: git remote rm considered harmful?
Date: Sun, 1 Feb 2009 09:52:40 -0500
Message-ID: <76718490902010652w7a332550w5e0658a390c7dea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 01 15:58:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTdma-00077s-Jq
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 15:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbZBAOwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 09:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbZBAOwm
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 09:52:42 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:61668 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbZBAOwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 09:52:41 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1121372rvb.1
        for <git@vger.kernel.org>; Sun, 01 Feb 2009 06:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=Xn3MM9qmcUWrRiB1lSHztsrVPvNDj8wREnjf17gSJ9k=;
        b=H7htiuKJjJR+6uQy8GFBjzmTjApzVo6IRxbOUEeGOMkzuTNc3BXEFdeJM4gRutLNy7
         PENdce1aMQbt780Ib1hZ31UQXtbc+rndfc419lPMJMendMpKojm5cV4EyaSNjN0jaPaz
         08h1I11wdfPK4HZ4DCwfsRvsrNMluAI+QzZTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FcCG5e/pikftdoni8gxyVofp0sGxKgRFI+rDnqv9QYcGRwwPDz+f/pXaftJ2OzcRkY
         Og6EXPA0CQtqbnamJoOP/n7KRg9vHAAXzc8N3MuwnCDC9HeYa+Agqa90Sf45JaMyqhaw
         vXFvTSft1iXpwTmZjS7kQpM01rimOeqiI3jIw=
Received: by 10.140.125.1 with SMTP id x1mr1764864rvc.73.1233499960401; Sun, 
	01 Feb 2009 06:52:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107982>

Yesterday I was not paying attention to a repository I was in when I
used git remote to make a mirror:

$ git remote add --mirror bar git://foo/bar

I realized my mistake and removed the mirror:

$ git remote rm bar

Poof. All of my local branches and their reflogs were gone. Reproduce with:

# Setup a repository
mkdir foo && cd foo && git init
echo foo > foo && git add foo && git commit -m foo

# Make some branches for demonstration purposes
git co -b branch1
git co -b branch2
git co -b branch3
git co master
find .git/refs .git/logs
.git/refs
.git/refs/heads
.git/refs/heads/branch1
.git/refs/heads/branch2
.git/refs/heads/branch3
.git/refs/heads/master
.git/refs/tags
.git/logs
.git/logs/HEAD
.git/logs/refs
.git/logs/refs/heads
.git/logs/refs/heads/branch1
.git/logs/refs/heads/branch2
.git/logs/refs/heads/branch3
.git/logs/refs/heads/master

# Setup a remote
git remote add --mirror bar git://foo/bar

# Oops, didn't mean to do that, remove the repo
git remote rm bar # poof!
find .git/refs .git/logs
.git/refs
.git/refs/heads
.git/refs/tags
.git/logs
.git/logs/HEAD
.git/logs/refs
.git/logs/refs/heads

I just realized that at least the HEAD log is still there. I missed
that originally since:

git reflog
fatal: bad default revision 'HEAD'

(Separate issue, but shouldn't "git reflog" work even if .git/HEAD is invalid?)

Anyway, it would seem to me it should be harder to remove local refs.
This one was somewhat painful to recover from. Not sure what better
behavior would be: should it be harder to do "remote add --mirror" on
a repository with content, should "remote rm" on mirrored repository
require a --force switch with a stern warning first, or...?

Thoughts?

j.
