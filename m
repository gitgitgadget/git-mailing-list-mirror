Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1AB1F428
	for <e@80x24.org>; Sat, 30 Dec 2017 14:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbdL3OV1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 09:21:27 -0500
Received: from avasout02.plus.net ([212.159.14.17]:56514 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbdL3OV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 09:21:26 -0500
Received: from [10.0.2.15] ([80.189.70.206])
        by smtp with ESMTPA
        id VI0peW1fWUnu3VI0qeyODk; Sat, 30 Dec 2017 14:21:24 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=DY5nkrlW c=1 sm=1 tr=0
 a=BecK+r/lr4XRfISlKBaA+g==:117 a=BecK+r/lr4XRfISlKBaA+g==:17
 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8 a=MajcE8fYuQYblhCy17sA:9 a=QEXdDO2ut3YA:10
 a=Df3jFdWbhGDLdZNm0fyq:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>,
        Adam Dinwoodie <adam@dinwoodie.org>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Test failure for v2.16.0-rc0 on cygwin
Message-ID: <519ac918-6b5f-bca3-05a0-0114683b9724@ramsayjones.plus.com>
Date:   Sat, 30 Dec 2017 14:21:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfFgb9YopjQYends2YCxe0C0aZTKVEFIU2TY5+mIpUxQp0GxmUn1bADW4e1I0nJe+kyCwcfO2eN1hEzT7nu4H7ztL/ELx4km5mpHy2gmaMkAE6k+CWpfz
 oiCFQlkcnepszm23Ldf84tssQVIa5GaLmztWiAJHjRjEgurOAoz3ZrwlF/84HCq2BZPtp/qJJ/erFA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, Adam,

Just a quick note about the failure of the test-suite on cygwin.
In particular, test t5580-clone-push-unc.sh #3, like so:

  $ ./t5580-clone-push-unc.sh -i -v

  ...

  ok 2 - clone
  
  expecting success: 
  	(
  		cd clone &&
  		git checkout -b to-push &&
  		test_commit to-push &&
  		git push origin HEAD
  	) &&
  	rev="$(git -C clone rev-parse --verify refs/heads/to-push)" &&
  	test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
  
  Switched to a new branch 'to-push'
  [to-push 0adccbe] to-push
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 to-push.t
  Counting objects: 3, done.
  Delta compression using up to 4 threads.
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), 289 bytes | 289.00 KiB/s, done.
  Total 3 (delta 0), reused 0 (delta 0)
  error: remote unpack failed: unable to create temporary object directory
  To file:////localhost/C$/\cygwin64\home\ramsay\git\t\trash directory.t5580-clone-push-unc
   ! [remote rejected] HEAD -> to-push (unpacker error)
  error: failed to push some refs to 'file:////localhost/C$/\cygwin64\home\ramsay\git\t\trash directory.t5580-clone-push-unc'
  not ok 3 - push
  #	
  #		(
  #			cd clone &&
  #			git checkout -b to-push &&
  #			test_commit to-push &&
  #			git push origin HEAD
  #		) &&
  #		rev="$(git -C clone rev-parse --verify refs/heads/to-push)" &&
  #		test "$rev" = "$(git rev-parse --verify refs/heads/to-push)"
  #	
  $ 

My first, knee-jerk, reaction on seeing the backslashes in the 'local' part
of the pathname (despite what it says in commit f21d60b429) was to replace
the 'cygpath -aw .' with 'cygpath -am .'. This leads to exactly the same
error display as above, except '\\' replaced by '/' in the pathname! Hmm.

Note:

  $ ls '//localhost/C$/\cygwin64\home\ramsay\git\t\trash directory.t5580-clone-push-unc'
  clone/  initial.t
  $ ls '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc'
  clone/  initial.t
  $ ls //localhost/C$/\\cygwin64\\home\\ramsay\\git\\t\\trash\ directory.t5580-clone-push-unc
  clone/  initial.t
  $ 
 
So, after some debugging (using the 'cygpath -am .' version), it seems that
the error message is caused by the mkdtemp() call in tmp_objdir_create()
function (tmp-objdir.c:123), failing with an errno of 'permission denied'. 

At the time of the call to mkdtemp, the current working directory is given by
'//localhost/C$/cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc/.git',
and the parameter to mkdtemp is (for example) "./objects/incoming-MgZCkI".

  $ cd trash\ directory.t5580-clone-push-unc/
  $ ls
  clone/  initial.t
  $ ls .git
  branches/       config       HEAD             index  logs/     refs/
  COMMIT_EDITMSG  description  hooks-disabled/  info/  objects/
  $ ls .git/objects
  24/  93/  e7/  info/  pack/
  $ mkdir '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc/.git/./objects/incoming-MgZCkI'
  mkdir: cannot create directory ‘//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc/.git/./objects/incoming-MgZCkI’: Permission denied
    $ 

So, when 'doing it by hand', I get the same result. ;-)

Looking at the permissions:

  $ ls -ld '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc/.git/./objects'
  drwxr-xr-x+ 1 ramsay None 0 Dec 30 13:51 '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc/.git/./objects'/

  $ ls -ld '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc/.git'
  drwxr-xr-x+ 1 ramsay None 0 Dec 30 13:51 '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc/.git'/

  $ ls -ld '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc'
  drwxr-xr-x+ 1 ramsay None 0 Dec 30 13:51 '//localhost/C$//cygwin64/home/ramsay/git/t/trash directory.t5580-clone-push-unc'/

  ... and so on, until:

  $ ls -ld '//localhost/C$'
  d---r-x---+ 1 TrustedInstaller TrustedInstaller 0 Oct 28 16:16 '//localhost/C$'/
  $ 

Doing a quick web-search on '//localhost/C$' lead me to several posts which
seem to suggest the problem could be related to UAC filtering on remote
shares (and the fact that I am on Windows 10), along with a registry setting
for 'LocalAccountTokenFilterPolicy'. However, I have not had time to look
into any of that.

Adam, are you running the tests on Windows 10?

I have to go now, so I can't look at this further today. Just FYI.

ATB,
Ramsay Jones

