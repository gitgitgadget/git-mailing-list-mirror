From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] More test cases for sanitized path names
Date: Fri, 1 Feb 2008 10:10:40 +0100
Message-ID: <200802011010.41938.robin.rosenberg.lists@dewire.com>
References: <47975FE6.4050709@viscovery.net> <200802010534.55925.robin.rosenberg.lists@dewire.com> <7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:11:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKrvc-00013I-Sg
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 10:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbYBAJKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 04:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbYBAJKf
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 04:10:35 -0500
Received: from [83.140.172.130] ([83.140.172.130]:10669 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752162AbYBAJKc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 04:10:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 3FA831475CE1;
	Fri,  1 Feb 2008 10:10:30 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bKzppdwk+76J; Fri,  1 Feb 2008 10:10:29 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 5152580266C;
	Fri,  1 Feb 2008 10:10:29 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72159>

fredagen den 1 februari 2008 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > +test_expect_failure 'add a directory outside the work tree' '
> > +	d1="$(cd .. ; pwd)" &&
> > +	git add "$d1"
> > +	echo $?
> > +'
Oops. Remove the echo $?. It still fails, i.e. git add succeeds when
it shouldn't. I was double checking it just before sending the patch.

> > +test_expect_failure 'add a file outside the work tree, nasty case 1' '(
> > +	f="$(pwd)x" &&
> > +	touch "$f" &&
> > +	git add "$f"
> > +)'
> 
> You are in the directory "t/trash", and try to add t/trashx, so
> this should fail and you would want to make sure it fails.
> 
> But this has a few problems:
> 
>  * First, the obvious one.  You are creating a garbage file
>    outside of t/trash directory.  Don't.  If you need to, dig a
>    test directory one level lower inside t/trash and play around
>    there.
Can we move the default trash one level down for all tests? That
would give us one free level to play with.

>  * In general you should stay away from test_expect_failure.  If
I respect that.
[...]
> I'd like to make the _first_ patch after 1.5.4 to be a fix-up
> for tests that misuse test_expect_failure.  After that, we can
> use test_expect_failure to mark tests that ought to pass but
> don't because of bugs in the commands.  That way, people who are
> absolutely bored can grep for test_expect_failure to see what
> existing issues to tackle ;-).

If I recall things properly there are lots of test that test for success
rather than checking that the command does what it should.

Update follows.

-- robin

>From 11a52821ca81096987f53c29bf1b9ce373fe7fd4 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Fri, 1 Feb 2008 05:29:38 +0100
Subject: [PATCH] More test cases for sanitized path names

Verify a few more commands and pathname variants.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 t/t7010-setup.sh |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/t/t7010-setup.sh b/t/t7010-setup.sh
index da20ba5..ef30099 100755
--- a/t/t7010-setup.sh
+++ b/t/t7010-setup.sh
@@ -4,6 +4,10 @@ test_description='setup taking and sanitizing funny paths'
 
 . ./test-lib.sh
 
+rm -rf .git
+test_create_repo repo
+cd repo
+
 test_expect_success setup '
 
 	mkdir -p a/b/c a/e &&
@@ -114,4 +118,42 @@ test_expect_success 'git ls-files (relative #3)' '
 
 '
 
+test_expect_success 'commit using absolute path names' '
+	git commit -m "foo" &&
+	echo aa >>a/b/c/d &&
+	git commit -m "aa" "$(pwd)/a/b/c/d"
+'
+
+test_expect_success 'log using absolute path names' '
+	echo bb >>a/b/c/d &&
+	git commit -m "bb" $(pwd)/a/b/c/d &&
+
+	git log a/b/c/d >f1.txt &&
+	git log "$(pwd)/a/b/c/d" >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_success 'blame using absolute path names' '
+	git blame a/b/c/d >f1.txt &&
+	git blame "$(pwd)/a/b/c/d" >f2.txt &&
+	diff -u f1.txt f2.txt
+'
+
+test_expect_success 'add a directory outside the work tree' '
+	d1="$(cd .. ; pwd)" &&
+	! git add "$d1"
+'
+
+test_expect_success 'add a file outside the work tree, nasty case 1' '(
+	f="$(pwd)x" &&
+	touch "$f" &&
+	! git add "$f"
+)'
+
+test_expect_success 'add a file outside the work tree, nasty case 2' '(
+	f="$(pwd|sed "s/.$//")x" &&
+	touch "$f" &&
+	! git add "$f"
+)'
+
 test_done
-- 
1.5.4.rc4.25.g81cc
