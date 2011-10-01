From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/8] bundle: use leak_pending flag
Date: Sat, 01 Oct 2011 18:02:36 +0200
Message-ID: <4E87399C.5010700@lsrfire.ath.cx>
References: <4DF6A8B6.9030301@op5.se> <7c0105c6cca7dd0aa336522f90617fe4@quantumfyre.co.uk> <4E84B89F.4060304@lsrfire.ath.cx> <201109291411.06733.mfick@codeaurora.org> <4E8587E8.9070606@lsrfire.ath.cx> <7vfwjeotv1.fsf@alter.siamese.dyndns.org> <4E8607B6.2040800@lsrfire.ath.cx> <4E8731AF.2040305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Oct 01 18:02:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA21f-0007O4-0t
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 18:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754899Ab1JAQCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 12:02:51 -0400
Received: from india601.server4you.de ([85.25.151.105]:55646 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507Ab1JAQCu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 12:02:50 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id 314E22F803A;
	Sat,  1 Oct 2011 18:02:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8731AF.2040305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182561>

Instead of creating a copy of the list of pending objects, copy the
struct object_array that points to it, turn on leak_pending, and thus
cause prepare_revision_walk to leave it to us.  And free it once
we're done.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 bundle.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index f48fd7d..26cc9ab 100644
--- a/bundle.c
+++ b/bundle.c
@@ -122,11 +122,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	req_nr = revs.pending.nr;
 	setup_revisions(2, argv, &revs, NULL);
 
-	memset(&refs, 0, sizeof(struct object_array));
-	for (i = 0; i < revs.pending.nr; i++) {
-		struct object_array_entry *e = revs.pending.objects + i;
-		add_object_array(e->item, e->name, &refs);
-	}
+	refs = revs.pending;
+	revs.leak_pending = 1;
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
@@ -146,6 +143,7 @@ int verify_bundle(struct bundle_header *header, int verbose)
 
 	for (i = 0; i < refs.nr; i++)
 		clear_commit_marks((struct commit *)refs.objects[i].item, -1);
+	free(refs.objects);
 
 	if (verbose) {
 		struct ref_list *r;
-- 
1.7.7
