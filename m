Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FAF620285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752187AbdH3Rua (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:30 -0400
Received: from mout.web.de ([212.227.17.12]:57942 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752028AbdH3RuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:09 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgHLE-1d8EPb2eH6-00ndMj for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 16/34] mailinfo: release strbuf after use in handle_from()
Date:   Wed, 30 Aug 2017 19:49:47 +0200
Message-Id: <20170830175005.20756-17-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:iW2ZNWvZ8UCLfiZ1T6LxE+FsSdeiev1iWNkdPBtlpmhkdv2TVzS
 xcrh6WF7kyI8XgRbNmJ/xlujq3EpO0e6m6MsNyCqOZ/O81KOEHvIEMI4THQvcjToHFDzVfB
 R+IzRp2YeMRSyhM5YtMhml4QnKa7xFpLqrnclyXpI7Dox4yCiinMJYZYbNnZT9GpiNM9LAD
 dFajYH4hwgZzoGSBWg+JQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M0oEkMCrrdU=:XopaosHm/CWUHl0qrFevV6
 siMGOxZmeQJ3AFxJQBjUZ6Y3k2NNIx2PbAbrJxP4mh9Vw3GfUBN3Hr3ZYySeXkcCOD08SKSnU
 RfS0ic+9IHkuxfnOWvrQ8jHQJkLuoMWMaz4Zhfv2sAhWK70IfAeELqKInO6RSPknbDyTcjc2o
 XxGIEe5ycpLTmUuGnobassGXrJsZHBqdyShpkwxT34VMebidPVvd/GAopPeSKVDUudPQHA/mS
 eTCHjECnvIo2XHdWS4Xjzsjw7tBzu6Y8UvQ5Tp74VS/en4fNok+iNvhqmaBbDbt9Np5Nicl9j
 0NRNg0w28d4HeJGXelCkiq5HDCA3AB+yRHEdysBFbAuGfqUWDrBqSblvPBJCqWEjxdJY2eDTU
 vUiQ+pcvcAfbwV0Yy0IN7AupiXUWYbV2skcSTrz3wjmxz1/7vZzqjxlCfymAfA0g1AdZhs8js
 QR9GZez1tMmAa/y7O4MrOLxfqspVWB4AP/LKJz9GnON1om2YlbZXJyjhGbDGyaxFtHsZIQScV
 cYXxEXQ8ErLC8Hetu+xhK0l+2cMyU/Usg3jUyHgQ76gwddKa+6r0YNhljEY4KwOrkpvLiwyeP
 qXZxWWTZl3lhbsUei9cpuLWLHCvAxkCVVKRXyxDn6rJsWw9KKXoIWtloObE/cI3JDheAFxdJF
 WSY47oteGuZmICKDDIuWTaTX0wTAZDrgP3KsyxJMWjGmv1rOqGPSVc2m7jMQgxe7oZkIjFG9u
 N7x0p1yA0IXMv8p8QdeqhPO6Rr95v544mx8rrBAI+NDeOy2q48PRZVgEyJHt3WmLhTrLO2lAJ
 9+VFfzJ9jzbQViICJ2McWqz4imRyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up at the end and jump there instead of returning early.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 mailinfo.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index bd574cb752..b1f5159546 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -138,66 +138,65 @@ static void unquote_quoted_pair(struct strbuf *line)
 static void handle_from(struct mailinfo *mi, const struct strbuf *from)
 {
 	char *at;
 	size_t el;
 	struct strbuf f;
 
 	strbuf_init(&f, from->len);
 	strbuf_addbuf(&f, from);
 
 	unquote_quoted_pair(&f);
 
 	at = strchr(f.buf, '@');
 	if (!at) {
 		parse_bogus_from(mi, from);
-		return;
+		goto out;
 	}
 
 	/*
 	 * If we already have one email, don't take any confusing lines
 	 */
-	if (mi->email.len && strchr(at + 1, '@')) {
-		strbuf_release(&f);
-		return;
-	}
+	if (mi->email.len && strchr(at + 1, '@'))
+		goto out;
 
 	/* Pick up the string around '@', possibly delimited with <>
 	 * pair; that is the email part.
 	 */
 	while (at > f.buf) {
 		char c = at[-1];
 		if (isspace(c))
 			break;
 		if (c == '<') {
 			at[-1] = ' ';
 			break;
 		}
 		at--;
 	}
 	el = strcspn(at, " \n\t\r\v\f>");
 	strbuf_reset(&mi->email);
 	strbuf_add(&mi->email, at, el);
 	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
 
 	/* The remainder is name.  It could be
 	 *
 	 * - "John Doe <john.doe@xz>"			(a), or
 	 * - "john.doe@xz (John Doe)"			(b), or
 	 * - "John (zzz) Doe <john.doe@xz> (Comment)"	(c)
 	 *
 	 * but we have removed the email part, so
 	 *
 	 * - remove extra spaces which could stay after email (case 'c'), and
 	 * - trim from both ends, possibly removing the () pair at the end
 	 *   (cases 'a' and 'b').
 	 */
 	cleanup_space(&f);
 	strbuf_trim(&f);
 	if (f.buf[0] == '(' && f.len && f.buf[f.len - 1] == ')') {
 		strbuf_remove(&f, 0, 1);
 		strbuf_setlen(&f, f.len - 1);
 	}
 
 	get_sane_name(&mi->name, &f, &mi->email);
+out:
 	strbuf_release(&f);
 }
 
-- 
2.14.1

