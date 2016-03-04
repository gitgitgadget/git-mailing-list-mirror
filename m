From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/2] xdiff/xprepare: fix a memory leak
Date: Fri, 4 Mar 2016 23:10:50 +0000
Message-ID: <56DA15FA.1090601@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 00:11:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abysF-0005re-9l
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 00:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760382AbcCDXK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 18:10:56 -0500
Received: from avasout02.plus.net ([212.159.14.17]:55787 "EHLO
	avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759947AbcCDXK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 18:10:56 -0500
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout02 with smtp
	id RzAs1s0041BQLD401zAt7b; Fri, 04 Mar 2016 23:10:53 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=COHXJkfD c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=7FARQufIaMDUgg5QwSEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288280>


The xdl_prepare_env() function may initialise an xdlclassifier_t
data structure via xdl_init_classifier(), which allocates memory
to several fields, for example 'rchash', 'rcrecs' and 'ncha'.
If this function later exits due to the failure of xdl_optimize_ctxs(),
then this xdlclassifier_t structure, and the memory allocated to it,
is not cleaned up.

In order to fix the memory leak, insert a call to xdl_free_classifier()
before returning.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 xdiff/xprepare.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 5ffcf99..13b55ab 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -301,6 +301,7 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 
 		xdl_free_ctx(&xe->xdf2);
 		xdl_free_ctx(&xe->xdf1);
+		xdl_free_classifier(&cf);
 		return -1;
 	}
 
-- 
2.7.0
