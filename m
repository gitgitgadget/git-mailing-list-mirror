From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH] test-lib: add the test_pause convenience function
Date: Tue, 17 Jan 2012 09:21:16 +0100
Message-ID: <4F152F7C.9020902@web.de>
References: <4F133069.10308@web.de> <20120115232413.GA14724@sigill.intra.peff.net> <7vk44ruupe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 09:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn4Ia-00063h-TN
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 09:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab2AQIVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 03:21:40 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:42476 "EHLO
	fmmailgate05.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab2AQIVj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 03:21:39 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate05.web.de (Postfix) with ESMTP id CEB226914659
	for <git@vger.kernel.org>; Tue, 17 Jan 2012 09:21:20 +0100 (CET)
Received: from [192.168.178.43] ([91.3.199.218]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0MRTvU-1SFh0K20Uq-00SoD4; Tue, 17 Jan 2012 09:21:20
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vk44ruupe.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:4nK4IOSOQOY5gf3uaEnhflUBrqWy/bJctV+JTeLs5l0
 sjaiZRd+m7e6Mr9u/60+Afiscaoypt5Gveaqx4oGtCN6raa7rQ
 Zh+lWcT5Kjwr2DUIGN34iP8RP3Jo30cF3d/JJOk/Outg6xY7uN
 DsorNGQnb1WTXl6rGO54fuhShwqEIe87xwEK3X6rzm+Jn3FiUP
 RPQylNDLoIUVoC/nlZONA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188699>

Since 781f76b15 (test-lib: redirect stdin of tests) you can't simply put a
"bash &&" into a test for debugging purposes anymore. Instead you'll have
to use "bash <&6 >&3 2>&4".

As that invocation is not that easy to remember add the test_pause
convenience function. This function also checks if the -v flag is given
and will error out if that is not the case instead of letting the test
hang until ^D is pressed.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 16.01.2012 23:51, schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
> 
>> Nice. Many times I have added such a "bash" or "gdb" invocation then
>> forgotten "-v", only to scratch my head at why the test seemed to be
>> hanging.
>>
>> Two minor nits on the patch itself:
>> ...
>> 1. It may be worth putting a warning in the comment that this is never
>>    to be used in a real test, but only temporarily inserted.
>>
>> 2. I do this not just with bash, but with "gdb". I wonder if it is worth
>>    making this "test_foo bash", for some value of "foo" (the ones that
>>    occur to me are "debug" and "run", but of course they are taken).
>>
>>    Actually, I wonder if the existing test_debug could handle this
>>    already (though you do have to remember to add "--debug" to your
>>    command line, then).
> 
> I wondered the same thing from a different angle. My first reaction was
> "Why is this called 'bash' not 'sh'?" which naturally led to the same
> direction as yours "why not an arbitrary command 'test_debug xxx'?"
> 
> test_pause perhaps?

I really don't care deeply about the name, so test_pause is absolutely
ok for me. I added some documentation in t/README too and made it an
error when --verbose is not used.

Is it ok to invoke bash here or should sh be used?


 t/README      |   13 +++++++++++++
 t/test-lib.sh |   13 +++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index c85abaf..c09c582 100644
--- a/t/README
+++ b/t/README
@@ -548,6 +548,19 @@ library for your script to use.
 		...
 	'

+ - test_pause
+
+	This command is useful for writing and debugging tests and must be
+	removed before submitting. It halts the execution of the test and
+	spawns a shell in the trash directory. Exit the shell to continue
+	the test. Example:
+
+	test_expect_success 'test' '
+		git do-something >actual &&
+		test_pause &&
+		test_cmp expected actual
+	'
+
 Prerequisites
 -------------

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a65dfc7..85084c4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -329,6 +329,19 @@ test_tick () {
 	export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }

+# Stop execution and start a shell. This is useful for debugging tests and
+# only makes sense together with "-v".
+#
+# Be sure to remove all invocations of this command before submitting.
+
+test_pause () {
+	if test "$verbose" = t; then
+		bash <&6 >&3 2>&4
+	else
+		error >&5 "test_pause requires --verbose"
+	fi
+}
+
 # Call test_commit with the arguments "<message> [<file> [<contents>]]"
 #
 # This will commit a file with the given contents and the given commit
-- 
1.7.9.rc1.2.g0b847.dirty
