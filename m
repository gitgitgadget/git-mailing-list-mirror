From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] rebase: improve error message when upstream argument is
 missing
Date: Mon, 31 May 2010 17:51:32 -0500
Message-ID: <20100531225132.GA6066@progeny.tock>
References: <20100531213525.GA3826@tchicaya.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>
To: Jon Dowland <jmtd@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 00:52:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJDq3-0004HX-PI
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 00:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827Ab0EaWwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 18:52:03 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:47452 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab0EaWwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 18:52:00 -0400
Received: by gwaa12 with SMTP id a12so3078270gwa.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 15:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=lNfy2yyDuS99m29rF9ill4nLMQp3IxRZWohL3fhXcLE=;
        b=XH4VICea9IKH3mCQqV/4ED7EQ1diIHQtorQIxXYEXB1frG0KBAWr/RcsgoR/XpC3PB
         hRn9h5epUh9+Db0DInW4ZN4cenN0bCJHV6R1iAJ0X8/HEni1Llzg3MYVmwqZG8Q03jZk
         RQiqbO8pk3COscFkNfAF0oWtW0HDzpzS8sCso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VWv9XHr6KHmRFp+VGBno/Hsz2c/hu2xku7er+Og4cjy1UDhzxgPem59RRaQOZ5S+Wk
         gF0MMrlZT9f91fSBxGm/koV9i0Plq2wkGojaUr5vsv1XdgpRvQ+K0GaxUezicNFIGUqK
         WxNPvtVGjXb0t5KlRZEnh/7dupTP2nn8eGz8o=
Received: by 10.231.184.1 with SMTP id ci1mr6629942ibb.39.1275346299617;
        Mon, 31 May 2010 15:51:39 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm28321752ibl.16.2010.05.31.15.51.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 15:51:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100531213525.GA3826@tchicaya.lan>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148057>

Strip out options before checking for a missing upstream argument.
Before:

 $ git rebase -m
 shift: 426: can't shift that many

After:

 $ git rebase -m
 Usage: git rebase ...

While at it, fix the usage message to explain that the upstream
argument is mandatory.

Reported-by: Jon Dowland <jmtd@debian.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jon Dowland wrote:

> jon@tchicaya:~/wd/web/crm114-spamd$ git rebase --onto origin/master
> shift: 426: can't shift that many

How about this patch?

 git-rebase.sh     |   17 ++++++++---------
 t/t3400-rebase.sh |   13 ++++++++++++-
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 44f5c65..ab4afa7 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
+USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--onto <newbase>] (<upstream>|--root) [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -198,14 +198,6 @@ test -f "$GIT_DIR"/rebase-apply/applying &&
 
 is_interactive "$@" && exec git-rebase--interactive "$@"
 
-if test $# -eq 0
-then
-	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
-	test -d "$dotest" -o -f "$GIT_DIR"/rebase-apply/rebasing &&
-		die 'A rebase is in progress, try --continue, --skip or --abort.'
-	die "No arguments given and $GIT_DIR/rebase-apply already exists."
-fi
-
 while test $# != 0
 do
 	case "$1" in
@@ -370,6 +362,13 @@ do
 done
 test $# -gt 2 && usage
 
+if test $# -eq 0 && test -z "$rebase_root"
+then
+	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
+	test -d "$dotest" -o -f "$GIT_DIR"/rebase-apply/rebasing &&
+		die 'A rebase is in progress, try --continue, --skip or --abort.'
+fi
+
 # Make sure we do not have $GIT_DIR/rebase-apply
 if test -z "$do_merge"
 then
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index dbf7dfb..e5691bc 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -126,9 +126,20 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
      test_must_fail git rebase topic 2> output.err > output.out &&
      grep "Untracked working tree file .B. would be overwritten" output.err
 '
+rm -f B
+
+test_expect_success 'dump usage when upstream arg is missing' '
+     git checkout -b usage topic &&
+     test_must_fail git rebase 2>error1 &&
+     grep "[Uu]sage" error1 &&
+     test_must_fail git rebase --abort 2>error2 &&
+     grep "No rebase in progress" error2 &&
+     test_must_fail git rebase --onto master 2>error3 &&
+     grep "[Uu]sage" error3 &&
+     ! grep "can.t shift" error3
+'
 
 test_expect_success 'rebase -q is quiet' '
-     rm B &&
      git checkout -b quiet topic &&
      git rebase -q master > output.out 2>&1 &&
      test ! -s output.out
-- 
1.7.1.349.g784ce.dirty
