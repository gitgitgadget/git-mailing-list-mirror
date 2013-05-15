From: Jiang Xin <worldhello.net@gmail.com>
Subject: [RFC 1/2] path.c: refactor relative_path(), not only strip prefix
Date: Wed, 15 May 2013 23:18:38 +0800
Message-ID: <7f77be827e21940dfe415d34f7239799d999fef4.1368630636.git.worldhello.net@gmail.com>
References: <cover.1368630636.git.worldhello.net@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 15 17:19:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcdTz-0006Yx-U3
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 17:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759275Ab3EOPTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 11:19:07 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:34674 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759238Ab3EOPTF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 11:19:05 -0400
Received: by mail-da0-f52.google.com with SMTP id o9so1041122dan.11
        for <git@vger.kernel.org>; Wed, 15 May 2013 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:in-reply-to:references;
        bh=n2apbR7+jeJkoyQ9khQ6e43DDs2MZrGIow0rwFzycEs=;
        b=T6vnyQhDM9nkmgVy/hsGhbsm4PHJL6N+yvfKjF06LhkqDa+KLErMF8k+uzBSRJ/RQ6
         um5HH9VzmIT7uORzY1PbJQTxVwiXPzZYI68/a56UPJZGgt8yy3E26SzouMkWkc7g5a2f
         fXX1BGmwyXS3lRxCd/uMBN5ES/8Je5J+LUf6iyiud206JRTBOihQEhxiHanRPMlgAbzm
         jle0HJ8A6JlzjtiN9v6FLbnL6CeoQA/iBh3+Mh8KLMWS9MYRBZbneVTwEo8vACiesbY5
         DjwS6FS3C+Cj4B6Juefduw+u0NuYQHQF8EuuXVGcCNtkUWh10wxNcXCrhpLz3ruQn+Dc
         IYtQ==
X-Received: by 10.68.11.73 with SMTP id o9mr39434491pbb.18.1368631145169;
        Wed, 15 May 2013 08:19:05 -0700 (PDT)
Received: from localhost.localdomain ([114.248.153.37])
        by mx.google.com with ESMTPSA id iy2sm3161860pbb.31.2013.05.15.08.18.58
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 May 2013 08:19:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.404.ga32c147
In-Reply-To: <cover.1368630636.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1368630636.git.worldhello.net@gmail.com>
References: <7vvc6ldtx7.fsf@alter.siamese.dyndns.org> <cover.1368630636.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224415>

Original design of relative_path() is simple, just strip the prefix
(*base) from the abosolute path (*abs). In most cases, we need a real
relative path, such as: ../foo, ../../bar. That's why there is another
reimplementation (path_relative()) in quote.c.

Refactor relative_path() in path.c to return real relative path, so
that user can reuse this function without reimplement his/her own.
I will use this method for interactive git-clean later. Some of the
implementations are borrowed from path_relative() in quote.c.

Different results for relative_path() before and after this refactor:

    base path  abs path  relative (orignal)  relative (refactor)
    =========  ========  ==================  ===================
    /a/b       /a/b/c/   c/                  c/
    //a///b/   /a/b//c/  c/                  c/
    /a/b       /a/b/     .                   ./
    /a/b/      /a        /a                  ../
    /a/b/      /         /                   ../../
    /a/b/      /a/c      /a/c                ../c

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 path.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/path.c b/path.c
index 04ff..4dafa8 100644
--- a/path.c
+++ b/path.c
@@ -444,38 +444,92 @@ int adjust_shared_perm(const char *path)
 const char *relative_path(const char *abs, const char *base)
 {
 	static char buf[PATH_MAX + 1];
-	int i = 0, j = 0;
+	int abs_off, base_off, i, j;
+	int abs_len, base_len;
 
 	if (!base || !base[0])
 		return abs;
-	while (base[i]) {
+
+	abs_len = strlen(abs);
+	base_len = strlen(base);
+
+	abs_off = 0;
+	base_off = 0;
+	i = 0;
+	j = 0;
+	while (i < base_len && j < abs_len && base[i] == abs[j]) {
 		if (is_dir_sep(base[i])) {
-			if (!is_dir_sep(abs[j]))
-				return abs;
 			while (is_dir_sep(base[i]))
 				i++;
 			while (is_dir_sep(abs[j]))
 				j++;
-			continue;
-		} else if (abs[j] != base[i]) {
+			base_off = i;
+			abs_off = j;
+		} else {
+			i++;
+			j++;
+		}
+	}
+	if (
+	    /* base seems like prefix of abs */
+	    i >= base_len &&
+	    /*
+	     * but "/foo" is not a prefix of "/foobar"
+	     * (i.e. base not end with '/')
+	     */
+	    base_off < base_len) {
+		if (j >= abs_len) {
+			/* abs="/a/b", base="/a/b" */
+			abs_off = abs_len;
+		} else if (is_dir_sep(abs[j])) {
+			/* abs="/a/b/c", base="/a/b" */
+			while (is_dir_sep(abs[j]))
+				j++;
+			abs_off = j;
+		} else {
+			/* abs="/a/bbb/c", base="/a/b" */
+			i = base_off;
+		}
+	} else if (
+		   /* abs is short than base (prefix of base) */
+		   j >= abs_len &&
+		   /* abs not end with '/' */
+		   abs_off < abs_len) {
+		if (is_dir_sep(base[i])) {
+			/* abs="/a/b", base="/a/b/c/" */
+			while (is_dir_sep(base[i]))
+				i++;
+			abs_off = abs_len;
+		}
+	}
+	abs += abs_off;
+	abs_len -= abs_off;
+
+	/* base is prefix of abs */
+	if (i >= base_len) {
+		if (*abs == '\0') {
+			strcpy(buf, "./");
+			return buf;
+		} else {
 			return abs;
 		}
+	}
+
+	buf[0] = '\0';
+	while (i < base_len) {
+		if (is_dir_sep(base[i])) {
+			strcat(buf, "../");
+			while (is_dir_sep(base[i]))
+				i++;
+			continue;
+		}
 		i++;
-		j++;
 	}
-	if (
-	    /* "/foo" is a prefix of "/foo" */
-	    abs[j] &&
-	    /* "/foo" is not a prefix of "/foobar" */
-	    !is_dir_sep(base[i-1]) && !is_dir_sep(abs[j])
-	   )
-		return abs;
-	while (is_dir_sep(abs[j]))
-		j++;
-	if (!abs[j])
-		strcpy(buf, ".");
-	else
-		strcpy(buf, abs + j);
+	if (!is_dir_sep(base[base_len - 1]))
+		strcat(buf, "../");
+
+	strcat(buf, abs);
+
 	return buf;
 }
 
-- 
1.8.3.rc1.404.ga32c147
