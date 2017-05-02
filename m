Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CD291F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbdEBQCm (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:52015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbdEBQCj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:39 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lev1D-1drXT43Bdv-00qexG; Tue, 02
 May 2017 18:02:17 +0200
Date:   Tue, 2 May 2017 18:02:17 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 14/25] setup_discovered_git_dir(): plug memory leak
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <ab131705c4383dc408860b516b1e18b0753b0cbf.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pgZy5nqFqsVBdSavBzY+Lfq3jttYcfnmFqJ+FWaLPYPfB6yMHGY
 dEhHnYqdBwpxP4Gc71LV6HDgOgNoHnUTkGR2IQw2wVmeMK4qq76LsLAw/D6sDRHVHmu9UpM
 atPDQzt5hIs/AfQKCRB5wq3PaU29NO5RAZZZvFPXrg88Cx9pvR0Y7MqoYS85Mg2WXQGU8CK
 NKVRxOyhtbVCN6Wl9dugw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+gb9vWmSUjE=:kAd5/quMoZOuYUSjXcjhNg
 UIXF6hOuULatJ173sJw4kkYh65Wuz9Soi0zoBhT8qokq6XWJSK7o//X0FomWHlmk8wRe0wzY/
 6+CDZ6ROw+9DT+ikMIL7y8evZ0goiwkQfXWUPCCPG6dIASBTBo8O7jc/GD4s2aDfI/SFjNEsk
 fqWkr9rDBTkct+k9KOWMpG8ncOyfmkFQ25pgSYezBwTWp5hzswI689xwph5dx0oAcB8uXJUWr
 KK2lX30qzbLr6xeM+z+bDACA/iLoIY8/Hp/G9EP1ZWAo/FCkXKnZmPebi1MhqPCee94bbCmQm
 CXXeH/vqEBg35FgwetzW1x6Othmt4MMlBLyIHSz4Mzd9CN0aF/sUlxd8mGnAD6IrLGaeAEI1T
 W93xAjMMJ6E4iCc8yl/OYvnYMHuu1+/pmZ8AJ3g+RhFjRr/G9PscD1eXrQNZj/zEJ0ajogJHj
 ho2EFGFBlDHm/KNe0J/4ciu6f7BdhvelmmHhEybUGU+w7uRK1cSU7uPzsZdOkyDy+45sSGDFg
 9ZUHuk/OPB4HQl3+CygrtdaEyQWGawrv9gddpi2dJOoXRTXik6lTYE4m3zAGt5TVl/T5EWeDj
 FO2I9ZJdyF9ZDFgRztebAZVRJFkTu3M6h07RQst2FQqXUBFbMJns++SVV3Qmv29eexLOmQ/ax
 N/PRffGM1K8l1OBfjeAHyXXfBuD4kz8c1iGoweCu8PqOPqBh00AvI7OdPfyGIJr0jdV+Wh1oH
 joZW7/QmFvcCMWm2c3LbZ6V0K0P8IZA/Gr96hTL661zKMfeKHS13Fy/QOzd+rHRbNCM3T0p3W
 AZt7SJK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The setup_explicit_git_dir() function does not take custody of the string
passed as first parameter; we have to release it if we turned the value of
git_dir into an absolute path.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 0320a9ad14c..e3f7699a902 100644
--- a/setup.c
+++ b/setup.c
@@ -703,11 +703,16 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
+		char *to_free = NULL;
+		const char *ret;
+
 		if (offset != cwd->len && !is_absolute_path(gitdir))
-			gitdir = real_pathdup(gitdir, 1);
+			gitdir = to_free = real_pathdup(gitdir, 1);
 		if (chdir(cwd->buf))
 			die_errno("Could not come back to cwd");
-		return setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		ret = setup_explicit_git_dir(gitdir, cwd, nongit_ok);
+		free(to_free);
+		return ret;
 	}
 
 	/* #16.2, #17.2, #20.2, #21.2, #24, #25, #28, #29 (see t1510) */
-- 
2.12.2.windows.2.800.gede8f145e06


