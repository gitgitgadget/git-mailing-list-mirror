From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 09/11] Allow parse_pack_index on temporary files
Date: Sat, 17 Apr 2010 13:07:42 -0700
Message-ID: <1271534864-31944-9-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJR-0005ew-ON
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab0DQUIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:08:14 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:57482 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab0DQUID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:08:03 -0400
Received: by mail-gx0-f217.google.com with SMTP id 9so2216648gxk.8
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:08:03 -0700 (PDT)
Received: by 10.101.3.28 with SMTP id f28mr7379262ani.221.1271534883257;
        Sat, 17 Apr 2010 13:08:03 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 4sm1085684yxd.16.2010.04.17.13.08.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:08:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145180>

The easiest way to verify a pack index is to open it through the
standard parse_pack_index function, permitting the header check
to happen when the file is mapped.  However, the dumb HTTP client
needs to verify a pack index before its moved into its proper file
name within the objects/pack directory, to prevent a corrupt index
from being made available.  So permit the caller to specify the
exact path of the index file.

For now we're still using the final destination name within the
sole call site in http.c, but eventually we will start to parse
the temporary path instead.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 cache.h     |    2 +-
 http.c      |    2 +-
 sha1_file.c |    3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 4150603..0d101e4 100644
--- a/cache.h
+++ b/cache.h
@@ -905,7 +905,7 @@ struct extra_have_objects {
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1);
+extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
diff --git a/http.c b/http.c
index 1a52740..9f3dfc1 100644
--- a/http.c
+++ b/http.c
@@ -932,7 +932,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	if (fetch_pack_index(sha1, base_url))
 		return -1;
 
-	new_pack = parse_pack_index(sha1);
+	new_pack = parse_pack_index(sha1, sha1_pack_index_name(sha1));
 	if (!new_pack)
 		return -1; /* parse_pack_index() already issued error message */
 	new_pack->next = *packs_head;
diff --git a/sha1_file.c b/sha1_file.c
index 820063e..74bba79 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -838,9 +838,8 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	return p;
 }
 
-struct packed_git *parse_pack_index(unsigned char *sha1)
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 {
-	const char *idx_path = sha1_pack_index_name(sha1);
 	const char *path = sha1_pack_name(sha1);
 	struct packed_git *p = alloc_packed_git(strlen(path) + 1);
 
-- 
1.7.1.rc1.269.ga27c7
