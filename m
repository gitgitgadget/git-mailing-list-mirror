From: Nix <nix@esperi.org.uk>
Subject: git 2.0.0 PROFILE=BUILD check-phase problems with ./t5561-http-backend.sh; GIT_TEST_HTTPD=false problems with t5537-fetch-shallow.sh
Date: Thu, 29 May 2014 23:44:37 +0100
Message-ID: <87y4xk8asq.fsf@spindle.srvr.nix>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 30 01:25:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq9hD-0004Iv-PL
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 01:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbaE2XZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 19:25:06 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:47130 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbaE2XZE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 19:25:04 -0400
X-Greylist: delayed 2420 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 May 2014 19:25:03 EDT
Received: from spindle.srvr.nix (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.9/8.14.8) with ESMTP id s4TMibXo000631
	for <git@vger.kernel.org>; Thu, 29 May 2014 23:44:37 +0100
Emacs: is that a Lisp interpreter in your editor, or are you just happy to see me?
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
X-DCC-dcc1-Metrics: spindle 1182; Body=1 Fuz1=1 Fuz2=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250419>

I observe test failures with git 2.0.0 which are attributable to the
change to run network tests by default. I'm lumping them both together
into one report because I'm lazy and I've blown too much time on this
already.

I've got Apache 2.2.24 on this box, and t5551-http-fetch-smart.sh fails
in a peculiar fashion during the PROFILE=BUILD stage:

--- exp 2014-05-29 22:42:50.221599297 +0000
+++ act 2014-05-29 22:42:50.231598452 +0000
@@ -12,10 +12,10 @@
 GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
 GET  /smart/repo.git/objects/41/57d6f47fc8b7cb455fbf6f18d6f47fed49a6a5 HTTP/1.1 200
 GET  /smart/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.pack HTTP/1.1 200
-GET  /smart/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.idx HTTP/1.1 200

 ###  no git-daemon-export-ok
 ###
+GET  /smart/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.idx HTTP/1.1 200
 GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404 -
 GET  /smart_noexport/repo.git/info/refs HTTP/1.1 404 -
 GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 404 -
@@ -34,10 +34,10 @@
 GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 200 -
 GET  /smart_noexport/repo.git/objects/41/57d6f47fc8b7cb455fbf6f18d6f47fed49a6a5 HTTP/1.1 200
 GET  /smart_noexport/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.pack HTTP/1.1 200
-GET  /smart_noexport/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.idx HTTP/1.1 200

 ###  getanyfile true
 ###
+GET  /smart_noexport/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.idx HTTP/1.1 200
 GET  /smart/repo.git/HEAD HTTP/1.1 200
 GET  /smart/repo.git/info/refs HTTP/1.1 200
 GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
@@ -45,10 +45,10 @@
 GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
 GET  /smart/repo.git/objects/41/57d6f47fc8b7cb455fbf6f18d6f47fed49a6a5 HTTP/1.1 200
 GET  /smart/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.pack HTTP/1.1 200
-GET  /smart/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.idx HTTP/1.1 200

 ###  getanyfile false
 ###
+GET  /smart/repo.git/objects/pack/pack-2cb3186872e8768852fcb6b22cdf2182e12f7490.idx HTTP/1.1 200
 GET  /smart/repo.git/HEAD HTTP/1.1 403 -
 GET  /smart/repo.git/info/refs HTTP/1.1 403 -
 GET  /smart/repo.git/objects/info/packs HTTP/1.1 403 -
not ok 14 - server request log matches test results
#
#               sed -e "
#                       s/^.* \"//
#                       s/\"//
#                       s/ [1-9][0-9]*\$//
#                       s/^GET /GET  /
#               " >act <"$HTTPD_ROOT_PATH"/access.log &&
#               test_cmp exp act
#

# failed 1 among 14 test(s)

It appears that the Apache daemon is writing to the log slowly enough
that its log lines only get there after the testsuite has written its
separator, so a bunch of log lines appear to be attached to the wrong
test, and the comparison fails.

Curiously, I can't make this happen in a conventional 'make check', even
though the only relevant components would seem to be bash and httpd: if
anything, you'd expect the gcovvery to slow down git and thus make it
*more* likely that any race between httpd log syncing and testsuite
framework output to the same logfile would be hit...

Attempting to work around this by building with GIT_TEST_HTTPD=false
doesn't work either:

*** t5537-fetch-shallow.sh ***
ok 1 - setup
ok 2 - setup shallow clone
ok 3 - clone from shallow clone
ok 4 - fetch from shallow clone
ok 5 - fetch --depth from shallow clone
ok 6 - fetch --unshallow from shallow clone
ok 7 - fetch something upstream has but hidden by clients shallow boundaries
ok 8 - fetch that requires changes in .git/shallow is filtered
ok 9 - fetch --update-shallow
error: Can't use skip_all after running some tests
Makefile:43: recipe for target 't5537-fetch-shallow.sh' failed
make[3]: *** [t5537-fetch-shallow.sh] Error 1

since this is trying to run the httpd halfway through the test, which
will never work if it's skipping it. Moving the httpd sourcing to the
top of the test isn't going to work either, because that would skip
*everything*, when we want to skip only the httpd bits. Maybe splitting
the httpd bits into a separate test is best here? I'm not sure.

-- 
NULL && (void)
