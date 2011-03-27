From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] tests: fix overeager scrubbing of environment variables
Date: Mon, 28 Mar 2011 00:26:29 +0200
Message-ID: <4D8FB995.20001@web.de>
References: <4D8FAAAC.3050905@web.de> <20110327213756.GD25927@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 00:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3yPw-00083v-NT
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 00:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695Ab1C0W0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 18:26:36 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:45984 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab1C0W0f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 18:26:35 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6975419B2659A;
	Mon, 28 Mar 2011 00:26:29 +0200 (CEST)
Received: from [93.246.35.114] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q3yPl-0007d2-00; Mon, 28 Mar 2011 00:26:29 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110327213756.GD25927@elie>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19mux4RJf9TzQOMb9Hs2ixPBSHOOAKtTTpJdWkp
	BXVyGDKra1qbMN2TwpfF8NL6QduO4zXofda6nmdwBNasMtVwOt
	7Q8Sorp5powFLODx+P9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170092>

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
that by adding them to the exception list.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
---

Am 27.03.2011 23:37, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
> 
>> - GIT_SKIP_TESTS
>> - GIT_TEST*
>> - GIT_PROVE_OPTS
>>
>> Let's fix that by adding them to the exception list.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> 
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for your review! (I took the liberty to add your Ack to this updated
version, please speak up if you are unhappy with anything in this v2!)

> It misses a few, though:
> 
>  - GIT_REMOTE_SVN_TEST_BIG_FILES
>  - GIT_NOTES_TIMING_TESTS
>  - GIT_PATCHID_TIMING_TESTS
>  - GIT_VALGRIND_OPTIONS

Right you are, this version includes those too (but - except once for
GIT_VALGRIND_OPTIONS - none of them are mentioned in t/README, that's why
I managed to miss them ... maybe they should be documented there?).

> If we were starting over I suppose those would all be GIT_TEST* but
> there's something to be said for muscle memory.

Yeah, I thought the same about GIT_SKIP_TESTS when writing the first version
of this patch ... ;-)

>> I noticed today that skipping a test the way I was used to suddenly failed:
>>
>> GIT_SKIP_TESTS='t1234' GIT_TEST_OPTS='--root=/dev/shm' make -j10 test
>>
>> This should work according to t/README, but didn't anymore.
> 
> I would have just written that in the change description.

Yup, did that!

 t/test-lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7cc9a52..f1f6d94 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -46,7 +46,7 @@ unset VISUAL
 unset EMAIL
 unset $(perl -e '
 	my @env = keys %ENV;
-	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP)/, @env);
+	my @vars = grep(/^GIT_/ && !/^GIT_(TRACE|DEBUG|USE_LOOKUP|NOTES_TIMING_TESTS|PATCHID_TIMING_TESTS|PROVE_OPTS|REMOTE_SVN_TEST_BIG_FILES|SKIP_TESTS|TEST|VALGRIND_OPTIONS)/, @env);
 	print join("\n", @vars);
 ')
 GIT_AUTHOR_EMAIL=author@example.com
-- 
1.7.4.2.407.gac78c
