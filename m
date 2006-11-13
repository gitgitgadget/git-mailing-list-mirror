X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shallow clone
Date: Sun, 12 Nov 2006 21:29:11 -0800
Message-ID: <7vodrbap94.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	<45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
	<7vac31p8om.fsf@assigned-by-dhcp.cox.net>
	<87zmaynl18.fsf@wine.dyndns.org>
	<7vu015f5av.fsf@assigned-by-dhcp.cox.net>
	<20061112205909.f8951300.vsu@altlinux.ru>
	<7vd57scong.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 05:29:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vd57scong.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 12 Nov 2006 13:59:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31291>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjUNn-000402-Qv for gcvg-git@gmane.org; Mon, 13 Nov
 2006 06:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753942AbWKMF3N (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 00:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945AbWKMF3N
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 00:29:13 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:20718 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1753942AbWKMF3M
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 00:29:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061113052912.WXXN18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 13
 Nov 2006 00:29:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id m5Um1V00M1kojtg0000000; Mon, 13 Nov 2006
 00:28:46 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Sergey Vlasov <vsu@altlinux.ru> writes:
>
>> This is due to optimization in builtin-pack-objects.c:try_delta():
>>
>> 	/*
>> 	 * We do not bother to try a delta that we discarded
>> 	 * on an earlier try, but only when reusing delta data.
>> 	 */
>> 	if (!no_reuse_delta && trg_entry->in_pack &&
>> 	    trg_entry->in_pack == src_entry->in_pack)
>> 		return 0;
>>
>> After removing this part the shallow pack after clone is 2.6M, as it
>> should be.
>>
>> The problem with this optimization is that it is only valid if we are
>> repacking either the same set of objects as we did earlier, or its
>> superset.  But if we are packing a subset of objects, there will be some
>> objects in that subset which were delta-compressed in the original pack,
>> but base objects for that deltas are not included in our subset -
>> therefore we will be unable to reuse existing deltas, and with that
>> optimization we will never try to use delta compression for these
>> objects.
>> ...
>> So any partial fetch (shallow or not) from a mostly packed repository
>> currently results in a suboptimal pack.

What we tried to avoid with the original heuristics in commit
51d1e83f was to avoid wasting time on undeltifiable blobs, and
they would be stored as base in the original packs, so I think
the following would fly better (the patch is for maint, for
master we would also check for OBJ_REF_DELTA as well).

---

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 96c069a..84a8749 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1101,7 +1101,8 @@ static int try_delta(struct unpacked *tr
 	 * on an earlier try, but only when reusing delta data.
 	 */
 	if (!no_reuse_delta && trg_entry->in_pack &&
-	    trg_entry->in_pack == src_entry->in_pack)
+	    trg_entry->in_pack == src_entry->in_pack &&
+	    trg_entry->in_pack_type != OBJ_DELTA)
 		return 0;
 
 	/*



