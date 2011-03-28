From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 3/9] interpret %C(invalid) as we would %%C(invalid)
Date: Tue, 29 Mar 2011 00:17:25 +0100
Message-ID: <1301354251-23380-4-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4LhL-0000rH-2E
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab1C1XR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:17:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56503 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab1C1XR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:17:57 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so3294020wya.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Sq9CkTUtMLB78Pqd/NlPcQM0nf9Cpx8gi7fm5uEz+A8=;
        b=FWsQXnS2AiWbgHCn+ctBbz0kfzfr0UXWlJyGtrfuK2DYCspS000YjU0zwrgni02Csh
         CzYTJantbCkrMEWL3Gn7lHgpM7V93QRmupkGbEY5FiexfsfORB9f2L3TaFmhA3zBurcJ
         4mhEYtoPOjg4XRm7KS1Kl2NlfItN54MU4+rr0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lMlO7EgNy9eOs0WNb0z3kkLA3QmJ929+07e2ao2qO5rMFEzs6Q1Z0aWzzCutQmMJUM
         DNu6/UNCtNWjFxVqoFAHLymsjilKLtPvq/yHls37O+MAampNjp5AE8RA1KKG0esv7IwV
         aQ3w3UQeSqQgp3CRJ4BD2RKJuGsAOGLiLW8nc=
Received: by 10.216.145.200 with SMTP id p50mr3292378wej.79.1301354276554;
        Mon, 28 Mar 2011 16:17:56 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.17.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:17:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170202>

%C(...) had the distinction of being the only format placeholder which
could trigger a die(), a side-effect of its ancestry in calling the
existing color_parse_mem(...). This was good, because it gave users an
explanation of what went wrong. It was also inconsistent, since every
other "unknown placeholder" was interpreted as a literal.

This removes the inconsistency by interpreting %C(invalid) as a literal.
Perhaps this is a step in the wrong direction.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 color.c  |   17 +++++++++++------
 color.h  |    1 +
 pretty.c |    7 +++----
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/color.c b/color.c
index 6a5a54e..9bc190b 100644
--- a/color.c
+++ b/color.c
@@ -45,6 +45,13 @@ void color_parse(const char *value, const char *var, char *dst)
 void color_parse_mem(const char *value, int value_len, const char *var,
 		char *dst)
 {
+	if (color_parse_len(value, value_len, dst))
+		return;
+	die("bad color value '%.*s' for variable '%s'", value_len, value, var);
+}
+
+int color_parse_len(const char *value, int value_len, char *dst)
+{
 	const char *ptr = value;
 	int len = value_len;
 	unsigned int attr = 0;
@@ -53,7 +60,7 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 
 	if (!strncasecmp(value, "reset", len)) {
 		strcpy(dst, GIT_COLOR_RESET);
-		return;
+		return 1;
 	}
 
 	/* [fg [bg]] [attr]... */
@@ -82,13 +89,13 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 				bg = val;
 				continue;
 			}
-			goto bad;
+			return 0;
 		}
 		val = parse_attr(word, wordlen);
 		if (0 <= val)
 			attr |= (1 << val);
 		else
-			goto bad;
+			return 0;
 	}
 
 	if (attr || fg >= 0 || bg >= 0) {
@@ -130,9 +137,7 @@ void color_parse_mem(const char *value, int value_len, const char *var,
 		*dst++ = 'm';
 	}
 	*dst = 0;
-	return;
-bad:
-	die("bad color value '%.*s' for variable '%s'", value_len, value, var);
+	return 1;
 }
 
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty)
diff --git a/color.h b/color.h
index 170ff40..084d85d 100644
--- a/color.h
+++ b/color.h
@@ -59,6 +59,7 @@ int git_color_default_config(const char *var, const char *value, void *cb);
 
 int git_config_colorbool(const char *var, const char *value, int stdout_is_tty);
 void color_parse(const char *value, const char *var, char *dst);
+int color_parse_len(const char *value, int len, char *dst);
 void color_parse_mem(const char *value, int len, const char *var, char *dst);
 __attribute__((format (printf, 3, 4)))
 int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
diff --git a/pretty.c b/pretty.c
index 8549934..d5a724f 100644
--- a/pretty.c
+++ b/pretty.c
@@ -752,11 +752,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		if (placeholder[1] == '(') {
 			const char *end = strchr(placeholder + 2, ')');
 			char color[COLOR_MAXLEN];
-			if (!end)
+			if (!end || !color_parse_len(placeholder + 2,
+						     end - (placeholder + 2),
+						     color))
 				return 0;
-			color_parse_mem(placeholder + 2,
-					end - (placeholder + 2),
-					"--pretty format", color);
 			strbuf_addstr(sb, color);
 			return end - placeholder + 1;
 		}
-- 
1.7.4.2
