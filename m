From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/4] git_connect: avoid quoting the path on the command line when it's not necessary
Date: Thu, 28 Apr 2016 23:12:37 +0900
Message-ID: <1461852759-28429-3-git-send-email-mh@glandium.org>
References: <1461852759-28429-1-git-send-email-mh@glandium.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 16:13:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avmgn-00012r-HN
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 16:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbcD1OMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 10:12:49 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:45590 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752377AbcD1OMp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 10:12:45 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <glandium@glandium.org>)
	id 1avmgJ-0007PL-HN; Thu, 28 Apr 2016 23:12:39 +0900
X-Mailer: git-send-email 2.8.1.5.g18c8a48
In-Reply-To: <1461852759-28429-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292889>

Some remote systems can employ restricted shells that aren't very smart
with quotes, so avoid quoting when it's not strictly necessary.

The list of "safe" characters comes from Mercurial's shell quoting
function used for its ssh client side. There likely are more that could
be added to the list.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/connect.c b/connect.c
index 96c8c1d..919bf9e 100644
--- a/connect.c
+++ b/connect.c
@@ -668,6 +668,17 @@ static void prepare_connect_command(struct strbuf *cmd, const char *prog,
 		strbuf_addstr(cmd, prog);
 		strbuf_addch(cmd, ' ');
 	}
+	if (quote) {
+		const char *p;
+		for (p = path; *p; p++) {
+			if (!isalnum(*p) && *p != '@' && *p != '%' &&
+			    *p != '_' && *p != '+' && *p != '=' && *p != ':' &&
+			    *p != ',' && *p != '.' && *p != '/' && *p != '-')
+				break;
+		}
+		if (!*p)
+			quote = 0;
+	}
 	if (quote)
 		sq_quote_buf(cmd, path);
 	else
-- 
2.8.1.5.g18c8a48
