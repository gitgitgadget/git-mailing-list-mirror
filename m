From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 9/9] strbuf: retire strbuf_getline() for now
Date: Wed, 13 Jan 2016 19:03:10 -0800
Message-ID: <1452740590-16827-11-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYCU-0007mh-HK
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbcANDDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752909AbcANDDa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE81F3C457;
	Wed, 13 Jan 2016 22:03:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=7Mel
	fMRsgQVvo3Bs1Xav6geICDg=; b=WuXXZy2BRdfGgOdql6NGN1v1Uq3AuYDDEFIg
	zzYbS0shrEjrNidV9z2p+NagPXiCbr+JtS7w9oNCZhcWHtA1dKF5syTyz4Kn67Lp
	cxmj4IQ+/rXbnEb/mlqqa5qDsI0dDqnK7yMRDisZTm1AsPS233rZJbGsJiWRbERK
	HpzwghQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LyEiCn
	ddEa/YuYNb5kzQOTb6DURnSoRJqxBlrpOIV7XXvcTupC7SD+EumyPrhEoMjsb/Un
	1OiEBsW6jsjh+s9WgdnydBTphTiyZlAzdHNzUiBrhXWulIL5Clix94XP9wXOS0sw
	lE3GHI9SsCCt93ZL1Ovf6ddVMTe2QqBGah0EI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D79383C456;
	Wed, 13 Jan 2016 22:03:29 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 559CA3C453;
	Wed, 13 Jan 2016 22:03:29 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 6338E9CC-BA6B-11E5-9519-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284011>

Now there is no direct caller to strbuf_getline(), so demote it
to file-scope static private to strbuf.c implementation and rename
it to strbuf_getdelim().

Eventually, we may want to make this short and clean name a synonym
to strbuf_getline_crlf(), but not now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 strbuf.c           |  6 +++---
 strbuf.h           | 21 +++++++++++----------
 transport-helper.c |  3 ++-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 2ff898c..a8641cb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -501,7 +501,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 }
 #endif
 
-int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
+static int strbuf_getdelim(struct strbuf *sb, FILE *fp, int term)
 {
 	if (strbuf_getwholeline(sb, fp, term))
 		return EOF;
@@ -524,12 +524,12 @@ int strbuf_getline_crlf(struct strbuf *sb, FILE *fp)
 
 int strbuf_getline_lf(struct strbuf *sb, FILE *fp)
 {
-	return strbuf_getline(sb, fp, '\n');
+	return strbuf_getdelim(sb, fp, '\n');
 }
 
 int strbuf_getline_nul(struct strbuf *sb, FILE *fp)
 {
-	return strbuf_getline(sb, fp, '\0');
+	return strbuf_getdelim(sb, fp, '\0');
 }
 
 int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
diff --git a/strbuf.h b/strbuf.h
index 5501743..ea2a51f 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -354,8 +354,8 @@ extern void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm
  *
  * NOTE: The buffer is rewound if the read fails. If -1 is returned,
  * `errno` must be consulted, like you would do for `read(3)`.
- * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline()` has the
- * same behaviour as well.
+ * `strbuf_read()`, `strbuf_read_file()` and `strbuf_getline_*()`
+ * family of functions have the same behaviour as well.
  */
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 
@@ -380,24 +380,25 @@ extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 
 /**
  * Read a line from a FILE *, overwriting the existing contents
- * of the strbuf. The second argument specifies the line
- * terminator character, typically `'\n'`.
+ * of the strbuf.  There are three public functions with this
+ * function signature, with different line termination convention.
  * Reading stops after the terminator or at EOF.  The terminator
  * is removed from the buffer before returning.  Returns 0 unless
  * there was nothing left before EOF, in which case it returns `EOF`.
  */
-extern int strbuf_getline(struct strbuf *, FILE *, int);
-
 
 typedef int (*strbuf_getline_fn)(struct strbuf *, FILE *);
 
+/* Uses LF as the line terminator */
 extern int strbuf_getline_lf(struct strbuf *sb, FILE *fp);
+
+/* Uses NUL as the line terminator */
 extern int strbuf_getline_nul(struct strbuf *sb, FILE *fp);
 
-/*
- * Similar to strbuf_getline(), but uses '\n' as the terminator,
- * and additionally treats a '\r' that comes immediately before '\n'
- * as part of the terminator.
+/**
+ * Similar to strbuf_getline_lf(), but additionally treats
+ * a '\r' that comes immediately before '\n' as part of the
+ * terminator.
  */
 extern int strbuf_getline_crlf(struct strbuf *, FILE *);
 
diff --git a/transport-helper.c b/transport-helper.c
index 74eb217..d108336 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -137,7 +137,8 @@ static struct child_process *get_helper(struct transport *transport)
 	data->no_disconnect_req = 0;
 
 	/*
-	 * Open the output as FILE* so strbuf_getline() can be used.
+	 * Open the output as FILE* so strbuf_getline_*() family of
+	 * functions can be used.
 	 * Do this with duped fd because fclose() will close the fd,
 	 * and stuff like taking over will require the fd to remain.
 	 */
-- 
2.7.0-242-gdd583c7
