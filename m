From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Expect the exit code of builtin checkout to be in
 portable range
Date: Thu, 28 Feb 2008 12:52:48 -0800
Message-ID: <7vk5kohkgv.fsf@gitster.siamese.dyndns.org>
References: <20080228163047.GA4069@steel.home>
 <20080228164953.GB4069@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:54:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUplN-0003hL-I1
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761584AbYB1UxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761016AbYB1UxK
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:53:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761013AbYB1UxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:53:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77A202E78;
	Thu, 28 Feb 2008 15:53:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5612A2E76; Thu, 28 Feb 2008 15:53:00 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75455>

Alex Riesen <raa.lkml@gmail.com> writes:

> This allows crashes to be noticed at least in bash and dash, which put
> the signal which terminated the command in its exit status.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Alex Riesen, Thu, Feb 28, 2008 17:30:47 +0100:
>> Noticed in t2008, which actually passed, but silently removed
>> core-files (I saw segfaults in syslog) and did not properly check the
>> exit code.  The change for the t2008 comes as seperate patch, but it
>> should be noted that "! command" is *not* how you check for a command
>> to have failed. It could have crashed.
>
> So we'd better check the exit status in failure tests.
> Like this, for instance

Yeah, very well spotted, although I would have liked it if this
were caught before it hit 'master'.

I think we want a helper shell function to fix potentially many
other uses of "! git-command" construct, so how about doing it
this way?

---
 t/t2008-checkout-subdir.sh |    8 ++++----
 t/test-lib.sh              |   17 +++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/t/t2008-checkout-subdir.sh b/t/t2008-checkout-subdir.sh
index 4a723dc..3e098ab 100755
--- a/t/t2008-checkout-subdir.sh
+++ b/t/t2008-checkout-subdir.sh
@@ -68,15 +68,15 @@ test_expect_success 'checkout with simple prefix' '
 '
 
 test_expect_success 'relative path outside tree should fail' \
-	'! git checkout HEAD -- ../../Makefile'
+	'test_must_fail git checkout HEAD -- ../../Makefile'
 
 test_expect_success 'incorrect relative path to file should fail (1)' \
-	'! git checkout HEAD -- ../file0'
+	'test_must_fail git checkout HEAD -- ../file0'
 
 test_expect_success 'incorrect relative path should fail (2)' \
-	'( cd dir1 && ! git checkout HEAD -- ./file0 )'
+	'( cd dir1 && test_must_fail git checkout HEAD -- ./file0 )'
 
 test_expect_success 'incorrect relative path should fail (3)' \
-	'( cd dir1 && ! git checkout HEAD -- ../../file0 )'
+	'( cd dir1 && test_must_fail git checkout HEAD -- ../../file0 )'
 
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 83889c4..90df619 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -270,6 +270,23 @@ test_expect_code () {
 	echo >&3 ""
 }
 
+# This is not among top-level (test_expect_success | test_expect_failure)
+# but is a prefix that can be used in the test script, like:
+#
+#	test_expect_success 'complain and die' '
+#           do something &&
+#           do something else &&
+#	    test_must_fail git checkout ../outerspace
+#	'
+#
+# Writing this as "! git checkout ../outerspace" is wrong, because
+# the failure could be due to a segv.  We want a controlled failure.
+
+test_must_fail () {
+	"$@"
+	test $? -gt 0 -a $? -le 128
+}
+
 # Most tests can use the created repository, but some may need to create more.
 # Usage: test_create_repo <directory>
 test_create_repo () {
