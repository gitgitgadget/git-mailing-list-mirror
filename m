Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7121D202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 14:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754737AbdKAOpo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 10:45:44 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:44337 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdKAOpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 10:45:43 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Wed, 01 Nov 2017 15:45:42 +0100
  id 000000000000000D.0000000059F9DE16.00007C1D
Date:   Wed, 1 Nov 2017 15:45:42 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/2] sequencer.c: check return value of close() in
 rewrite_file()
Message-ID: <06c33d3cfa35c0524ede2970ee3169d6c62eb5c1.1509547231.git.simon@ruderich.org>
References: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22afeefa-cdd5-cd32-0a7c-6bad4de79f05@web.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not checking close(2) can hide errors as not all errors are reported
during the write(2).

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---

On Wed, Nov 01, 2017 at 02:00:11PM +0100, René Scharfe wrote:
> Most calls are not checked, but that doesn't necessarily mean they need
> to (or should) stay that way.  The Linux man-page of close(2) spends
> multiple paragraphs recommending to check its return value..  Care to
> send a follow-up patch?

Hello,

Sure, here is it.

Regards
Simon

 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f93b60f61..e0cc2f777 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2673,7 +2673,8 @@ static int rewrite_file(const char *path, const char *buf, size_t len)
 		return error_errno(_("could not open '%s' for writing"), path);
 	if (write_in_full(fd, buf, len) < 0)
 		rc = error_errno(_("could not write to '%s'"), path);
-	close(fd);
+	if (close(fd) && !rc)
+		rc = error_errno(_("could not close '%s'"), path);
 	return rc;
 }
 
-- 
2.15.0

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
