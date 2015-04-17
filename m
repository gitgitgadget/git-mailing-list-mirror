From: Jeff King <peff@peff.net>
Subject: [PATCH] type_from_string_gently: make sure length matches
Date: Fri, 17 Apr 2015 10:52:48 -0400
Message-ID: <20150417145247.GA2421@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 17 16:52:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj7dZ-0000uS-1V
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 16:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbbDQOwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 10:52:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:46727 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965085AbbDQOwv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 10:52:51 -0400
Received: (qmail 4210 invoked by uid 102); 17 Apr 2015 14:52:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 09:52:50 -0500
Received: (qmail 2576 invoked by uid 107); 17 Apr 2015 14:53:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 10:53:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 10:52:48 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267360>

When commit fe8e3b7 refactored type_from_string to allow
input that was not NUL-terminated, it switched to using
strncmp instead of strcmp. But this means we check only the
first "len" bytes of the strings, and ignore any remaining
bytes in the object_type_string. We should make sure that it
is also "len" bytes, or else we would accept "comm" as
"commit", and so forth.

Signed-off-by: Jeff King <peff@peff.net>
---
Since the strings we are matching are literals, we could also record
their sizes in the object_type_strings array and check the length first
before even calling strncmp. I doubt this is a performance hot-spot,
though.

You could also potentially just use strlen(object_type_strings[i]), but
I'm not sure if compilers will optimize out the strlen in this case,
since it is in a loop.

 object.c               | 3 ++-
 t/t1007-hash-object.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/object.c b/object.c
index 23d6c96..980ac5f 100644
--- a/object.c
+++ b/object.c
@@ -41,7 +41,8 @@ int type_from_string_gently(const char *str, ssize_t len, int gentle)
 		len = strlen(str);
 
 	for (i = 1; i < ARRAY_SIZE(object_type_strings); i++)
-		if (!strncmp(str, object_type_strings[i], len))
+		if (!strncmp(str, object_type_strings[i], len) &&
+		    object_type_strings[i][len] == '\0')
 			return i;
 
 	if (gentle)
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index f83df8e..ebb3a69 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -201,4 +201,12 @@ test_expect_success 'corrupt tag' '
 	test_must_fail git hash-object -t tag --stdin </dev/null
 '
 
+test_expect_success 'hash-object complains about bogus type name' '
+	test_must_fail git hash-object -t bogus --stdin </dev/null
+'
+
+test_expect_success 'hash-object complains about truncated type name' '
+	test_must_fail git hash-object -t bl --stdin </dev/null
+'
+
 test_done
-- 
2.4.0.rc2.384.g7297a4a
