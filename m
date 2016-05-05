From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] test-parse-options: fix output when callback option fails
Date: Thu,  5 May 2016 14:50:54 -0700
Message-ID: <20160505215056.28224-2-gitster@pobox.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
 <20160505215056.28224-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 23:51:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRAw-0001w1-5d
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924AbcEEVvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:51:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755959AbcEEVvB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:51:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 495DF18843;
	Thu,  5 May 2016 17:51:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=GN8P
	9Q7426800zURN9u03TAii84=; b=fH5Gms7JhDzFYYdmsc9MpwZz90EHHGg8OBBY
	o4VWUL2mhJxL/W3Z1HDBT+Pc2dmcOd7jmyTfirRlRZBevzkl496uE1/j6Zx0Zf1Q
	+8V23O9SnlXmplL90+PJee/GGU/Lg/e8Z3nZ89pKaAZJ4kK5TCCU+tMv8I8p6eQk
	cnjo0AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Rj5vIa
	rvS5+rtOCkY7DxpymXzncWXjRl+46tG9JJxnZ5Mzx2x5FsmcFpoJzQdvWiNH3APT
	AFtRnPrfSUzFZIk7CxJL/1djColkSHf1Ug7qDTwwAixyBynrqKzeZwU1NWc5ZECn
	iAejmNWBuAOitK9JN5J0zFj0CNQUD5gCW1tKw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40A7918842;
	Thu,  5 May 2016 17:51:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD19518841;
	Thu,  5 May 2016 17:50:59 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-505-gdbd0e1d
In-Reply-To: <20160505215056.28224-1-gitster@pobox.com>
X-Pobox-Relay-ID: 743E707C-130B-11E6-A0D6-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293707>

When test-parse-options detects an error on the command line, it
gives the usage string just like any parse-options API users do,
without showing any "variable dump".  An exception is the callback
test, where a "variable dump" for the option is done before the
command line options are fully parsed.

Do not expose this implementation detail by separating the handling
of callback test into two phases, one to capture the fact that an
option was given during the option parsing phase, and the other to
show that fact as a part of normal "variable dump".

The effect of this fix is seen in the patch to t/t0040 where it
tried "test-parse-options --no-length" where "--length" is a callback
that does not take a negative form.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0040-parse-options.sh |  4 +---
 test-parse-options.c     | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index fec3fef..dbaee55 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -356,9 +356,7 @@ test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
 	test_cmp expect output
 '
 
-cat >expect <<\EOF
-Callback: "not set", 1
-EOF
+>expect
 
 test_expect_success 'OPT_CALLBACK() and callback errors work' '
 	test_must_fail test-parse-options --no-length >output 2>output.err &&
diff --git a/test-parse-options.c b/test-parse-options.c
index f02c275..b5f4e90 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -14,10 +14,18 @@ static char *file = NULL;
 static int ambiguous;
 static struct string_list list;
 
+static struct {
+	int called;
+	const char *arg;
+	int unset;
+} length_cb;
+
 static int length_callback(const struct option *opt, const char *arg, int unset)
 {
-	printf("Callback: \"%s\", %d\n",
-		(arg ? arg : "not set"), unset);
+	length_cb.called = 1;
+	length_cb.arg = arg;
+	length_cb.unset = unset;
+
 	if (unset)
 		return 1; /* do not support unset */
 
@@ -84,6 +92,12 @@ int main(int argc, char **argv)
 
 	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
 
+	if (length_cb.called) {
+		const char *arg = length_cb.arg;
+		int unset = length_cb.unset;
+		printf("Callback: \"%s\", %d\n",
+		       (arg ? arg : "not set"), unset);
+	}
 	printf("boolean: %d\n", boolean);
 	printf("integer: %d\n", integer);
 	printf("magnitude: %lu\n", magnitude);
-- 
2.8.2-505-gdbd0e1d
