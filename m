From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v4 09/11] Allow parse_pack_index on temporary files
Date: Mon, 19 Apr 2010 07:23:08 -0700
Message-ID: <1271686990-16363-5-git-send-email-spearce@spearce.org>
References: <20100418115744.0000238b@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 19 16:23:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3rt0-0000jt-MT
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 16:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab0DSOXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 10:23:38 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:63892 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab0DSOXg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 10:23:36 -0400
Received: by ewy20 with SMTP id 20so1476770ewy.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 07:23:34 -0700 (PDT)
Received: by 10.103.126.36 with SMTP id d36mr131433mun.65.1271687014356;
        Mon, 19 Apr 2010 07:23:34 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id y37sm28163762mug.52.2010.04.19.07.23.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Apr 2010 07:23:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.279.g22727
In-Reply-To: <20100418115744.0000238b@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145300>

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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 No change from v3.

 cache.h     |    2 +-
 http.c      |    2 +-
 sha1_file.c |    3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 0eba039..7db23ef 100644
--- a/cache.h
+++ b/cache.h
@@ -900,7 +900,7 @@ struct extra_have_objects {
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
 extern int server_supports(const char *feature);
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1);
+extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 extern void prepare_packed_git(void);
 extern void reprepare_packed_git(void);
diff --git a/http.c b/http.c
index 95e3b8b..9c62632 100644
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
index 4e82654..9f3f514 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -845,9 +845,8 @@ struct packed_git *add_packed_git(const char *path, int path_len, int local)
 	return p;
 }
 
-struct packed_git *parse_pack_index(unsigned char *sha1)
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
 {
-	const char *idx_path = sha1_pack_index_name(sha1);
 	const char *path = sha1_pack_name(sha1);
 	struct packed_git *p = alloc_packed_git(strlen(path) + 1);
 
-- 
1.7.1.rc1.279.g22727
