From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH 2/2] Documentation/Makefile: break up texi pipeline
Date: Tue, 24 Mar 2009 23:21:40 -0500
Message-ID: <1237954900-21161-2-git-send-email-chris_johnsen@pobox.com>
References: <20090324091836.GD1799@coredump.intra.peff.net>
 <1237954900-21161-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, Chris Johnsen <chris_johnsen@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 05:24:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmKfE-0006CG-UN
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 05:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbZCYEWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 00:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbZCYEWA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 00:22:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35398 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZCYEV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 00:21:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C08DE9C21;
	Wed, 25 Mar 2009 00:21:57 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 324989C20; Wed, 25 Mar 2009 00:21:54 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.315.g33192
In-Reply-To: <1237954900-21161-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 7AB7AA5E-18F4-11DE-9DA8-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114558>

Most shells define the exit value of a pipeline as the exit value
of the last process. For each texi rule, run the DOCBOOK2X_TEXI
tool and the "fixup" script in their own non-pipeline commands so
that make will notice an error exit code.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

This textually depends on my "quiet doc gen" patch as it modifies
a couple of the same lines.
---
 Documentation/Makefile |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3f9bc01..372a2cc 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -177,7 +177,7 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 
 clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
-	$(RM) *.texi *.texi+ git.info gitman.info
+	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/api-*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
@@ -220,8 +220,9 @@ git.info: user-manual.texi
 
 user-manual.texi: user-manual.xml
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout | \
-		$(PERL_PATH) fix-texi.perl >$@+ && \
+	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
+	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
+	rm $@++ && \
 	mv $@+ $@
 
 user-manual.pdf: user-manual.xml
@@ -232,7 +233,9 @@ user-manual.pdf: user-manual.xml
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-		--to-stdout $(xml);)) | $(PERL_PATH) cat-texi.perl $@ >$@+ && \
+		--to-stdout $(xml) &&) true) > $@++
+	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+ && \
+	rm $@++ && \
 	mv $@+ $@
 
 gitman.info: gitman.texi
-- 
1.6.2.1.315.g33192
