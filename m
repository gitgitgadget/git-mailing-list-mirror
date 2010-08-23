From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 1/2] rev-parse: exit with non-zero status if ref@{n} is not valid.
Date: Tue, 24 Aug 2010 09:11:42 +1000
Message-ID: <1282605103-8320-2-git-send-email-jon.seymour@gmail.com>
References: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 01:12:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OngBS-00056u-4P
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 01:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603Ab0HWXMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 19:12:03 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46184 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab0HWXMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 19:12:01 -0400
Received: by pwi7 with SMTP id 7so2273366pwi.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ZbCcQHWeCbWtWXz89I8ADR36NOkn/7fCdfDJib3tuu4=;
        b=nQnS/homLC2SIA0V9azgVBUd2dVOtgppJmCD8C0E7EG2i/cMkDGquEIY/aFAt5Jw5v
         KWymTFDSCmQ5Nlw4zJZeUtlLoaK6dC0GFWudzw5iZmHy3JtzDp/P3XA4SLnNIqUxyRpT
         Moqs9XUulLzLWPJIMM4c4pWMmjtYhlbCvUzIw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=p/673e9dO1cU+oXHjopWnORYWUnJ9lJinP0dWEG+WdStJUBdXR5Bd+6LVC90Hp2vuW
         CdwfafhTjWa96Az+GNdPufSkyVrdd50JWSSqxMA7KYqYtgBeIpDJn9VwlaipV7NWrjuh
         JNGW27z2W60z/n59xErlInhOpCUMUfmXV3a9c=
Received: by 10.142.128.13 with SMTP id a13mr3431306wfd.273.1282605120969;
        Mon, 23 Aug 2010 16:12:00 -0700 (PDT)
Received: from localhost.localdomain (124-169-135-9.dyn.iinet.net.au [124.169.135.9])
        by mx.google.com with ESMTPS id v13sm9081625wfv.5.2010.08.23.16.11.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 16:12:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.99.geab11
In-Reply-To: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154270>

>From Junio's e-mail:

"The current behaviour of ref@{...} syntax parser is suboptimal:

    $ git rev-parse --verify jch@{99999} && echo true
    warning: Log for 'jch' only has 1368 entries.
    cfb88e9a8d4926b0011ae2dd67e1f57a98f4b768
    true

It even knows that it is running off the cut-off point; it should just
cause the caller to notice that fact.  I don't think changing it to error
out should cause any harm to existing callers."

With this change:

   $ git rev-parse --verify jch@{99999} || echo false
   fatal: Log for 'jch' only has 1368 entries.
   false

   $ git rev-parse jch@{99999} || echo false
   fatal: Log for 'jch' only has 1368 entries.
   false

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 sha1_name.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4af94fa..d40ae48 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -342,7 +342,7 @@ static int get_sha1_1(const char *name, int len, unsigned char *sha1);
 
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
-	static const char *warning = "warning: refname '%.*s' is ambiguous.\n";
+	static const char *warn_msg = "warning: refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
 	int refs_found = 0;
 	int at, reflog_len;
@@ -390,7 +390,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		return -1;
 
 	if (warn_ambiguous_refs && refs_found > 1)
-		fprintf(stderr, warning, len, str);
+		fprintf(stderr, warn_msg, len, str);
 
 	if (reflog_len) {
 		int nth, i;
@@ -426,14 +426,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		if (read_ref_at(real_ref, at_time, nth, sha1, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (at_time)
-				fprintf(stderr,
-					"warning: Log for '%.*s' only goes "
-					"back to %s.\n", len, str,
+				warning("Log for '%.*s' only goes "
+					"back to %s.", len, str,
 					show_date(co_time, co_tz, DATE_RFC2822));
-			else
-				fprintf(stderr,
-					"warning: Log for '%.*s' only has "
-					"%d entries.\n", len, str, co_cnt);
+			else {
+				free(real_ref);
+				die("Log for '%.*s' only has %d entries.",
+						len,
+						str,
+						co_cnt);
+			}
 		}
 	}
 
-- 
1.7.2.1.99.geab11
