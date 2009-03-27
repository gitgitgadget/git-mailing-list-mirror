From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: [PATCH v2 2/2] Documentation/Makefile: break up texi pipeline
Date: Fri, 27 Mar 2009 01:49:39 -0500
Message-ID: <1238136579-23166-2-git-send-email-chris_johnsen@pobox.com>
References: <1238136579-23166-1-git-send-email-chris_johnsen@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Chris Johnsen <chris_johnsen@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 27 07:51:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ln5uU-0000bb-3x
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 07:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbZC0Gtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 02:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZC0Gtu
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 02:49:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbZC0Gtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 02:49:49 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0FA5DA5453;
	Fri, 27 Mar 2009 02:49:48 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.43.147]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id
 52F28A5450; Fri, 27 Mar 2009 02:49:41 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.401.gc048
In-Reply-To: <1238136579-23166-1-git-send-email-chris_johnsen@pobox.com>
X-Pobox-Relay-ID: 76A3CB02-1A9B-11DE-99B2-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114863>

Most shells define the exit value of a pipeline as the exit value
of the last process. For each texi rule, run the DOCBOOK2X_TEXI
tool and the "fixup" script in their own non-pipeline commands so
that make will notice an error exit code.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>

---

Change since "v1": Fix incompletely introduced, "&& chain" in
  gitman.texi rule.

This textually depends on my "quiet doc gen" patch as it modifies
a couple of the same lines.
---
 Documentation/Makefile |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3e1d175..d145372 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -178,7 +178,7 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 
 clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
-	$(RM) *.texi *.texi+ git.info gitman.info
+	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/api-*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
@@ -221,8 +221,9 @@ git.info: user-manual.texi
 
 user-manual.texi: user-manual.xml
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout | \
-		$(PERL_PATH) fix-texi.perl >$@+ && \
+	$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
+	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
+	rm $@++ && \
 	mv $@+ $@
 
 user-manual.pdf: user-manual.xml
@@ -233,7 +234,9 @@ user-manual.pdf: user-manual.xml
 gitman.texi: $(MAN_XML) cat-texi.perl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-		--to-stdout $(xml) &&) true) | $(PERL_PATH) cat-texi.perl $@ >$@+ && \
+		--to-stdout $(xml) &&) true) > $@++ && \
+	$(PERL_PATH) cat-texi.perl $@ <$@++ >$@+ && \
+	rm $@++ && \
 	mv $@+ $@
 
 gitman.info: gitman.texi
-- 
1.6.2.1.401.gc048
