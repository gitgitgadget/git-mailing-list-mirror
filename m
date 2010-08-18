From: Will Palmer <wmpalmer@gmail.com>
Subject: [BUG?] Fresh clone of jquery.git shows modifications?
Date: Wed, 18 Aug 2010 13:40:26 +0100
Message-ID: <1282135226.24584.92.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 14:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olhwe-0001s3-KU
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 14:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151Ab0HRMke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 08:40:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:41480 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0HRMkc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 08:40:32 -0400
Received: by wwi17 with SMTP id 17so781007wwi.1
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=+rKCdYACYW5905cW7d5hFLHLakewi9jcnDQxYxKNVbE=;
        b=PVHoVmxL9b9wvfsEwqEASsCeT6JoCfG5QDoivbqObE7thMc7aC4UMlGM4sZJQZrOXM
         2NbJb0BXc9JlsCTV37aF5lI1JXXTfon+1ybuMDjz2A+J5k47WzqHm1NpYh2kzit+gnho
         Wf5MmzUoL/66zuI+G0tdrn4UehdwFy96CG7mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=A+mZN3j+lCN78TXdm50isCbxNDAJQYPJMRGEAQD9qntJnreKGRF3btsJMnhYRg/32P
         dr3zOqd3HfruOF0dMaRreNlHf1aemavL7LkfKIVgWLhPoLJFxNoisU+xOJCa1tsV7gP6
         lMZ0QhDFXkUyfru1dBC2rWPTsqugH006dlD9w=
Received: by 10.227.37.8 with SMTP id v8mr6877612wbd.37.1282135230695;
        Wed, 18 Aug 2010 05:40:30 -0700 (PDT)
Received: from [192.168.2.64] ([193.164.118.24])
        by mx.google.com with ESMTPS id w1sm155686weq.25.2010.08.18.05.40.28
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 05:40:29 -0700 (PDT)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153832>

I am on Linux, and core.autocrlf is not set. .gitattributes in the
JQuery repository contains:
* crlf=input

Bisect reveals:
fd6cce9e89ab5ac1125a3b5f5611048ad22379e7  v1.7.0-3-gfd6cce9
Add per-repository eol normalization

is the first git commit which shows this problem.

I am confused as to why I am seeing what I am seeing, though. I was
under the impression that "crlf=input" meant: "convert crlf to lf on
input", which I would take to mean that it would never have any effect
whatsoever on "git status"'s output.

If I clone using a version of git before v1.7.0-3-gfd6cce9, then "git
status" from a newer git, then everything also appears to work normally
(though I haven't dug much into this aspect)

Is there a git option for "just give me what's in the repository, don't
ever perform any conversions, one way or the other, just act sane" ?

I thought I had finally understood all this autocrlf nonsense, but once
again I see this as being only an "act stupid mode". I have no idea
what's going on here, and I just want to be able to rely on the
following:
 - git clone someproj.git && cd someproj && git status;
   should NEVER report changes
 - git reset --hard HEAD && git status;
   should NEVER report changes

and, why I ran into this situation this time around:
 - git clone someproj.git && cd someproj && git checkout sometag;
   should ALWAYS work

Can anyone explain why these aren't valid assertions? If they're not,
then what is the proper way to tell git "give me a real pristine copy"?

Below is a log of the problem in-action.

[shruggar@shruggar jquery]$ git --version
git version 1.7.2.1.224.g2f41ea
[shruggar@shruggar jquery]$ uname -a
Linux shruggar 2.6.32-24-generic #39-Ubuntu SMP Wed Jul 28 05:14:15 UTC
2010 x86_64 GNU/Linux
[shruggar@shruggar extra]$ git clone git://github.com/jquery/jquery.git 
Cloning into jquery...
remote: Counting objects: 12750, done.
remote: Compressing objects: 100% (3921/3921), done.
remote: Total 12750 (delta 8690), reused 12276 (delta 8312)
Receiving objects: 100% (12750/12750), 8.95 MiB | 775 KiB/s, done.
Resolving deltas: 100% (8690/8690), done.
[shruggar@shruggar extra]$ cd jquery/
[shruggar@shruggar jquery]$ git st
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#	modified:   build/google-compiler-20091218.jar
#	modified:   build/js.jar
#	modified:   speed/jquery-basis.js
#	modified:   test/data/text.php
#	modified:   test/delegatetest.html
#
no changes added to commit (use "git add" and/or "git commit -a")
[shruggar@shruggar jquery]$ git reset --hard HEAD
HEAD is now at 6f031c1 Replace usage of the removed global reset()
method with QUnit.reset().
[shruggar@shruggar jquery]$ git st
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
directory)
#
#	modified:   build/google-compiler-20091218.jar
#	modified:   build/js.jar
#	modified:   speed/jquery-basis.js
#	modified:   test/data/text.php
#	modified:   test/delegatetest.html
#
no changes added to commit (use "git add" and/or "git commit -a")
[shruggar@shruggar jquery]$ GIT_EDITOR=cat git config --edit
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = git://github.com/jquery/jquery.git
[branch "master"]
	remote = origin
	merge = refs/heads/master
[shruggar@shruggar jquery]$
