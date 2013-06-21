From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 05/16] remote: remove dead code in read_branches_file()
Date: Fri, 21 Jun 2013 16:42:29 +0530
Message-ID: <1371813160-4200-6-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKK-0003RE-Of
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319Ab3FULQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:14 -0400
Received: from mail-pb0-f50.google.com ([209.85.160.50]:41543 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965550Ab3FULQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:08 -0400
Received: by mail-pb0-f50.google.com with SMTP id wz7so7665612pbc.37
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=I6qQfcb0zrIX8qgFn6qxAPcLqpJU5g81T60Mf3GC1dM=;
        b=CRQIvIN15DNu4SpFg5s/xXuQUdUU9bj8LwQIUcqoMIuDC60JW6DLJWaNp7WitN/p0c
         K+7pP18n5ZdKUcQVcaqFCVyfcm3yVAYCA01urUfLeO2OuJnRp+JWqTO5Yx9S+McRTt8h
         SAtCq9C5DkN0c5xyEUV2pYHdi2ELPjmYA48PUZdqAyexxWTouCtcxprO/G0CDOoCID3M
         eBbbUbiVZt7cdiqiz1lGFioULjRWOPqJBGdxmPDkOLGOwP0lsGrDXYo7JcTnydiYvEmV
         C1o4mET0Q4eoXP5QFhad95RtE1tTm/rTgmRgZ8EEogtX25di6fsbZohZoLkUYp9V/i46
         p6Ww==
X-Received: by 10.66.193.199 with SMTP id hq7mr15986014pac.183.1371813368286;
        Fri, 21 Jun 2013 04:16:08 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228600>

The first line of the function checks that the remote-name contains a
slash ('/'), and sets the "slash" variable accordingly.  The only caller
of read_branches_file() is remote_get_1(); the calling codepath is
guarded by valid_remote_nick(), which checks that the remote does not
contain a slash.  Therefore, the "slash" variable can never be set:
remove the dead code that assumes otherwise.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/remote.c b/remote.c
index e71f66d..128b210 100644
--- a/remote.c
+++ b/remote.c
@@ -276,10 +276,9 @@ static void read_remotes_file(struct remote *remote)
 
 static void read_branches_file(struct remote *remote)
 {
-	const char *slash = strchr(remote->name, '/');
 	char *frag;
 	struct strbuf branch = STRBUF_INIT;
-	int n = slash ? slash - remote->name : 1000;
+	int n = 1000;
 	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
 	char *s, *p;
 	int len;
@@ -299,36 +298,17 @@ static void read_branches_file(struct remote *remote)
 	while (isspace(p[-1]))
 		*--p = 0;
 	len = p - s;
-	if (slash)
-		len += strlen(slash);
 	p = xmalloc(len + 1);
 	strcpy(p, s);
-	if (slash)
-		strcat(p, slash);
 
-	/*
-	 * With "slash", e.g. "git fetch jgarzik/netdev-2.6" when
-	 * reading from $GIT_DIR/branches/jgarzik fetches "HEAD" from
-	 * the partial URL obtained from the branches file plus
-	 * "/netdev-2.6" and does not store it in any tracking ref.
-	 * #branch specifier in the file is ignored.
-	 *
-	 * Otherwise, the branches file would have URL and optionally
-	 * #branch specified.  The "master" (or specified) branch is
-	 * fetched and stored in the local branch of the same name.
-	 */
 	frag = strchr(p, '#');
 	if (frag) {
 		*(frag++) = '\0';
 		strbuf_addf(&branch, "refs/heads/%s", frag);
 	} else
 		strbuf_addstr(&branch, "refs/heads/master");
-	if (!slash) {
-		strbuf_addf(&branch, ":refs/heads/%s", remote->name);
-	} else {
-		strbuf_reset(&branch);
-		strbuf_addstr(&branch, "HEAD:");
-	}
+
+	strbuf_addf(&branch, ":refs/heads/%s", remote->name);
 	add_url_alias(remote, p);
 	add_fetch_refspec(remote, strbuf_detach(&branch, NULL));
 	/*
-- 
1.8.3.1.499.g7ad3486.dirty
