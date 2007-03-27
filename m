From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] git-upload-pack: make sure we close unused pipe ends
Date: Tue, 27 Mar 2007 16:45:06 -0700
Message-ID: <200703272347.l2RNln90025931@tazenda.hos.anvin.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWLOb-0000dM-8j
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:48:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbXC0XsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXC0XsF
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:48:05 -0400
Received: from terminus.zytor.com ([192.83.249.54]:34110 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXC0XsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:48:04 -0400
Received: from mail.hos.anvin.org (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l2RNlqhf028294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 27 Mar 2007 16:47:52 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l2RNlpxI012370;
	Tue, 27 Mar 2007 16:47:52 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.13.8/8.13.6) with ESMTP id l2RNlo00025932;
	Tue, 27 Mar 2007 16:47:50 -0700
Received: (from hpa@localhost)
	by tazenda.hos.anvin.org (8.13.8/8.13.8/Submit) id l2RNln90025931;
	Tue, 27 Mar 2007 16:47:49 -0700
X-Authentication-Warning: tazenda.hos.anvin.org: hpa set sender to hpa@zytor.com using -f
X-Virus-Scanned: ClamAV 0.88.7/2944/Tue Mar 27 12:36:49 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.1 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL autolearn=no version=3.1.8
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43325>

Right now, we don't close the read end of the pipe when git-upload-pack
runs git-pack-object, so we hang forever (why don't we get SIGALRM?)
instead of dying with SIGPIPE if the latter dies, which seems to be the
norm if the client disconnects.

Thanks to Johannes Schindelin <Johannes.Schindelin@gmx.de> for
pointing out where this close() needed to go.

This patch has been tested on kernel.org for several weeks and appear
to resolve the problem of git-upload-pack processes hanging around
forever.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 upload-pack.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 498bf50..d3a09e7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -119,6 +119,7 @@ static void create_pack_file(void)
 		int i;
 		struct rev_info revs;
 
+		close(lp_pipe[0]);
 		pack_pipe = fdopen(lp_pipe[1], "w");
 
 		if (create_full_pack)
-- 
1.5.0.3
