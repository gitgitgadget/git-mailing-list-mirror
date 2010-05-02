From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] test-lib: Let tests specify commands to be run at end
 of test
Date: Sun, 2 May 2010 03:53:41 -0500
Message-ID: <20100502085341.GA1767@progeny.tock>
References: <20100502084827.GA1690@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 02 10:53:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8Uvx-0001S3-L2
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 10:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab0EBIxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 04:53:48 -0400
Received: from mail-iw0-f182.google.com ([209.85.223.182]:35238 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755911Ab0EBIxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 04:53:46 -0400
Received: by iwn12 with SMTP id 12so2016651iwn.15
        for <git@vger.kernel.org>; Sun, 02 May 2010 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dWohxDH4bZawrix5d1WiSzWO1sgGXWT875ZeikWU6no=;
        b=AY1RMA64wUMePeQcIvZ3mhqb44pJhWRRxHZuoGw0kZRM2Hp6rmyGcR6RY/1vNC2RGs
         y/+8pogMOYL+FBB2y8lohM/UpdFn26JqJB6vr9fybm0OuhAsCCeMSWvEKueruhLwDiJh
         qSb6WoZZ4jMlx/OEmw6vcH+XCn1b587WXbcvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Crz+E20VCqQOjprEyyz7+4fkpKOpch108CQib4at67YsrQ5EkFmbSQjvHWbpnqg2y7
         y/++f5O4RB7CmVupSAsd3mSdW3/ypK6DCWghfsZ3P1Y75lnHjPK2QgsWmWiFrtYEeCAZ
         y3oIUVm4zvi7aHxcLjgv31jHcrXXjGRxbI0+M=
Received: by 10.231.159.134 with SMTP id j6mr1046943ibx.29.1272790425930;
        Sun, 02 May 2010 01:53:45 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3309519iwn.6.2010.05.02.01.53.44
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 01:53:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100502084827.GA1690@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146145>

Certain actions can imply that if the test fails early, recovery from
within other tests is too much to expect:

 - creating unwritable directories, like the EACCESS test in t0001-init
 - setting unusual configuration, like user.signingkey in t7004-tag
 - crashing and leaving the index lock held, like t3600-rm once did

Some test scripts work around this by running cleanup actions outside
the supervision of the test harness, with the unfortunate consequence
that those commands are not appropriately echoed and their output not
suppressed.  Others explicitly save exit status, clean up, and then
reset the exit status within the tests, which has excellent behavior
but makes the tests hard to read.  Still others ignore the problem.

Allow tests a fourth option: by calling this function, tests can
stack up commands they would like to be run to clean up.

Commands passed to test_when_finished during a test are
unconditionally run in the test environment immediately before the
test is completed, in last-in-first-out order.  If some cleanup
command fails, then the other cleanup commands are still run before
the failure is reported and the test script allowed to continue.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Really I am more interested in this helper than the bugfix.

 t/test-lib.sh |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c582964..6dcade3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -354,8 +354,9 @@ test_debug () {
 }
 
 test_run_ () {
+	test_cleanup='eval_ret=$?'
 	eval >&3 2>&4 "$1"
-	eval_ret="$?"
+	eval >&3 2>&4 "$test_cleanup"
 	return 0
 }
 
@@ -533,6 +534,31 @@ test_cmp() {
 	$GIT_TEST_CMP "$@"
 }
 
+# This function can be used to schedule some commands to be run
+# unconditionally at the end of the test to restore sanity:
+#
+#	test_expect_success 'test core.capslock' '
+#		git config core.capslock true &&
+#		test_when_finished "git config --unset core.capslock" &&
+#		hello world
+#	'
+#
+# That would be roughly equivalent to
+#
+#	test_expect_success 'test core.capslock' '
+#		git config core.capslock true &&
+#		hello world
+#		git config --unset core.capslock
+#	'
+#
+# except that the greeting and config --unset must both succeed for
+# the test to pass.
+
+test_when_finished () {
+	test_cleanup="eval_ret=\$?; { $*
+		} && (exit \"\$eval_ret\"); $test_cleanup"
+}
+
 # Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
-- 
1.7.1
