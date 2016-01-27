From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] git: remove an early return from save_env_before_alias()
Date: Wed, 27 Jan 2016 15:18:36 -0800
Message-ID: <xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	<xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 00:18:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOZML-0002SL-AK
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 00:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755241AbcA0XSl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 18:18:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754465AbcA0XSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 18:18:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 97C943F175;
	Wed, 27 Jan 2016 18:18:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+/b6BE87jiihwVPLA6XHBtTrCVk=; b=G6zvDE
	DKPy7LMuViEYhl6t/anqCJOnpWZyqORulFlv2Keic+M87phL5oUx1c+sgwLAK+iV
	xIlbYwmlY/ONyt3uT+9ZCBg3y9O6XGluD9z+IoUTQq8DaTaw253aD4YuRmQBugCF
	VJSeNn546JseJoKdAGB340OBMnIq7mUzrqvhI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Na5d/HI7G6fWiOsKEsczomv0BqzP2TgM
	uYNINO+2aJ18DgRwM5kyuP2mxpMpl8KvctR/r7p7wgGiVWZH1ZZ5PQVBn8J+rRhO
	DukewITP+GOgRjN5XdIfE1bxti89RildT6+UZYsPmbQJETDxGooYp2HLdGpekpve
	EdvF4cG6QyA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F14F3F174;
	Wed, 27 Jan 2016 18:18:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0FB573F173;
	Wed, 27 Jan 2016 18:18:37 -0500 (EST)
In-Reply-To: <xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Jan 2016 04:01:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B930334-C54C-11E5-B2DF-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jan 27, 2016 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> I spoke too soon, I am afraid.
>>>> ...
>>>> I wonder if this would be better done as a multi-part series that
>>>> goes like this:
>>>> ...
>>>
>>> So here is the first of the three-patch series to replace it.
>>
>> This is much better (the whole series, not just the first patch). We
>> probably should add a test about help.autocorrect though, maybe in the
>> first patch, because it's not tested at all in the test suite.
>
> Patches welcome.  Thanks.

Here is an updated 1/3; this feature does not fit very well to any
category (it is certainly not basic, or command that is primarily
about objects or worktree; I just picked "Git tools" t9xxx as that
is the closest thing to "direct end user support").

-- >8 --
When help.autocorrect is in effect, an attempt to auto-execute an
uniquely corrected result of a misspelt alias will result in an
irrelevant error message.  The codepath that causes this calls
save_env_before_alias() and restore_env() in handle_alias(), and
that happens twice.  A global variable orig_cwd is allocated to hold
the return value of getcwd() in save_env_before_alias(), which is
then used in restore_env() to go back to that directory and finally
free(3)'d there.

However, save_env_before_alias() is not prepared to be called twice.
It returns early when it knows it has already been called, leaving
orig_cwd undefined, which is then checked in the second call to
restore_env(), and by that time, the memory that used to hold the
contents of orig_cwd is either freed or reused to hold something
else, and this is fed to chdir(2), causing it to fail.  Even if it
did not fail (i.e. reading of the already free'd piece of memory
yielded a directory path that we can chdir(2) to), it then gets
free(3)'d.

Fix this by making sure save_env() does do the saving when called.

While at it, add a minimal test for help.autocorrect facility.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.c                       |  2 --
 t/t9003-help-autocorrect.sh | 52 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 2 deletions(-)
 create mode 100755 t/t9003-help-autocorrect.sh

diff --git a/git.c b/git.c
index 98d4412..a57a4cb 100644
--- a/git.c
+++ b/git.c
@@ -30,8 +30,6 @@ static int saved_env_before_alias;
 static void save_env_before_alias(void)
 {
 	int i;
-	if (saved_env_before_alias)
-		return;
 	saved_env_before_alias = 1;
 	orig_cwd = xgetcwd();
 	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
new file mode 100755
index 0000000..dfe95c9
--- /dev/null
+++ b/t/t9003-help-autocorrect.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='help.autocorrect finding a match'
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	# An alias
+	git config alias.lgf "log --format=%s --first-parent" &&
+
+	# A random user-defined command
+	write_script git-distimdistim <<-EOF &&
+		echo distimdistim was called
+	EOF
+
+	PATH="$PATH:." &&
+	export PATH &&
+
+	git commit --allow-empty -m "a single log entry" &&
+
+	# Sanity check
+	git lgf >actual &&
+	echo "a single log entry" >expect &&
+	test_cmp expect actual &&
+
+	git distimdistim >actual &&
+	echo "distimdistim was called" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'autocorrect showing candidates' '
+	git config help.autocorrect 0 &&
+
+	test_must_fail git lfg 2>actual &&
+	sed -e "1,/^Did you mean this/d" actual | grep lgf &&
+
+	test_must_fail git distimdist 2>actual &&
+	sed -e "1,/^Did you mean this/d" actual | grep distimdistim
+'
+
+test_expect_success 'autocorrect running commands' '
+	git config help.autocorrect -1 &&
+
+	git lfg >actual &&
+	echo "a single log entry" >expect &&
+	test_cmp expect actual &&
+
+	git distimdist >actual &&
+	echo "distimdistim was called" >expect &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.7.0-368-gb6e04f9
