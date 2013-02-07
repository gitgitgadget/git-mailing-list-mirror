From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/6] graph: output padding for merge subsequent parents
Date: Thu,  7 Feb 2013 20:15:23 +0000
Message-ID: <b98eb2bfe2b022ddf1afbe9f7123accfe068e8c9.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 07 21:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Y0V-0001X8-LL
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 21:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759377Ab3BGUXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 15:23:08 -0500
Received: from pichi.aluminati.org ([72.9.246.58]:37244 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759354Ab3BGUXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 15:23:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7F17A161E2AE;
	Thu,  7 Feb 2013 20:15:34 +0000 (GMT)
X-Quarantine-ID: <wWGaT7wlg5ZQ>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWGaT7wlg5ZQ; Thu,  7 Feb 2013 20:15:32 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 962F6161E463;
	Thu,  7 Feb 2013 20:15:27 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
In-Reply-To: <cover.1360267849.git.john@keeping.me.uk>
References: <cover.1360267849.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215724>

When showing merges in git-log, the same commit is shown once for each
parent.  Combined with "--graph" this results in graph_show_commit()
being called once for each parent without graph_update() being called.

Currently graph_show_commit() does not print anything on subsequent
invocations for the same commit (this was changed by commit 656197a -
"graph.c: infinite loop in git whatchanged --graph -m" from the previous
behaviour of looping infinitely).

Change this so that if the graph code believes it has already shown the
commit it prints a single padding line.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 graph.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/graph.c b/graph.c
index 391a712..2a3fc5c 100644
--- a/graph.c
+++ b/graph.c
@@ -1227,6 +1227,16 @@ void graph_show_commit(struct git_graph *graph)
 	if (!graph)
 		return;
 
+	/*
+	 * When showing a diff of a merge against each of its parents, we
+	 * are called once for each parent without graph_update having been
+	 * called.  In this case, simply output a single padding line.
+	 */
+	if (graph_is_commit_finished(graph)) {
+		graph_show_padding(graph);
+		shown_commit_line = 1;
+	}
+
 	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
 		shown_commit_line = graph_next_line(graph, &msgbuf);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
-- 
1.8.1.2
