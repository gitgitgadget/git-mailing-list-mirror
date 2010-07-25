From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] commit: split commit -s handling into its own function
Date: Sat, 24 Jul 2010 19:58:48 -0500
Message-ID: <20100725005848.GD18420@burratino>
References: <20100725005443.GA18370@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 03:00:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcpZV-00080o-Dy
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 03:00:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817Ab0GYA77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 20:59:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46638 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0GYA76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 20:59:58 -0400
Received: by gyg10 with SMTP id 10so545688gyg.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 17:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3RqT18rhvZ7VuHhIaLftF7yh2Ry8xTKWC7wReVVNyWw=;
        b=LcA2RobdKz9IUbt7c0PcJtTojPVdcL0JQ94STiywHhT4Vn0Fre7QIPRlDd2AXKJLy0
         2NVufwdFNZ+gbMXEQhF9myedEXujj4YWcfVd4ACW0tfkZWe4z2TrOP9lR6tBBZsxCww2
         5egvtRa+6F8KQqKOwE/A3tbJ2i3NIAg/fGkqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=yFnK/EbzH7rwPodc+cXPdeuE/4Uibs5YV4J64PO1AxLgA8cPX0aKt0ZqleVbRXrikD
         iAHVf7PVppHfD4JuExC5PE4sMyF4ztY+rrLeoWdNHrnWjh2Zl7qLDgf6LUeuROh2W90J
         L3gmUvuaEmn57AfAJlDb/MPc0XUMczecww/dc=
Received: by 10.100.111.7 with SMTP id j7mr6018802anc.30.1280019591600;
        Sat, 24 Jul 2010 17:59:51 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id c19sm3323003ana.22.2010.07.24.17.59.50
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 17:59:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100725005443.GA18370@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151696>

prepare_to_commit is easier to read straight through with optional
steps moved out-of-line.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/commit.c |   37 ++++++++++++++++++++-----------------
 1 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6774180..b599486 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -606,6 +606,24 @@ static const char *get_template_message(struct strbuf *sb,
 	return NULL;
 }
 
+static void add_committer_signoff(struct strbuf *sb)
+{
+	struct strbuf sob = STRBUF_INIT;
+	int i;
+
+	strbuf_addstr(&sob, sign_off_header);
+	strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
+				     getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addch(&sob, '\n');
+	for (i = sb->len - 1; i > 0 && sb->buf[i - 1] != '\n'; i--)
+		; /* do nothing */
+	if (prefixcmp(sb->buf + i, sob.buf)) {
+		if (!i || !ends_rfc2822_footer(sb))
+			strbuf_addch(sb, '\n');
+		strbuf_addbuf(sb, &sob);
+	}
+	strbuf_release(&sob);
+}
 
 static int prepare_to_commit(const char *index_file, const char *prefix,
 			     struct wt_status *s)
@@ -629,23 +647,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, 0);
 
-	if (signoff) {
-		struct strbuf sob = STRBUF_INIT;
-		int i;
-
-		strbuf_addstr(&sob, sign_off_header);
-		strbuf_addstr(&sob, fmt_name(getenv("GIT_COMMITTER_NAME"),
-					     getenv("GIT_COMMITTER_EMAIL")));
-		strbuf_addch(&sob, '\n');
-		for (i = sb.len - 1; i > 0 && sb.buf[i - 1] != '\n'; i--)
-			; /* do nothing */
-		if (prefixcmp(sb.buf + i, sob.buf)) {
-			if (!i || !ends_rfc2822_footer(&sb))
-				strbuf_addch(&sb, '\n');
-			strbuf_addbuf(&sb, &sob);
-		}
-		strbuf_release(&sob);
-	}
+	if (signoff)
+		add_committer_signoff(&sb);
 
 	if (fwrite(sb.buf, 1, sb.len, fp) < sb.len)
 		die_errno("could not write commit template");
-- 
1.7.2.9.ge3789.dirty
