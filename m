From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCHv2] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test suite for detecting heap corruption
Date: Thu, 13 Sep 2012 09:59:19 -0700
Message-ID: <1347555559-5341-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 19:00:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCCm7-0000hf-3m
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 19:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758629Ab2IMRAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 13:00:11 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:49758 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758606Ab2IMQ7x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 12:59:53 -0400
Received: by pbbrr13 with SMTP id rr13so4251683pbb.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 09:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=3KJSrMwTPaKd3L57es5wXVmmb1X1oWh6BKnr/X+G3pI=;
        b=ULhsnnN1ksQnuUFdIrZwKB6dGZZmkwLdOazYaWDixTqFpJlarLNJw287grwsStmf+V
         iM0rLNhaIa5wxGYq/bDcl9s2IjMxSf+13Mhv4JIBtGZKDAU8Y6B5h47bnn5LjyVsleyV
         HT0i0lDKXFYg5ABRSP9f8pnwYfCQt7XAykSbwgDXlsYrU5ksKT6GBcJeONO0qdbiS9KD
         3rVBMM0Dv+4SU4irc5E59lKLFO9DJlOcBG+Dh40n2Dhz9XJ7382gPp2Nq+yH0J1oZQ1m
         3Gys7oRTbidLgX9aq1X7Xa8bSXM1RRh4vlec9o5cRZMEgUsteXTl9LzTa3iO+jw5gk/B
         sfjg==
Received: by 10.68.195.163 with SMTP id if3mr454711pbc.36.1347555593194;
        Thu, 13 Sep 2012 09:59:53 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (141.195.207.67.nephoscale.net. [67.207.195.141])
        by mx.google.com with ESMTPS id vd4sm13353770pbc.41.2012.09.13.09.59.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Sep 2012 09:59:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205392>

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
This the second reroll of the original patch.

I redid the patch correcting the export command in a more portable
way thanks to the Junio observation.

 t/test-lib.sh |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c4286..6317ffc 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -93,6 +93,14 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+# Add libc malloc_check and MALLOC_PERTURB test 
+MALLOC_CHECK_=3
+export MALLOC_CHECK_
+MALLOC_PERTURB_="$( expr \( $$ % 255 \) + 1)"
+export MALLOC_PERTURB_
+#
+
+
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
-- 
1.7.10.4
