From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv0 1/4] fast-import.c:do_change_note_fanout(): Remove unneeded local var 't'
Date: Mon,  5 Jan 2015 04:39:35 +0100
Message-ID: <1420429178-20336-1-git-send-email-johan@herland.net>
References: <CALKQrgdVp7cLER2DQxwdFT82Y=Pamrx6=oa3bY=X7mWy_r3QWA@mail.gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 05 04:40:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7yWZ-0002RO-7G
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 04:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbbAEDkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2015 22:40:04 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:41827 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbbAEDkC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2015 22:40:02 -0500
Received: by mail-la0-f46.google.com with SMTP id q1so17987532lam.33
        for <git@vger.kernel.org>; Sun, 04 Jan 2015 19:40:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rQGqi/m+TivDm7gP9k/hmIpT1ocVx9vKlmzid+jNRAw=;
        b=Z9QpAS0IXjuxpuffI9mK8n5yPnSPW7I5KNHzajk29UstzxsH+k6uZ0NFps6x594+oq
         4gCNaLcMpjHmKpqdGOCXxQdXtwZJb/TV6fQyauiFqYVq5Oc8ZrXmxqhnLN2CVmjxP7nV
         sgw+y7x+ss6e3ivlqfZwkkaNKeomJMxGsiD+l8gRaieAlVM7iJkH/wM4hhXPsjpS9+V6
         0UH8pkmZ5mIKQWO5jWfN6JSp8zMD9mc4YfqGp8DoKELw9cCeDyLZk4ymaMWIYAWHTFs3
         hfZvfsuYxNaM+QNS3X440RJP1Kvdjys8Qjs4cOc9G5RzF45MytYSl7ORmYlrUsIXxGE6
         0YAA==
X-Received: by 10.112.167.68 with SMTP id zm4mr34352635lbb.93.1420429201267;
        Sun, 04 Jan 2015 19:40:01 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id ya4sm4239978lbb.32.2015.01.04.19.39.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Jan 2015 19:39:59 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <CALKQrgdVp7cLER2DQxwdFT82Y=Pamrx6=oa3bY=X7mWy_r3QWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262010>

The struct tree_content *t variable was used as a shorthand for the
given root->tree, but it was only used in the first two lines of the for
loop, so the shorthand itself does not add much value. Furthermore,
since the for loop body might end up reallocating root->tree we had to
reinitialize t at the end of the for loop body, which is ugly and brittle.

Simply use root->tree directly instead, and remote the t shorthand.

Signed-off-by: Johan Herland <johan@herland.net>
---
 fast-import.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d0bd285..04dfd50 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2153,15 +2153,14 @@ static uintmax_t do_change_note_fanout(
 		char *fullpath, unsigned int fullpath_len,
 		unsigned char fanout)
 {
-	struct tree_content *t = root->tree;
 	struct tree_entry *e, leaf;
 	unsigned int i, tmp_hex_sha1_len, tmp_fullpath_len;
 	uintmax_t num_notes = 0;
 	unsigned char sha1[20];
 	char realpath[60];
 
-	for (i = 0; t && i < t->entry_count; i++) {
-		e = t->entries[i];
+	for (i = 0; root->tree && i < root->tree->entry_count; i++) {
+		e = root->tree->entries[i];
 		tmp_hex_sha1_len = hex_sha1_len + e->name->str_len;
 		tmp_fullpath_len = fullpath_len;
 
@@ -2217,9 +2216,6 @@ static uintmax_t do_change_note_fanout(
 				hex_sha1, tmp_hex_sha1_len,
 				fullpath, tmp_fullpath_len, fanout);
 		}
-
-		/* The above may have reallocated the current tree_content */
-		t = root->tree;
 	}
 	return num_notes;
 }
-- 
2.1.1.392.g062cc5d
