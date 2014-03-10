From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 11/26] update-ref --stdin: Improve error messages for invalid values
Date: Mon, 10 Mar 2014 13:46:28 +0100
Message-ID: <1394455603-2968-12-git-send-email-mhagger@alum.mit.edu>
References: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:47:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMzc0-0007QZ-K5
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 13:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbaCJMrP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 08:47:15 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57594 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753551AbaCJMrL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 08:47:11 -0400
X-AuditID: 1207440d-f79d86d0000043db-59-531db44eb323
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 5A.47.17371.E44BD135; Mon, 10 Mar 2014 08:47:10 -0400 (EDT)
Received: from michael.fritz.box (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2ACkjwZ025479
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 08:47:09 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394455603-2968-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqOu3RTbYYPNWY4ud6yQsuq50M1k0
	9F5htph3dxeTxe0V85ktfrT0MFt87FzA7MDu8ff9ByaPnbPusntcevmdzePjs+XsHs969zB6
	XLyk7PF5k1wAexS3TVJiSVlwZnqevl0Cd8aNizMZC15qVsz7fpulgXGjUhcjJ4eEgInErP4F
	LBC2mMSFe+vZuhi5OIQELjNKXG66yQjhnGCSePSijxGkik1AV2JRTzMTiC0ioCYxse0QC0gR
	s8AVRonPX3+xdzFycAgLhEh8vFoEUsMioCoxsfcv2AZeAReJIyvfMEJsk5OY8nsBO4jNCRSf
	fuUBmC0k4Czxck8z6wRG3gWMDKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdI30cjNL9FJTSjcx
	QkKPdwfj/3UyhxgFOBiVeHgPvJUJFmJNLCuuzD3EKMnBpCTKO3GtbLAQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEd7MxUA53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE
	b/1moEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UGzEFwOjAyTFA7R3G0g7b3FB
	Yi5QFKL1FKOilDjvHJCEAEgiozQPbiwsobxiFAf6Upi3FaSKB5iM4LpfAQ1mAhrcfFwKZHBJ
	IkJKqoExdhnvxadqW5brCTs9eSc6xz3f/XOCyz1uBqHaEwyvI1utEpQ+fLjofkNiYnHXi9jE
	zjucbRwx91g9tXsczfvONs59cc5yy8w3p/SlfZac3ve2rZhZZPv21NQ3D5XlXuUe 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243737>

If an invalid value is passed to "update-ref --stdin" as <oldvalue> or
<newvalue>, include the command and the name of the reference at the
beginning of the error message.  Update the tests accordingly.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 24 +++++++++++++-----------
 t/t1400-update-ref.sh |  8 ++++----
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0dc2061..13a884a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -35,20 +35,22 @@ static struct ref_update *update_alloc(void)
 	return update;
 }
 
-static void update_store_new_sha1(struct ref_update *update,
+static void update_store_new_sha1(const char *command,
+				  struct ref_update *update,
 				  const char *newvalue)
 {
 	if (*newvalue && get_sha1(newvalue, update->new_sha1))
-		die("invalid new value for ref %s: %s",
-		    update->ref_name, newvalue);
+		die("%s %s: invalid new value: %s",
+		    command, update->ref_name, newvalue);
 }
 
-static void update_store_old_sha1(struct ref_update *update,
+static void update_store_old_sha1(const char *command,
+				  struct ref_update *update,
 				  const char *oldvalue)
 {
 	if (*oldvalue && get_sha1(oldvalue, update->old_sha1))
-		die("invalid old value for ref %s: %s",
-		    update->ref_name, oldvalue);
+		die("%s %s: invalid old value: %s",
+		    command, update->ref_name, oldvalue);
 
 	/* We have an old value if non-empty, or if empty without -z */
 	update->have_old = *oldvalue || line_termination;
@@ -165,12 +167,12 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
 		die("update line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1(update, newvalue.buf);
+		update_store_new_sha1("update", update, newvalue.buf);
 	else
 		die("update %s missing <newvalue>", update->ref_name);
 
 	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1(update, oldvalue.buf);
+		update_store_old_sha1("update", update, oldvalue.buf);
 		if (*next != line_termination)
 			die("update %s has extra input: %s", update->ref_name, next);
 	} else if (!line_termination)
@@ -191,7 +193,7 @@ static const char *parse_cmd_create(struct strbuf *input, const char *next)
 		die("create line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &newvalue))
-		update_store_new_sha1(update, newvalue.buf);
+		update_store_new_sha1("create", update, newvalue.buf);
 	else
 		die("create %s missing <newvalue>", update->ref_name);
 
@@ -216,7 +218,7 @@ static const char *parse_cmd_delete(struct strbuf *input, const char *next)
 		die("delete line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &oldvalue)) {
-		update_store_old_sha1(update, oldvalue.buf);
+		update_store_old_sha1("delete", update, oldvalue.buf);
 		if (update->have_old && is_null_sha1(update->old_sha1))
 			die("delete %s given zero old value", update->ref_name);
 	} else if (!line_termination)
@@ -240,7 +242,7 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
 		die("verify line missing <ref>");
 
 	if (!parse_next_arg(input, &next, &value)) {
-		update_store_old_sha1(update, value.buf);
+		update_store_old_sha1("verify", update, value.buf);
 		hashcpy(update->new_sha1, update->old_sha1);
 	} else if (!line_termination)
 		die("verify %s missing [<oldvalue>] NUL", update->ref_name);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 627aaaf..c5be870 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -518,14 +518,14 @@ test_expect_success 'stdin update ref fails with wrong old value' '
 test_expect_success 'stdin update ref fails with bad old value' '
 	echo "update $c $m does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	grep "fatal: update $c: invalid old value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin create ref fails with bad new value' '
 	echo "create $c does-not-exist" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
+	grep "fatal: create $c: invalid new value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
@@ -840,14 +840,14 @@ test_expect_success 'stdin -z update ref fails with wrong old value' '
 test_expect_success 'stdin -z update ref fails with bad old value' '
 	printf $F "update $c" "$m" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid old value for ref $c: does-not-exist" err &&
+	grep "fatal: update $c: invalid old value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
 test_expect_success 'stdin -z create ref fails with bad new value' '
 	printf $F "create $c" "does-not-exist" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: invalid new value for ref $c: does-not-exist" err &&
+	grep "fatal: create $c: invalid new value: does-not-exist" err &&
 	test_must_fail git rev-parse --verify -q $c
 '
 
-- 
1.9.0
