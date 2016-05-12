From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] test-lib: set BASH_XTRACEFD automatically
Date: Thu, 12 May 2016 17:44:12 +0200 (CEST)
Message-ID: <ffc132a9d6cdb97c49861bd9b6b2c6aca42cec93.1463067811.git.johannes.schindelin@gmx.de>
References: <cover.1462888768.git.johannes.schindelin@gmx.de> <cover.1463067811.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 17:59:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0t1N-0005Pr-Pi
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 17:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbcELP71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 11:59:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:62964 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932291AbcELP70 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 11:59:26 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MU0U9-1b9zp005kf-00QnFl; Thu, 12 May 2016 17:59:19
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1463067811.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:R/UE2iLy80P5k6yIJ2puH30NxS55TQy1zAo0fuOfd1QZFUnrS69
 Fs2TBjsvGI7R8VwTgjd6CNq9IoXELGZBNqAhHhYNTXIyqlJz/GgtwXEQvDu9q6ZJTG0dX6r
 ROmK7mkuOdbfiPt3DEj5LSoMc+mixoWHfFggBqa0wQoCt5pd/SoTdr1XCogFy8hdRXW0gao
 hZDdSYf+yB6oGbpuFgI4g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LqunEen5yWI=:HQArfFL2d1GQlHrZ9cnaWY
 9SA3e5G4zf35w9aHVDwBTrDhTs/Atiw+d+ceWJyRbSOGATz8nsIlLWZl3mb6iC67sDG6fdO2e
 IW4kP2b818tYznvA8NcfBl+KnHLm8EWrbH/hHnbTxGbqubkMl8xvWr9vR+9YxBJFaS6HdhfTo
 tn5IUfuIVDwOIvSD0tLg0JTuqWUWewq7ogFbLIUb5shjwJzuGiO2pJRhNGuRBIaYqu0MbxBEE
 0M0mF00j0U2CQGT/e24FBdq7xNtfMVkvd8UR2PT+T5zJ2+MpGi6fo05hNW7uSWzc0oPtOL/VF
 +vIBHCNXlmBo1j9gw1G59isv7+p4pbUHs0mjrRkYCrvy4MjwpSCPaKY9+RrxiIrNwKSr/bTVU
 hoLX9RHNqdTsw7z3tk2gJFZWyeUwzGzLXpImEz+JKLIJSOVhWm0e2RFTha+obdzrWV9Z2Mc3g
 bHDJLa5Jez+yrjWhts09S6NWuOrpR2ol9nJsBmGBHonp3qdLLFRLgej4VakXWM+6hyDsyutEB
 NfJLNlCkHoIYkCAhAGHur/bmbssRaA60MiSuygm7f5nKV9zBWhA4+tdcfc7uarGI/r3/V7ptQ
 BcpOa/WGq7kP3p0dOdhYiqxfeXPjNMgSUqP/67NGEf4IgYznqm4p/uTro1YB6USIm+GKjESzI
 moTL0p0ru2MIgjkvcbToMZ08p9cONDZiJNmBvcQw6+dw8lQ6LytENJP8hsbQC8Z1P87/4SBLD
 d60it/gDI6YjF01o0ffu0hRALIZ8e6wtigxltfz5UqN+oNKK99oHBrSbC+dxuUHp7g30ifRM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294414>

From: Jeff King <peff@peff.net>

Passing "-x" to a test script enables the shell's "set -x"
tracing, which can help with tracking down the command that
is causing a failure. Unfortunately, it can also _cause_
failures in some tests that redirect the stderr of a shell
function.  Inside the function the shell continues to
respect "set -x", and the trace output is collected along
with whatever stderr is generated normally by the function.

You can see an example of this by running:

  ./t0040-parse-options.sh -x -i

which will fail immediately in the first test, as it
expects:

  test_must_fail some-cmd 2>output.err

to leave output.err empty (but with "-x" it has our trace
output).

Unfortunately there isn't a portable or scalable solution to
this. We could teach test_must_fail to disable "set -x", but
that doesn't help any of the other functions or subshells.

However, we can work around it by pointing the "set -x"
output to our descriptor 4, which always points to the
original stderr of the test script. Unfortunately this only
works for bash, but it's better than nothing (and other
shells will just ignore the BASH_XTRACEFD variable).

The patch itself is a simple one-liner, but note the caveats
in the accompanying comments.

Automatic tests for our "-x" option may be a bit too meta
(and a pain, because they are bash-specific), but I did
confirm that it works correctly both with regular "-x" and
with "--verbose-only=1". This works because the latter flips
"set -x" off and on for particular tests (if it didn't, we
would get tracing for all tests, as going to descriptor 4
effectively circumvents the verbose flag).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/README      |  6 +++---
 t/test-lib.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/t/README b/t/README
index 1dc908e..76a0daa 100644
--- a/t/README
+++ b/t/README
@@ -84,9 +84,9 @@ appropriately before running "make".
 
 -x::
 	Turn on shell tracing (i.e., `set -x`) during the tests
-	themselves. Implies `--verbose`. Note that this can cause
-	failures in some tests which redirect and test the
-	output of shell functions. Use with caution.
+	themselves. Implies `--verbose`. Note that in non-bash shells,
+	this can cause failures in some tests which redirect and test
+	the output of shell functions. Use with caution.
 
 -d::
 --debug::
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 286c5f3..0055ebb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -322,6 +322,19 @@ else
 	exec 4>/dev/null 3>/dev/null
 fi
 
+# Send any "-x" output directly to stderr to avoid polluting tests
+# which capture stderr. We can do this unconditionally since it
+# has no effect if tracing isn't turned on.
+#
+# Note that this sets up the trace fd as soon as we assign the variable, so it
+# must come after the creation of descriptor 4 above. Likewise, we must never
+# unset this, as it has the side effect of closing descriptor 4, which we
+# use to show verbose tests to the user.
+#
+# Note also that we don't need or want to export it. The tracing is local to
+# this shell, and we would not want to influence any shells we exec.
+BASH_XTRACEFD=4
+
 test_failure=0
 test_count=0
 test_fixed=0
-- 
2.8.2.465.gb077790
