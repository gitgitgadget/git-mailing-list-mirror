From: Daniel DeLorme <dan-ml@dan42.com>
Subject: [PATCH] git verify-pack -vs
Date: Sat, 25 Sep 2010 14:45:29 +0900
Message-ID: <4C9D8C79.2040101@dan42.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010009000701080605010104"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 08:09:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzNxI-0001hy-9w
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 08:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab0IYGHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 02:07:46 -0400
Received: from wind.ocn.ne.jp ([122.28.30.139]:56426 "EHLO smtp.wind.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750949Ab0IYGHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 02:07:45 -0400
X-Greylist: delayed 1332 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Sep 2010 02:07:44 EDT
Received: from [192.168.1.2] (p1179-ipbf2007hodogaya.kanagawa.ocn.ne.jp [123.220.138.179])
	by smtp.wind.ocn.ne.jp (Postfix) with ESMTP id 912FE243B
	for <git@vger.kernel.org>; Sat, 25 Sep 2010 14:45:29 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157123>

This is a multi-part message in MIME format.
--------------010009000701080605010104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

According to git help verify-pack, when --stat-only and --verbose are 
used together the "list of objects is also shown." But in fact it is 
not; `git verify-pack -sv` has the same behavior as `git verify-pack -s`
It seems like a trivial mistake in verify-pack.c (the verbose behavior 
is triggered with !stat_only) so here is a patch that makes the behavior 
fit the manual's description.

--
Daniel DeLorme

--------------010009000701080605010104
Content-Type: text/x-patch;
 name="verify-pack.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="verify-pack.patch"

diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index b6079ae..ad67eb8 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -13,6 +13,7 @@ static void show_pack_info(struct packed_git *p, unsigned int flags)
 {
 	uint32_t nr_objects, i;
 	int cnt;
+	int verbose = flags & VERIFY_PACK_VERBOSE;
 	int stat_only = flags & VERIFY_PACK_STAT_ONLY;
 	unsigned long chain_histogram[MAX_CHAIN+1], baseobjects;
 
@@ -36,16 +37,16 @@ static void show_pack_info(struct packed_git *p, unsigned int flags)
 		type = packed_object_info_detail(p, offset, &size, &store_size,
 						 &delta_chain_length,
 						 base_sha1);
-		if (!stat_only)
+		if (verbose)
 			printf("%s ", sha1_to_hex(sha1));
 		if (!delta_chain_length) {
-			if (!stat_only)
+			if (verbose)
 				printf("%-6s %lu %lu %"PRIuMAX"\n",
 				       type, size, store_size, (uintmax_t)offset);
 			baseobjects++;
 		}
 		else {
-			if (!stat_only)
+			if (verbose)
 				printf("%-6s %lu %lu %"PRIuMAX" %u %s\n",
 				       type, size, store_size, (uintmax_t)offset,
 				       delta_chain_length, sha1_to_hex(base_sha1));

--------------010009000701080605010104--
