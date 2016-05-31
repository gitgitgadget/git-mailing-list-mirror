From: Matteo Bertini <naufraghi@develer.com>
Subject: [PATCH 1/4] hash-object.c: Allow distinct file/path in stdin mode too.
Date: Tue, 31 May 2016 17:07:46 +0200
Message-ID: <20160531150749.24840-2-naufraghi@develer.com>
References: <20160531150749.24840-1-naufraghi@develer.com>
Cc: Matteo Bertini <matteo@naufraghi.net>, normalperson@yhbt.net,
	gitster@pobox.com, Matteo Bertini <naufraghi@develer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 17:15:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7lNm-0002Hr-6D
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 17:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159AbcEaPOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 11:14:50 -0400
Received: from neo.develer.net ([2.228.72.10]:39512 "EHLO neo.develer.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673AbcEaPOo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 11:14:44 -0400
Received: from odello.trilan (odello.trilan [10.3.15.118])
	(Authenticated sender: naufraghi)
	by neo.develer.net (Postfix) with ESMTPSA id C0F4B5E311F;
	Tue, 31 May 2016 17:07:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=develer.com;
	s=gongolo; t=1464707277;
	bh=NW/PcQ1c0GZrtVpFOkB8hg9Eq65BUv5N0awlQi4bdf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rM3I3kBDcQL0Dh+wxAL+p4hYc/Gvk1g8R1/R+ZnoCE7RnFSZ+KGLM9Kia3fUh8v0F
	 RXoumLcwozAzL816DUsH4JJjmjcD+rA19bl4VUCxgiJlONN4c3UQzEFvwzbS8hQfga
	 bYqvPVeFP9pza1MfZ8DcN3FadHsnWlP7Opexv2TE=
X-Mailer: git-send-email 2.9.0.rc0.39.gb9f310b.dirty
In-Reply-To: <20160531150749.24840-1-naufraghi@develer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295981>

From: Matteo Bertini <matteo@naufraghi.net>

The hash-object command has the --path option to use a name for the filters
that is different from the file containing the data.

This patch exposes the same functionality for the --stdin-paths, using \t
as separator.

Signed-off-by: Matteo Bertini <naufraghi@develer.com>
---
 builtin/hash-object.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index f7d3567..f74c6bd 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -58,20 +58,45 @@ static void hash_object(const char *path, const char *type, const char *vpath,
 static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 			     int literally)
 {
+	int has_path = 0;
 	struct strbuf buf = STRBUF_INIT;
+	struct strbuf path = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
+	struct strbuf **pair;
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
+		pair = strbuf_split_max(&buf, '\t', 2);
+		if (pair[0]) {
+			if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '\t') {
+				strbuf_setlen(pair[0], pair[0]->len - 1);
+			}
+			strbuf_swap(&buf, pair[0]);
+		}
+		if (pair[1]) {
+			strbuf_swap(&path, pair[1]);
+			has_path = 1;
+		}
+		strbuf_list_free(pair);
+
 		if (buf.buf[0] == '"') {
 			strbuf_reset(&unquoted);
 			if (unquote_c_style(&unquoted, buf.buf, NULL))
 				die("line is badly quoted");
 			strbuf_swap(&buf, &unquoted);
 		}
-		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
-			    literally);
+
+		if (has_path && path.buf[0] == '"') {
+			strbuf_reset(&unquoted);
+			if (unquote_c_style(&unquoted, path.buf, NULL))
+				die("line is badly quoted");
+			strbuf_swap(&path, &unquoted);
+		}
+
+		hash_object(buf.buf, type, no_filters ? NULL : (has_path ? path.buf : buf.buf),
+				  flags, literally);
 	}
 	strbuf_release(&buf);
+	strbuf_release(&path);
 	strbuf_release(&unquoted);
 }
 
-- 
2.9.0.rc0.39.gb9f310b.dirty
