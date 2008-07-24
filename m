From: "marc zonzon" <marc.zonzon@gmail.com>
Subject: BUG: fetch incorrect interpretation of globing patterns in refspecs
Date: Thu, 24 Jul 2008 09:07:21 +0200
Message-ID: <71295b5a0807240007k246973abj1897895d0d67bb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 09:08:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLuw4-0002Lv-El
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 09:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbYGXHHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 03:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbYGXHHY
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 03:07:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:1896 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYGXHHX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 03:07:23 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1020922nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 00:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=7GLnup86OcZNV0W5yUFZM9NFFDK0Er2jWwofTc7ZML8=;
        b=uMdYNIl5dOEUPa5ZetActhmiCMnbwlyYrNGta7m+5e11DKYtgWFRtVqEO9tLDjh2Sz
         sPrLBJoCqEGZ1o419BV1Z6JJUMJMWfKIOE8s15mJYVlp9zZP1F506P/eFIYkNNN1jSoK
         fKTQuqeGJ4FlsuYLONGPOFfJcsMhWRrxy+Ey8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=clu7dLsOcqtMHCYxNIfTXLt6SZlfh3Qn8FWryOnrP1X0sOC7gH4i6Z3yojzakKKHlq
         FZGAUMsSn21ts0g/rASgmTII+9QJ+dl1tLjbp/BH0/MzLruLJNegFhKRw3UvOl05GP0A
         gMORi9JS4jsh2zR+hvQUg6r432+x0d1p2zaTU=
Received: by 10.210.56.10 with SMTP id e10mr901006eba.20.1216883241351;
        Thu, 24 Jul 2008 00:07:21 -0700 (PDT)
Received: by 10.210.24.1 with HTTP; Thu, 24 Jul 2008 00:07:21 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89842>

Helo

I have a repository repo1 with four branches b_first, b_second,
b/third,  b/fourth.
In a repository repo2 I put a remote config with: fetch =
+refs/heads/b/*:refs/remotes/b/* and I expect a fetch to apply to both
b/third and  b/fourth.
But fetch will also catch b_first and b_second even if they don't
match the globing pattern.

I give the full script to reproduce the bug.

Marc

---------------------------------------------------------------------------------
Script started on Thu 24 Jul 2008 08:23:26 AM CEST
$ mkdir repo1
$ cd repo1
$ git init
Initialized empty Git repository in /shared/home/marc/gits/testbed/repo1/.git/
$ echo "master branch" > README
$ git add README
$ git commit README -m'initial commit in master'
Created initial commit 9ebc74c: initial commit in master
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 README
$ git checkout -b  b_first
Switched to a new branch "b_first"
$ echo "branch b_first" >| README
$ git add README
$ git commit README -m'commit in b_first'
Created commit 40d985a: commit in b_first
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git checkout -b b_second
Switched to a new branch "b_second"
$ echo "branch b_second" >| README
$ git add README
$ git commit README -m'commit in b_second'
Created commit 661fe61: commit in b_second
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git checkout -b b/third master
Switched to a new branch "b/third"
$  echo "branch b/third" >| README
$ git add README
$ git commit README -m'commit in b/third'
Created commit 4f02216: commit in b/third
 1 files changed, 1 insertions(+), 1 deletions(-)
$ git checkout -b b/fourth  master
Switched to a new branch "b/fourth"
$ echo "branch b/fourth" >| README
$ git add README
$ git commit README -m'commit in b/fourth'
Created commit 068f9da: commit in b/fourth
 1 files changed, 1 insertions(+), 1 deletions(-)
$ cd ..
$ mkdir repo2
$ cd repo2
$ git init
Initialized empty Git repository in /shared/home/marc/gits/testbed/repo2/.git/
$ git config --add remote.repo1.url ../repo1
$ git config --add remote.repo1.fetch '+refs/heads/b/*:refs/remotes/b/*'
$ git fetch -v repo1
warning: no common commits
remote: Counting objects: 15, done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 15 (delta 2), reused 0 (delta 0)
Unpacking objects: 100% (15/15), done.
From ../repo1
 * [new branch]      b/fourth   -> b/fourth
 * [new branch]      b/third    -> b/third
 * [new branch]      b_first    -> b_first
 * [new branch]      b_second   -> b_second
