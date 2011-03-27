From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] tests: fix overeager scrubbing of environment variables
Date: Sun, 27 Mar 2011 23:22:52 +0200
Message-ID: <4D8FAAAC.3050905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 23:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3xQP-0000nQ-GE
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 23:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab1C0VW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 17:22:59 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44924 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab1C0VW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 17:22:59 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id DD9B118B5821F;
	Sun, 27 Mar 2011 23:22:57 +0200 (CEST)
Received: from [93.246.35.114] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q3xQH-0003oh-00; Sun, 27 Mar 2011 23:22:57 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Y7I5tzsqd5Yu5sweRp4vrLPeXps4d2D9M1uoD
	fCaOFgEnePIjqE/Rpl8yIu1jiUgSKsmBwOmjYPuwEiDrX99k+u
	dnWSGE6g1f9tJ8DDTaKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170089>

In commit 95a1d12e9b9f ("tests: scrub environment of GIT_* variables") all
environment variables starting with "GIT_" were unset for the tests using
a perl script rather than unsetting them one by one. Only three exceptions
were made to make them work as before: "GIT_TRACE*", "GIT_DEBUG*" and
"GIT_USE_LOOKUP".

Unfortunately some environment variables used by the test framework itself
were not added to the exceptions and thus stopped working when given
before the make command instead of after it. Those are:

- GIT_SKIP_TESTS

- GIT_TEST*

- GIT_PROVE_OPTS

Let's fix that by adding them to the exception list.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

I noticed today that skipping a test the way I was used to suddenly failed:

GIT_SKIP_TESTS='t1234' GIT_TEST_OPTS='--root=/dev/shm' make -j10 test

This should work according to t/README, but didn't anymore.

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7cc9a52..4a8c443 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -46,7 +46,7 @@ unset VISUAL
 unset EMAIL
 unset $(perl -e '
 	my @env = keys %ENV;
-	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP)/, @env);
+	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP|SKIP_TESTS|TEST|PROVE_OPTS)/, @env);
 	print join("\n", @vars);
 ')
 GIT_AUTHOR_EMAIL=author@example.com
-- 
1.7.4.2.407.gac78c
