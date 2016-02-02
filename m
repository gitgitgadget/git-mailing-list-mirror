From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] git: remove an early return from save_env_before_alias()
Date: Tue, 02 Feb 2016 15:47:26 -0800
Message-ID: <xmqqvb66ptdd.fsf_-_@gitster.mtv.corp.google.com>
References: <56A72235.9080602@drmicha.warpmail.net>
	<1453814801-1925-1-git-send-email-pclouds@gmail.com>
	<xmqq60ygcd9a.fsf@gitster.mtv.corp.google.com>
	<xmqqbn87a54v.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DzHYpw3TT3i17W-8eiR9J9DOQUO6mkxffUEnGqT1u96Q@mail.gmail.com>
	<xmqqtwlz8c4w.fsf@gitster.mtv.corp.google.com>
	<xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 00:47:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQkfl-0008PK-R2
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 00:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbcBBXra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 18:47:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63234 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099AbcBBXr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 18:47:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C1904198B;
	Tue,  2 Feb 2016 18:47:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lMPCxSKrzUhqmKvt1bFafajWuR4=; b=bvbyGJ
	0AcAgdJBu2Tmg4+4siCVDgoXun6Ei2alMrlP8/tB4U/03xwJE4ilH7IF2bLTkMhp
	ppAPLcT3uAngBNWgXNwdEPyqpapSr7mDG3JMzCAdUN5KCYk5s/VUSk5/IjCcDEl9
	274Ghf7xazRAD0N7OVed1RksWNgw0kVFO4T00=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tSRX6+PrZotKZeXMedCtC5IJKJnv1T7b
	9gBdb8Tz2oKv5nzZZAwqoaLpgmkDIiCdmIm/uzJXwMfVBZ7rkol7Aa/ORJScundA
	knggN2U13e178h9hvmcedOJDuWQZBGzvct3WPeo8n5NLu7X75hBk8SHUzpfRU6Rx
	b4dZ7i5TqiQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6173F4198A;
	Tue,  2 Feb 2016 18:47:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C858041989;
	Tue,  2 Feb 2016 18:47:27 -0500 (EST)
In-Reply-To: <xmqqy4ba627n.fsf_-_@gitster.mtv.corp.google.com> (Junio
	C. Hamano's message of "Wed, 27 Jan 2016 15:18:36 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51116A84-CA07-11E5-A6F0-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285316>

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

 * For another review round before deciding what to write in the
   upcoming "What's cooking" report.

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
2.7.0-391-gcd29568
