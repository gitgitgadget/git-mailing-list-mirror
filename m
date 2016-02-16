From: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
Subject: Re: [PULL] svn pathnameencoding for git svn dcommit
Date: Wed, 17 Feb 2016 01:19:11 +0900
Message-ID: <56C34BFF.3030301@f2.dion.ne.jp>
References: <56B8B1EA.5020901@f2.dion.ne.jp>
 <20160208225806.GA3487@dcvr.yhbt.net> <20160215005210.GA31141@dcvr.yhbt.net>
 <56C297A9.2080705@f2.dion.ne.jp> <20160216063357.GA17455@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040805020601060802030702"
Cc: git@vger.kernel.org, alex.crezoff@gmail.com
To: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 17:19:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aViLe-0001bJ-F1
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 17:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbcBPQTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 11:19:31 -0500
Received: from mail-ae1-f9.auone-net.jp ([106.187.231.9]:50441 "EHLO
	dmta03.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751929AbcBPQTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 11:19:30 -0500
Received: from amlmta048.auone-net.jp (amlmta048-MM [10.188.23.63])
	by dmta03.auone-net.jp (au one net mail) with ESMTP id 0D004DA03F4
	for <git@vger.kernel.org>; Wed, 17 Feb 2016 01:19:28 +0900 (JST)
Received: from [0.0.0.0] ([193.90.12.90])
	by amlmta048.auone-net.jp id 56c34c0a0008578200006fcb00001e752000086fb4a7;
	Wed, 17 Feb 2016 01:19:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160216063357.GA17455@dcvr.yhbt.net>
X-MXM-DELIVERY-TYPE: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286406>

This is a multi-part message in MIME format.
--------------040805020601060802030702
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 2016/02/16 15:33 +0900, Eric Wong wrote:
> Kazutoshi Satoda <k_satoda@f2.dion.ne.jp> wrote:
>> Thank you for the tests. But, on my environment, both of them failed
>> unexpectedly. (Windows 7 SP1, x86_64 Cygwin, LANG=ja_JP.UTF-8)
...
>> > Untracked files:
>> >         svnrepo/
>> >         "\357\202\201\357\202\202"
>> >         "\357\202\201\357\202\207"
...
>> I can't see how "\357\202\201\357\202\202" came as output in the test.
> 
> I wonder if it's a shell or printf portability problem.  I've
> repushed the branch against master and implemented the weird
> character use inside Perl scripts.
> 
> Can you give it a try?

(Shouldn't the branch be based on maint, as these are bugfixes?)

Thank you. I tried it but got similar problem:
> $ ./t9115-git-svn-dcommit-funky-renames.sh -x --run='11-12'
(snip)
> expecting success:
>         git config svn.pathnameencoding cp932 &&
>         "$PERL_PATH" -w "$TEST_DIRECTORY"/t9115/neq.perl &&
>         git commit -m "neq" &&
>         git svn dcommit
>
> ++ git config svn.pathnameencoding cp932
> ++ /usr/bin/perl -w /home/k_satoda/project/git/t/t9115/neq.perl
> ++ git commit -m neq
> On branch master
>
> Initial commit
>
> Untracked files:
>         svnrepo/
>         "\357\202\201\357\202\202"
>
> nothing added to commit but untracked files present
> error: last command exited with $?=1
> not ok 11 - svn.pathnameencoding=cp932 new file on dcommit
> #
> #               git config svn.pathnameencoding cp932 &&
> #               "$PERL_PATH" -w "$TEST_DIRECTORY"/t9115/neq.perl &&
> #               git commit -m "neq" &&
> #               git svn dcommit
> #
>
> expecting success:
>         "$PERL_PATH" -w "$TEST_DIRECTORY"/t9115/inf.perl
>
> ++ /usr/bin/perl -w /home/k_satoda/project/git/t/t9115/inf.perl
> On branch master
>
> Initial commit
>
> Untracked files:
>         svnrepo/
>         "\357\202\201\357\202\202"
>         "\357\202\201\357\202\207"
>
> nothing added to commit but untracked files present
> git commit -m inf: 256 at /home/k_satoda/project/git/t/t9115/inf.perl line 5.
> error: last command exited with $?=1
> not ok 12 - svn.pathnameencoding=cp932 rename on dcommit
> #
> #               "$PERL_PATH" -w "$TEST_DIRECTORY"/t9115/inf.perl
> #


I found how "\357\202\201\357\202\202" (U+F081 U+F082 in UTF-8) could
come.
https://cygwin.com/cygwin-ug-net/using-specialnames.html#pathnames-specialchars
> Some characters are disallowed in filenames on Windows filesystems. ...
...
> ... All of the above characters, except for the backslash, are converted
> to special UNICODE characters in the range 0xf000 to 0xf0ff (the
> "Private use area") when creating or accessing files.
"U+F081 U+F082" seems the result of conversion from "0x8182" (neq in
cp932) as treating each of 2 bytes as disallowed characters.

And I also noticed that LANG and LC_ALL is set to "C" in test-lib.sh.

Setting LC_ALL=C.UTF-8 in the test 11-12 made them pass on Cygwin.
Same change made the previous version also pass. Please find the patch
in the attached output of git format-patch.

Could you please test with this on non-Cygwin environment?

If it made no harm, please tell me what should I do to proceed this patch.
Will you (Eric) please make further integration? Shall I make another
series (v2) of patches?

-- 
k_satoda

--------------040805020601060802030702
Content-Type: text/plain; charset=UTF-8;
 name="0001-Add-LC_ALL-C.UTF-8-in-t9115-git-svn-dcommit-funky-re.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Add-LC_ALL-C.UTF-8-in-t9115-git-svn-dcommit-funky-re.pa";
 filename*1="tch"

>From 7b827f2d65aaa859030ba5b08055020f2bda1f0f Mon Sep 17 00:00:00 2001
From: Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>
Date: Wed, 17 Feb 2016 00:29:24 +0900
Subject: [PATCH] Add LC_ALL=C.UTF-8 in t9115-git-svn-dcommit-funky-renames.sh

This makes the test 11-12 pass on Cygwin.
---
 t/t9115-git-svn-dcommit-funky-renames.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
index 9828f05..59d086b 100755
--- a/t/t9115-git-svn-dcommit-funky-renames.sh
+++ b/t/t9115-git-svn-dcommit-funky-renames.sh
@@ -84,7 +84,16 @@ test_expect_success 'git svn rebase works inside a fresh-cloned repository' '
 		test -e test-rebase
 	)'
 
+# Without this, LC_ALL=C as set in test-lib.sh, and Cygwin converts
+# non-ASCII characters in filenames unexpectedly, and causes errors.
+# https://cygwin.com/cygwin-ug-net/using-specialnames.html#pathnames-specialchars
+# > Some characters are disallowed in filenames on Windows filesystems. ...
+# ...
+# > ... All of the above characters, except for the backslash, are converted
+# > to special UNICODE characters in the range 0xf000 to 0xf0ff (the
+# > "Private use area") when creating or accessing files.
 test_expect_success 'svn.pathnameencoding=cp932 new file on dcommit' '
+	export LC_ALL=C.UTF-8 &&
 	neq=$(printf "\201\202") &&
 	git config svn.pathnameencoding cp932 &&
 	echo neq >"$neq" &&
@@ -93,7 +102,9 @@ test_expect_success 'svn.pathnameencoding=cp932 new file on dcommit' '
 	git svn dcommit
 '
 
+# See the comment on the above test for setting of LC_ALL.
 test_expect_success 'svn.pathnameencoding=cp932 rename on dcommit' '
+	export LC_ALL=C.UTF-8 &&
 	inf=$(printf "\201\207") &&
 	git config svn.pathnameencoding cp932 &&
 	echo inf >"$inf" &&
-- 
2.7.0


--------------040805020601060802030702--
