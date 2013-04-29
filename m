From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2 v2] test output: respect $TEST_OUTPUT_DIRECTORY
Date: Mon, 29 Apr 2013 19:16:21 +0100
Message-ID: <20130429181621.GL472@serenity.lan>
References: <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
 <7c0618f3fa7f68b963bf483f1e97afed835bdb74.1367002553.git.john@keeping.me.uk>
 <47c9ba4200a22e865040208628357d9bc4bcf3f4.1367002553.git.john@keeping.me.uk>
 <87fvy9dxok.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 29 20:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWscy-0007Mv-4e
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 20:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758378Ab3D2SQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 14:16:35 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:60763 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519Ab3D2SQe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 14:16:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 4F9B1CDA5B2;
	Mon, 29 Apr 2013 19:16:34 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQjnNuZ1AEnq; Mon, 29 Apr 2013 19:16:33 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 6EF10CDA569;
	Mon, 29 Apr 2013 19:16:23 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <87fvy9dxok.fsf@hexa.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222835>

Most test results go in $TEST_OUTPUT_DIRECTORY, but the output files for
tests run with --tee or --valgrind just use bare "test-results".
Changes these so that they do respect $TEST_OUTPUT_DIRECTORY.

As a result of this, the valgrind/analyze.sh script may no longer
inspect the correct files so it is also updated to respect
$TEST_OUTPUT_DIRECTORY by adding it to GIT-BUILD-OPTIONS.  This may be a
regression for people who have TEST_OUTPUT_DIRECTORY in their config.mak
but want to override it in the environment, but this change merely
brings it into line with GIT_TEST_OPTS which already cannot be
overridden if it is specified in config.mak.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Mon, Apr 29, 2013 at 08:00:27PM +0200, Thomas Rast wrote:
> John Keeping <john@keeping.me.uk> writes:
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index ca6bdef..70ad085 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -54,8 +54,8 @@ done,*)
> >  	# do not redirect again
> >  	;;
> >  *' --tee '*|*' --va'*)
> > -	mkdir -p test-results
> > -	BASE=test-results/$(basename "$0" .sh)
> > +	mkdir -p "$(TEST_OUTPUT_DIRECTORY)/test-results"
> > +	BASE="$(TEST_OUTPUT_DIRECTORY)/test-results/$(basename "$0" .sh)"
> >  	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
> >  	 echo $? > $BASE.exit) | tee $BASE.out
> >  	test "$(cat $BASE.exit)" = 0
> 
> Hmm, I initially was too lazy to review this change, and now it's biting
> me.  The above is Makefile-quoted, which to the shell reads like a
> command substitution.

Yeah, that's completely wrong - clearly it was too late on Friday
evening when I wrote this.  There was another case of the same in
t/valgrind/analyze.sh.

All fixed in this version.

 Makefile              | 3 +++
 t/test-lib.sh         | 4 ++--
 t/valgrind/analyze.sh | 8 ++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 598d631..ef5be0f 100644
--- a/Makefile
+++ b/Makefile
@@ -2153,6 +2153,9 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@
+ifdef TEST_OUTPUT_DIRECTORY
+	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@
+endif
 ifdef GIT_TEST_OPTS
 	@echo GIT_TEST_OPTS=\''$(subst ','\'',$(subst ','\'',$(GIT_TEST_OPTS)))'\' >>$@
 endif
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 657b0bd..e7d169c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -54,8 +54,8 @@ done,*)
 	# do not redirect again
 	;;
 *' --tee '*|*' --va'*)
-	mkdir -p test-results
-	BASE=test-results/$(basename "$0" .sh)
+	mkdir -p "$TEST_OUTPUT_DIRECTORY/test-results"
+	BASE="$TEST_OUTPUT_DIRECTORY/test-results/$(basename "$0" .sh)"
 	(GIT_TEST_TEE_STARTED=done ${SHELL_PATH} "$0" "$@" 2>&1;
 	 echo $? > $BASE.exit) | tee $BASE.out
 	test "$(cat $BASE.exit)" = 0
diff --git a/t/valgrind/analyze.sh b/t/valgrind/analyze.sh
index d8105d9..2ffc80f 100755
--- a/t/valgrind/analyze.sh
+++ b/t/valgrind/analyze.sh
@@ -1,6 +1,10 @@
 #!/bin/sh
 
-out_prefix=$(dirname "$0")/../test-results/valgrind.out
+# Get TEST_OUTPUT_DIRECTORY from GIT-BUILD-OPTIONS if it's there...
+. "$(dirname "$0")/../../GIT-BUILD-OPTIONS"
+# ... otherwise set it to the default value.
+: ${TEST_OUTPUT_DIRECTORY=$(dirname "$0")/..}
+
 output=
 count=0
 total_count=0
@@ -115,7 +119,7 @@ handle_one () {
 	finish_output
 }
 
-for test_script in "$(dirname "$0")"/../test-results/*.out
+for test_script in "$TEST_OUTPUT_DIRECTORY"/test-results/*.out
 do
 	handle_one $test_script
 done
-- 
1.8.3.rc0.149.g98a72f2.dirty
