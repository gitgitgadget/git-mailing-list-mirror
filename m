Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C68320401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbdFNLgK (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:36:10 -0400
Received: from mout.gmx.net ([212.227.17.21]:59951 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752243AbdFNLgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:36:09 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lpxdr-1e0BpU2Xfr-00fgQD; Wed, 14
 Jun 2017 13:35:47 +0200
Date:   Wed, 14 Jun 2017 13:35:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v4 2/6] config: report correct line number upon error
In-Reply-To: <cover.1497440104.git.johannes.schindelin@gmx.de>
Message-ID: <af8b91b870e67600690fc9c1886fa32985b66b0b.1497440104.git.johannes.schindelin@gmx.de>
References: <cover.1497440104.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/v+sg2LsJH2hrask74+8/rCjYG1Z3SaGmwwvre5w3gulpyfPbwW
 lOPDhbCH0vMnYrg9VMLbk0+GiBHdQ6FLVvufaRbwyB4z78FAAjwB+fqLOb1gpad6w9EJLKX
 2aG+0H623kXXyvve9LSOGNErI9ev4I02FFtWjLTcam1whqPtOQPz6/FKXEiPJ2DmrCpojj/
 X8Dxayat2x0WYdN03e6nw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/pVYt1FYQAA=:sOepgDRKv9NkUW0A3lmDPs
 lMKaCgP8gslYJyEvzp7rA+EepQuuNhQEc2irozyeUq0dH+l6J4FirXLwi79pHMb/VzJt7BAlj
 /LpJG7ZjmM8BI0uDB88+MnTBctJlwMZF5K2YvKMo4X0IU3oJG8G0m1cMR5YzTy9V/otKzoIGe
 4kZXTPf+V6v9mZf21X4Wp2SWhs55jkogyX6CazAw8dxemENlA1xz8kt8kgFEKtp8vd/FUgmfq
 +Fj/+S5I9mcIefY0wLBtPQwpmD6zfY12+1uxGBJvFrSK7sPQ74XI2fJnOfNX5SrrAf8O2Q5SW
 qcoHotbrfWL0OBTrUGbgxjcC/TfwLjzI2JhXFLRbQMQ7YcyXDQGvNSjrcCuM+QuoNXTjYqc8g
 lG1WWX9ltbYzaPf6EG8TPPl+FvMAGMOTbxako3hSHnoEW8ixcd4fQn/rf/90ajRrIMG1lkCBB
 Ur1NbciY16JDt7YqmFMpTXIQRLrEM2Ft5hkgU7m71eYrtkESdVtXuQvI0hyO9NVPwXII72Nqi
 1mJGy2lSnMEluCHzvdp95gH2DTa8fqZ//rIoe0unfQ45Aa7FXH8Sjj5t2z2QusGIWTBdWc0gC
 5SPQaxqzTGJ9BpD5LQAlY+r1CtDKCAOwV2N5kpplMSZ8sadGuI25+8DoGrXyfDffgvIOKeJ00
 GVe5esGi2n+sD6a0TbIZLCUmYNTy3vEA3h65w5zMwoklPr+gZZM7q3Bcv3QrQr+BouZ09zq6F
 G/BD7CNkfI50aJZGaYiuT+Br/nCNsbB03EU5O+2IasT3avyM499QlJx9Yhpjyg7wBqGvLjidt
 /mZs/ae
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
 config.c               | 3 ++-
 t/t1300-repo-config.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 34a139c40bd..547daf87d40 100644
--- a/config.c
+++ b/config.c
@@ -604,7 +604,8 @@ static int get_value(config_fn_t fn, void *data, struct strbuf *name)
 	 */
 	cf->linenr--;
 	ret = fn(name->buf, value, data);
-	cf->linenr++;
+	if (ret >= 0)
+		cf->linenr++;
 	return ret;
 }
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 13b7851f7c2..a37ef042221 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -703,6 +703,12 @@ test_expect_success 'invalid unit' '
 	test_i18ngrep "bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit" actual
 '
 
+test_expect_success 'line number is reported correctly' '
+	printf "[bool]\n\tvar\n" >invalid &&
+	test_must_fail git config -f invalid --path bool.var 2>actual &&
+	test_i18ngrep "line 2" actual
+'
+
 test_expect_success 'invalid stdin config' '
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
 	test_i18ngrep "bad config line 1 in standard input" output
-- 
2.13.1.windows.1.1.ga36e14b3aaa


