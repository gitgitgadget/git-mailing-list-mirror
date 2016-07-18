Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 457FA1FEAA
	for <e@80x24.org>; Mon, 18 Jul 2016 09:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbcGRJTK (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 05:19:10 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50962 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549AbcGRJTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 05:19:09 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E751FEAA;
	Mon, 18 Jul 2016 09:19:07 +0000 (UTC)
Date:	Mon, 18 Jul 2016 09:19:07 +0000
From:	Eric Wong <e@80x24.org>
To:	norm@dad.org
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>, l.s.r@web.de,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] pager: disable color when pager is "more"
Message-ID: <20160718091907.GA13588@starla>
References: <201607171726.u6HHQShO005227@shell1.rawbw.com>
 <alpine.DEB.2.20.1607180922580.28832@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1607180922580.28832@virtualbox>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 17 Jul 2016, norm@dad.org wrote:
> > 'git diff' outputs escape characters which clutter my terminal. Yes, I
> > can sed them out, but then why are they there?
> 
> Those are most likely the ANSI sequences to add color. Can you call Git
> with the --no-color option and see whether the escape characters go away?

Norm: do you have PAGER=more set by any chance?
Perhaps changing it to "less" will allow you to preserve colors.

I saw a similar or identical problem during my vacation in
FreeBSD-land.  Perhaps the out-of-the-box experience can be
improved:

-----8<-----
Subject: [PATCH] pager: disable color when pager is "more"

more(1) traditionally cannot handle colors.

On FreeBSD 10.3, a new user ~/.profile explicitly sets
PAGER=more, but does not configure it to display colors, leading
to a bad out-of-the-box experience with escape sequences being
seen by the user.

In the FreeBSD 10.3 case, /usr/bin/more is actually a hardlink
to /usr/bin/less and capable of handling colors.  While we could
set MORE=FRX, this breaks other more(1) implementations,
including the one provided by util-linux on common GNU/Linux
systems.

So take the safe route and assume anybody still using more(1)
today can live with monochrome output, but acknowledge 'R'
in the MORE environment variable if it was set by the user.

Signed-off-by: Eric Wong <e@80x24.org>
---
 environment.c |  2 +-
 pager.c       | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/environment.c b/environment.c
index ca72464..cfb56fd 100644
--- a/environment.c
+++ b/environment.c
@@ -41,7 +41,7 @@ size_t packed_git_limit = DEFAULT_PACKED_GIT_LIMIT;
 size_t delta_base_cache_limit = 96 * 1024 * 1024;
 unsigned long big_file_threshold = 512 * 1024 * 1024;
 const char *pager_program;
-int pager_use_color = 1;
+int pager_use_color = -1;
 const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
diff --git a/pager.c b/pager.c
index 4bc0481..3110df4 100644
--- a/pager.c
+++ b/pager.c
@@ -80,6 +80,17 @@ void setup_pager(void)
 	if (!pager)
 		return;
 
+	if (pager_use_color < 0 && !strcmp(pager, "more")) {
+		const char *more = getenv("MORE");
+
+		/*
+		 * MORE=R does not work everywhere, so we cannot set it,
+		 * but we can respect it if set.
+		 */
+		if (!more || !strchr(more, 'R'))
+			pager_use_color = 0;
+	}
+
 	/*
 	 * force computing the width of the terminal before we redirect
 	 * the standard output to the pager.
-- 
EW
