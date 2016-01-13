From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 2/4] am: release pack files before garbage-collecting
Date: Wed, 13 Jan 2016 18:20:16 +0100 (CET)
Message-ID: <999dc2556d5a4683722b4c63870f43c48d2a3211.1452705584.git.johannes.schindelin@gmx.de>
References: <cover.1452705584.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:20:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJP5w-0004nK-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 18:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbcAMRUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 12:20:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:54935 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176AbcAMRUU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 12:20:20 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MWBpJ-1ai0MK10hN-00XO68; Wed, 13 Jan 2016 18:20:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452705584.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:/CIIC7ydOu4fi2bQ9uD1+AITJwedEb0ikBn3VIRrVXpEZxgMFNM
 ekQ+/8/pZv6Yet2ZvrRABLVL/134kuFsRZwRvLKiI5m4EUpoT9kAg/8Z0P/6LhGs+x7BD/o
 ATxtfqLhMRtiiNgyxxWxMoxnl/B4KGJxNFSLfDIYzRAkeOJ7ej7TC+mXjKZ0aR5OqL0RQq1
 g8TqKr4G9L8ABa1Jmhl6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4S2wjUVOT/Q=:ugWTLOZnLVGDNUMRQ7X4A8
 ODUw+SRriARYfUNxhkJmFWV4Hg9gyc8g95V8iEtAz1znLJhzPOmxoZD5E4+t86qEH9+bhhrNl
 4S+FmaJGQGjg9l+Ye/wcGny1HbYCH/ttS+kkXQZPONrNpz3lyHsLPsjeb0qF7HyoZI0zoF6sm
 pbVqQdPmtvOVxwjnOUnNbU77I94Ra6rnIvyGy13+GxaRtFl+Lu0czkgrGlcMs9S1bQjrJFA/1
 7W7YIG7ozPn80EA0CBqa0hQ9EsTpmPnxBDZGGvcvN3Ad8AY1fIQnwgkLN9p88607R0UzULSxA
 ycpT2pBp45hpHZfNiJbDyFOkSgQULptL/KLPb7MH0Q7P+hLew0JHu9Gg4qRy8RnNHCBvsYue1
 Z+Nohgmtqe2JWf+K3Df8oQKo2ZQ+bSevXoGQyobBmO7XpDVfKenr4/v2GdIdshbd5QuQUUeAT
 rhiKWjnoul8iXxVmTZlMufFNL63W09TcfD/6gfamaDUHznMULfXMLUBzL0jfy4Vl2YA/wJBeM
 RnHq8mxZMC6/LwTu8Jg/88k6c6DFttmDRumjz5YoJ/txDDifrwOXovvb9kGr4GfHEUcdrbbG4
 YOCDQHoxxyU1Y8kAiGz1lXMgPtzTDYYCbNlwWDI+89vpO715skx1pEhFocUisUZ2fguKvda4F
 BjajaNudxrFJ74Kix5M+HUPAFAla+DP+aYqTVcSSPs5zUbrSlIRG77aEyLtoSG6TaLoPvl6g4
 78hDyDxtYevp7dsWt3Siktev2D9arXg38pNIhqdqsdlxfB3ikH15DurSUmfC+6A16zIRpTFV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283948>

Before auto-gc'ing, we need to make sure that the pack files are
released in case they need to be repacked and garbage-collected.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/am.c b/builtin/am.c
index 9fb42fd..de235cf 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1939,6 +1939,7 @@ next:
 	 */
 	if (!state->rebasing) {
 		am_destroy(state);
+		close_all_packs();
 		run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	}
 }
-- 
2.6.3.windows.1.300.g1c25e49
