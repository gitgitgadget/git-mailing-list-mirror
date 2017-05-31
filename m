Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866F51FD09
	for <e@80x24.org>; Wed, 31 May 2017 23:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdEaXfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 19:35:31 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:34854
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751033AbdEaXf3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 31 May 2017 19:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496273712;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=EcOl2bRlUEayMUYT5XY1Rh+EpcCVe4EqmueL2Q0tUfs=;
        b=HGNu+oYIPoIrv9C/OCJrZth8i3hV/cKEMfx014bjg2/kROAgDbh1Y8LNOdtt3Tac
        7EGv4VcaRrwN2WVfwuZohT8L+VI1hPyXIvZKOtIAA0RyUiwNNkfHw15i3eeOt1hOmVC
        YOX3MhUZwFkiMdLDGb3GgTXUY6BpqWcthLB8BCKA=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c60dcf691-aeac42e6-0b21-4467-9af5-fea131665df3-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
References: <0102015c60dcf5f6-057de56f-3355-40dc-a0d3-ee62fa9b8259-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC v2 3/6] config: abstract out create section from key
 logic
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 May 2017 23:35:12 +0000
X-SES-Outgoing: 2017.05.31-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abstracts out the logic for creating string buffer from given key for
example - 'branch.b' and returns '[branch "b"]'.

We want to keep the original config section intact in case of copy
operation. For this we need to fetch the section with updated new branch
name so that we can write that to the config file.

For example - git branch -c foo bar
The mentioned/edited function renames and overwrites this part in the
config - [branch "foo"] to [branch "bar"]. However, in case of copy, we
want to keep the original [branch "foo"] intact and get [branch "bar"]
from "branch.bar" key. 'store_create_section' function will return
[branch "bar"] when "branch.bar" is passed.

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 config.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 78cf1ffac043e..d3d48bfae3b96 100644
--- a/config.c
+++ b/config.c
@@ -2169,10 +2169,10 @@ static int write_error(const char *filename)
 	return 4;
 }
 
-static int store_write_section(int fd, const char *key)
+struct strbuf store_create_section(const char *key)
 {
 	const char *dot;
-	int i, success;
+	int i;
 	struct strbuf sb = STRBUF_INIT;
 
 	dot = memchr(key, '.', store.baselen);
@@ -2188,6 +2188,16 @@ static int store_write_section(int fd, const char *key)
 		strbuf_addf(&sb, "[%.*s]\n", store.baselen, key);
 	}
 
+	return sb;
+}
+
+static int store_write_section(int fd, const char *key)
+{
+	int success;
+
+	/* Create a section with the given key */
+	struct strbuf sb = store_create_section(key);
+
 	success = write_in_full(fd, sb.buf, sb.len) == sb.len;
 	strbuf_release(&sb);
 

--
https://github.com/git/git/pull/363
