From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] fast-import: support the ls command anywhere comments are accepted
Date: Wed, 26 Nov 2014 07:25:39 +0900
Message-ID: <1416954339-9304-1-git-send-email-mh@glandium.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 23:26:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtOYY-0002aR-BI
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 23:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbaKYWZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 17:25:54 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:51985 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbaKYWZy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 17:25:54 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1XtOYF-0002Qh-Js; Wed, 26 Nov 2014 07:25:39 +0900
X-Mailer: git-send-email 2.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260244>

The git-fast-import manual page says about both cat-blob and ls that they can
be used "anywhere in the stream that comments are accepted", but in practice
it turns out it was only true for cat-blob. This change makes fast-import
behavior match its documentation.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 fast-import.c | 4 ++++
 1 file changed, 4 insertions(+)

The downside of this change is that if a script relies on the fixed behavior,
it won't work with older versions of git. I'm not sure it is better than
fixing the documentation to match the unfortunate current limitation?


diff --git a/fast-import.c b/fast-import.c
index d0bd285..7fd59ef 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1910,6 +1910,10 @@ static int read_next_command(void)
 			parse_cat_blob(p);
 			continue;
 		}
+		if (skip_prefix(command_buf.buf, "ls ", &p)) {
+			parse_ls(p, NULL);
+			continue;
+		}
 		if (command_buf.buf[0] == '#')
 			continue;
 		return 0;
-- 
2.1.1
