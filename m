From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 07/19] Allow helpers to report in "list" command that the ref is unchanged
Date: Thu, 29 Oct 2009 11:01:15 -0700
Message-ID: <1256839287-19016-8-git-send-email-srabbelier@gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:02:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZKk-0004ac-W3
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbZJ2SC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753815AbZJ2SC0
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:02:26 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:55291 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbZJ2SCX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:02:23 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so1335963pxi.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=C4qYCCM/lkeSV2TJUTWNzv7f/N4eEDp3INw43E01PFI=;
        b=gBD4gwH70gXWak0B5oYpHSHaIFRzyal5H3W9hyXsLgXHiIcBljejbvhxoUBoOGMd+z
         V0p2yGRtAsiTIjw+IXKwaoPetsx1Ofk33SAqxYt4Lo3G2tmi+cbAw0uLppS09KHqbmoE
         +TguhH2q9/2iGirmj5PJSB8+lVFGTBSP2VHac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CSK4V8OZHT3jeKUMm+ZQq3d0Lz8VJ50lwBsq3K2Q+D/0chwBfXb2kAnTtF8RcLYU3T
         DxTaKTF4u7IfO/iuxwkzL2INDxge1BzhbLyV46K05b4tNUB685ZeOo6QmOPDS5VV3bP0
         7xkiqsLrFag3jm9K14vDYQw/TAjzvHnNO0ucA=
Received: by 10.114.165.15 with SMTP id n15mr264270wae.89.1256839348642;
        Thu, 29 Oct 2009 11:02:28 -0700 (PDT)
Received: from localhost.localdomain (ip67-152-86-163.z86-152-67.customer.algx.net [67.152.86.163])
        by mx.google.com with ESMTPS id 23sm1332445pxi.5.2009.10.29.11.02.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 11:02:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.2.291.gf76a3
In-Reply-To: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131623>

From: Daniel Barkalow <barkalow@iabervon.org>

Helpers may use a line like "? name unchanged" to specify that there
is nothing new at that name, without any git-specific code to
determine the correct response.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

	Unchanged.

 Documentation/git-remote-helpers.txt |    4 +++-
 transport-helper.c                   |   22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index e9aa67e..2c5130f 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -70,7 +70,9 @@ CAPABILITIES
 REF LIST ATTRIBUTES
 -------------------
 
-None are defined yet, but the caller must accept any which are supplied.
+'unchanged'::
+	This ref is unchanged since the last import or fetch, although
+	the helper cannot necessarily determine what value that produced.
 
 Documentation
 -------------
diff --git a/transport-helper.c b/transport-helper.c
index ab40a9a..e093d05 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -163,6 +163,22 @@ static int fetch(struct transport *transport,
 	return -1;
 }
 
+static int has_attribute(const char *attrs, const char *attr) {
+	int len;
+	if (!attrs)
+		return 0;
+
+	len = strlen(attr);
+	for (;;) {
+		const char *space = strchrnul(attrs, ' ');
+		if (len == space - attrs && !strncmp(attrs, attr, len))
+			return 1;
+		if (!*space)
+			return 0;
+		attrs = space + 1;
+	}
+}
+
 static struct ref *get_refs_list(struct transport *transport, int for_push)
 {
 	struct child_process *helper;
@@ -197,6 +213,12 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 			(*tail)->symref = xstrdup(buf.buf + 1);
 		else if (buf.buf[0] != '?')
 			get_sha1_hex(buf.buf, (*tail)->old_sha1);
+		if (eon) {
+			if (has_attribute(eon + 1, "unchanged")) {
+				(*tail)->status |= REF_STATUS_UPTODATE;
+				read_ref((*tail)->name, (*tail)->old_sha1);
+			}
+		}
 		tail = &((*tail)->next);
 	}
 	strbuf_release(&buf);
-- 
1.6.5.2.291.gf76a3
