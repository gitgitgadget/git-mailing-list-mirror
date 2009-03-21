From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] check-ref-format --branch: give Porcelain a way to grok
 branch shorthand
Date: Sat, 21 Mar 2009 15:13:35 -0700
Message-ID: <1237673619-12608-4-git-send-email-gitster@pobox.com>
References: <1237673619-12608-1-git-send-email-gitster@pobox.com>
 <1237673619-12608-2-git-send-email-gitster@pobox.com>
 <1237673619-12608-3-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 21 23:16:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ll9U5-0007f9-I5
	for gcvg-git-2@gmane.org; Sat, 21 Mar 2009 23:16:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbZCUWNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 18:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbZCUWNw
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 18:13:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856AbZCUWNt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2009 18:13:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D8D1F8394
	for <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 76E088393 for
 <git@vger.kernel.org>; Sat, 21 Mar 2009 18:13:47 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.299.gda643a
In-Reply-To: <1237673619-12608-3-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8CE17CE6-1665-11DE-A66F-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114080>

The command may not be the best place to add this new feature, but

    $ git check-ref-format --branch "@{-1}"

allows Porcelains to figure out what branch you were on before the last
branch switching.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-check-ref-format.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index 701de43..39db6cb 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -5,9 +5,19 @@
 #include "cache.h"
 #include "refs.h"
 #include "builtin.h"
+#include "strbuf.h"
 
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
+	if (argc == 3 && !strcmp(argv[1], "--branch")) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_branchname(&sb, argv[2]);
+		strbuf_splice(&sb, 0, 0, "refs/heads/", 11);
+		if (check_ref_format(sb.buf))
+			die("'%s' is not a valid branch name", argv[2]);
+		printf("%s\n", sb.buf + 11);
+		exit(0);
+	}
 	if (argc != 2)
 		usage("git check-ref-format refname");
 	return !!check_ref_format(argv[1]);
-- 
1.6.2.1.299.gda643a
