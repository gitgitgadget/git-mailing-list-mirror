Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5699A1FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbdFHTxo (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:53:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:52812 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbdFHTxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:53:43 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBnvD-1dBb6Q0W6p-00AlpA; Thu, 08
 Jun 2017 21:53:33 +0200
Date:   Thu, 8 Jun 2017 21:53:32 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/8] discover_git_directory(): avoid setting invalid
 git_dir
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
Message-ID: <effd58a564e54ccd3d695d91bc9c4f32255b8ab7.1496951503.git.johannes.schindelin@gmx.de>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:93RfzNJxcIp/ixbs7pw2Xn+2DLtLV4OQ+0up/LT/D4sQQRgHB7E
 kd9vNlOovqOqfXEpaeahZHzvbab8l8uTXcgmdIjEfzpYmbLIfE58P0cT2BUQXI5hwdhYoWU
 EnZxKVU62xUz3Q5A4LL9fSpT4SSeIJTiPP+pPjBPPG4+H2t7g496SfvHH63F7n18wwGUKVo
 2oQEqKPnOdAaE2ZqkrmTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MziMbeW7sX8=:hKt09lF9DePg9xfzFk69Sk
 G5MvG6S6MYjzeKBsd0Kg8ARLhIVkEoVOMhUdbpPWwdzePiDeQl5747UWJ3BbiUMpjtLQLBvYy
 825Q9wzZpY/nB3pVut+lRXFW6OV9r+V7zksH5W9UfXEJiVO+imzA5TdspEHeYyf5y/Ew2IJA8
 XBVJQNeKhotDxfrDYk1DXp7GsZnRmqefmxa51aCKsiN2362ObIW8CiBLbD3l3yGA1ZnZ6lWPD
 GIdT65HL404t33W3gEt77E1dSZ5NvfB1jOYqsMjMi5pdLp4cc7rpijsGQOVL7dHpFl5h4R5QL
 /xC9MpyKg+p8mK4kDS7CU69pS1I2l7C6i6iKO/I2DLiXnN00f0zzxg88RRZM1H7NfXVqX/6l3
 vNmMIQMjlJI6v6aNG0k9TeXYSqiUDfNlAsWRdy/hMiTVYaOIqUZeEK4bGz0T2MA4Kc0j8GrcI
 xI+BZOlmwjf1UJAoj9K4urZ9kU/sUZ9/m0Nrea50BiN0Oe60n0IjqHha3ITnAZFMb+hhdbEB0
 EXYbCl3JZ/SHhmSN02XxhB11urOmJvk5kEaeFEhmi8XisE1EK3u+X0rXOmhMaU3fe8D59EXAx
 cJX69NFLSbbZ/oXJ4IBUqyc5BlniZ/N3L+q0JuL/cuqO3gAphL7QJdFjWHf3cnssXBzKk5LMh
 KkMRyNhn2S1eymZpqUox08UBv0SYib3K2ljFlIFuFVDL+CDYwBlxPNmTMsk7EywqUY97mVtfe
 A41PntwKrz4adpZ/v0xHEqS4lCrteWHd3/PuLT44keBE/dE5nZtaxHI8pEnnWopEl2D5gHcuA
 iCFnXwx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When discovering a .git/ directory, we take pains to ensure that its
repository format version matches Git's expectations, and we return NULL
otherwise.

However, we still appended the invalid path to the strbuf passed as
argument.

Let's just reset the strbuf to the state before we appended the .git/
directory that was eventually rejected.

There is another early return path in that function, when
setup_git_directory_gently_1() returns GIT_DIR_NONE or an error. In that
case, the gitdir parameter has not been touched, therefore there is no
need for an equivalent change in that code path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup.c b/setup.c
index e3f7699a902..2435186e448 100644
--- a/setup.c
+++ b/setup.c
@@ -982,6 +982,7 @@ const char *discover_git_directory(struct strbuf *gitdir)
 		warning("ignoring git dir '%s': %s",
 			gitdir->buf + gitdir_offset, err.buf);
 		strbuf_release(&err);
+		strbuf_setlen(gitdir, gitdir_offset);
 		return NULL;
 	}
 
-- 
2.13.0.windows.1.460.g13f583bedb5


