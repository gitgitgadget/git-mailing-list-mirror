From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 17/22] remote: avoid passing NULL to read_ref()
Date: Thu, 15 Sep 2011 23:10:38 +0200
Message-ID: <1316121043-29367-18-git-send-email-mhagger@alum.mit.edu>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 23:19:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JLC-0001GW-Li
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935031Ab1IOVTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:19:18 -0400
Received: from ssh.berlin.jpk.com ([212.222.128.135]:40234 "EHLO
	homer.berlin.jpk.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934943Ab1IOVTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:19:16 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1R4J90-00019o-Le; Thu, 15 Sep 2011 23:06:50 +0200
X-Mailer: git-send-email 1.7.6.8.gd2879
In-Reply-To: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181519>

read_ref() can (and in test t5800, actually *does*) return NULL.
Don't pass the NULL along to read_ref().  Coincidentally, this mistake
didn't make resolve_ref() blow up, but upcoming changes to
resolve_ref() will make it less forgiving.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 transport-helper.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 0713126..6f227e2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -446,8 +446,10 @@ static int fetch_with_import(struct transport *transport,
 			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
 		else
 			private = xstrdup(posn->name);
-		read_ref(private, posn->old_sha1);
-		free(private);
+		if (private) {
+			read_ref(private, posn->old_sha1);
+			free(private);
+		}
 	}
 	strbuf_release(&buf);
 	return 0;
-- 
1.7.6.8.gd2879
