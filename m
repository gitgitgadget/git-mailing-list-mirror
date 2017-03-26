Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DF120958
	for <e@80x24.org>; Sun, 26 Mar 2017 13:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbdCZNuw (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 09:50:52 -0400
Received: from mout.web.de ([212.227.15.4]:54995 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751354AbdCZNuw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 09:50:52 -0400
Received: from [192.168.178.36] ([79.237.59.215]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MC1ho-1d0yAC3aZk-008upp; Sun, 26
 Mar 2017 15:43:52 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: support long paths w/o read rights in strbuf_getcwd()
 on FreeBSD
Message-ID: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
Date:   Sun, 26 Mar 2017 15:43:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:TWnw+TFVOwGgqzEiq1kpZjKEgK+Wyi5qIcsBXC7UFflegrdpD1Z
 5T3GcSkoFXy8RexT0f/IQa8zcOM3oiITYT7aiJSUVbcpDHybB2DR10aIceyXRXJxGy6636T
 5QgQvwc4PnMfGVC/s7ssOAM0D/26pIQVYLXR10IZ3M5urdgl0GtRidiz3Bvj8kTzkjVj2eU
 7vWRVRsPrJiOhSEtFwYrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CKnhvyQntis=:MmKKMf3/bAC+D+qzL1sp4s
 edlOx/ACprPZYE/BgOj18KA0ktBlly7f83vpQQ6Dve97n4uiYpZNvhz4Sh8/fU9FXm68IRCU9
 pOExZpTtz0RfvlXQ4NdfdDbn1x4sJALqh41O5ui5uOQ2jLwCItiZ3KBSHdfV0KGhMUcn5mDxi
 3ChWwRn+NQKQmIANY8B+UQejxE3aZGwB4QjOA4lCUno5srxCjqsEqRJIGBKZKXgwwnbQ29BVL
 p48M+lWxLMZkNHq071hEUV1S0kf7lY9j8r/C4HHHbhY1m/b/1rK2U96ayJJbxBnudOZ43f4pC
 oS2oLo3EnyWaQVPjeGa95cPXAX0KfmY6Kd0nS21x1THslmOEpTXto6a3dCw5M4UvBuEHLMq9c
 3GWFY4PK+G/KHud3AfMVVX80DpANVCzyC7S0XWIMvCR3fYmCDq/eMpgkC2pmUhq/iXCrJi+uH
 q39ywBRrBd5u/ODTOZW7yIHvUtx8vRfDl6ED3aV2q3//RBuIiHylozjRMxxC0tohwUTLNImJt
 F5DJMwrtpwso57SDUtY9NpUkBaG+p1m/bOGA4N6HH2nnJfHPVchlDzNCo0H1ojs32Jnv469Co
 0cJeIeTbNHwqKCY+zB5Cb7wfWJbiRs6sXd1B2nqBF2XKsGc8zfqZqdbwPucyex0FjpDSPnxwj
 R51nEfhGEe7wUD7R2/Tj11buB8GSsDa+X6IBV5yyNymF5MxOdIH8oYXAKEZKZQHQbOINFSOIc
 yNkvGqTwRPREzpd12pAUzdVc9NtjXQPy2oAkV04uBY1W25uEmn6SGZv82WM6rwCmBNWdqO3YG
 B4o8YRF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FreeBSD implements getcwd(3) as a syscall, but falls back to a version
based on readdir(3) if it fails for some reason.  The latter requires
permissions to read and execute path components, while the former does
not.  That means that if our buffer is too small and we're missing
rights we could get EACCES, but we may succeed with a bigger buffer.

Keep retrying if getcwd(3) indicates lack of permissions until our
buffer can fit PATH_MAX bytes, as that's the maximum supported by the
syscall on FreeBSD anyway.  This way we do what we can to be able to
benefit from the syscall, but we also won't loop forever if there is a
real permission issue.

This fixes a regression introduced with 7333ed17 (setup: convert
setup_git_directory_gently_1 et al. to strbuf, 2014-07-28) for paths
longer than 127 bytes with components that miss read or execute
permissions (e.g. 0711 on /home for privacy reasons); we used a fixed
PATH_MAX-sized buffer before.

Reported-by: Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 strbuf.c        | 11 +++++++++++
 t/t0001-init.sh | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index ace58e7367..00457940cf 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -449,6 +449,17 @@ int strbuf_getcwd(struct strbuf *sb)
 			strbuf_setlen(sb, strlen(sb->buf));
 			return 0;
 		}
+
+		/*
+		 * If getcwd(3) is implemented as a syscall that falls
+		 * back to a regular lookup using readdir(3) etc. then
+		 * we may be able to avoid EACCES by providing enough
+		 * space to the syscall as it's not necessarily bound
+		 * to the same restrictions as the fallback.
+		 */
+		if (errno == EACCES && guessed_len < PATH_MAX)
+			continue;
+
 		if (errno != ERANGE)
 			break;
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e424de5363..5f81fbe07c 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -315,6 +315,20 @@ test_expect_success 'init with separate gitdir' '
 	test_path_is_dir realgitdir/refs
 '
 
+test_expect_success 'init in long base path' '
+	# exceed initial buffer size of strbuf_getcwd()
+	component=123456789abcdef &&
+	test_when_finished "chmod 0700 $component; rm -rf $component" &&
+	p31=$component/$component &&
+	p127=$p31/$p31/$p31/$p31 &&
+	mkdir -p $p127 &&
+	chmod 0111 $component &&
+	(
+		cd $p127 &&
+		git init newdir
+	)
+'
+
 test_expect_success 're-init on .git file' '
 	( cd newdir && git init )
 '
-- 
2.12.2

