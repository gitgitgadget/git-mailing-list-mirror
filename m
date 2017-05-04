Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303C5207B3
	for <e@80x24.org>; Thu,  4 May 2017 09:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbdEDJta (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 05:49:30 -0400
Received: from mout.gmx.net ([212.227.17.20]:55728 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdEDJt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 05:49:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1FAK-1dub7I3FF2-00tByK; Thu, 04
 May 2017 11:49:20 +0200
Date:   Thu, 4 May 2017 11:49:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 1/7] Fix build with core.autocrlf=true
In-Reply-To: <cover.1493891336.git.johannes.schindelin@gmx.de>
Message-ID: <0a2af24e3423e402e6607fdc69fcbeb8cfe5489a.1493891336.git.johannes.schindelin@gmx.de>
References: <cover.1493728172.git.johannes.schindelin@gmx.de> <cover.1493891336.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uZN6SCZGkZu24F3tj1TPdc4XwhP8sHrzkh1a9RCzxo4lqXP8++W
 7nSaB1n16m9E48EZshOcSxH80U3ubmg97hSckWnF+X+dKdUlgKwdMEXYw2OhDAbR67LyKYL
 J/La4mZXl816PL47sEUBtnleofjEG4GniY9v4WUCC3GVZ+36zWK13Osfzp6N5naQfuSSKAb
 3MvoVcUjcIsPn7jCncL/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XNxXI1T4+bY=:fp9iecQ0eJ8bInZZ6DPw9/
 qSH2zYznvdCBp5YsF3+yG2uckcU1zLAIR3eJFc/T/9k+ihokHHQLTSfkG4y4AHCScB1vjSYCq
 gUKb+o276T7JeZQ/r9xCOFDPq8FYlhgzr0RyyF3KF8VFH341oJ2eTCeKVby9xJ0ePz4F5TMvR
 YEjB6w1A1vnu+Q1uEwMq4yms6H5M6DGWmRQL5G8UC3g0fNZlcyfhhoUTcbT68ZrvQh1km8BdY
 sLddxT1efRCZpLiB/lUL2D49Runpi4srmPZBLdl8kMH0AoTG3QUs9dRFSOiOlWdOi3NLLYqa8
 xhfkcM/XMvCSurxmZV+ZBwtTX+KS9uBMTYPoBVlsacEpgYf+CzU4Tqc8+FgqSWkF8kMyOCif1
 lHp0qNPwsn9yFAVAsXbqt1j8mrZMi+Oa+xkRJOXfiJ5QLSNFURNQdKHPaVMgPo+StJqESVEQo
 B8pgmLXBC/eDMagmSp8Qt6qsDParFw83ubu1H6nuFsJcc+2ebol3utj8B9wnzhLT9rBd5uu80
 yC8HFwk+bUpdPAN148WBDMN3mvc7RkAJQ1vVdxlIk16LNMRqiTM8Ea+2ndzUGkdYK6D9u9pIY
 8HdKmr2JDys3MXNIatN1DRZ+GLAOVmOjj6QVQh3zbC3RfeI6In/+APfZh+zPoe5pMDqkKkMxZ
 sIxkSomYPwNx3TnXrlj5QaMOVmEab+Pj2g+e8A/NLwc/iMvOX7pblyUnm+fMVKIYdSlfy83QC
 GlbHoxseJO15Tfcil7vvrgrUEthpXsmQzQa029q9oaVMVyzCTlngoVLam6Ra5q/oUI+G0dOrA
 +VPKZ/A
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

This patch can be validated even on Linux, by using this cadence:

	git config core.autocrlf true
	rm .git/index && git stash
	make -j15 DEVELOPER=1

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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


