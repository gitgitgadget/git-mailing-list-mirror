From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/27] parse_arg(): really test that argument is properly terminated
Date: Mon,  7 Apr 2014 15:47:54 +0200
Message-ID: <1396878498-19887-4-git-send-email-mhagger@alum.mit.edu>
References: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 15:48:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX9uf-0002Rp-1A
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 15:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbaDGNsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 09:48:33 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44163 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755333AbaDGNsa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2014 09:48:30 -0400
X-AuditID: 12074413-f79076d000002d17-01-5342acadeb79
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id AB.78.11543.DACA2435; Mon,  7 Apr 2014 09:48:29 -0400 (EDT)
Received: from michael.fritz.box (p5B156B1D.dip0.t-ipconnect.de [91.21.107.29])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s37DmJaA026029
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 7 Apr 2014 09:48:27 -0400
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396878498-19887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLt2jVOwwabLWhY710lYdF3pZrJo
	6L3CbDHv7i4mi9sr5jNb/GjpYbb42LmA2YHd4+/7D0weO2fdZfe49PI7m8fHZ8vZPZ717mH0
	uHhJ2ePzJrkA9ihum6TEkrLgzPQ8fbsE7owLayYzFryRqLjZNIutgXG6SBcjJ4eEgInE4lV3
	WSFsMYkL99azdTFycQgJXGaUaLxynhnCOcYk8e7/EUaQKjYBXYlFPc1MILaIgJrExLZDLCBF
	zAJXGCWufNzOApIQFgiX2HapF2wsi4CqxLIfHWwgNq+Ai8TzJbeYINbJSZw8NhmshlPAVWLG
	oVtgC4SAau6vOcYygZF3ASPDKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ
	4BPewbjrpNwhRgEORiUe3pWHHIOFWBPLiitzDzFKcjApifI+X+YULMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEl2s1UI43JbGyKrUoHyYlzcGiJM6rtkTdT0ggPbEkNTs1tSC1CCYrw8GhJMHb
	CNIoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qO+GJgfICkeID2zgXbW1yQmAsU
	hWg9xagoJc5bApIQAElklObBjYWllFeM4kBfCvM+B6niAaYjuO5XQIOZgAYbuoINLklESEk1
	MOrcMnD8XhyYvHS7hvYX+0kL1z3vO3/o+Catn34vzRtEBVf/iFq7on36JuMrtiqCdb+9Cmf+
	mGYQuSH+WkRAPuvv5COTtf+7LW9w/2m58IhP/bOZJU+WrXv98dzx1Ar/cJ59R6Yz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245837>

The old parse_arg(), when fed an argument

    "refs/heads/a"master

parsed 'refs/heads/a' off of the front of the argument and considered
itself successful.  It was only when parse_next_arg() tried to parse
the *next* argument that a problem was noticed.  But in fact, the
definition of the input format requires arguments to be terminated by
SP or NUL, so *this* argument is already erroneous and parse_arg()
should diagnose the problem.

So teach parse_arg() to verify that C-quoted arguments are terminated
correctly.  If not, emit a more specific error message.

There is no corresponding error case of a non-C-quoted argument that
is not terminated correctly, because the end of a non-quoted argument
is *by definition* a space or NUL, so there is no way to insert other
junk between the "end" of the argument and the argument terminator.

Adjust the tests to expect the new error message.  Add a docstring to
the function, incorporating the comments that were formerly within the
function plus some added information.

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
1.9.1
