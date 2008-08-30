From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/12] rerere: understand "diff3 -m" style conflicts with the
 original
Date: Fri, 29 Aug 2008 17:42:37 -0700
Message-ID: <1220056963-2352-7-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <1220056963-2352-5-git-send-email-gitster@pobox.com>
 <1220056963-2352-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZt-00076v-Nx
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbYH3AnH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYH3AnG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:43:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41146 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbYH3AnD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:43:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3073A57A09
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8902957A08 for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:01
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 99CB709E-762C-11DD-A761-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94345>

This teaches rerere to grok conflicts expressed in "diff3 -m" style
output, where the version from the common ancestor is output after the
first side, preceded by a "|||||||" line.

The rerere database needs to keep only the versions from two sides, so the
code parses the original copy and discards it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rerere.c b/rerere.c
index bf74b26..4e2c9dd 100644
--- a/rerere.c
+++ b/rerere.c
@@ -77,7 +77,7 @@ static int handle_file(const char *path,
 	char buf[1024];
 	int hunk_no = 0;
 	enum {
-		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2,
+		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL,
 	} hunk = RR_CONTEXT;
 	struct strbuf one, two;
 	FILE *f = fopen(path, "r");
@@ -104,9 +104,13 @@ static int handle_file(const char *path,
 			if (hunk != RR_CONTEXT)
 				goto bad;
 			hunk = RR_SIDE_1;
-		} else if (!prefixcmp(buf, "=======") && isspace(buf[7])) {
+		} else if (!prefixcmp(buf, "|||||||") && isspace(buf[7])) {
 			if (hunk != RR_SIDE_1)
 				goto bad;
+			hunk = RR_ORIGINAL;
+		} else if (!prefixcmp(buf, "=======") && isspace(buf[7])) {
+			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
+				goto bad;
 			hunk = RR_SIDE_2;
 		} else if (!prefixcmp(buf, ">>>>>>> ")) {
 			if (hunk != RR_SIDE_2)
@@ -132,6 +136,8 @@ static int handle_file(const char *path,
 			strbuf_reset(&two);
 		} else if (hunk == RR_SIDE_1)
 			strbuf_addstr(&one, buf);
+		else if (hunk == RR_ORIGINAL)
+			; /* discard */
 		else if (hunk == RR_SIDE_2)
 			strbuf_addstr(&two, buf);
 		else if (out)
-- 
1.6.0.1.149.ga4c44
