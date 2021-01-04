Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2DC433DB
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD0A21BE5
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 19:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbhADTzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 14:55:37 -0500
Received: from mout01.posteo.de ([185.67.36.65]:44622 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbhADTzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 14:55:37 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 04758160061
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 20:54:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1609790079; bh=oLMgFaZAwcWY+k7o3wFZLPSSPJH3W6FZ91EvGklOlzk=;
        h=From:Subject:To:Cc:Date:From;
        b=Ex8ULYK5Brp5qKd8UXW8/TKlx0wTrXBov2RAgjIebXs9j8dwtpW0q1b0wj/5QyOZu
         KSXwTXSxbHBnqnqAidtkFSZ3WWr9uaiMMjEKwzfvkLa2kpWzAzqjizgIlcdsQktCFt
         BX+P3OJ40gIWjaU4soA+LN4lGb/cTx2pZZ5ORcw9uhfIz/kBNirlbNRSCw9NIFQtHd
         4wdo0z23+U41lXaWyx7GOCB7djEjWssHNZ/eupgHaBEjX0TTZ0sjtWCatsk878ccxr
         ABjM4PfzNmZZFt034uCFqCla/HoJJYHTydX1zmkiNdE7QG/x0DIKrXSIm+H3G4J32O
         6avnXBVrzv9iQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4D8mYT6N7qz6tm9;
        Mon,  4 Jan 2021 20:54:37 +0100 (CET)
From:   Robert Pollak <robert.pollak@posteo.net>
Subject: [RFC PATCH] gitk: Activate --find-copies-harder
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Laszlo Ersek <lersek@redhat.com>, git@vger.kernel.org
Message-ID: <b12574f0-3ebc-95c0-9def-555150257e46@posteo.net>
Date:   Mon, 4 Jan 2021 20:54:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Naively forward the diff arguments to make --find-copies-harder work.

Signed-off-by: Robert Pollak <robert.pollak@posteo.net>
---
Dear Paul Mackerras,

This patch is an obviously naive attempt to make gitk observe
--find-copies-harder. I am a gitk user with many small projects, so I am
currently using this patch to get better diffs.

With this, gitk displays the copy in the second commit of my test
repository [1] as desired:

similarity index 100%
copy from a
copy to b


I see the following problems with my patch:

1) It is totally untested with all the other args that are collected in
diffargs, like e.g. "-O<orderfile>", since I didn't need them yet.

2) Even if --find-copies-harder is the only diff argument used, there
might be unintended side effects, since the modified procedure 'diffcmd'
is called in several places. I did not systematically test all these
code paths.


To deal with 1), I could rename the variable 'vdflags' to
'vdflags_ignored' and continue using 'vdflags' only for
--find-copies-harder. Later, other flags could be moved over, after
their harmlessness has been proven. Would this be good?

Ad 2), maybe someone with more code knowledge can tell whether this
a real risk? Also, would it be preferable to add the new flag(s) only to
the arguments of the diffcmd call in 'getblobdiffs'?
(as in:
diff --git a/gitk b/gitk
index 23d9dd1..da6b372 100755
--- a/gitk
+++ b/gitk
@@ -8017,7 +8017,7 @@ proc initblobdiffvars {} {
 proc getblobdiffs {ids} {
     global blobdifffd diffids env
     global treediffs
-    global diffcontext
+    global vdflags diffcontext
     global ignorespace
     global worddiff
     global limitdiffs vfilelimit curview
@@ -8031,7 +8031,7 @@ proc getblobdiffs {ids} {
     if {[package vcompare $git_version "1.6.6"] >= 0} {
         set submodule "--submodule"
     }
-    set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
+    set cmd [diffcmd $ids "$vdflags($curview) -p $textconv $submodule  -C --cc --no-commit-id -U$diffcontext"]
     if {$ignorespace} {
         append cmd " -w"
     }
)
For my test case, this also works.


I'd be happy to prepare an updated patch incorporating your feedback.

Having this functionality in gitk will hopefully make some people stop
crafting their git history for copy detection, like described e.g. in
https://devblogs.microsoft.com/oldnewthing/20190919-00/?p=102904 .

I am CCing Laszlo Ersek, because he expressed interest in a similar
topic a year ago:
'gitk feature requests: (1) "diff.orderFile" and (2) "--function-context"',
https://public-inbox.org/git/d972c1f1-c49a-f644-ab1c-6a3e26c43ee3@redhat.com/
.

-- Robert

[1] My minimal test case:
> git init
> echo "a file" > a
> git add a
> git commit -m "a file"
> cp a b
> git add b
> git commit -m "a copy"


 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 23d9dd1..eb6ba9a 100755
--- a/gitk
+++ b/gitk
@@ -7869,7 +7869,7 @@ proc addtocflist {ids} {
 }
  proc diffcmd {ids flags} {
-    global log_showroot nullid nullid2 git_version
+    global log_showroot nullid nullid2 git_version vdflags curview
      set i [lsearch -exact $ids $nullid]
     set j [lsearch -exact $ids $nullid2]
@@ -7909,7 +7909,7 @@ proc diffcmd {ids flags} {
         if {$log_showroot} {
             lappend flags --root
         }
-        set cmd [concat | git diff-tree -r $flags $ids]
+        set cmd [concat | git diff-tree -r $vdflags($curview) $flags $ids]
     }
     return $cmd
 }
-- 
2.17.1

