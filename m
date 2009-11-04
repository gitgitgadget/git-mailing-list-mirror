From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 10/13] Allow helpers to report in "list" command that the ref is unchanged
Date: Wed,  4 Nov 2009 20:48:15 +0100
Message-ID: <1257364098-1685-11-git-send-email-srabbelier@gmail.com>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Cc: Daniel Barkalow <barkalow@iabervon.org>
To: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrh-0000NL-Vo
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:49:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758102AbZKDTtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758098AbZKDTtS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:18 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:61042 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083AbZKDTtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:14 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3490470ewy.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XPwqIupSzkhULwKxdnC4LACqj8hFd4ccosrywguUDGk=;
        b=dbBGpCKdEafWEOH0ysVWWRMWwotyQSPMKJ8Ghp3d/FsGWNiGgbHIZxjg9FSb7knwJa
         jDcd4lN52jp71zapGQyQ7FeafVCyGnLkC/PTJHAenNlm3P4O9b6hkB7eVQLW8AOBb9Q/
         5XUnZZhapWh7V/Oj4aw5gWbbOujzj9isMGzVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uM7AJsoGhRsM2z9Lo5uSsWb23DxQ697uHdFRx7IB/lF/OaC1hCxUmB7qt856DSnlxn
         o01DIil4Hhex0nkpc6kblgszE3pib4mpelmWRUHHrZAvSXtNhnXXEOdsle8aTCqc0Nge
         POZ7ZZecG+IN57h7aDmHoDf8tMfvx1rG0SS78=
Received: by 10.213.2.73 with SMTP id 9mr2286495ebi.21.1257364159575;
        Wed, 04 Nov 2009 11:49:19 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 5sm4314489eyh.2.2009.11.04.11.49.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 11:49:18 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132130>

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
index 72ed95b..a80d803 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -176,6 +176,22 @@ static int fetch(struct transport *transport,
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
@@ -210,6 +226,12 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
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
1.6.5.2.295.g0d105
