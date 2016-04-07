From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/4] builtin/am: read mailinfo from file
Date: Thu, 7 Apr 2016 18:23:13 +0300
Message-ID: <1460042563-32741-4-git-send-email-mst@redhat.com>
References: <1460042563-32741-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 17:23:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoBmD-0004xb-Fy
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 17:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756558AbcDGPXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 11:23:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076AbcDGPXR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 11:23:17 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB35B83F45;
	Thu,  7 Apr 2016 15:23:16 +0000 (UTC)
Received: from redhat.com (vpn1-7-7.ams2.redhat.com [10.36.7.7])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id u37FNDbd000953;
	Thu, 7 Apr 2016 11:23:14 -0400
Content-Disposition: inline
In-Reply-To: <1460042563-32741-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290920>

Slightly slower, but will allow easy additional processing on it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 builtin/am.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index d003939..4180b04 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1246,6 +1246,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	FILE *fp;
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf msg = STRBUF_INIT;
+	struct strbuf log_msg = STRBUF_INIT;
 	struct strbuf author_name = STRBUF_INIT;
 	struct strbuf author_date = STRBUF_INIT;
 	struct strbuf author_email = STRBUF_INIT;
@@ -1330,7 +1331,12 @@ static int parse_mail(struct am_state *state, const char *mail)
 	}
 
 	strbuf_addstr(&msg, "\n\n");
-	strbuf_addbuf(&msg, &mi.log_message);
+
+	if (strbuf_read_file(&log_msg,  am_path(state, "msg"), 0) < 0) {
+		die_errno(_("could not read '%s'"), am_path(state, "msg"));
+	}
+
+	strbuf_addbuf(&msg, &log_msg);
 	strbuf_stripspace(&msg, 0);
 
 	if (state->signoff)
@@ -1349,6 +1355,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	state->msg = strbuf_detach(&msg, &state->msg_len);
 
 finish:
+	strbuf_release(&log_msg);
 	strbuf_release(&msg);
 	strbuf_release(&author_date);
 	strbuf_release(&author_email);
-- 
MST
