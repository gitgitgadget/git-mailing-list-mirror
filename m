From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 03/13] transport-helper: factor out push_update_refs_status
Date: Sat, 28 Aug 2010 22:45:30 -0500
Message-ID: <1283053540-27042-4-git-send-email-srabbelier@gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: "Git List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 05:47:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpYrM-0006pV-Ft
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 05:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab0H2Dqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 23:46:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38975 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab0H2DqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 23:46:14 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so3824467iwn.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 20:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TNLkudvaXxhppz3MNfeghdyOPAQERRNykYk8njTvcCs=;
        b=uv0ocohzEHiPTzPiFEQfJ7oHQxd1uaQLaMu6eVjMnoFo6y2z09oLPygVf6s+yLpVre
         z9dDU5WQJDm5v9me5/WAHmdaR4vX1CxnvhsdbScQbtjUST2nXNS4LrCr5Zs+EOP4SrkB
         rinX2eNYZpSHtb/lNAcm5hiPHsCcsU/IlDz9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=f0VKHLjSKowGKO6fHbY81ZdGD4Wu8oU1T1yYpye+TZ2p1OYwK37I3HhtRU0ycAhqZs
         GmOLMnI2lzep3p2FoD+BmsVI8LCNaxpuPaGOgGCWJsZnuK1fVh1L5a7iKUO4trSLf1y1
         yZXXjaWDl72vunV7pqZDVOSs0vdqLQn7B8ywg=
Received: by 10.231.11.11 with SMTP id r11mr3138001ibr.135.1283053574525;
        Sat, 28 Aug 2010 20:46:14 -0700 (PDT)
Received: from localhost.localdomain (adsl-76-237-184-184.dsl.chcgil.sbcglobal.net [76.237.184.184])
        by mx.google.com with ESMTPS id n20sm5647049ibe.17.2010.08.28.20.46.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 20:46:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.240.g6a95c3
In-Reply-To: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154673>

The update ref status part of push is useful for the export command
as well, factor it out into it's own function.
---

  I didn't move the new function up above push_refs_with_push so that
  it is obvious to the reviewer that the change is trivial.

 transport-helper.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 191fbf7..9f2ad00 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -554,6 +554,9 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+static void push_update_refs_status(struct helper_data *data,
+				    struct ref *remote_refs);
+
 static int push_refs_with_push(struct transport *transport,
 		struct ref *remote_refs, int flags)
 {
@@ -609,8 +612,17 @@ static int push_refs_with_push(struct transport *transport,
 
 	strbuf_addch(&buf, '\n');
 	sendline(data, &buf);
+	strbuf_release(&buf);
+
+	push_update_refs_status(data, remote_refs);
+	return 0;
+}
 
-	ref = remote_refs;
+static void push_update_refs_status(struct helper_data *data,
+				    struct ref *remote_refs)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct ref *ref = remote_refs;
 	while (1) {
 		char *refname, *msg;
 		int status;
@@ -679,7 +691,7 @@ static int push_refs_with_push(struct transport *transport,
 		ref->remote_status = msg;
 	}
 	strbuf_release(&buf);
-	return 0;
+	return;
 }
 
 static int push_refs_with_export(struct transport *transport,
-- 
1.7.2.1.240.g6a95c3
