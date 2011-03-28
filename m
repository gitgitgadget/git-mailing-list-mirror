From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v3] tests: fix overeager scrubbing of environment variables
Date: Mon, 28 Mar 2011 21:16:09 +0200
Message-ID: <4D90DE79.7000103@web.de>
References: <4D8FAAAC.3050905@web.de> <20110327213756.GD25927@elie> <7v4o6n18oy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 21:16:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Hvf-0002rs-Nn
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 21:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753906Ab1C1TQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 15:16:39 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:33334 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab1C1TQi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 15:16:38 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 2FDDC19B34F3E;
	Mon, 28 Mar 2011 21:16:10 +0200 (CEST)
Received: from [93.240.104.132] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q4Hv8-0000fj-00; Mon, 28 Mar 2011 21:16:10 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7v4o6n18oy.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX198AslERc1Bcv5f7+JPYPZfetzTEaP6mYNLS4cz
	WszeTlCqY5Eo2PYey8GvstjHTMU4QOSWYstIGnM3QUkVMPBwro
	JBMvoKGy7WHsiHEO/Jpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170177>

In commit 95a1d12e9b9f ("tests: scrub environment of GIT_* variables") all
environment variables starting with "GIT_" were unset for the tests using
a perl script rather than unsetting them one by one. Only three exceptions
were made to make them work as before: "GIT_TRACE*", "GIT_DEBUG*" and
"GIT_USE_LOOKUP".

Unfortunately some environment variables used by the test framework itself
were not added to the exceptions and thus stopped working when given
before the make command instead of after it. Those are:

- GIT_NOTES_TIMING_TESTS
- GIT_PATCHID_TIMING_TESTS
- GIT_PROVE_OPTS
- GIT_REMOTE_SVN_TEST_BIG_FILES
- GIT_SKIP_TESTS
- GIT_TEST*
- GIT_VALGRIND_OPTIONS

I noticed that when skipping a test the way I was used to suddenly failed:

GIT_SKIP_TESTS='t1234' GIT_TEST_OPTS='--root=/dev/shm' make -j10 test

This should work according to t/README, but didn't anymore, so let's fix
that by adding them to the exception list. And to avoid having a long
regexp put the exceptions in a separate variable using nicer formatting.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks-to: Jeff King <peff@peff.net>
---


Am 28.03.2011 19:00, schrieb Junio C Hamano:
> I think it is Ok to do this (yes I am trying to avoid doing this myself,
> as I am a bit behind and also am lazy) just as a single patch to rename
> the environment variables, and filter them with a single GIT_TEST_*
> pattern at the same time.

Agreed, that would be the best solution. But I got sidetracked by this
issue while trying to fix something else, so I would rather want to
avoid doing the whole exercise myself. So here is v3 of my patch which
just makes these variables work again.


 t/test-lib.sh |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7cc9a52..7a56f11 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -46,7 +46,16 @@ unset VISUAL
 unset EMAIL
 unset $(perl -e '
 	my @env = keys %ENV;
-	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP)/, @env);
+	my $ok = join("|", qw(
+		TRACE
+		DEBUG
+		USE_LOOKUP
+		TEST
+		.*_TEST
+		PROVE
+		VALGRIND
+	));
+	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
 	print join("\n", @vars);
 ')
 GIT_AUTHOR_EMAIL=author@example.com
-- 
1.7.4.2.407.g50b80.dirty
