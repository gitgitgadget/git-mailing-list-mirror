From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] t4150 (am): futureproof against failing tests
Date: Fri, 23 Jul 2010 12:04:01 -0500
Message-ID: <20100723170401.GC2507@burratino>
References: <7vwsfb2k3u.fsf@gitster.siamese.dyndns.org>
 <1279742303-29817-1-git-send-email-ddkilzer@kilzer.net>
 <20100722075133.GA9292@burratino>
 <681325.9577.qm@web30002.mail.mud.yahoo.com>
 <20100723170103.GA2507@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Fri Jul 23 19:05:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcLgM-0006fh-NM
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 19:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724Ab0GWRFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 13:05:04 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51567 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab0GWRFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 13:05:01 -0400
Received: by qwh6 with SMTP id 6so3691089qwh.19
        for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=u1WxdXwWTvYVpog1af+/bxOKymptFfwD+J2S5lGEY6E=;
        b=VrQNwVkPNe4rG6aJ93pbR7Bur74rorUGyxDViwYffrCHngJw5sHp/XV2hFubFUnX78
         CmXUuvWHTPJVAXYjKQTHPPlJbMUKNXaVpFgGM4vyHMJ1+8AzUxKo8gUiWTcLSOoP91VI
         ImeiVRhBw4vNMut0mxLyITUL6ogiwPW6CCA80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A1EqfjiK2gLInuimP9HfWS5Mfg+172hWlCBQxqsOqnDfNUiSPBU5z932LV1lE6t7dm
         12NiayEiDCKfBIGP0kUS0rpk+i0GQPfV9i9bR5Wejgf/ZXO5IHzzUA55WzKiMWN83jZv
         CKvWZ65x65wKiovZYB+DvsCT7dzL0PnbBObJU=
Received: by 10.224.63.230 with SMTP id c38mr2787688qai.234.1279904700586;
        Fri, 23 Jul 2010 10:05:00 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e32sm461669qcg.22.2010.07.23.10.04.59
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 23 Jul 2010 10:05:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100723170103.GA2507@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151550>

Most tests in t4150 begin by navigating to a sane state and
applying some patch:

	git checkout first &&
	git am patch1

If a previous test left behind unmerged files or a .git/rebase-apply
directory, they are untouched and the test fails, causing later tests
to fail, too.  This is not a problem in practice because none of the
tests leave a mess behind.

But as a futureproofing measure, it is still best to avoid the problem
and clean up at the start of each test.  In particular, this
simplifies the process of adding new tests that are known to fail.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4150-am.sh |   48 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 47 insertions(+), 1 deletions(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index b50aad3..70b57de 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -122,6 +122,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'am applies patch correctly' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	test_tick &&
 	git am <patch1 &&
@@ -132,6 +134,8 @@ test_expect_success 'am applies patch correctly' '
 '
 
 test_expect_success 'am applies patch e-mail not in a mbox' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	git am patch1.eml &&
 	! test -d .git/rebase-apply &&
@@ -141,6 +145,8 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
 '
 
 test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	git am patch1-crlf.eml &&
 	! test -d .git/rebase-apply &&
@@ -165,6 +171,8 @@ compare () {
 
 test_expect_success 'am changes committer and keeps author' '
 	test_tick &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	git am patch2 &&
 	! test -d .git/rebase-apply &&
@@ -178,6 +186,8 @@ test_expect_success 'am changes committer and keeps author' '
 '
 
 test_expect_success 'am --signoff adds Signed-off-by: line' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout -b master2 first &&
 	git am --signoff <patch2 &&
 	printf "%s\n" "$signoff" >expected &&
@@ -198,6 +208,8 @@ test_expect_success 'am stays in branch' '
 test_expect_success 'am --signoff does not add Signed-off-by: line if already there' '
 	git format-patch --stdout HEAD^ >patch3 &&
 	sed -e "/^Subject/ s,\[PATCH,Re: Re: Re: & 1/5 v2," patch3 >patch4
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout HEAD^ &&
 	git am --signoff patch4 &&
 	git cat-file commit HEAD >actual &&
@@ -211,6 +223,8 @@ test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
 '
 
 test_expect_success 'am --keep really keeps the subject' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout HEAD^ &&
 	git am --keep patch4 &&
 	! test -d .git/rebase-apply &&
@@ -219,6 +233,8 @@ test_expect_success 'am --keep really keeps the subject' '
 '
 
 test_expect_success 'am -3 falls back to 3-way merge' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout -b lorem2 master2 &&
 	sed -n -e "3,\$p" msg >file &&
 	head -n 9 msg >>file &&
@@ -231,6 +247,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
 '
 
 test_expect_success 'am -3 -q is quiet' '
+	rm -fr .git/rebase-apply &&
 	git reset master2 --hard &&
 	sed -n -e "3,\$p" msg >file &&
 	head -n 9 msg >>file &&
@@ -242,6 +259,8 @@ test_expect_success 'am -3 -q is quiet' '
 '
 
 test_expect_success 'am pauses on conflict' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
 	test -d .git/rebase-apply
@@ -257,6 +276,8 @@ test_expect_success 'am --skip works' '
 
 test_expect_success 'am --resolved works' '
 	echo goodbye >expected &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout lorem2^^ &&
 	test_must_fail git am lorem-move.patch &&
 	test -d .git/rebase-apply &&
@@ -268,6 +289,8 @@ test_expect_success 'am --resolved works' '
 '
 
 test_expect_success 'am takes patches from a Pine mailbox' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	cat pine patch1 | git am &&
 	! test -d .git/rebase-apply &&
@@ -275,11 +298,16 @@ test_expect_success 'am takes patches from a Pine mailbox' '
 '
 
 test_expect_success 'am fails on mail without patch' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	test_must_fail git am <failmail &&
-	rm -r .git/rebase-apply/
+	git am --abort &&
+	! test -d .git/rebase-apply
 '
 
 test_expect_success 'am fails on empty patch' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	echo "---" >>failmail &&
 	test_must_fail git am <failmail &&
 	git am --skip &&
@@ -288,6 +316,8 @@ test_expect_success 'am fails on empty patch' '
 
 test_expect_success 'am works from stdin in subdirectory' '
 	rm -fr subdir &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	(
 		mkdir -p subdir &&
@@ -299,6 +329,8 @@ test_expect_success 'am works from stdin in subdirectory' '
 
 test_expect_success 'am works from file (relative path given) in subdirectory' '
 	rm -fr subdir &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	(
 		mkdir -p subdir &&
@@ -310,6 +342,8 @@ test_expect_success 'am works from file (relative path given) in subdirectory' '
 
 test_expect_success 'am works from file (absolute path given) in subdirectory' '
 	rm -fr subdir &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	P=$(pwd) &&
 	(
@@ -321,6 +355,8 @@ test_expect_success 'am works from file (absolute path given) in subdirectory' '
 '
 
 test_expect_success 'am --committer-date-is-author-date' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	test_tick &&
 	git am --committer-date-is-author-date patch1 &&
@@ -331,6 +367,8 @@ test_expect_success 'am --committer-date-is-author-date' '
 '
 
 test_expect_success 'am without --committer-date-is-author-date' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	test_tick &&
 	git am patch1 &&
@@ -345,6 +383,8 @@ test_expect_success 'am without --committer-date-is-author-date' '
 # by test_tick that uses -0700 timezone; if this feature does not
 # work, we will see that instead of +0000.
 test_expect_success 'am --ignore-date' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	test_tick &&
 	git am --ignore-date patch1 &&
@@ -355,6 +395,8 @@ test_expect_success 'am --ignore-date' '
 
 test_expect_success 'am into an unborn branch' '
 	git rev-parse first^{tree} >expected &&
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	rm -fr subdir &&
 	mkdir subdir &&
 	git format-patch --numbered-files -o subdir -1 first &&
@@ -371,6 +413,8 @@ test_expect_success 'am into an unborn branch' '
 '
 
 test_expect_success 'am newline in subject' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	test_tick &&
 	sed -e "s/second/second \\\n foo/" patch1 >patchnl &&
@@ -379,6 +423,8 @@ test_expect_success 'am newline in subject' '
 '
 
 test_expect_success 'am -q is quiet' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
 	git checkout first &&
 	test_tick &&
 	git am -q <patch1 >output.out 2>&1 &&
-- 
1.7.2.rc3
