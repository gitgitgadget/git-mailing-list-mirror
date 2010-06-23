From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH 4/7] Replace deprecated svn_path_join
Date: Wed, 23 Jun 2010 18:22:17 +0200
Message-ID: <1277310140-16891-5-git-send-email-artagnon@gmail.com>
References: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 23 18:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORShb-000170-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 18:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186Ab0FWQVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 12:21:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59780 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041Ab0FWQVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 12:21:14 -0400
Received: by mail-wy0-f174.google.com with SMTP id 11so931137wyi.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 09:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=SzphC+ua6Sy2wdLU0uYUd/86eofblKHcQsbwL4rkGsI=;
        b=paXpIP8YkjaqopU+JzRVsZ39KX5hv5Otiq/RJzCOFHWsGzrZqppFmFnNUg6yG7KoH1
         H4MNLXkYD+gj1ed6xraK/51tICaKxBb487wYCRinX693joV2j3GsNX81H6w4nqNi636J
         Ehm+c+oK+eLK/O/H8SSQ56Xna447ulDYq6qOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BExjpN7YaaNMyqbQxJ1Bm4An5gSSKqG3ls9ZfwVwN9cqukb+1Caan9gmxysmp2q171
         JUZ81UlSP3n/i69dfjOiZeMNyTAs/GI62KT620H9MYVPUDwfwpNlnqD9ArTr2Ewr5lEi
         vZNWsDpVin3E9tZWVEw5na2iRtPlseDygn39c=
Received: by 10.216.161.67 with SMTP id v45mr6173844wek.26.1277310073299;
        Wed, 23 Jun 2010 09:21:13 -0700 (PDT)
Received: from localhost ([130.226.133.98])
        by mx.google.com with ESMTPS id n50sm1060293weq.33.2010.06.23.09.21.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 09:21:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1277310140-16891-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149514>

Strip the deprecated svn_path_join API, using svn_path_compose
instead. Re-add -Werror to the Makefile.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Makefile      |    2 +-
 dump_editor.c |   21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 269c406..cf7fef7 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
 svnclient_ra: *.c *.h
-	$(CC) -Wall -ggdb3 -O0 -o $@ svnclient_ra.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
+	$(CC) -Wall -Werror -ggdb3 -O0 -o $@ svnclient_ra.c debug_editor.c dump_editor.c -lsvn_client-1 -I. -I/usr/local/include/subversion-1 -I/usr/include/apr-1.0
 clean:
 	$(RM) svnclient_ra
diff --git a/dump_editor.c b/dump_editor.c
index ba0630f..00c838a 100644
--- a/dump_editor.c
+++ b/dump_editor.c
@@ -80,14 +80,17 @@ struct dir_baton *make_dir_baton(const char *path,
 	struct dir_baton *pb = parent_dir_baton;
 	struct dir_baton *new_db = apr_pcalloc(pool, sizeof(*new_db));
 	const char *full_path;
-
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
 
 	/* A path relative to nothing?  I don't think so. */
 	SVN_ERR_ASSERT_NO_RETURN(!path || pb);
 
 	/* Construct the full path of this node. */
-	if (pb)
-		full_path = svn_path_join("/", path, pool);
+	if (pb) {
+		APR_ARRAY_PUSH(compose_path, const char *) = "/";
+		APR_ARRAY_PUSH(compose_path, const char *) = path;
+		full_path = svn_path_compose(compose_path, pool);
+	}
 	else
 		full_path = apr_pstrdup(pool, "/");
 
@@ -332,12 +335,14 @@ svn_error_t *open_directory(const char *path,
 	struct dir_baton *new_db;
 	const char *cmp_path = NULL;
 	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
 
 	/* If the parent directory has explicit comparison path and rev,
 	   record the same for this one. */
 	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
-		cmp_path = svn_path_join(pb->cmp_path,
-		                         svn_dirent_basename(path, pool), pool);
+		APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+		APR_ARRAY_PUSH(compose_path, const char *) = svn_dirent_basename(path, pool);
+		cmp_path = svn_path_compose(compose_path, pool);
 		cmp_rev = pb->cmp_rev;
 	}
 
@@ -424,11 +429,13 @@ svn_error_t *open_file(const char *path,
 	const char *cmp_path = NULL;
 	svn_revnum_t cmp_rev = SVN_INVALID_REVNUM;
 
+	apr_array_header_t *compose_path = apr_array_make(pool, 2, sizeof(const char *));
 	/* If the parent directory has explicit comparison path and rev,
 	   record the same for this one. */
 	if (pb && ARE_VALID_COPY_ARGS(pb->cmp_path, pb->cmp_rev)) {
-		cmp_path = svn_path_join(pb->cmp_path,
-		                         svn_dirent_basename(path, pool), pool);
+		APR_ARRAY_PUSH(compose_path, const char *) = pb->cmp_path;
+		APR_ARRAY_PUSH(compose_path, const char *) = svn_dirent_basename(path, pool);
+		cmp_path = svn_path_compose(compose_path, pool);
 		cmp_rev = pb->cmp_rev;
 	}
 
-- 
1.7.1
