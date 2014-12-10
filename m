From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] update-ref: fix "verify" command with missing <oldvalue>
Date: Thu, 11 Dec 2014 00:47:52 +0100
Message-ID: <1418255272-5875-3-git-send-email-mhagger@alum.mit.edu>
References: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:48:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqzJ-0008I9-TI
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758368AbaLJXsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:48:06 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:52087 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758343AbaLJXsD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 18:48:03 -0500
X-AuditID: 12074414-f797f6d000004084-5b-5488dbb2799a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 59.16.16516.2BBD8845; Wed, 10 Dec 2014 18:48:02 -0500 (EST)
Received: from michael.fritz.box (p5DDB0BBF.dip0.t-ipconnect.de [93.219.11.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBANlutA003387
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 10 Dec 2014 18:48:01 -0500
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsUixO6iqLvpdkeIQf9LJYud6yQsuq50M1k0
	9F5htnh7cwmjxe0V85ktevs+sVps3tzO4sDu8ff9ByaPnbPusnss2FTq8fHZcnaPi5eUPT5v
	kgtgi+K2SUosKQvOTM/Tt0vgzjjxdAVbwTnxio2vVzI2MPYLdzFyckgImEg8eTCPGcIWk7hw
	bz1bFyMXh5DAZUaJ/9cvQjknmCQenZwMVsUmoCuxqKeZCcQWEVCTmNh2iAWkiFngC6PE+n1/
	wBLCAr4SB9tusYLYLAKqEj9m94M18wo4S/SensfYxcgBtE5OYus6b5Awp4CLxOZ7y8FahYBK
	bi2+yT6BkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0LvdzMEr3UlNJNjJBwE9nBeOSk
	3CFGAQ5GJR7egMvtIUKsiWXFlbmHGCU5mJREeXuvd4QI8SXlp1RmJBZnxBeV5qQWH2KU4GBW
	EuFNugGU401JrKxKLcqHSUlzsCiJ835brO4nJJCeWJKanZpakFoEk5Xh4FCS4PW7BdQoWJSa
	nlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2doK08xYXJOYCRSFaTzEq
	SonzWoAkBEASGaV5cGNhSeQVozjQl8K8L0CqeIAJCK77FdBgJqDBy7eADS5JREhJNTBmH819
	pFPCxxTWdNWjyc/gb/71tQf4gp9PWmwq3Ga+MHPvOTfNJI7FZ8KPpG7acOeipDlHEN+bc/9l
	WZ/z7pzwO+X9o3VT74rsfSnp6/aW8XpmwheLE08/CH6/s+3/Z+aVJwo5XZUKixwN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261261>

If "git update-ref --stdin" was given a "verify" command with no
"<newvalue>" at all (not even zeros), the code was mistakenly setting
have_old=0 (and leaving old_sha1 uninitialized). But this is
incorrect: this command is supposed to verify that the reference
doesn't exist. So in this case we really need old_sha1 to be set to
null_sha1 and have_old to be set to 1.

Moreover, since have_old was being set to zero, *no* check of the old
value was being done, so the new value of the reference was being set
unconditionally to the value in new_sha1. new_sha1, in turn, was set
to null_sha1 in the expectation that that was the old value and it
shouldn't be changed. But because the precondition was not being
checked, the result was that the reference was being deleted
unconditionally.

So, if <oldvalue> is missing, set have_old unconditionally and set
old_sha1 to null_sha1.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 14 +++++---------
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6c9be05..1993529 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -282,26 +282,22 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 	char *refname;
 	unsigned char new_sha1[20];
 	unsigned char old_sha1[20];
-	int have_old;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
 		die("verify: missing <ref>");
 
 	if (parse_next_sha1(input, &next, old_sha1, "verify", refname,
-			    PARSE_SHA1_OLD)) {
-		hashclr(new_sha1);
-		have_old = 0;
-	} else {
-		hashcpy(new_sha1, old_sha1);
-		have_old = 1;
-	}
+			    PARSE_SHA1_OLD))
+		hashclr(old_sha1);
+
+	hashcpy(new_sha1, old_sha1);
 
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
-				   update_flags, have_old, msg, &err))
+				   update_flags, 1, msg, &err))
 		die("%s", err.buf);
 
 	update_flags = 0;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 6a3cdd1..6805b9e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -655,7 +655,7 @@ test_expect_success 'stdin verify fails for mistaken null value' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'stdin verify fails for mistaken empty value' '
+test_expect_success 'stdin verify fails for mistaken empty value' '
 	M=$(git rev-parse $m) &&
 	test_when_finished "git update-ref $m $M" &&
 	git rev-parse $m >expect &&
@@ -1020,7 +1020,7 @@ test_expect_success 'stdin -z verify fails for mistaken null value' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'stdin -z verify fails for mistaken empty value' '
+test_expect_success 'stdin -z verify fails for mistaken empty value' '
 	M=$(git rev-parse $m) &&
 	test_when_finished "git update-ref $m $M" &&
 	git rev-parse $m >expect &&
-- 
2.1.3
