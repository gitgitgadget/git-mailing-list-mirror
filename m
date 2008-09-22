Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 7773 invoked by uid 111); 22 Sep 2008 17:20:58 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 22 Sep 2008 13:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbYIVRUc (ORCPT <rfc822;peff@peff.net>);
	Mon, 22 Sep 2008 13:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbYIVRUc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 13:20:32 -0400
Received: from [212.249.11.140] ([212.249.11.140]:57875 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751517AbYIVRUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 13:20:31 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 65EC02AC8E4; Mon, 22 Sep 2008 19:20:21 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com
Subject: [PATCH] Do not perform cross-directory renames when creating packs
Date:	Mon, 22 Sep 2008 19:20:21 +0200
Message-Id: <1222104021-28277-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

A comment on top of create_tmpfile() describes caveats ('can have
problems on various systems (FAT, NFS, Coda)') that should apply
in this situation as well.  This in the end did not end up solving
any of my personal problems, but it might be a useful cleanup patch
nevertheless.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---

If this one gets dropped now, I don't intend pursuing it further.

 builtin-pack-objects.c |    2 +-
 fast-import.c          |    4 ++--
 index-pack.c           |    2 +-
 pack-write.c           |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 5fc1b8c..1158e42 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -465,7 +465,7 @@ static void write_pack_file(void)
 			char tmpname[PATH_MAX];
 			int fd;
 			snprintf(tmpname, sizeof(tmpname),
-				 "%s/tmp_pack_XXXXXX", get_object_directory());
+				 "%s/pack/tmp_pack_XXXXXX", get_object_directory());
 			fd = xmkstemp(tmpname);
 			pack_tmp_name = xstrdup(tmpname);
 			f = sha1fd(fd, pack_tmp_name);
diff --git a/fast-import.c b/fast-import.c
index ccdf2e5..ab6689a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -816,7 +816,7 @@ static void start_packfile(void)
 	int pack_fd;
 
 	snprintf(tmpfile, sizeof(tmpfile),
-		"%s/tmp_pack_XXXXXX", get_object_directory());
+		"%s/pack/tmp_pack_XXXXXX", get_object_directory());
 	pack_fd = xmkstemp(tmpfile);
 	p = xcalloc(1, sizeof(*p) + strlen(tmpfile) + 2);
 	strcpy(p->pack_name, tmpfile);
@@ -878,7 +878,7 @@ static char *create_index(void)
 	}
 
 	snprintf(tmpfile, sizeof(tmpfile),
-		"%s/tmp_idx_XXXXXX", get_object_directory());
+		"%s/pack/tmp_idx_XXXXXX", get_object_directory());
 	idx_fd = xmkstemp(tmpfile);
 	f = sha1fd(idx_fd, tmpfile);
 	sha1write(f, array, 256 * sizeof(int));
diff --git a/index-pack.c b/index-pack.c
index a6e91fe..530d820 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -172,7 +172,7 @@ static char *open_pack_file(char *pack_name)
 		if (!pack_name) {
 			static char tmpfile[PATH_MAX];
 			snprintf(tmpfile, sizeof(tmpfile),
-				 "%s/tmp_pack_XXXXXX", get_object_directory());
+				 "%s/pack/tmp_pack_XXXXXX", get_object_directory());
 			output_fd = xmkstemp(tmpfile);
 			pack_name = xstrdup(tmpfile);
 		} else
diff --git a/pack-write.c b/pack-write.c
index 939ed56..3621f1d 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -45,7 +45,7 @@ char *write_idx_file(char *index_name, struct pack_idx_entry **objects,
 	if (!index_name) {
 		static char tmpfile[PATH_MAX];
 		snprintf(tmpfile, sizeof(tmpfile),
-			 "%s/tmp_idx_XXXXXX", get_object_directory());
+			 "%s/pack/tmp_idx_XXXXXX", get_object_directory());
 		fd = xmkstemp(tmpfile);
 		index_name = xstrdup(tmpfile);
 	} else {
-- 
tg: (fe33b33..) t/pack/crossdir (depends on: vanilla/master)
