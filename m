X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shallow clone
Date: Sun, 12 Nov 2006 13:59:15 -0800
Message-ID: <7vd57scong.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	<45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
	<7vac31p8om.fsf@assigned-by-dhcp.cox.net>
	<87zmaynl18.fsf@wine.dyndns.org>
	<7vu015f5av.fsf@assigned-by-dhcp.cox.net>
	<20061112205909.f8951300.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 21:59:31 +0000 (UTC)
Cc: Alexandre Julliard <julliard@winehq.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061112205909.f8951300.vsu@altlinux.ru> (Sergey Vlasov's
	message of "Sun, 12 Nov 2006 20:59:09 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31282>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjNMH-0007Et-Jo for gcvg-git@gmane.org; Sun, 12 Nov
 2006 22:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753331AbWKLV7S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 16:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbWKLV7S
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 16:59:18 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:65456 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1753331AbWKLV7Q
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 16:59:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112215916.GFPH18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 16:59:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id lxyq1V00J1kojtg0000000; Sun, 12 Nov 2006
 16:58:51 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> writes:

> This is due to optimization in builtin-pack-objects.c:try_delta():
>
> 	/*
> 	 * We do not bother to try a delta that we discarded
> 	 * on an earlier try, but only when reusing delta data.
> 	 */
> 	if (!no_reuse_delta && trg_entry->in_pack &&
> 	    trg_entry->in_pack == src_entry->in_pack)
> 		return 0;
>
> After removing this part the shallow pack after clone is 2.6M, as it
> should be.
>
> The problem with this optimization is that it is only valid if we are
> repacking either the same set of objects as we did earlier, or its
> superset.  But if we are packing a subset of objects, there will be some
> objects in that subset which were delta-compressed in the original pack,
> but base objects for that deltas are not included in our subset -
> therefore we will be unable to reuse existing deltas, and with that
> optimization we will never try to use delta compression for these
> objects.
> ...
> So any partial fetch (shallow or not) from a mostly packed repository
> currently results in a suboptimal pack.

That is correct.  How about something like this?

I think the determination of "repacking_superset" may need to be
tweaked because existing packs may have overlaps, and the patch
counts them once per pack.


diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 69e5dd3..fb25124 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -64,6 +64,7 @@ struct object_entry {
 static unsigned char object_list_sha1[20];
 static int non_empty;
 static int no_reuse_delta;
+static int repacking_superset;
 static int local;
 static int incremental;
 static int allow_ofs_delta;
@@ -1172,10 +1173,13 @@ static int try_delta(struct unpacked *tr
 		return -1;
 
 	/*
-	 * We do not bother to try a delta that we discarded
-	 * on an earlier try, but only when reusing delta data.
+	 * When we are packing the superset of objects we have already
+	 * packed, we do not bother to try a delta that we discarded
+	 * on an earlier try.  This heuristic of course should not
+	 * kick in when we are not reusing delta, or we know we are
+	 * sending a subset of objects from a repository.
 	 */
-	if (!no_reuse_delta && trg_entry->in_pack &&
+	if (!no_reuse_delta && repacking_superset && trg_entry->in_pack &&
 	    trg_entry->in_pack == src_entry->in_pack)
 		return 0;
 
@@ -1493,6 +1497,16 @@ static void get_object_list(int ac, cons
 	traverse_commit_list(&revs, show_commit, show_object);
 }
 
+static int count_packed_objects(void)
+{
+	struct packed_git *p;
+	int cnt = 0;
+
+	for (p = packed_git; p; p = p->next)
+		cnt += num_packed_objects(p);
+	return cnt;
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	SHA_CTX ctx;
@@ -1631,6 +1645,8 @@ int cmd_pack_objects(int argc, const cha
 	if (non_empty && !nr_result)
 		return 0;
 
+	repacking_superset = count_packed_objects() < nr_result;
+
 	SHA1_Init(&ctx);
 	list = sorted_by_sha;
 	for (i = 0; i < nr_result; i++) {

