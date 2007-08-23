From: David Kastrup <dak@gnu.org>
Subject: [PATCH] diff-delta.c: Fix broken skip calculation.
Date: Thu, 23 Aug 2007 07:51:45 +0200
Organization: Organization?!?
Message-ID: <85veb6iyry.fsf@lola.goethe.zz>
References: <85k5rnjcbu.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708222126590.16727@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 07:52:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO5bq-0005s3-Qy
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 07:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbXHWFvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 01:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbXHWFvz
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 01:51:55 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:41310 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751918AbXHWFvy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 01:51:54 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id DBB1D31F2DB
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 07:51:52 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id D06FD212FB4
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 07:51:52 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-050-128.pools.arcor-ip.net [84.61.50.128])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id B866C1D7141
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 07:51:48 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E01C21C36605; Thu, 23 Aug 2007 07:51:45 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56454>

A particularly bad case was HASH_LIMIT <= hash_count[i] < 2*HASH_LIMIT:
in that case, only a single hash survived.  For larger cases,
2*HASH_LIMIT was the actual limiting value after pruning.

Acked-by: Nicolas Pitre <nico@cam.org>
Signed-off-by: David Kastrup <dak@gnu.org>
---
 diff-delta.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff-delta.c b/diff-delta.c
index 3af5835..0dde2f2 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -213,7 +213,7 @@ struct delta_index * create_delta_index(const void *buf, unsigned long bufsize)
 		entry = hash[i];
 		do {
 			struct index_entry *keep = entry;
-			int skip = hash_count[i] / HASH_LIMIT / 2;
+			int skip = hash_count[i] / HASH_LIMIT;
 			do {
 				entry = entry->next;
 			} while(--skip && entry);
-- 
1.5.3.rc2.257.gd8a21
