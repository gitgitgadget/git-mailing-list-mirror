Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33C661FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 12:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbdFMMEh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 08:04:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:52968 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752622AbdFMMEg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 08:04:36 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5tof-1e4SQN1mH3-00xpmo; Tue, 13
 Jun 2017 14:04:26 +0200
Date:   Tue, 13 Jun 2017 14:04:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 2/6] config: report correct line number upon error
In-Reply-To: <cover.1497355444.git.johannes.schindelin@gmx.de>
Message-ID: <e9698a39789f51a4e3cdff41bfeeba9fe46be605.1497355444.git.johannes.schindelin@gmx.de>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:maJLvwerv5ir1mQwDFbOs8lmW/JNeDAgxh+RjlSF0aBKw8qJzXv
 dckOAj5lv6knw0OH7nIRsdJ4swWybkKo/KKgYSgLVWEHHsvCdaqTwZ3FJP4u9bPE5Z8yk47
 eTkFQ+eV4CBmFKcPGhNBqa5Re6N7uxE7UBkVq/vBmm48SjvSGtUZjf+/DDdwJPO/tJN9JFs
 iubzok40h0pNhS/rq8WCw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6YBFe3J3Ygw=:ek5EyIdoTD5kr8V1ku8CiE
 p2zZDy6D26+NDoOQOd/r1rLuduy1nZC0lrqcqgG+yO0zcW5Q21XT7pEzb3bKyGLqMGwL5y9ny
 NDuk97VCYp4BYN16Gj+J8m/h2BNPxe3A3bCZ7GlR2VH7A5VuR5vWb+fM8dngJaHovdEMET9Qa
 5BOnaHZSYhiKH0lnykvAYqywi8fpTq+Q5p+VGQZPdJQkiCPTXZxlf45GVPajnURaTo9TLyqI1
 25tZBvqgVwKu+Q1uU+kHbOLSwfaaU6gNLfCtWhc6DF7JeTU/lanQ+AAQdkYvr9q+DjJzJllzT
 GxSvuh9JQ4rk3x8wz5Q3x3DQG+pT8x/bSG8Pfuaz31US96oMusWqKEmSL8Am+3vCFCppWagyj
 XVcYtmbaiQdqoXHOFpblEjZ97MlEcnvQ7rf2nufY37eIpmUxLtCLdog+qy0s+wLTnDMwgXSAW
 JGtQVFaOQtv8moserxDOUII8J+33BAvSMB3wvo25dTqOyz2LDRsgyLcpgPZ9FazVy745yNUmz
 YWlNp6MfeZae6B42jgbmf/hUmCgFr/PXYNIIVSDYOrpfvSOYOnRZVFSDkqqn0gB9VfnJki1J8
 rRJcQq/2J07JthyO4yl7AkRYCyuQkks6+CpmRxW2FJTXn7BBwwYtqXWhxeZsHLz3obSaiv4iV
 Q92/wW3GVPmW6Qr4HwEC7Z2nm3D7uaeDg8DBpDdyflr3O4ABrM929xN9LcWyBaG6vhEySN5Hf
 dAbfsnmX4lAs3ON+rxMHY+Gn7psKLfxIYAh0f4yf/VZ/wzAAyvfrST6R4rx956t27HKyQ73Q9
 OSUURwz
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
index 146cb3452ad..12c172e298a 100644
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
2.13.0.windows.1.460.g13f583bedb5


