From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/9] t7508 (status): modernize style
Date: Sat, 24 Jul 2010 19:59:42 -0500
Message-ID: <20100725005942.GF18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 03:00:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcpaF-0008GZ-Jx
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 03:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948Ab0GYBAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 21:00:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871Ab0GYBAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 21:00:45 -0400
Received: by iwn7 with SMTP id 7so1573328iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 18:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=YM/64LcI3nOcofw5Yrzw4Ajj+qZvTpf+SV4M6YACGb8=;
        b=Oe0DYgJrQm8S1wLv9QxSoQgVms5v/SyxHTCKpbIR/c8eSti9W/WjC2/T4mF5XlsqYq
         RJUk+4RVJ/DzdIYpO+ReJWSThvDTxqvOUuYatCR+A1GkRpLwUd7XcFQyH7PiW5JQgirE
         88Yc1IDA6UNl72WPAvhn6oukNBLWOju2oLCp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nKzJun1OJmM9RNT1h5vwf/ETSW+mZrS2QN/jXrWn/t5VIK7kQA43OnhhYs9F4alsja
         b8Hz4JOvGg1KBss4UVWIVoilNoJnjoPb4LMx+MS3VX+NXnnrZyPy6IYqoX32jUvnafez
         lapUmIhQy/eCx3DlUwlOEBqqG6bEneKFL/AIU=
Received: by 10.231.14.200 with SMTP id h8mr5475168iba.188.1280019645014;
        Sat, 24 Jul 2010 18:00:45 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm1916051ibe.11.2010.07.24.18.00.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 18:00:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151698>

Some cleanups to make this test script easier to read and use,
such as:

 - put setup code in test_expect_success scripts to make the
   test script easier to scan through;

 - avoid a pipe to test_decode_color that forgets the exit status of
   "git status", by redirecting to a temporary file (named "actual")
   for that function to consume instead;

 - remove precomputed object IDs;

 - reset configuration after each test, so there is less state
   for a reader to keep in mind.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7508-status.sh | 1373 ++++++++++++++++++++++++++++-------------------------
 1 files changed, 734 insertions(+), 639 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a72fe3a..882e5d7 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -8,23 +8,23 @@ test_description='git status'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	: >tracked &&
-	: >modified &&
+	>tracked &&
+	>modified &&
 	mkdir dir1 &&
-	: >dir1/tracked &&
-	: >dir1/modified &&
+	>dir1/tracked &&
+	>dir1/modified &&
 	mkdir dir2 &&
-	: >dir1/tracked &&
-	: >dir1/modified &&
+	>dir1/tracked &&
+	>dir1/modified &&
 	git add . &&
 
 	git status >output &&
 
 	test_tick &&
 	git commit -m initial &&
-	: >untracked &&
-	: >dir1/untracked &&
-	: >dir2/untracked &&
+	>untracked &&
+	>dir1/untracked &&
+	>dir2/untracked &&
 	echo 1 >dir1/modified &&
 	echo 2 >dir2/modified &&
 	echo 3 >dir2/added &&
@@ -32,564 +32,604 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'status (1)' '
-
 	grep "use \"git rm --cached <file>\.\.\.\" to unstage" output
-
 '
 
-cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
-
 test_expect_success 'status (2)' '
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
 
 	git status >output &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#	new file:   dir2/added
-#
-# Changed but not updated:
-#	modified:   dir1/modified
-#
-# Untracked files:
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
-
-git config advice.statusHints false
-
 test_expect_success 'status (advice.statusHints false)' '
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
+	git config advice.statusHints false &&
+	test_when_finished "git config --unset advice.statusHints" &&
 
 	git status >output &&
 	test_cmp expect output
-
 '
 
-git config --unset advice.statusHints
-
-cat >expect <<\EOF
- M dir1/modified
-A  dir2/added
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
-
 test_expect_success 'status -s' '
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
 
 	git status -s >output &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
-## master
- M dir1/modified
-A  dir2/added
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
-
 test_expect_success 'status -s -b' '
+	cat >expect <<-\EOF &&
+	## master
+	 M dir1/modified
+	A  dir2/added
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
 
 	git status -s -b >output &&
 	test_cmp expect output
-
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files not listed (use -u option to show untracked files)
-EOF
-test_expect_success 'status -uno' '
+test_expect_success 'set up dir3 for untracked files tests' '
 	mkdir dir3 &&
-	: >dir3/untracked1 &&
-	: >dir3/untracked2 &&
+	>dir3/untracked1 &&
+	>dir3/untracked2 &&
+
+	cat >expect <<-\EOF
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files not listed (use -u option to show untracked files)
+	EOF
+'
+
+test_expect_success 'status -uno' '
 	git status -uno >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'status (status.showUntrackedFiles no)' '
-	git config status.showuntrackedfiles no
+	git config status.showuntrackedfiles no &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#	new file:   dir2/added
-#
-# Changed but not updated:
-#	modified:   dir1/modified
-#
-# Untracked files not listed
-EOF
-git config advice.statusHints false
 test_expect_success 'status -uno (advice.statusHints false)' '
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#	modified:   dir1/modified
+	#
+	# Untracked files not listed
+	EOF
+	git config status.showuntrackedfiles no &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
+	git config advice.statusHints false &&
+	test_when_finished "git config --unset advice.statusHints" &&
 	git status -uno >output &&
 	test_cmp expect output
 '
-git config --unset advice.statusHints
 
-cat >expect << EOF
- M dir1/modified
-A  dir2/added
-EOF
+test_expect_success 'setup: status -s -uno expected output' '
+	cat >expect <<-\EOF
+	 M dir1/modified
+	A  dir2/added
+	EOF
+'
+
 test_expect_success 'status -s -uno' '
-	git config --unset status.showuntrackedfiles
+	test_might_fail git config --unset status.showuntrackedfiles &&
 	git status -s -uno >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'status -s (status.showUntrackedFiles no)' '
-	git config status.showuntrackedfiles no
+	git config status.showuntrackedfiles no &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status -s >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	dir3/
-#	expect
-#	output
-#	untracked
-EOF
+test_expect_success 'setup: status -unormal expected output' '
+	cat >expect <<-\EOF
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	dir3/
+	#	expect
+	#	output
+	#	untracked
+	EOF
+'
+
 test_expect_success 'status -unormal' '
+	git config status.showuntrackedfiles no &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status -unormal >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'status (status.showUntrackedFiles normal)' '
-	git config status.showuntrackedfiles normal
+	git config status.showuntrackedfiles normal &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
- M dir1/modified
-A  dir2/added
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? dir3/
-?? expect
-?? output
-?? untracked
-EOF
+test_expect_success 'setup: status -s -unormal expected output' '
+	cat >expect <<-\EOF
+	 M dir1/modified
+	A  dir2/added
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? dir3/
+	?? expect
+	?? output
+	?? untracked
+	EOF
+'
+
 test_expect_success 'status -s -unormal' '
-	git config --unset status.showuntrackedfiles
+	test_might_fail git config --unset status.showuntrackedfiles &&
 	git status -s -unormal >output &&
 	test_cmp expect output
 '
 
 test_expect_success 'status -s (status.showUntrackedFiles normal)' '
-	git config status.showuntrackedfiles normal
+	git config status.showuntrackedfiles normal &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status -s >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	dir3/untracked1
-#	dir3/untracked2
-#	expect
-#	output
-#	untracked
-EOF
+test_expect_success 'setup: status -uall expected output' '
+	cat >expect <<-\EOF
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	dir3/untracked1
+	#	dir3/untracked2
+	#	expect
+	#	output
+	#	untracked
+	EOF
+'
+
 test_expect_success 'status -uall' '
 	git status -uall >output &&
 	test_cmp expect output
 '
 test_expect_success 'status (status.showUntrackedFiles all)' '
-	git config status.showuntrackedfiles all
+	git config status.showuntrackedfiles all &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status >output &&
 	rm -rf dir3 &&
-	git config --unset status.showuntrackedfiles &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
- M dir1/modified
-A  dir2/added
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
+test_expect_success 'setup: status -s -uall expected output' '
+	cat >expect <<-\EOF
+	 M dir1/modified
+	A  dir2/added
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
+'
+
 test_expect_success 'status -s -uall' '
-	git config --unset status.showuntrackedfiles
+	test_might_fail git config --unset status.showuntrackedfiles &&
 	git status -s -uall >output &&
 	test_cmp expect output
 '
+
 test_expect_success 'status -s (status.showUntrackedFiles all)' '
-	git config status.showuntrackedfiles all
+	git config status.showuntrackedfiles all &&
+	test_when_finished "git config --unset status.showuntrackedfiles" &&
 	git status -s >output &&
-	rm -rf dir3 &&
-	git config --unset status.showuntrackedfiles &&
 	test_cmp expect output
 '
 
-cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   ../dir2/added
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	untracked
-#	../dir2/modified
-#	../dir2/untracked
-#	../expect
-#	../output
-#	../untracked
-EOF
+test_expect_success 'setup: done with dir3' '
+	rm -rf dir3
+'
 
 test_expect_success 'status with relative paths' '
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   ../dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	untracked
+	#	../dir2/modified
+	#	../dir2/untracked
+	#	../expect
+	#	../output
+	#	../untracked
+	EOF
 
-	(cd dir1 && git status) >output &&
+	(
+		cd dir1 &&
+		git status >../output
+	) &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
- M modified
-A  ../dir2/added
-?? untracked
-?? ../dir2/modified
-?? ../dir2/untracked
-?? ../expect
-?? ../output
-?? ../untracked
-EOF
 test_expect_success 'status -s with relative paths' '
+	cat >expect <<-\EOF &&
+	 M modified
+	A  ../dir2/added
+	?? untracked
+	?? ../dir2/modified
+	?? ../dir2/untracked
+	?? ../expect
+	?? ../output
+	?? ../untracked
+	EOF
 
-	(cd dir1 && git status -s) >output &&
+	(
+		cd dir1 &&
+		git status -s >../output
+	) &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
- M dir1/modified
-A  dir2/added
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
-
 test_expect_success 'status --porcelain ignores relative paths setting' '
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
 
-	(cd dir1 && git status --porcelain) >output &&
+	(
+		cd dir1 &&
+		git status --porcelain >../output
+	) &&
 	test_cmp expect output
-
 '
 
-test_expect_success 'setup unique colors' '
-
+test_expect_success 'setup: unique colors' '
 	git config status.color.untracked blue
-
 '
 
-cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	<GREEN>new file:   dir2/added<RESET>
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	<RED>modified:   dir1/modified<RESET>
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	<BLUE>dir1/untracked<RESET>
-#	<BLUE>dir2/modified<RESET>
-#	<BLUE>dir2/untracked<RESET>
-#	<BLUE>expect<RESET>
-#	<BLUE>output<RESET>
-#	<BLUE>untracked<RESET>
-EOF
+test_expect_success 'setup: expect colorful output' '
+	cat >expect <<-\EOF
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	<GREEN>new file:   dir2/added<RESET>
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	<RED>modified:   dir1/modified<RESET>
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	<BLUE>actual<RESET>
+	#	<BLUE>dir1/untracked<RESET>
+	#	<BLUE>dir2/modified<RESET>
+	#	<BLUE>dir2/untracked<RESET>
+	#	<BLUE>expect<RESET>
+	#	<BLUE>output<RESET>
+	#	<BLUE>untracked<RESET>
+	EOF
+'
 
 test_expect_success 'status with color.ui' '
-
 	git config color.ui always &&
-	git status | test_decode_color >output &&
+	test_when_finished "git config --unset color.ui" &&
+	git status >actual &&
+	test_decode_color <actual >output &&
 	test_cmp expect output
-
 '
 
 test_expect_success 'status with color.status' '
-
-	git config --unset color.ui &&
+	test_might_fail git config --unset color.ui &&
 	git config color.status always &&
-	git status | test_decode_color >output &&
+	test_when_finished "git config --unset color.status" &&
+	git status >actual &&
+	test_decode_color <actual >output &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
- <RED>M<RESET> dir1/modified
-<GREEN>A<RESET>  dir2/added
-<BLUE>??<RESET> dir1/untracked
-<BLUE>??<RESET> dir2/modified
-<BLUE>??<RESET> dir2/untracked
-<BLUE>??<RESET> expect
-<BLUE>??<RESET> output
-<BLUE>??<RESET> untracked
-EOF
+test_expect_success 'setup: expected colorful short output' '
+	cat >expect <<-\EOF
+	 <RED>M<RESET> dir1/modified
+	<GREEN>A<RESET>  dir2/added
+	<BLUE>??<RESET> actual
+	<BLUE>??<RESET> dir1/untracked
+	<BLUE>??<RESET> dir2/modified
+	<BLUE>??<RESET> dir2/untracked
+	<BLUE>??<RESET> expect
+	<BLUE>??<RESET> output
+	<BLUE>??<RESET> untracked
+	EOF
+'
 
 test_expect_success 'status -s with color.ui' '
-
-	git config --unset color.status &&
+	test_might_fail git config --unset color.status &&
 	git config color.ui always &&
-	git status -s | test_decode_color >output &&
+	test_when_finished "git config --unset color.ui" &&
+	git status -s >actual &&
+	test_decode_color <actual >output &&
 	test_cmp expect output
-
 '
 
 test_expect_success 'status -s with color.status' '
-
-	git config --unset color.ui &&
+	test_might_fail git config --unset color.ui &&
 	git config color.status always &&
-	git status -s | test_decode_color >output &&
+	test_when_finished "git config --unset color.status" &&
+	git status -s >actual &&
+	test_decode_color <actual >output &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
-## <GREEN>master<RESET>
- <RED>M<RESET> dir1/modified
-<GREEN>A<RESET>  dir2/added
-<BLUE>??<RESET> dir1/untracked
-<BLUE>??<RESET> dir2/modified
-<BLUE>??<RESET> dir2/untracked
-<BLUE>??<RESET> expect
-<BLUE>??<RESET> output
-<BLUE>??<RESET> untracked
-EOF
-
 test_expect_success 'status -s -b with color.status' '
+	cat >expect <<-\EOF &&
+	## <GREEN>master<RESET>
+	 <RED>M<RESET> dir1/modified
+	<GREEN>A<RESET>  dir2/added
+	<BLUE>??<RESET> actual
+	<BLUE>??<RESET> dir1/untracked
+	<BLUE>??<RESET> dir2/modified
+	<BLUE>??<RESET> dir2/untracked
+	<BLUE>??<RESET> expect
+	<BLUE>??<RESET> output
+	<BLUE>??<RESET> untracked
+	EOF
 
-	git status -s -b | test_decode_color >output &&
+	git config color.status always &&
+	test_when_finished "git config --unset color.status" &&
+	git status -s -b >actual &&
+	test_decode_color <actual >output &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
- M dir1/modified
-A  dir2/added
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
+test_expect_success 'setup: expect uncolorful status --porcelain output' '
+	cat >expect <<-\EOF
+	 M dir1/modified
+	A  dir2/added
+	?? actual
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
+'
 
 test_expect_success 'status --porcelain ignores color.ui' '
-
-	git config --unset color.status &&
+	test_might_fail git config --unset color.status &&
 	git config color.ui always &&
-	git status --porcelain | test_decode_color >output &&
+	test_when_finished "git config --unset color.ui" &&
+	git status --porcelain >actual &&
+	test_decode_color <actual >output &&
 	test_cmp expect output
-
 '
 
 test_expect_success 'status --porcelain ignores color.status' '
-
-	git config --unset color.ui &&
+	test_might_fail git config --unset color.ui &&
 	git config color.status always &&
-	git status --porcelain | test_decode_color >output &&
+	test_when_finished "git config --unset color.status" &&
+	git status --porcelain >actual &&
+	test_decode_color <actual >output &&
 	test_cmp expect output
-
 '
 
-# recover unconditionally from color tests
-git config --unset color.status
-git config --unset color.ui
+test_expect_success 'setup: recover unconditionally from color tests' '
+	test_might_fail git config --unset color.status &&
+	test_might_fail git config --unset color.ui
+'
 
 test_expect_success 'status --porcelain ignores -b' '
-
 	git status --porcelain -b >output &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
-
-
 test_expect_success 'status without relative paths' '
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
 
-	git config status.relativePaths false
-	(cd dir1 && git status) >output &&
+	git config status.relativePaths false &&
+	test_when_finished "git config --unset status.relativePaths" &&
+	(
+		cd dir1 &&
+		git status >../output
+	) &&
 	test_cmp expect output
-
 '
 
-cat >expect <<\EOF
- M dir1/modified
-A  dir2/added
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
-
 test_expect_success 'status -s without relative paths' '
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	?? actual
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
 
-	(cd dir1 && git status -s) >output &&
+	git config status.relativePaths false &&
+	test_when_finished "git config --unset status.relativePaths" &&
+	(
+		cd dir1 &&
+		git status -s >../output
+	) &&
 	test_cmp expect output
-
 '
 
-cat <<EOF >expect
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'dry-run of partial commit excluding new file in index' '
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/
+	#	expect
+	#	output
+	#	untracked
+	EOF
+
 	git commit --dry-run dir1/modified >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 M	dir1/modified
-EOF
 test_expect_success 'status refreshes the index' '
+	EMPTY_BLOB=$(git hash-object -t blob --stdin </dev/null) &&
+	ZEROES=0000000000000000000000000000000000000000 &&
+	echo ":100644 100644 $EMPTY_BLOB $ZEROES M	dir1/modified" >expect &&
+
 	touch dir2/added &&
 	git status &&
 	git diff-files >output &&
@@ -597,39 +637,42 @@ test_expect_success 'status refreshes the index' '
 '
 
 test_expect_success 'setup status submodule summary' '
-	test_create_repo sm && (
+	test_create_repo sm &&
+	(
 		cd sm &&
 		>foo &&
 		git add foo &&
 		git commit -m "Add foo"
 	) &&
-	git add sm
+	git add sm &&
+
+	cat >expect <<-\EOF
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#	new file:   sm
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#	new file:   sm
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'status submodule summary is disabled by default' '
 	git status >output &&
 	test_cmp expect output
@@ -641,17 +684,21 @@ test_expect_success 'status --untracked-files=all does not show submodule' '
 	test_cmp expect output
 '
 
-cat >expect <<EOF
- M dir1/modified
-A  dir2/added
-A  sm
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
+test_expect_success 'setup status -s submodule summary' '
+	cat >expect <<-\EOF
+	 M dir1/modified
+	A  dir2/added
+	A  sm
+	?? actual
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
+'
+
 test_expect_success 'status -s submodule summary is disabled by default' '
 	git status -s >output &&
 	test_cmp expect output
@@ -663,275 +710,323 @@ test_expect_success 'status -s --untracked-files=all does not show submodule' '
 	test_cmp expect output
 '
 
-head=$(cd sm && git rev-parse --short=7 --verify HEAD)
+test_expect_success 'setup: save head' '
+	head=$(
+		cd sm &&
+		git rev-parse --short=7 --verify HEAD
+	)
+'
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	new file:   dir2/added
-#	new file:   sm
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Submodule changes to be committed:
-#
-# * sm 0000000...$head (1):
-#   > Add foo
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'status submodule summary' '
+	cat >expect <<-EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#	new file:   sm
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Submodule changes to be committed:
+	#
+	# * sm 0000000...$head (1):
+	#   > Add foo
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
+
 	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
 	git status >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
- M dir1/modified
-A  dir2/added
-A  sm
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
 test_expect_success 'status -s submodule summary' '
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	A  dir2/added
+	A  sm
+	?? actual
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
+
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
 	git status -s >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
-EOF
 test_expect_success 'status submodule summary (clean submodule)' '
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+
 	git commit -m "commit submodule" &&
 	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
 	test_must_fail git commit --dry-run >output &&
 	test_cmp expect output &&
 	git status >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
- M dir1/modified
-?? dir1/untracked
-?? dir2/modified
-?? dir2/untracked
-?? expect
-?? output
-?? untracked
-EOF
 test_expect_success 'status -s submodule summary (clean submodule)' '
+	cat >expect <<-\EOF &&
+	 M dir1/modified
+	?? actual
+	?? dir1/untracked
+	?? dir2/modified
+	?? dir2/untracked
+	?? expect
+	?? output
+	?? untracked
+	EOF
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
 	git status -s >output &&
 	test_cmp expect output
 '
 
-cat >expect <<EOF
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD^1 <file>..." to unstage)
-#
-#	new file:   dir2/added
-#	new file:   sm
-#
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Submodule changes to be committed:
-#
-# * sm 0000000...$head (1):
-#   > Add foo
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-EOF
 test_expect_success 'commit --dry-run submodule summary (--amend)' '
+	cat >expect <<-EOF &&
+	# On branch master
+	# Changes to be committed:
+	#   (use "git reset HEAD^1 <file>..." to unstage)
+	#
+	#	new file:   dir2/added
+	#	new file:   sm
+	#
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Submodule changes to be committed:
+	#
+	# * sm 0000000...$head (1):
+	#   > Add foo
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	EOF
+
 	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
 	git commit --dry-run --amend >output &&
 	test_cmp expect output
 '
 
 test_expect_success POSIXPERM 'status succeeds in a read-only repository' '
-	(
-		chmod a-w .git &&
-		# make dir1/tracked stat-dirty
-		>dir1/tracked1 && mv -f dir1/tracked1 dir1/tracked &&
-		git status -s >output &&
-		! grep dir1/tracked output &&
-		# make sure "status" succeeded without writing index out
-		git diff-files | grep dir1/tracked
-	)
-	status=$?
-	chmod 775 .git
-	(exit $status)
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
+
+	chmod a-w .git &&
+	test_when_finished "chmod 775 .git" &&
+
+	# make dir1/tracked stat-dirty
+	>dir1/tracked1 &&
+	mv -f dir1/tracked1 dir1/tracked &&
+
+	git status -s >output &&
+	! grep dir1/tracked output &&
+
+	# make sure "status" succeeded without writing index out
+	git diff-files >output &&
+	grep dir1/tracked output
 '
 
-cat > expect << EOF
-# On branch master
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
-EOF
+test_expect_success 'setup: status --ignore-submodules' '
+	cat >expect <<-\EOF
+	# On branch master
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+'
 
 test_expect_success '--ignore-submodules=untracked suppresses submodules with untracked content' '
-	echo modified > sm/untracked &&
-	git status --ignore-submodules=untracked > output &&
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
+	echo modified >sm/untracked &&
+	git status --ignore-submodules=untracked >output &&
 	test_cmp expect output
 '
 
 test_expect_success '--ignore-submodules=dirty suppresses submodules with untracked content' '
-	git status --ignore-submodules=dirty > output &&
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
+	git status --ignore-submodules=dirty >output &&
 	test_cmp expect output
 '
 
 test_expect_success '--ignore-submodules=dirty suppresses submodules with modified content' '
-	echo modified > sm/foo &&
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
+	echo modified >sm/foo &&
 	git status --ignore-submodules=dirty > output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-# On branch master
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#   (commit or discard the untracked or modified content in submodules)
-#
-#	modified:   dir1/modified
-#	modified:   sm (modified content)
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
-EOF
-
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodules with modified content" '
-	git status --ignore-submodules=untracked > output &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#   (commit or discard the untracked or modified content in submodules)
+	#
+	#	modified:   dir1/modified
+	#	modified:   sm (modified content)
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
+	git status --ignore-submodules=untracked >output &&
 	test_cmp expect output
 '
 
-head2=$(cd sm && git commit -q -m "2nd commit" foo && git rev-parse --short=7 --verify HEAD)
-
-cat > expect << EOF
-# On branch master
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#	modified:   sm (new commits)
-#
-# Submodules changed but not updated:
-#
-# * sm $head...$head2 (1):
-#   > 2nd commit
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
-EOF
+test_expect_success 'setup' '
+	head2=$(
+		cd sm &&
+		git commit -q -m "2nd commit" foo &&
+		git rev-parse --short=7 --verify HEAD
+	) &&
+	cat >expect <<-EOF
+	# On branch master
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#	modified:   sm (new commits)
+	#
+	# Submodules changed but not updated:
+	#
+	# * sm $head...$head2 (1):
+	#   > 2nd commit
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+'
 
 test_expect_success "--ignore-submodules=untracked doesn't suppress submodule summary" '
-	git status --ignore-submodules=untracked > output &&
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
+	git status --ignore-submodules=untracked >output &&
 	test_cmp expect output
 '
 
 test_expect_success "--ignore-submodules=dirty doesn't suppress submodule summary" '
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
 	git status --ignore-submodules=dirty > output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-# On branch master
-# Changed but not updated:
-#   (use "git add <file>..." to update what will be committed)
-#   (use "git checkout -- <file>..." to discard changes in working directory)
-#
-#	modified:   dir1/modified
-#
-# Untracked files:
-#   (use "git add <file>..." to include in what will be committed)
-#
-#	dir1/untracked
-#	dir2/modified
-#	dir2/untracked
-#	expect
-#	output
-#	untracked
-no changes added to commit (use "git add" and/or "git commit -a")
-EOF
-
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
-	git status --ignore-submodules=all > output &&
+	cat >expect <<-\EOF &&
+	# On branch master
+	# Changed but not updated:
+	#   (use "git add <file>..." to update what will be committed)
+	#   (use "git checkout -- <file>..." to discard changes in working directory)
+	#
+	#	modified:   dir1/modified
+	#
+	# Untracked files:
+	#   (use "git add <file>..." to include in what will be committed)
+	#
+	#	actual
+	#	dir1/untracked
+	#	dir2/modified
+	#	dir2/untracked
+	#	expect
+	#	output
+	#	untracked
+	no changes added to commit (use "git add" and/or "git commit -a")
+	EOF
+	git config status.submodulesummary 10 &&
+	test_when_finished "git config --unset status.submodulesummary" &&
+	git status --ignore-submodules=all >output &&
 	test_cmp expect output
 '
 
-- 
1.7.2.9.ge3789.dirty
