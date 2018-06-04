Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 539121F403
	for <e@80x24.org>; Mon,  4 Jun 2018 20:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeFDUdX (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 16:33:23 -0400
Received: from 28dayslater.mr.itd.umich.edu ([141.211.125.104]:33023 "EHLO
        28dayslater.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750950AbeFDUdX (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 16:33:23 -0400
X-Greylist: delayed 867 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jun 2018 16:33:23 EDT
Received: FROM tombraider.mr.itd.umich.edu (smtp.mail.umich.edu [141.211.12.86])
        By 28dayslater.mr.itd.umich.edu ID 5B159EAE.D3593.11963;
        Mon, 04 Jun 2018 16:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umich.edu;
        s=relay-2016-05-12; t=1528143533;
        bh=uQJpv4892s8g3ulcuRPNd5zSVNGSq5g+2WN81bz/qNA=;
        h=From:To:Cc:Subject:Date;
        b=PefrK6aS/fxajrOYyJvcxTY/sQaHmZOPhuRc6Mbnf0ZKtHXk/nHMgucB8JODylY4f
         TGV8iVxDX+Q8vE8MrF4FZ/9z6BAZNIoxDXSfMhQgf3uqPnQ2XXYivYEFsxDIEqRcXU
         4MH9d1EcEhsLsFz02pQpoarVzo5/ZwCmSsF0tHcAsWAG5KP71jIsnTyZNVjyybvKbx
         JfhKacNuQXyNa9JvWkSwTmsZvYANmIzmRZSzX2OILGsxXSzR6NwMv+yDjxiWKocHqe
         swzdcGVUMBU3HCE/AxIFzIOOH2rNi5D4lAutfN143BjYbkEN6ICFaoOuk3epCAW6w4
         wTSBzzw9EOFTA==
Authentication-Results: tombraider.mr.itd.umich.edu;
        iprev=permerror policy.iprev=4.14.106.7 (unknown);
        auth=pass smtp.auth=asottile
Received: FROM asottile-VirtualBox.lyft-corp.net (unknown [4.14.106.7])
        By tombraider.mr.itd.umich.edu ID 5B159EAC.C9EB1.30830;
        Authuser asottile;
        Mon, 04 Jun 2018 16:18:53 -0400
From:   Anthony Sottile <asottile@umich.edu>
To:     git@vger.kernel.org
Cc:     Anthony Sottile <asottile@umich.edu>
Subject: [PATCH] config.c: fix regression for core.safecrlf false
Date:   Mon,  4 Jun 2018 13:17:42 -0700
Message-Id: <20180604201742.18992-1-asottile@umich.edu>
X-Mailer: git-send-email 2.18.0.rc1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A regression introduced in 8462ff43e42ab67cecd16fdfb59451a53cc8a945 caused
autocrlf rewrites to produce a warning message despite setting safecrlf=false.

Signed-off-by: Anthony Sottile <asottile@umich.edu>
---
 config.c        |  2 +-
 t/t0020-crlf.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index fbbf0f8..de24e90 100644
--- a/config.c
+++ b/config.c
@@ -1233,7 +1233,7 @@ static int git_default_core_config(const char *var, const char *value)
 		}
 		eol_rndtrp_die = git_config_bool(var, value);
 		global_conv_flags_eol = eol_rndtrp_die ?
-			CONV_EOL_RNDTRP_DIE : CONV_EOL_RNDTRP_WARN;
+			CONV_EOL_RNDTRP_DIE : 0;
 		return 0;
 	}
 
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 71350e0..5f05698 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -98,6 +98,16 @@ test_expect_success 'safecrlf: git diff demotes safecrlf=true to warn' '
 '
 
 
+test_expect_success 'safecrlf: no warning with safecrlf=false' '
+	git config core.autocrlf input &&
+	git config core.safecrlf false &&
+
+	for w in I am all CRLF; do echo $w; done | append_cr >allcrlf &&
+	git add allcrlf 2>err &&
+	test_must_be_empty err
+'
+
+
 test_expect_success 'switch off autocrlf, safecrlf, reset HEAD' '
 	git config core.autocrlf false &&
 	git config core.safecrlf false &&
-- 
2.7.4

