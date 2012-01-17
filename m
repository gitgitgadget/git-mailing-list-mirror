From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2] test-lib: add the test_pause convenience function
Date: Tue, 17 Jan 2012 22:04:31 +0100
Message-ID: <4F15E25F.2000002@web.de>
References: <4F133069.10308@web.de> <20120115232413.GA14724@sigill.intra.peff.net> <7vk44ruupe.fsf@alter.siamese.dyndns.org> <4F152F7C.9020902@web.de> <7vboq2rvhl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 22:05:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnGDK-0004gJ-Kk
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 22:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab2AQVFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 16:05:00 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:43975 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab2AQVE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 16:04:59 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate01.web.de (Postfix) with ESMTP id E64B41A9017E9
	for <git@vger.kernel.org>; Tue, 17 Jan 2012 22:04:34 +0100 (CET)
Received: from [192.168.178.43] ([91.3.199.218]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lsy7e-1SpN8q09BS-011nQY; Tue, 17 Jan 2012 22:04:34
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vboq2rvhl.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:tIqRIhaxuEnS+8yWzfbmQGpFie6Q/I3+4HAgr4b3VMH
 778b6CRGexwFmTxUbeFj1eQjlhDT8z6JLWhTqfWUPKz+Wq6ppH
 p//BiYlmbL4E0MbMbvIDWYGBzzPwSvq/IuZpu8qcTpyzBiiY2s
 A0M6xqBiT54l0/9QCbZs8MYyasQkTd/LFEub6A9uugGcnhMUAv
 6BuAt4fHbdX2O+Sztji2g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188721>

Since 781f76b15 (test-lib: redirect stdin of tests) you can't simply put a
"bash &&" into a test for debugging purposes anymore. Instead you'll have
to use "bash <&6 >&3 2>&4".

As that invocation is not that easy to remember add the test_pause
convenience function. It invokes "$SHELL_PATH" to provide a sane shell
for the user.

This function also checks if the -v flag is given and will error out if
that is not the case instead of letting the test hang until ^D is pressed.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---

Am 17.01.2012 20:15, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> What I cared was more about the hardcoded "bash". Believe it or not, there
> are boxes that lack it, and there are people who prefer other shells for
> their interactive work. At the very least, invoke "$SHELL_PATH" instead of
> bash there, perhaps?

Sure, I changed that in this version and explained it in the commit
message.

> If we wanted to allow an ad-hoc debugging of test scripts to sprinkle
> "test_pause $cmd", we might need to do something like:
> 
>> +test_pause () {
>> +	if test "$verbose" = t; then
>> +		bash <&6 >&3 2>&4
> 		${1-"$SHELL_PATH"} <&6 >&3 2>&4
>> +	else
>> +		error >&5 "test_pause requires --verbose"
>> +	fi
>> +}
> 
> but I do not think that is worth it. The debugging developer should easily
> be able to run gdb or whatever from the interactive shell you are giving
> here.

That's what I always do, so I'm fine with what this patch provides. And
now the fact that you can temporarily pause a test and explore the trash
directory is documented too ;-)


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
index a65dfc7..709a300 100644
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
+		"$SHELL_PATH" <&6 >&3 2>&4
+	else
+		error >&5 "test_pause requires --verbose"
+	fi
+}
+
 # Call test_commit with the arguments "<message> [<file> [<contents>]]"
 #
 # This will commit a file with the given contents and the given commit
-- 
1.7.9.rc1.1.g8dae2
