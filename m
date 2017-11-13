Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 500A91F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 17:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbdKMRNe (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 12:13:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:39760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753854AbdKMRNd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 12:13:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9F22AAB9
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 17:13:32 +0000 (UTC)
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Subject: [RFC 1/3] mailinfo: extract patch series id
To:     git@vger.kernel.org
References: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Openpgp: preference=signencrypt
Message-ID: <2252b046-a608-b2aa-d67a-8f7e95fe2dbc@suse.de>
Date:   Mon, 13 Nov 2017 18:13:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:56.0) Gecko/20100101
 Thunderbird/56.0
MIME-Version: 1.0
In-Reply-To: <xmqqbmk68o9d.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: fr-xx-classique+reforme1990
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract the patch ID and series length from the [PATCH N/M]
 prefix in the mail header

Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
---
 mailinfo.c | 35 +++++++++++++++++++++++++++++++++++
 mailinfo.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/mailinfo.c b/mailinfo.c
index a89db22ab..2ab9d446d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -308,6 +308,39 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 			if (!pos)
 				break;
 			remove = pos - subject->buf + at + 1;
+			if (7 <= remove &&
+			    memmem(subject->buf + at, remove, "PATCH", 5)){
+				/*
+				 * Look for a N/M series identifier at
+				 * the end of the brackets
+				 */
+				int is_series = 1;
+				int ret, num, total;
+				int pt = at + remove - 2;
+
+				if (!isdigit(subject->buf[pt]))
+					is_series = 0;
+				else {
+					while(isdigit(subject->buf[--pt]));
+				}
+
+				if(is_series && subject->buf[pt--] != '/')
+					is_series = 0;
+
+				if (!isdigit(subject->buf[pt]))
+					is_series = 0;
+				if (is_series)
+					while(isdigit(subject->buf[--pt]));
+
+				pt++;
+
+				ret = sscanf(subject->buf + pt, "%d/%d]", &num, &total);
+				if (ret == 2){
+					mi->series_id = num;
+					mi->series_len = total;
+				}
+			}
+
 			if (!mi->keep_non_patch_brackets_in_subject ||
 			    (7 <= remove &&
 			     memmem(subject->buf + at, remove, "PATCH", 5)))
@@ -1154,6 +1187,8 @@ void setup_mailinfo(struct mailinfo *mi)
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
 	mi->content_top = mi->content;
+	mi->series_id = -1;
+	mi->series_len = -1;
 	git_config(git_mailinfo_config, mi);
 }
 
diff --git a/mailinfo.h b/mailinfo.h
index 04a25351d..bd4f7c9e0 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -21,6 +21,8 @@ struct mailinfo {
 	struct strbuf **content_top;
 	struct strbuf charset;
 	char *message_id;
+	int series_id;    /* Id of the patch within a patch series. -1 if not a patch series */
+	int series_len;   /* Length of the patch series. -1 if not a patch series */
 	enum  {
 		TE_DONTCARE, TE_QP, TE_BASE64
 	} transfer_encoding;
-- 
2.15.0.169.g3d3eebb67.dirty


