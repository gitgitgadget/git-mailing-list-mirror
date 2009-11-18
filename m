From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v4 09/12] Fix various memory leaks in transport-helper.c
Date: Wed, 18 Nov 2009 02:42:29 +0100
Message-ID: <1258508552-20752-10-git-send-email-srabbelier@gmail.com>
References: <1258508552-20752-1-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-2-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-3-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-4-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-5-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-6-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-7-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-8-git-send-email-srabbelier@gmail.com>
 <1258508552-20752-9-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 02:44:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAZar-0000vW-8H
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 02:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844AbZKRBnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 20:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756838AbZKRBni
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 20:43:38 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:17370 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835AbZKRBnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 20:43:35 -0500
Received: by ey-out-2122.google.com with SMTP id 25so5797eya.19
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 17:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BQnx1gLIRM4gPsA4LegyUw33viHVoR2UrW0dFHmneio=;
        b=S222+43UsrKzDbrSgLi/dZelpgH6URFjPmqbySIsFviMIRNKWwF/7DNMpqZhqCdB+W
         UY16DOoFChgmnEj/4j8ch+CrNqEcxVlHl81fPowHTQG34FpZtrz3e8Wasv/A9sZH1+5C
         VIjVBrVN1gItGtU3ZM15LZmjni8V0CSdM5OkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RFep1gXJx7Iqh+46G9A/qKRuLQDBTYDdm2IP20mf05v95gtsWctZH1McsUKoWwuMBI
         rydG8F9CfwX3JLGiwYD1ywgyDFKHzc0gXAw6c6alDPr9OsIjYXPiBYmUqTO6tbd6iVb6
         GwEeVbQzbWGCW+4FywNskeVkMiE1kov55dZaQ=
Received: by 10.216.89.80 with SMTP id b58mr1052939wef.73.1258508621132;
        Tue, 17 Nov 2009 17:43:41 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 28sm2372670eye.3.2009.11.17.17.43.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 17:43:40 -0800 (PST)
X-Mailer: git-send-email 1.6.5.3.164.g07b0c
In-Reply-To: <1258508552-20752-9-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133135>

Found with:
valgrind --tool=memcheck --leak-check=full --show-reachable=yes

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

	These are mine, Daniel, please verify for saneness.

 transport-helper.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index da8185a..628a5ca 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -74,6 +74,7 @@ static struct child_process *get_helper(struct transport *transport)
 		}
 		free(refspecs);
 	}
+	strbuf_release(&buf);
 	return data->helper;
 }
 
@@ -163,6 +164,8 @@ static int fetch_with_import(struct transport *transport,
 	}
 	disconnect_helper(transport);
 	finish_command(&fastimport);
+	free(fastimport.argv);
+	fastimport.argv = NULL;
 
 	for (i = 0; i < nr_heads; i++) {
 		char *private;
@@ -176,6 +179,7 @@ static int fetch_with_import(struct transport *transport,
 		read_ref(private, posn->old_sha1);
 		free(private);
 	}
+	strbuf_release(&buf);
 	return 0;
 }
 
-- 
1.6.5.3.164.g07b0c
