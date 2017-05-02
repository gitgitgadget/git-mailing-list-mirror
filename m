Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029A71F790
	for <e@80x24.org>; Tue,  2 May 2017 12:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdEBMak (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 08:30:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:56865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751036AbdEBMaj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 08:30:39 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgdBZ-1dtOHx1l8H-00nxmv; Tue, 02
 May 2017 14:30:28 +0200
Date:   Tue, 2 May 2017 14:30:27 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/5] Fix build with core.autocrlf=true
In-Reply-To: <cover.1493728172.git.johannes.schindelin@gmx.de>
Message-ID: <2232589c0368c286ae757817842ba5452a6986e4.1493728172.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Y4XpjIIMXdnrmPcEtQ7woqjKEBRxzavwIJ5+v1kUYY3wpLOvnbG
 2nHUkTOeD7z81o02DJVgvcqyQ+mXBeMhYpMM9rl7UV1VVn95zwlttX7qFS+127d0YJPsJDC
 fjLI0p0pnI/bCeyiGqyB+Goc2oaxpcH0q+JLwvDVTk8pDHRIbUr3Xd79zk6jSumaSsDvzSm
 gd8RXBF9t2rlL+wKGtF7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:93rGvsI7E6U=:6OwOCI0pXp91Kq9XCwlT2D
 pO1NyWtuAjfat+XcvpL372wSlpbQWOEV1TYCodesaqWK9RvK02VvCF/B0lQyFmox2n9a6Y+97
 U80ZxLPIivzG1SXPq0dzAUsAClMLmofr4JdZB/iiY9HQ8A14wbBdxZvFUC2aNu25+HJHZB0vS
 xpTM9dflEkovfhRsViJMEUWzdmI6hYc2P+9emYcQa7azc3BQVyz600/o2rNuzPR7rmVqsfc8U
 QtK2TPTpch53UojoIAN/aIrawWG32fMTjox8RPEedi5EmFzwrU2gMLrEyKo0DxvYuHl2PfVzr
 P8ardhFsG+CPH++lpW6jcNt7cB/UHmdPEc3sm9H5zmLsILR0ZYA20VZ724VulCmS2T1/zkk/Z
 z7NOeBY3xlNoN72SxYmn9FgImZPrrjcKI0fG16kWNN6s1MJHLDEyYrXJFqRk1ynx6X28lED9h
 ikX/RJ/or2JbENZs24F+4RZNl21c6udX1sOzy4jMCOn8t1cYRLn3mtoF4yHiEB277E+W6L3jT
 96RATtOev1k/F2YRkzvslqd4aw+N73fuLOOFhecWLjaVcjY+RCYK6LF/2ovky19E6Yi0NRgz8
 VSoN2B/gsbAP+aIR8wwhT2M/Kj/T+RQ3ukpo+NLlsANJL2uaJueG4JL8YBBi6KXcbMcdOFtWf
 DKGJm8HK8+mDADzxtFWFdK4fWFQCF/JzVSIHpkAtZ07as65DB1zw3xLtf+p2bQJ63N4YtvgGs
 knfh4aLgZLPo2yg4BC5cXN5V+rVB9HlnbzSJJwX5ZFuj9TNLRlrlTMSQ7tPx4jBCPpnorTUVf
 wlCS45y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, the default line endings are denoted by a Carriage Return
byte followed by a Line Feed byte, while Linux and MacOSX use a single
Line Feed byte to denote a line ending.

To help with this situation, Git introduced several mechanisms over the
last decade, most prominently the `core.autocrlf` setting.

Sometimes, however, a single setting is incorrect, e.g. when certain
files in the source code are to be consumed by software that can handle
only LF line endings, while other files can use whatever is appropriate
for the current platform.

To allow for that, Git added the `eol` option to its .gitattributes
handling, expecting every user of Git to mark their source code
appropriately.

Bash assumes that line-endings of scripts are denoted by a single Line
Feed byte. Therefore, shell scripts in Git's source code are one example
where that `eol=lf` option is *required*.

When generating common-cmds.h, the Unix tools we use generally operate on
the assumption that input and output deliminate their lines using LF-only
line endings. Consequently, they would happily copy the CR byte verbatim
into the strings in common-cmds.h, which in turn makes the C preprocessor
barf (that interprets them as MacOS-style line endings). Therefore, we
have to mark the input files as LF-only: command-list.txt and
Documentation/git-*.txt.

Quite a bit belatedly, this patch brings Git's own source code in line
with those expectations by setting those attributes to allow for a
correct build even when core.autocrlf=true.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitattributes         | 8 +++++++-
 git-gui/.gitattributes | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 320e33c327c..8ce9c6b8888 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,3 +1,9 @@
 * whitespace=!indent,trail,space
 *.[ch] whitespace=indent,trail,space diff=cpp
-*.sh whitespace=indent,trail,space
+*.sh whitespace=indent,trail,space eol=lf
+*.perl eol=lf
+*.pm eol=lf
+/Documentation/git-*.txt eol=lf
+/command-list.txt eol=lf
+/GIT-VERSION-GEN eol=lf
+/mergetools/* eol=lf
diff --git a/git-gui/.gitattributes b/git-gui/.gitattributes
index 33d07c06bd9..59cd41dbff7 100644
--- a/git-gui/.gitattributes
+++ b/git-gui/.gitattributes
@@ -2,3 +2,4 @@
 *           encoding=US-ASCII
 git-gui.sh  encoding=UTF-8
 /po/*.po    encoding=UTF-8
+/GIT-VERSION-GEN eol=lf
-- 
2.12.2.windows.2.800.gede8f145e06


