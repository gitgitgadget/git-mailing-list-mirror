From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 05/14] remote: remove dead code in read_branches_file()
Date: Sat, 22 Jun 2013 13:28:12 +0530
Message-ID: <1371887901-5659-6-git-send-email-artagnon@gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 22 10:02:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqIlm-00086I-Ue
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 10:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423739Ab3FVIBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Jun 2013 04:01:54 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:43463 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423719Ab3FVIBw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jun 2013 04:01:52 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so8752627pbc.21
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=W7WZH6PlFNE2kh4aRlL0y90M+2uH9LoobdXPfb4kL34=;
        b=mTOFFcRJu6v+FQKr4BHOaZbFiC7gIB1agkCwAfMvrKKUHQqpvNh6VtSf34MxH6NuMR
         D4effo4EAhFn6BH9e54SgsLVSwtLvdERxw2w9wg+7RzXcWyVGWui1G+aBre31UGt5+NC
         q2nkNk13PiBheHXQYcj2lD5QbbQjvnheijqcNxqXoSTemu3F6f8qcNE6OTqwSr/8cKZr
         S+aoPdZf6ozJXtC4Gs17SMTsy0AvNCf4knOBuEUBRzLSQkOiepJo3jHHbHPN9kcLbuOC
         He5pUl8Rtt7HZXPC0rqrMYwpEdm3hsazTCqNp/LLqfuMvW/IBubljc3lEd2STNk++UKQ
         b/Ew==
X-Received: by 10.68.3.107 with SMTP id b11mr15799961pbb.118.1371888111739;
        Sat, 22 Jun 2013 01:01:51 -0700 (PDT)
Received: from localhost.localdomain ([122.174.20.35])
        by mx.google.com with ESMTPSA id dc3sm8355333pbc.9.2013.06.22.01.01.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Jun 2013 01:01:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.487.gd3dfebf
In-Reply-To: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228681>

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
1.8.3.1.498.gacf2885
