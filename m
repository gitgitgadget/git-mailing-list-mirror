Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B174F20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdH3SAw (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:00:52 -0400
Received: from mout.web.de ([217.72.192.78]:65082 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752576AbdH3SAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:00:40 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBkLb-1dcu9p2fAd-00AkFv for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:00:38 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 26/34] sha1_file: release strbuf on error return in index_path()
Date:   Wed, 30 Aug 2017 20:00:29 +0200
Message-Id: <20170830180037.20950-7-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830180037.20950-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830180037.20950-1-l.s.r@web.de>
X-Provags-ID: V03:K0:eKVsWnMp5kDzErfDyKh+vBFc/xxX82jDa4//1xtz4+otuE0B57w
 yBgQjAqBfum2QYfmHz/lGYUrRArpSsRD9o/LnuPeGN0XCJQ6rgVxUyYHzQsCZ/xaGfUj60p
 itveJrwoumh5ssUbDHr+RXAdZvQ8jOPiyEnA6BdTwBlL0jDeCJvCyKS6OjoEcVF9j7JIHs4
 S9TSiY8eEvT4SL8tOg9lw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6PszexAjvys=:EjwEF0mZkK65c0nB/yXujk
 MN21WMyjvqDIESIKLC3LjwIoC7IqaP2iBKmSrInYxne9X3/TeQpmy3u3KEPHQ9QuL7JALJH8j
 wWUnPiHyEbkmQRSchYxjHUTOUvt6ndyxZkO1K6Evf0WnHtvig5MXeFNShqP7fvOnXBgHQt4OA
 u9u8JDlpajLGnuFLKPVjrPZzmE+ZzuyeaGaQshxdwe6DlY4tcOjD7KMT63QuBYf+YIL3wb83a
 nKy9bvC7WaqHsRR24FDuJCB354J1AEsZDI7DkOgQeRoyEb6x501Gtx+7ZEgpMyxa8l19jt4iX
 9Ki1ihKj2eJq8akO2wNCV7YwPnaLkAlZP0+yISt9kznBvT3b9FPt3L8/AzA6ztCRh87hIKQV8
 +ySXyw+uY2eW//8nMGSHDXcvW4sPIcW6ZzbcQKvbxq6JfgkkzDY58TW1WtmmgqfZHvryj3eaO
 ukN4NTBjUiDovG8fook+tf+nC1+MTTpQ4/t+zdbpqgLe0rQY0owd6QQ/kq8ZYUFU27aS0vnkP
 VRRUrlFUjxWYT4CG4L26VPxWT03QgvyM9D7lkJDIuSVUYzopknztHtM+zVGo4RZS408PvHLVy
 vhHJHGIg0MCFskXkgjuCqwOKQcN2qLe3qZ9Ybi3cgmInrEbWnZk37AaWhShjrDAJKYK2tmNjB
 4wGGnwhbfm1DAu4I6ymfg8oJ5Rbbz57Wh9yQ0zU/Dz9R7x4Ni4M11uPimcl5YWRjW0h0jWcDn
 yfcA9L/WBpOuZua0SdWzLV8U6Wwy3Id58bC93QXegS0tdAW1okZ2o3BETyXFoip4rlCcQaAUW
 6GJg9sUAqJ9P7AIDgbWHFC25SwFGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

strbuf_readlink() already frees the buffer for us on error.  Clean up
if write_sha1_file() fails as well instead of returning early.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 sha1_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f56bb5cae7..7d9c9aed2f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1819,33 +1819,33 @@ int index_fd(struct object_id *oid, int fd, struct stat *st,
 int index_path(struct object_id *oid, const char *path, struct stat *st, unsigned flags)
 {
 	int fd;
 	struct strbuf sb = STRBUF_INIT;
+	int rc = 0;
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFREG:
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error_errno("open(\"%s\")", path);
 		if (index_fd(oid, fd, st, OBJ_BLOB, path, flags) < 0)
 			return error("%s: failed to insert into database",
 				     path);
 		break;
 	case S_IFLNK:
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & HASH_WRITE_OBJECT))
 			hash_sha1_file(sb.buf, sb.len, blob_type, oid->hash);
 		else if (write_sha1_file(sb.buf, sb.len, blob_type, oid->hash))
-			return error("%s: failed to insert into database",
-				     path);
+			rc = error("%s: failed to insert into database", path);
 		strbuf_release(&sb);
 		break;
 	case S_IFDIR:
 		return resolve_gitlink_ref(path, "HEAD", oid->hash);
 	default:
 		return error("%s: unsupported file type", path);
 	}
-	return 0;
+	return rc;
 }
 
 int read_pack_header(int fd, struct pack_header *header)
-- 
2.14.1

