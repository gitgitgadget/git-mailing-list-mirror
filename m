Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C55203BD
	for <e@80x24.org>; Tue, 25 Oct 2016 18:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759135AbcJYSRS (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:17:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57123 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755817AbcJYSRM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:17:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 620AF473F1;
        Tue, 25 Oct 2016 14:16:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=SY06
        tXla+ktY25bfZcMh9PtaERE=; b=cz5k39tlnGHsC/62TFdB8UUjOtgPNQTLGDyV
        SjlhkxJ0RrBe1AlJO9fl3yPvEKxkCBjrHpFgNHvc92MrHc5kxFPu2PSnDajRn6O5
        Q4Jvmf+1A/XMkbAOKRv7onURioAX50R1SmqQ79WvH4L7bnRG43CPKKDR5WLJ5dKb
        94dGSeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        jTwX7YK1HVFxThuSlN88CFczCvF/P+hEvP4dqvSVWY/VIJk0ZYL2uCgPtUjvX4B9
        +UJS6Kvaq/sDe5+58/7BvbPUf4l7In20y8iDvIxtwtXiTAlUlOQK6eqxM+Bkv8WW
        0F12T2BRefu5S0tkoEwS5ND5oEKvqhoUZSaz7/ojHpg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58A46473F0;
        Tue, 25 Oct 2016 14:16:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD856473EF;
        Tue, 25 Oct 2016 14:16:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>, Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
Date:   Tue, 25 Oct 2016 11:16:20 -0700
Message-Id: <20161025181621.4201-3-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-777-gd068e6bde7
In-Reply-To: <20161025181621.4201-1-gitster@pobox.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
X-Pobox-Relay-ID: 2B713CCE-9ADF-11E6-BB0B-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

All processes that the Git main process spawns inherit the open file
descriptors of the main process. These leaked file descriptors can
cause problems.

Use the O_CLOEXEC flag similar to 05d1ed61 to fix the leaked file
descriptors.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And the remainder of original 1/2, again taking suggestion by DScho.

 sha1_file.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5d2bcd3ed1..09045df1dc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1561,7 +1561,7 @@ int check_sha1_signature(const unsigned char *sha1, void *map,
 
 int git_open(const char *name)
 {
-	static int sha1_file_open_flag = O_NOATIME;
+	static int sha1_file_open_flag = O_NOATIME | O_CLOEXEC;
 
 	for (;;) {
 		int fd;
@@ -1571,12 +1571,17 @@ int git_open(const char *name)
 		if (fd >= 0)
 			return fd;
 
-		/* Might the failure be due to O_NOATIME? */
-		if (errno != ENOENT && sha1_file_open_flag) {
-			sha1_file_open_flag = 0;
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		if ((sha1_file_open_flag & O_CLOEXEC) && errno == EINVAL) {
+			sha1_file_open_flag &= ~O_CLOEXEC;
 			continue;
 		}
 
+		/* Might the failure be due to O_NOATIME? */
+		if (errno != ENOENT && (sha1_file_open_flag & O_NOATIME)) {
+			sha1_file_open_flag &= ~O_NOATIME;
+			continue;
+		}
 		return -1;
 	}
 }
-- 
2.10.1-777-gd068e6bde7

