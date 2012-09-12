From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test suite for detecting heap corruption
Date: Wed, 12 Sep 2012 05:17:28 -0700
Message-ID: <1347452248-12222-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 12 14:17:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBlt4-0003mB-8c
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 14:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab2ILMRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 08:17:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42157 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab2ILMRg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 08:17:36 -0400
Received: by pbbrr13 with SMTP id rr13so2187955pbb.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 05:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=AkD3ZynQssSqK9QHqS7mxPvRqoGD9sMtVb+zZcAdyy8=;
        b=RSs0+uAQCGqV/mnrsBunX9niEzSCG++dG+aGUuqtjHtVdaBraRnxuwizhRLRKarUgC
         fvzqNA+w0Rk/WB3u63WBPWBDapwAQneciWfNerUkLrLRmugQXNw19gpxxP4Hhp92v7cN
         haT1FgzK8fBca/2301HV4EaKTOG5CJy8NsWEkwP+zLw6EOP78zvwL+1+u9mkjDPoK/hY
         gJTqp2HDwd7E+BNAIBXWsvSGAfOrCpbTZ5PczKORGvF+pe2w/HwMfnLS+jH39/QctrPb
         7qXEs88ba++Zp8DCNDO3qiRCmAQu++9R3xrBfb3BJrPAskMq0DEOjviI+BXMsWeVQUMF
         tR4Q==
Received: by 10.66.79.166 with SMTP id k6mr31757923pax.44.1347452256172;
        Wed, 12 Sep 2012 05:17:36 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (141.195.207.67.nephoscale.net. [67.207.195.141])
        by mx.google.com with ESMTPS id tw5sm5149381pbc.48.2012.09.12.05.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Sep 2012 05:17:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205282>

Recent versions of Linux libc (later than 5.4.23) and glibc (2.x)
include a malloc() implementation which is tunable via environment
variables. When MALLOC_CHECK_ is set, a special (less efficient)
implementation is used which is designed to be tolerant against
simple errors, such as double calls of free() with the same argument,
or overruns of a single byte (off-by-one bugs). When MALLOC_CHECK_
is set to 3, a diagnostic message is printed on stderr
and the program is aborted.

Setting the MALLOC_PERTURB_ environment variable causes the malloc
functions in libc to return memory which has been wiped and clear
memory when it is returned.
Of course this does not affect calloc which always does clear the memory.

The reason for this exercise is, of course, to find code which uses
memory returned by malloc without initializing it and code which uses
code after it is freed. valgrind can do this but it's costly to run.
The MALLOC_PERTURB_ exchanges the ability to detect problems in 100%
of the cases with speed.

The byte value used to initialize values returned by malloc is the byte
value of the environment value. The value used to clear memory is the
bitwise inverse. Setting MALLOC_PERTURB_ to zero disables the feature.

This technique can find hard to detect bugs.
It is therefore suggested to always use this flag (at least temporarily)
when testing out code or a new distribution.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 t/test-lib.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c4286..98c90b0 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -93,6 +93,12 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+# Add libc malloc_check and MALLOC_PERTURB test 
+export MALLOC_CHECK_=3
+export MALLOC_PERTURB_="$( expr \( $$ % 255 \) + 1)"
+#
+
+
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
-- 
1.7.11.rc1
