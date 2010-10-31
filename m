From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 02/10] test-lib: introduce test_line_count to measure
 files
Date: Sun, 31 Oct 2010 02:33:50 -0500
Message-ID: <20101031073350.GC11483@burratino>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
 <7vr5f73umz.fsf@alter.siamese.dyndns.org>
 <20101031072640.GA11483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 08:34:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCSQa-0004dW-N7
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 08:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab0JaHeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Oct 2010 03:34:01 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57865 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab0JaHeA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Oct 2010 03:34:00 -0400
Received: by gxk23 with SMTP id 23so2675908gxk.19
        for <git@vger.kernel.org>; Sun, 31 Oct 2010 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=kd2AiC10Xy7+YEvvcqgyyLP0FKvTLkPzCiN/SisyueU=;
        b=ShhdJnALvFGUDQtWRI2kNpzc8vr3ZBRi+Ewh/ancYGVkSs66YISy7RSuRIptzaUEFW
         wXHXKAbksbrvQjmfY2XJAloma/tqKGGtmLMmELn2j/Gfwsdf/OnGWRfdHIVFNwwtMxrK
         Alz56a8bPyaMbSXo+hM6k/h6hoJOVut/7ALCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FAwt1VlRaQqeM/OMgzfyGGmwRt5WFWxhiK+d8fMbdL+YwD1+A4twvlpx/qW7VBTWqw
         EeAbAuFTMyzxIuxYEH4vTx1rzAuMntTTHS3Vgku0LxtsJJpoGZOilT+qGPA32CGPfP8H
         5+8wlKIKmonfGJrorKIJrPYcRWLAI2wQ1So7Q=
Received: by 10.150.140.4 with SMTP id n4mr25741194ybd.316.1288510439495;
        Sun, 31 Oct 2010 00:33:59 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id 43sm3801306yhl.37.2010.10.31.00.33.57
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 31 Oct 2010 00:33:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101031072640.GA11483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160421>

Some tests check their output with code like the following:

	test "$(git ls-files -u B | wc -l)" -eq 3 || {
		echo "BAD: should have left stages for B"
		return 1
	}

The verbose failure condition is used because test, unlike
diff, does not print any useful information about the
nature of the failure when it fails.

Introduce a test_line_count function to help. If used like

	git ls-files -u B >output &&
	test_line_count -eq 3 output

it will produce output like

	test_line_count: line count for output !-eq 3
	100644 b023018cabc396e7692c70bbf5784a93d3f738ab 2	hi.c
	100644 45b983be36b73c0788dc9cbcb76cbb80fc7bb057 3	hi.c

on failure.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I don't imagine this would be too helpful for new tests,
but the idiom is common enough in old tests that maybe I'm
wrong about that.

 t/README      |    4 ++++
 t/test-lib.sh |   22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 2aceb67..1a78982 100644
--- a/t/README
+++ b/t/README
@@ -500,6 +500,10 @@ library for your script to use.
    <expected> file.  This behaves like "cmp" but produces more
    helpful output when the test is run with "-v" option.
 
+ - test_line_count (= | -lt | -ge | ...) <length> <file>
+
+   Check whether a file has the length it is expected to.
+
  - test_path_is_file <file> [<diagnosis>]
    test_path_is_dir <dir> [<diagnosis>]
    test_path_is_missing <path> [<diagnosis>]
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 87308f5..a417bdf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -598,6 +598,28 @@ test_path_is_missing () {
 	fi
 }
 
+# test_line_count checks that a file has the number of lines it
+# ought to. For example:
+#
+#	test_expect_success 'produce exactly one line of output' '
+#		do something >output &&
+#		test_line_count = 1 output
+#	'
+#
+# is like "test $(wc -l <output) = 1" except that it passes the
+# output through when the number of lines is wrong.
+
+test_line_count () {
+	if test $# != 3
+	then
+		error "bug in the test script: not 3 parameters to test_line_count"
+	elif ! test $(wc -l <"$3") "$1" "$2"
+	then
+		echo "test_line_count: line count for $3 !$1 $2"
+		cat "$3"
+		return 1
+	fi
+}
 
 # This is not among top-level (test_expect_success | test_expect_failure)
 # but is a prefix that can be used in the test script, like:
-- 
1.7.2.3.557.gab647.dirty
