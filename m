From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] test-parse-options: hold output in a strbuf
Date: Thu,  5 May 2016 14:50:55 -0700
Message-ID: <20160505215056.28224-3-gitster@pobox.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
 <20160505215056.28224-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 23:51:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayRAx-0001w1-8p
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929AbcEEVvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:51:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757887AbcEEVvD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:51:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 782D819505;
	Thu,  5 May 2016 17:51:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=XFCD
	f8zmSwnfaGRsXBXfJ/su3Q0=; b=RSRgXjaZv2q114QDQcvcubNxLxhTrlVZNIZG
	C0P1cr90CtWe/58/VMqHAtZqa7JtMZB0myG4Il8SEMPl5UJuvMVD7y+Q+LmJeP1Y
	Yr5gj07f7yMHS9cQdgqOp7lgP22oAGrMMkSTuoFm2VDfT3JKJgQUIK8c3N76YIlI
	E/Ipwgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=k1QNb9
	IJbNB7IqbXJd50yDjP2FSPOCa+yWDqbVCD+kY/fDL5yQmsu3KSeJ88+xtkYnMgkl
	bTxZQzCqMxyQEaYkkFnlsFtmjMTd7Jqh0AJgzJMG+jnrKGp2Lhk/50Qisn2VmtNE
	px0CHnCcqi78WZDvaDguf6lJPvSSs+5QV4oEg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6EBAA19504;
	Thu,  5 May 2016 17:51:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E613019503;
	Thu,  5 May 2016 17:51:01 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-505-gdbd0e1d
In-Reply-To: <20160505215056.28224-1-gitster@pobox.com>
X-Pobox-Relay-ID: 75939704-130B-11E6-B11F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293708>

In this step, all the output is held in a strbuf and unconditionally
dumped at the end, so there is no behaviour change (other than that
the processing may be a bit slower, now we do the buffering stdio
has been doing for us).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 test-parse-options.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/test-parse-options.c b/test-parse-options.c
index b5f4e90..3db4332 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "strbuf.h"
 
 static int boolean = 0;
 static int integer = 0;
@@ -89,31 +90,34 @@ int main(int argc, char **argv)
 		OPT_END(),
 	};
 	int i;
+	struct strbuf output = STRBUF_INIT;
 
 	argc = parse_options(argc, (const char **)argv, prefix, options, usage, 0);
 
 	if (length_cb.called) {
 		const char *arg = length_cb.arg;
 		int unset = length_cb.unset;
-		printf("Callback: \"%s\", %d\n",
+		strbuf_addf(&output, "Callback: \"%s\", %d\n",
 		       (arg ? arg : "not set"), unset);
 	}
-	printf("boolean: %d\n", boolean);
-	printf("integer: %d\n", integer);
-	printf("magnitude: %lu\n", magnitude);
-	printf("timestamp: %lu\n", timestamp);
-	printf("string: %s\n", string ? string : "(not set)");
-	printf("abbrev: %d\n", abbrev);
-	printf("verbose: %d\n", verbose);
-	printf("quiet: %d\n", quiet);
-	printf("dry run: %s\n", dry_run ? "yes" : "no");
-	printf("file: %s\n", file ? file : "(not set)");
+	strbuf_addf(&output, "boolean: %d\n", boolean);
+	strbuf_addf(&output, "integer: %d\n", integer);
+	strbuf_addf(&output, "magnitude: %lu\n", magnitude);
+	strbuf_addf(&output, "timestamp: %lu\n", timestamp);
+	strbuf_addf(&output, "string: %s\n", string ? string : "(not set)");
+	strbuf_addf(&output, "abbrev: %d\n", abbrev);
+	strbuf_addf(&output, "verbose: %d\n", verbose);
+	strbuf_addf(&output, "quiet: %d\n", quiet);
+	strbuf_addf(&output, "dry run: %s\n", dry_run ? "yes" : "no");
+	strbuf_addf(&output, "file: %s\n", file ? file : "(not set)");
 
 	for (i = 0; i < list.nr; i++)
-		printf("list: %s\n", list.items[i].string);
+		strbuf_addf(&output, "list: %s\n", list.items[i].string);
 
 	for (i = 0; i < argc; i++)
-		printf("arg %02d: %s\n", i, argv[i]);
+		strbuf_addf(&output, "arg %02d: %s\n", i, argv[i]);
+
+	printf("%s", output.buf);
 
 	return 0;
 }
-- 
2.8.2-505-gdbd0e1d
