From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] for_each_reflog_ent(): extract a helper to process a
 single entry
Date: Fri,  8 Mar 2013 13:53:42 -0800
Message-ID: <1362779624-15513-2-git-send-email-gitster@pobox.com>
References: <1362779624-15513-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 22:54:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UE5F8-0000MP-Ct
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 22:54:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab3CHVxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 16:53:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53811 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab3CHVxt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 16:53:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9578B4BF
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Qcg5
	p0UZYDk30IwheGsccYqSL+I=; b=Bg0t5RowgcUYWr9pUcusO0gwQ4GSz1hzQHgn
	rAzPjwnpyodDrI2uC2aC7bFB1FHV51xnLqjoCD6xSueBXBZDovc30pE7VNzy/m8z
	WL0D82GaX6k16TaJwyE5DJ1KMCWpQfsvPP/ZfpRSfFh5723O+bVmcyexvGpV+6hN
	HpW5oMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=BsJlFr
	g1GLb5HDoZS7cSf7qpW47zHO71YQFrReIkCfUXE1CXn7kWFozEQf4iUM9XarPGKE
	6DgJjdpaBTyJO14XN6F83FdWBHbG1iDOvNxgY3137Y7tHANs+4Rwq83ha/MBMk1c
	XhAMfD0ntoQ9AUf02R4C6Ss1MiF3aI9lNmXco=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACF76B4BE
	for <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 19AE5B4BB for
 <git@vger.kernel.org>; Fri,  8 Mar 2013 16:53:48 -0500 (EST)
X-Mailer: git-send-email 1.8.2-rc3-189-g94c4d42
In-Reply-To: <1362779624-15513-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A7E99118-883A-11E2-8F29-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217688>

Split the logic that takes a single line of reflog entry in a strbuf
parses it and calls the callback function out of the loop into a
separate helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c | 59 ++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index da74a2b..9f702a7 100644
--- a/refs.c
+++ b/refs.c
@@ -2290,6 +2290,34 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 	return 1;
 }
 
+static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
+{
+	unsigned char osha1[20], nsha1[20];
+	char *email_end, *message;
+	unsigned long timestamp;
+	int tz;
+
+	/* old SP new SP name <email> SP time TAB msg LF */
+	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
+	    get_sha1_hex(sb->buf, osha1) || sb->buf[40] != ' ' ||
+	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
+	    !(email_end = strchr(sb->buf + 82, '>')) ||
+	    email_end[1] != ' ' ||
+	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
+	    !message || message[0] != ' ' ||
+	    (message[1] != '+' && message[1] != '-') ||
+	    !isdigit(message[2]) || !isdigit(message[3]) ||
+	    !isdigit(message[4]) || !isdigit(message[5]))
+		return 0; /* corrupt? */
+	email_end[1] = '\0';
+	tz = strtol(message + 1, NULL, 10);
+	if (message[6] != '\t')
+		message += 6;
+	else
+		message += 7;
+	return fn(osha1, nsha1, sb->buf + 82, timestamp, tz, message, cb_data);
+}
+
 int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long ofs, void *cb_data)
 {
 	const char *logfile;
@@ -2314,35 +2342,8 @@ int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long
 		}
 	}
 
-	while (!strbuf_getwholeline(&sb, logfp, '\n')) {
-		unsigned char osha1[20], nsha1[20];
-		char *email_end, *message;
-		unsigned long timestamp;
-		int tz;
-
-		/* old SP new SP name <email> SP time TAB msg LF */
-		if (sb.len < 83 || sb.buf[sb.len - 1] != '\n' ||
-		    get_sha1_hex(sb.buf, osha1) || sb.buf[40] != ' ' ||
-		    get_sha1_hex(sb.buf + 41, nsha1) || sb.buf[81] != ' ' ||
-		    !(email_end = strchr(sb.buf + 82, '>')) ||
-		    email_end[1] != ' ' ||
-		    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
-		    !message || message[0] != ' ' ||
-		    (message[1] != '+' && message[1] != '-') ||
-		    !isdigit(message[2]) || !isdigit(message[3]) ||
-		    !isdigit(message[4]) || !isdigit(message[5]))
-			continue; /* corrupt? */
-		email_end[1] = '\0';
-		tz = strtol(message + 1, NULL, 10);
-		if (message[6] != '\t')
-			message += 6;
-		else
-			message += 7;
-		ret = fn(osha1, nsha1, sb.buf + 82, timestamp, tz, message,
-			 cb_data);
-		if (ret)
-			break;
-	}
+	while (!ret && !strbuf_getwholeline(&sb, logfp, '\n'))
+		ret = show_one_reflog_ent(&sb, fn, cb_data);
 	fclose(logfp);
 	strbuf_release(&sb);
 	return ret;
-- 
1.8.2-rc3-189-g94c4d42
