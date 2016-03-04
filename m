From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/2] diff: fix a memory leak
Date: Fri, 4 Mar 2016 23:07:40 +0000
Message-ID: <56DA153C.1060802@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 00:07:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abyp9-0004DJ-9B
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 00:07:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760533AbcCDXHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 18:07:50 -0500
Received: from avasout03.plus.net ([84.93.230.244]:57210 "EHLO
	avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760463AbcCDXHu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 18:07:50 -0500
Received: from [10.0.2.15] ([80.189.40.55])
	by avasout03 with smtp
	id Rz7m1s0081BQLD401z7oKA; Fri, 04 Mar 2016 23:07:48 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=X8+vUzne c=1 sm=1 tr=0
 a=LVbmpxbf7ppclCt3pfQTng==:117 a=LVbmpxbf7ppclCt3pfQTng==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=gt02UkMMVEFssZRZQBMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288278>


A recent memory leak patch from Patrick, commit 4867f1184
("xdiff/xmerge: fix memory leak in xdl_merge", 23-02-2016),
reminded me that I had a similar patch lying around.

After checking that it wasn't the same one, I dusted it off, and
split it into these two patches.

One of the reasons for not sending it earlier was that it is
not very likely to happen (without very large files), and I had
to use the debugger to confirm the leak and the fix.

[If you want to do so yourself, then I suggest that you use
two files that actually have changes and do 'run --no-pager diff
--no-index file-1 file-2'. set breakpoints on xdl_prepare_env,
xdl_init_classifier, xdl_free_classifier, xdl_optimize_ctxs and
xdl_cleanup_records. You have to force xdl_cleanup_records to
return -1 to simulate an OOM. Since xdl_free_classifier does
not set the allocated fields to NULL, you have to make sure that
you do/don't hit that breakpoint before the return at line #304/305.]

Ramsay Jones (2):
  xdiff/xprepare: use the XDF_DIFF_ALG() macro to access flag bits
  xdiff/xprepare: fix a memory leak

 xdiff/xprepare.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.7.0
