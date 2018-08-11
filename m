Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182CA1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 15:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbeHKSTU (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 14:19:20 -0400
Received: from mout.web.de ([217.72.192.78]:52727 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeHKSTU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 14:19:20 -0400
Received: from [192.168.178.36] ([79.237.254.3]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQNma-1fKvuR3pue-00TiFv; Sat, 11
 Aug 2018 17:39:32 +0200
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 1/2] fsck: use strbuf_getline() to read skiplist file
Message-ID: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
Date:   Sat, 11 Aug 2018 17:39:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RxRvo45tiAto67dxlTT8kB94SyfeJy611TCCwDhpr+I+hK2oscl
 rNBQqeCcq24Ook+cWYUMCwI6nEYlAHytp1nB/r03IbJlgq5yxWvmLzeQOEdlwJrIYaOqJTT
 Wzc8EIC/LOgnlVoY+okN1yvoKIZjza6sidFG7QMys6gKSiL4uGdyhYttz4FnuDX0OW0FbIv
 qa5cSzgBb+aHO9HqAftYw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YADTHsG00tI=:3+IZ+zrcje6QmJMcIkqmMd
 NOAnCPkkt+58gOt2Q/GoZ9XH+Oh+IoQJjee5c1z9zTZS3mTvHpvCPDgXiWy7ywkJehN1DJcPK
 bYpwp82vagdp6kYxiGaOxtOV4XoJq3rIvHA1uEzgsXz4+87UCmM/n+bxAxomiLFjL7G4ZPipl
 gWkywPL84b0DZ8kABkRmaeS51xOontGXB7e4rzrbzARKN5Tf/S+Z2Kyin4L4BPLDT7SVaorrD
 Swe7Ok0Abx/aCfDchL7BV6C9XREgsZ4wmkN85BacWIqgwafj9wgz35Hvt6I61OCz6eyEi9RPh
 617nZlaYoLvnGxJT0N90IIanDokFPs/y7fSE7D+tc9uykL0u3tgmJrT0vIW5sfyWoYSTWJvAB
 /Pv4Ng59GnwCoD8UbSv4kOQoLHGpXVx6zritJOcRucBK2cD7yM6ovkLEGnxdzsE3/Jqi5JOfQ
 DrQ8Q7txYkzstydYczVNK8ZfkRFd1QwmEPNv4ar+8SDZUGzmQH2m1vB1YEeM/QoJ1i8OPatzK
 ownwFF6v7vrZYojqbufLEOjdRUvgrEKPYAF02r0+S4QZm+s3F1KNVOCqu8+qys3HOcYhSkvV4
 073PU+6Hq0yRscCwYbdj+E0v5/qmn1bg3+HTlX1o8sZlGyMpRjqfogbs+FEA6SJAQV3F2hdwO
 RwrqlclpQR6XhkhSAJz/l9V1OlOJbNWnR4iSFbRjIx30Bgy/HXB842FwxbFVN7hGQbKXMP3+e
 Fbu53auNIX5VbQxsCwtKYGilcz9t4c3vsOKdeBKgORAEuu9+S0dmgWRxmVPv/X2/S8iiVt/eb
 cQjXuDJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The char array named "buffer" is unlikely to contain a NUL character, so
printing its contents using %s in a die() format is unsafe.  Clang's
ASan reports running over the end of buffer in the recently added
skiplist tests in t5504-fetch-receive-strict.sh as a result.

Use an idiomatic strbuf_getline() loop instead, which ensures the buffer
is always NUL-terminated.  As a side-effect this also adds support for
skiplist files with CRLF line endings.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
  fsck.c | 23 ++++++++++-------------
  1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/fsck.c b/fsck.c
index a0cee0be59..83f4562390 100644
--- a/fsck.c
+++ b/fsck.c
@@ -183,8 +183,9 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
  static void init_skiplist(struct fsck_options *options, const char *path)
  {
  	static struct oid_array skiplist = OID_ARRAY_INIT;
-	int sorted, fd;
-	char buffer[GIT_MAX_HEXSZ + 1];
+	int sorted;
+	FILE *fp;
+	struct strbuf sb = STRBUF_INIT;
  	struct object_id oid;
  
  	if (options->skiplist)
@@ -194,25 +195,21 @@ static void init_skiplist(struct fsck_options *options, const char *path)
  		options->skiplist = &skiplist;
  	}
  
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
+	fp = fopen(path, "r");
+	if (!fp)
  		die("Could not open skip list: %s", path);
-	for (;;) {
+	while (!strbuf_getline(&sb, fp)) {
  		const char *p;
-		int result = read_in_full(fd, buffer, sizeof(buffer));
-		if (result < 0)
-			die_errno("Could not read '%s'", path);
-		if (!result)
-			break;
-		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n')
-			die("Invalid SHA-1: %s", buffer);
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
+			die("Invalid SHA-1: %s", sb.buf);
  		oid_array_append(&skiplist, &oid);
  		if (sorted && skiplist.nr > 1 &&
  				oidcmp(&skiplist.oid[skiplist.nr - 2],
  				       &oid) > 0)
  			sorted = 0;
  	}
-	close(fd);
+	fclose(fp);
+	strbuf_release(&sb);
  
  	if (sorted)
  		skiplist.sorted = 1;
-- 
2.18.0
