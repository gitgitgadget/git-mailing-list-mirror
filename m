From: xzer <xiaozhu@gmail.com>
Subject: [PATCH] generate a valid rfc2047 mail header for multi-line subject.
Date: Mon, 14 Feb 2011 08:09:28 +0000
Message-ID: <1297670968-28130-1-git-send-email-xiaozhu@gmail.com>
Cc: xzer <xiaozhu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 09:09:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PotV9-0001kc-BV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 09:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220Ab1BNIJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 03:09:39 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35839 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab1BNIJh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 03:09:37 -0500
Received: by vxb37 with SMTP id 37so2457964vxb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 00:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=mTimFEb43H8qTwNal8z/FlwguLUs7Qhs/7z+Bp6GLJM=;
        b=Ifkcj3kgF5eagrkNxdz/hV50L8O6QhIJkwZvSK8NB8YPAOYToEyXUwwuYYep3V5kDK
         r9HExomBMZQe1vfi7Ap4qGftB5pSbxeIXT0RGevWZFLqU5ZKBSmCKUdTNCnDfadAIxzv
         kVgp9lSZA9o7kiIYcju8mxDS3rpgkecEBPUeY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oQ7y9yZ+8EHmgGLePqT73DXUlP7VGE1V8TN5nD8S64fJtKaex3CMKJ4SkFjTRyK6X7
         My90O23hB9JVZbLXH+EQSTDPsad4oL4loZBsgjiJH4lGHGZ8J8dWe5LdPlRhg4bVDIlM
         YOh8K3AXZo7wXaBRIJXSRLImfNH6JT81EHXtk=
Received: by 10.220.94.83 with SMTP id y19mr508543vcm.263.1297670976688;
        Mon, 14 Feb 2011 00:09:36 -0800 (PST)
Received: from serv.liurui.net ([96.9.152.142])
        by mx.google.com with ESMTPS id g17sm1717013vbv.12.2011.02.14.00.09.35
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 00:09:36 -0800 (PST)
X-Mailer: git-send-email 1.7.4.52.g00e6e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166697>

There is still a problem that git-am will lost the line break.
It's not easy to retain it, but as the first step, we can generate
a valid rfc2047 header now.
---
 pretty.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index 8549934..f18a38d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -249,6 +249,33 @@ needquote:
 	strbuf_addstr(sb, "?=");
 }
 
+static void add_rfc2047_multiline(struct strbuf *sb, const char *line, int len,
+                       const char *encoding)
+{
+	int first = 1;
+	char *mline = xmemdupz(line, len);
+	const char *cline = mline;
+	int offset = 0, linelen = 0;
+        for (;;) {
+                linelen = get_one_line(cline);
+
+                cline += linelen;
+
+                if (!linelen)
+                        break;
+		
+		if (!first)
+			strbuf_addf(sb, "\n ");
+
+		offset = *(cline -1) == '\n'; 
+
+		add_rfc2047(sb, cline-linelen, linelen-offset, encoding);
+		first = 0;
+
+        }
+	free(mline);
+}
+
 void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		  const char *line, enum date_mode dmode,
 		  const char *encoding)
@@ -1115,7 +1142,7 @@ void pp_title_line(enum cmit_fmt fmt,
 	strbuf_grow(sb, title.len + 1024);
 	if (subject) {
 		strbuf_addstr(sb, subject);
-		add_rfc2047(sb, title.buf, title.len, encoding);
+		add_rfc2047_multiline(sb, title.buf, title.len, encoding);
 	} else {
 		strbuf_addbuf(sb, &title);
 	}
-- 
1.7.4.52.g00e6e.dirty
