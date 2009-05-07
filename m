From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tests in Cygwin
Date: Thu, 07 May 2009 09:13:14 +0200
Message-ID: <4A028A0A.5070003@viscovery.net>
References: <83prfbhasp.fsf@kalahari.s2.org>	<4A01E64C.7050703@SierraAtlantic.com> <7vvdoet13g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Don Slutz <Don.Slutz@SierraAtlantic.com>,
	Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 09:13:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1xnO-0002kM-C0
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 09:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbZEGHNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 03:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbZEGHNU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 03:13:20 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:55785 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbZEGHNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 03:13:19 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M1xn8-00052Y-Jd; Thu, 07 May 2009 09:13:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 49C2154D; Thu,  7 May 2009 09:13:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vvdoet13g.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118434>

Junio C Hamano schrieb:
> Don Slutz <Don.Slutz@SierraAtlantic.com> writes:
> 
>> A lot of these failures are do to running as root (member of
>> Administrators)....
> 
> Perhaps we can do this to reduce the noise level.

Thank you for this patch. Unfortunately, it does not work as intended
because the call to test_have_prereq in test_skip does not split
the prereq tokens so that tests with space-separated prerequisite tokens
are always skipped.

My first attempt to solve that is to remove the quotes from the
test_have_prereq call in test_skip; but I think that this simple
solution is rather unintuitive, and will look like a bug if you inspect
the code again in two months.

You could squash in the patch below, where I chose to concatenate
tokens with '+' because I dislike the extra quoting that is otherwise
necessary at the call site. The downside is that it plays games with
IFS, which you might find too ugly and not worth it. It's your call.

BTW, I didn't dare test this as root on my production system; I'll do
that later today elsewhere.


diff --git a/t/README b/t/README
index a532c32..49c3a51 100644
--- a/t/README
+++ b/t/README
@@ -200,7 +200,7 @@ library for your script to use.
    <script>.  If it yields success, test is considered
    successful.  <message> should state what it is testing.

-   An optional parameter <prereq> is a space separated list of prerequisite
+   An optional parameter <prereq> is a '+' separated list of prerequisite
    tokens.  The test will be skipped if the test environment lacks any of
    the prerequiste feature listed (see below for commonly used
    prerequisites).
@@ -260,7 +260,8 @@ Prerequisites
 -------------

  POSIXPERM	The filesystem supports POSIX style permission bits
- BSLASHPSPEC	???
+ BSLASHPSPEC	Backslashes in pathspec are not directory separators
+                (i.e. they are not converted to forward-slash)
  EXECKEEPSPID	The process retains the same pid across exec(2)

  SANITY		Test is not run by root user, and an attempt to an
diff --git a/t/t1004-read-tree-m-u-wf.sh b/t/t1004-read-tree-m-u-wf.sh
index eb60f80..8683189 100755
--- a/t/t1004-read-tree-m-u-wf.sh
+++ b/t/t1004-read-tree-m-u-wf.sh
@@ -177,7 +177,7 @@ test_expect_success SYMLINKS 'funny symlink in work tree' '

 '

-test_expect_success 'SYMLINKS SANITY' 'funny symlink in work tree, un-unlink-able' '
+test_expect_success SYMLINKS+SANITY 'funny symlink in work tree, un-unlink-able' '

 	rm -fr a b &&
 	git reset --hard &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1922e0b..2d12799 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -263,7 +263,12 @@ test_set_prereq () {
 }
 satisfied=" "

+# prerequisites can be concatenated with '+'
 test_have_prereq () {
+	save_IFS=$IFS
+	IFS=+
+	set -- $*
+	IFS=$save_IFS
 	for prerequisite
 	do
 		case $satisfied in
