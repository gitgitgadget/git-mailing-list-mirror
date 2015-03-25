From: Kirill Marchuk <62mkv@mail.ru>
Subject: very weird behaviour with "merge -s subtree"
Date: Wed, 25 Mar 2015 18:55:23 +0600
Message-ID: <5512B03B.9020707@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 14:01:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yakvk-000090-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 14:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbbCYNA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 09:00:58 -0400
Received: from fallback5.mail.ru ([94.100.181.253]:49023 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbCYNAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 09:00:54 -0400
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [94.100.177.90])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id 53B6A7C142AF
	for <git@vger.kernel.org>; Wed, 25 Mar 2015 15:55:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
	h=Content-Transfer-Encoding:Content-Type:Subject:To:MIME-Version:From:Date:Message-ID; bh=54zJttIkrT7EQsI/e52q5D5l8SDPhdgqI8Sr2uQilQ8=;
	b=aegFbjfBInrewSfxHEXwsWyw+bVEqnRqFCqebAaLEPWW0F725l+OLR5l0cQVPsILOY84Dh9mGMHNi41lwUKxNAZ5xSYWlHicPtD/NrGuu+ZovEzwhyAhMG9pxPc9dJHjFpCE+RM2igmDdOgo9jJldjKg0vfSjV2YTUUY5enn8vY=;
Received: from [94.230.125.199] (port=63377 helo=[192.168.0.111])
	by smtp30.i.mail.ru with esmtpa (envelope-from <62mkv@mail.ru>)
	id 1YakqB-0001mz-Td; Wed, 25 Mar 2015 15:55:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266280>

Hi everyone

  I'm totally stuck with a following problem:

- we have a repo, which contains several projects as folders - like 
"api", "adminUI", "android", "web" - etc. Some parts are backend, some 
frontend. Lets name these parts "details", as they constitute details of 
the project in general.
- we would like to deploy via git, so as to minimize effort on 
deployment (and automate it later).
- but every project is deployed separately.

 From all I've read so far, I came to conclusion that "merge -s subtree" 
seems to be done with this thing in mind, although scenarios,
described in articles like this one 
(https://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html) 
usually take only one part of it: merge from "detail" to "common", and 
not vice versa.

So, what am I trying to: to implement a stable workflow, that would 
allow me to easily merge changes from "develop" in "common" repo to a 
"subtree-branch" and push to a corresponding "detail" remote.

What I am doing:

1) say, we have a folder "adminUI" in the root of "common" repo, branch 
"test" (it's a snapshot branch for test environment - all deploys should 
start here)
2) git remote add adminui-origin <path>
3) git fetch adminui-origin
4)  git checkout -B test-adminui adminui-origin/test
(above steps are taken from 
http://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging)
5) git checkout test
6) git merge -s ours --no-commit test-adminui
(this one is from 
https://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html)
7) git read-tree --prefix=adminUI/ -u test-adminui
Here I always get error like:
error: Entry 'adminUI/.gitignore' overlaps with 'adminUI/.gitignore'.  
Cannot bind.

8) so, I have to rename folder "adminUI" to, like, "adminUI2", then "git 
commit -a", then step 7 again
9) ok, so now I have a whole content of "adminui-origin" in folder 
"/adminUI" in branch "test" of my "common" repo.
10) then I merge changes from "develop", which I want to deploy: git 
merge develop
11) then I want to merge those changes "down the line" into "detail" repo:
git checkout test-adminui
git merge -s subtree test
12) for the first time, everything seems fine - only relevant changes 
(i.e., changes in adminUI folder) are merged, and they go straight into 
their right places (i.e., with respect to folder structure difference 
between "common" and "detail")
13) git push adminui-origin test-adminui:test  - this works good
14) let's say something else was updated in develop:
git checkout test
git merge develop
git checkout test-adminui
15) AND HERE BEGINS THE HELL:
git merge -s subtree test => leads to ALL of my working directory being 
copied to a 3rd level folder somewhere in the adminUI depths !!!

This drives me TOTALLY insane, and I very much need help !!

I use msysgit 1.9.4 on Windows 8.1

I suspect that it might have to do with the repository structure, maybe 
some errors, etc..

But I believe that it might be due to my total misunderstanding of something

Anyway, I totally appreciate your help !

Thanks a lot

Kirill, frustrated unexperienced git user...
