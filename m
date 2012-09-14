From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] Add MALLOC_CHECK_ and MALLOC_PERTURB_ libc env to the test suite for detecting heap corruption
Date: Fri, 14 Sep 2012 09:54:22 -0700
Message-ID: <1347641662-3596-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 18:54:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCZAJ-0001qU-Jf
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 18:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab2INQyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 12:54:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44227 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757325Ab2INQy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2012 12:54:27 -0400
Received: by pbbrr13 with SMTP id rr13so5902199pbb.19
        for <git@vger.kernel.org>; Fri, 14 Sep 2012 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=8/bjHxde7ucfrB/qJxN6RJXRK2vV2oiGkccgqqzUYkg=;
        b=VyvQ5eXqeZUS7cmL83hfIH5GNpV1jNN7bBcaOM0kO+c9iF16D4StZzRkukHh2jFgeX
         5RlIm5UKQFRIgILIpky561G8x6QFEdkRQzpaF0r7AXaTgY5w1+Wt9016bYtTdSrQwE1p
         ++WmJlbxEupmJi2FGBNb5kvJ3VoI/bgPGrwBFTMDGG7KjVJKaydP0D+bgKpATsXa4BYq
         K8OcrgIpy7hWRvpDc6PtYHLKYvY9vfK3zLsH6dqtsUDNAJNs3rlpAKcwVJO/ioq/4+k8
         y6ARbEo218KtT21jTkr4QccQ/6ZQEQircnNZodBfg9419j7N4tGNBCkgelxVuNvgSdfQ
         fC6Q==
Received: by 10.68.222.170 with SMTP id qn10mr5734635pbc.114.1347641667262;
        Fri, 14 Sep 2012 09:54:27 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (141.195.207.67.nephoscale.net. [67.207.195.141])
        by mx.google.com with ESMTPS id hr1sm1259902pbc.23.2012.09.14.09.54.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Sep 2012 09:54:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205501>

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

But the test suite can use also valgrind(memcheck) via 'make valgrind'
or 'make GIT_TEST_OPTS="--valgrind"'.

Memcheck wraps client calls to malloc(), and puts a "red zone" on
each end of each block in order to detect access overruns.
Memcheck already detects double free() (up to the limit of the buffer
which remembers pending free()). Thus memcheck subsumes all the
documented coverage of MALLOC_CHECK_.

If MALLOC_CHECK_ is set non-zero when running memcheck, then the
overruns that might be detected by MALLOC_CHECK_ would be overruns
on the wrapped blocks which include the red zones.  Thus MALLOC_CHECK_
would be checking memcheck, and not the client.  This is not useful,
and actually is wasteful.  The only possible [documented] advantage
of using MALLOC_CHECK_ and memcheck together, would be if MALLOC_CHECK_
detected duplicate free() in more cases than memcheck because memcheck's
buffer is too small.

Therefore we don't use MALLOC_CHECK_ and valgrind(memcheck) at the
same time.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
This the third reroll of the original patch.

I redid the patch correcting the export command in a more portable
way thanks to the Junio observation and not setting MALLOC_CHECK_
at the same time we are using valgrind. Added in the commit the reason,
not so simple to find. Hope the better :=)


 t/test-lib.sh |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 78c4286..f34b861 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -93,6 +93,15 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export EDITOR
 
+# Add libc MALLOC and MALLOC_PERTURB test 
+# only if we are not executing the test with valgrind
+expr "$GIT_TEST_OPTS" : ".*\(--valgrind\)" >/dev/null || {
+	MALLOC_CHECK_=3
+	export MALLOC_CHECK_
+	MALLOC_PERTURB_="$( expr \( $$ % 255 \) + 1)"
+	export MALLOC_PERTURB_
+}
+
 # Protect ourselves from common misconfiguration to export
 # CDPATH into the environment
 unset CDPATH
-- 
1.7.10.4
