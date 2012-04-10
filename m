From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Post 1.7.10 cycle
Date: Tue, 10 Apr 2012 20:55:58 +0200
Message-ID: <4F84823E.6030308@lsrfire.ath.cx>
References: <7v1unwtp02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:56:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHgEd-0000Ik-Kq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758357Ab2DJS4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:56:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:34925 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab2DJS4F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:56:05 -0400
Received: from [192.168.2.105] (p4FFD8505.dip.t-dialin.net [79.253.133.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 5566F2F806E;
	Tue, 10 Apr 2012 20:56:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7v1unwtp02.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195119>

Am 10.04.2012 02:22, schrieb Junio C Hamano:
> It's now time to pick among the topics that have been cooking in 'next'
> and 'pu' which ones to start moving to 'master' in what order.
> 
> I've already kicked one topic out of 'next' as it regresses the http proxy
> support, but I haven't spent enough time to look at the other topics again
> closely enough to decide.  I was hoping that we could feed a handful of
> topics every few days to 'master'.
> 
> I think the following topics (in 'next') are more or less ready:

> rs/unpack-trees-leakfix

Please apply the following patch before this one.  It makes sure that it
is a pure leak fix.  Without the added check, it'd change the behaviour
slightly: with o->merge == 0, we'd call mark_ce_used() on src[0]; before
it would point to the leaked version, but after the patch it points to
the version that has been added using do_add_entry().  Not sure if this
can lead to any user-visible consequences, but this is cleaner.

-- >8 --
Subject: unpack-trees: don't perform any index operation if we're not merging

src[0] points to the index entry in the merge case and to the first
tree to unpack in the non-merge case.  We only want to mark the index
entry, so check first if we're merging.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 unpack-trees.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 7c9ecf6..60b728e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -772,7 +772,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 	if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
 		return -1;
 
-	if (src[0]) {
+	if (o->merge && src[0]) {
 		if (ce_stage(src[0]))
 			mark_ce_used_same_name(src[0], o);
 		else
-- 
1.7.10
