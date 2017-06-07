Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DEC1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751464AbdFGQGR (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:06:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:60902 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbdFGQGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:06:16 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3R1g-1e9dfG2V1M-00qwnc; Wed, 07
 Jun 2017 18:06:10 +0200
Date:   Wed, 7 Jun 2017 18:06:09 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/9] config: report correct line number upon error
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <078fd144ddefa22892861488a7d3f48eb8d5b775.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HXyo9ne2zVdZYgSonwpTVwNvler7TnwKrlmjuv6M0fAdBCUcRoR
 8qTalPQ1E3G2WQiD0ol2QW9vUyjxjGJu4rIT1cfSWkE3J9HQUG94dMVzpXVyImLqzshllXW
 +5hXCDpPjhVwy9OP5Ia434f12bnD9CbPJfzQ9L4ivm/A0o4dwb1/GnUDRhAEwFcIQp9f3Gf
 ixYDlVBUofgqS5ctksm7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3WGVBhxuz9o=:K++J2Uj0JelZgjXhgzT43z
 XOm4PM4jtuh+nviStT2ZlkGQ6NrgUzppPLGi6ubUGdRZ9HM3Z1DkdVReMtITmZUtPeCXqeaHu
 esuHnqZIfBRIToSvVJVnrOlanYl+rjHJecGbNyFw20XqTmSvKtB+yCWJMQzDWIWog+QZlJY8d
 GUwB6Poahphohoac2StAzMc7lsdjmpPgFCNvvYByZaggDyn9AQnI9zRHvmiX6w1LE8H7bwDsN
 rx0/JLYwuRNTn5VgBl/wPa83dU1TT4sxyPR4Zm2Z538XfkMfhIWVYN1Aa9cK8QGtD6y0sa2yy
 8EQMxk60ne126Wpfu4SMtqlJoLmKu/0Fr1l4zaRFquanhIhkMMR3K8/AlRf1T3EYsEnhHx1+c
 7oA1otRdqzousSX8gC4kvXGhZ9R7ToXuDMO5waaf5xn3tPp6MzTewsOj/nw0hZHxydlEXD7Jh
 VlP7KuEhDqtyvVXih0HJukhAYXmJHGaNfJzhNBKkiBZ5hxvg4RLoeQWoHWpjLN3Nmollmgq0R
 kEcbw8+vfUDw5krbsdOtfWE9tHehupujxCZA5ZUdm9dkWzbid0rVHQ9pw/D8HXVGSkEpxhiEz
 IqBtgIL6IewU0vl2dZK4ICCBK0CsNTxoqbEa1xfTyYOw60KklxRG0i9nEtooSxx3TpGJFnoto
 412p0pninaewuxz5Jvj7qh5qjVSnts1d5/5L4i32a8doahnqA37a8lTxg68MvLdQ36FxF+pHh
 Vcv/g9yqWUo5R4AAFHEkFmvLTvWDVXCJeEIFV+VZHruCYB/fh5mfDssxM4ovmewdRsUwA78bp
 SAH48lK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When get_value() parses a key/value pair, it is possible that the line
number is decreased (because the \n has been consumed already) before the
key/value pair is passed to the callback function, to allow for the
correct line to be attributed in case of an error.

However, when git_parse_source() asks get_value() to parse the key/value
pair, the error reporting is performed *after* get_value() returns.

Which means that we have to be careful not to increase the line number
in get_value() after the callback function returned an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 146cb3452ad..9b88531a70d 100644
--- a/config.c
+++ b/config.c
@@ -604,7 +604,8 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 	 */
 	cf->linenr--;
 	ret = fn(name->buf, value, data);
-	cf->linenr++;
+	if (!ret)
+		cf->linenr++;
 	return ret;
 }
 
-- 
2.13.0.windows.1.460.g13f583bedb5


