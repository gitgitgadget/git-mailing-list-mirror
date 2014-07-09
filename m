From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 09 Jul 2014 08:14:58 +0200
Message-ID: <53BCDDE2.1080301@web.de>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de> <xmqqsimddrq3.fsf@gitster.dls.corp.google.com> <53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 08:15:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4lAb-0003ny-UD
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 08:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaGIGPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 02:15:53 -0400
Received: from mout.web.de ([212.227.17.12]:56693 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbaGIGPx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 02:15:53 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LeLSr-1WFCrx1o45-00qEqx; Wed, 09 Jul 2014 08:15:48
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53BC47BD.1000705@web.de>
X-Provags-ID: V03:K0:PfT4S33DYYsOB1LmLXC3MuzT7a45JwV29MPy3t+QWjsmIwvTQhs
 sjAxijIgUhKEGBvFnp0oyUBJRmacADCU/Eau+c8ogipDLqH33KYiRsebbOUZllYqWPapiUJ
 essEsharKSIuIbzODuugsDV8vK94Yr3T54nZb5II4WVhCaDhd+vjpENi4Kv2RWXeI5pmDSM
 94Q5zZub6snlf/nES3NDw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253068>


>> There seems to be some other trouble under Mac OS, not yet fully tracked down,
>> (may be related to the "diff -r")
> Torsten sees failures of this kind under Mac OS:
>
> diff -r .git/modules/sub1/config sub1/.git/config
> 6d5
> <     worktree = ../../../sub1
> 8a8
>>      worktree = ../../../sub1
> So the config contains the same content, but the worktree setting moved
> to a different line. This seems to be the result of setting core.worktree
> in the test_git_directory_is_unchanged function just before the "diff -r",
> but only under Mac OS.
>
So I was suspecting diff -r beinng non-portable, but that doesn't seem 
to be the problem here.
(But I wouldn't be surprised if there where problems with diff -r on 
some Unix systems)
Anyway, checking all the files in the working tree seems to be a good 
thing to do,
but that does not necessarily work for .git/config.
A "brute force" approach could be to simply run the config file(s) 
through sort and compare them:

sort <.git/modules/sub1/config >expect &&
sort <sub1/.git/config >actual &&
test_cmp expect actual &&
rm expect actual &&
cp git/modules/sub1/config sub1/.git/config


[end of scriptlet]
And here the "dumps" of the 2 config files:
.......
Branch remove_sub1 set up to track remote branch remove_sub1 from origin.
warning: unable to rmdir sub1: Directory not empty
Updating 68c8810..81b9f6a
Fast-forward
  .gitmodules | 4 ----
  1 file changed, 4 deletions(-)
  delete mode 100644 .gitmodules
---------------------
[core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true
         worktree = ../../../sub1
         ignorecase = true
         precomposeunicode = true
[remote "origin"]
         url = /Users/tb/projects/git/tb.140704_JensLehman/t/trash 
directory.t7613-merge-submodule/submodule_update_repo/.
         fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
         remote = origin
         merge = refs/heads/master
----------------
[core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true
         ignorecase = true
         precomposeunicode = true
         worktree = ../../../sub1
[remote "origin"]
         url = /Users/tb/projects/git/tb.140704_JensLehman/t/trash 
directory.t7613-merge-submodule/submodule_update_repo/.
         fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
         remote = origin
         merge = refs/heads/master
=====================
diff -r .git/modules/sub1/config sub1/.git/config
6d5
<       worktree = ../../../sub1
8a8
 >       worktree = ../../../sub1
not ok 7 - git merge: removed submodule leaves submodule containing a 
.git directory alone
