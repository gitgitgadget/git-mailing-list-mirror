From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/27] parse_arg(): Really test that argument is properly terminated
Date: Mon, 24 Mar 2014 18:56:36 +0100
Message-ID: <1395683820-17304-4-git-send-email-mhagger@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 18:57:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS985-00018N-Cz
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbaCXR5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:57:18 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:51430 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753729AbaCXR5Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 13:57:16 -0400
X-AuditID: 1207440f-f79326d000003c9f-69-533071fb787f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id E3.93.15519.BF170335; Mon, 24 Mar 2014 13:57:15 -0400 (EDT)
Received: from michael.fritz.box (p57A25F6C.dip0.t-ipconnect.de [87.162.95.108])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2OHv4xZ028070
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 24 Mar 2014 13:57:14 -0400
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsUixO6iqPu70CDYYGuLhcXOdRIWXVe6mSwa
	eq8wW8y7u4vJ4vaK+cwWP1p6mC0+di5gdmD3+Pv+A5PHzll32T0uvfzO5vHx2XJ2j2e9exg9
	Ll5S9vi8SS6APYrbJimxpCw4Mz1P3y6BO6Pz7hTmgqXCFdum/GBqYLzJ38XIySEhYCLxcuMJ
	JghbTOLCvfVsXYxcHEIClxklNl+8zQjhnGCSuPF0BzNIFZuArsSinmawDhEBNYmJbYdYQIqY
	Ba4wSlz5uJ0FJCEsEC5x/PktoG4ODhYBVYkjiwJAwrwCLhKv9+5lhtgmJzHl9wJ2EJtTwFVi
	a/thsLgQUM2Oj71MExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdHLzSzRS00p3cQI
	CT3+HYxd62UOMQpwMCrx8EYYGwQLsSaWFVfmHmKU5GBSEuVlywUK8SXlp1RmJBZnxBeV5qQW
	H2KU4GBWEuG1DAfK8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeKWB
	MSYkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICkeID2OoC08xYXJOYC
	RSFaTzEqSonzXisASgiAJDJK8+DGwhLKK0ZxoC+FedVA2nmAyQiu+xXQYCagweFNeiCDSxIR
	UlINjOr7fYrnlH+NSJE5bL71+/TPc9iCWdrqbgnxhXFs27teldXBc1OF16nY0tsbxML2Pbxy
	8y/nhWdS/ts6xAQ4vNe9dNh84LWUz6z3TuctlgRJmefc5o3cV+envTj/Vp+ZlNLV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244832>

Test that the argument is properly terminated by either whitespace or
a NUL character, even if it is quoted, to be consistent with the
non-quoted case.  Adjust the tests to expect the new error message.
Add a docstring to the function, incorporating the comments that were
formerly within the function plus some added information.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/update-ref.c  | 20 +++++++++++++++-----
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1292cfe..02b5f95 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -62,16 +62,26 @@ static void update_store_old_sha1(struct ref_update *update,
 	update->have_old = *oldvalue || line_termination;
 }
 
+/*
+ * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
+ * and append the result to arg.  Return a pointer to the terminator.
+ * Die if there is an error in how the argument is C-quoted.  This
+ * function is only used if not -z.
+ */
 static const char *parse_arg(const char *next, struct strbuf *arg)
 {
-	/* Parse SP-terminated, possibly C-quoted argument */
-	if (*next != '"')
+	if (*next == '"') {
+		const char *orig = next;
+
+		if (unquote_c_style(arg, next, &next))
+			die("badly quoted argument: %s", orig);
+		if (*next && !isspace(*next))
+			die("unexpected character after quoted argument: %s", orig);
+	} else {
 		while (*next && !isspace(*next))
 			strbuf_addch(arg, *next++);
-	else if (unquote_c_style(arg, next, &next))
-		die("badly quoted argument: %s", next);
+	}
 
-	/* Return position after the argument */
 	return next;
 }
 
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 29391c6..774f8c5 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -356,10 +356,10 @@ test_expect_success 'stdin fails on badly quoted input' '
 	grep "fatal: badly quoted argument: \\\"master" err
 '
 
-test_expect_success 'stdin fails on arguments not separated by space' '
+test_expect_success 'stdin fails on junk after quoted argument' '
 	echo "create \"$a\"master" >stdin &&
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: expected SP but got: master" err
+	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"master" err
 '
 
 test_expect_success 'stdin fails create with no ref' '
-- 
1.9.0
