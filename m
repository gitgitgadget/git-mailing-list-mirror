From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/8] revision: factor out add_pending_sha1
Date: Sat, 01 Oct 2011 17:43:52 +0200
Message-ID: <4E873538.8080401@lsrfire.ath.cx>
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
X-From: git-owner@vger.kernel.org Sat Oct 01 17:44:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RA1jd-0002eM-1p
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 17:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756614Ab1JAPoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 11:44:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:55617 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1JAPoG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 11:44:06 -0400
Received: from [192.168.2.104] (p4FFDAD66.dip.t-dialin.net [79.253.173.102])
	by india601.server4you.de (Postfix) with ESMTPSA id CB8BA2F803A;
	Sat,  1 Oct 2011 17:44:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E8731AF.2040305@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182557>

This function is a combination of the static get_reference and
add_pending_object.  It can be used to easily queue objects by hash.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
The next patch is going to use it in checkout.

 revision.c |   11 ++++++++---
 revision.h |    1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index c46cfaa..2e8aa33 100644
--- a/revision.c
+++ b/revision.c
@@ -185,6 +185,13 @@ static struct object *get_reference(struct rev_info *revs, const char *name, con
 	return object;
 }
 
+void add_pending_sha1(struct rev_info *revs, const char *name,
+		      const unsigned char *sha1, unsigned int flags)
+{
+	struct object *object = get_reference(revs, name, sha1, flags);
+	add_pending_object(revs, object, name);
+}
+
 static struct commit *handle_commit(struct rev_info *revs, struct object *object, const char *name)
 {
 	unsigned long flags = object->flags;
@@ -832,9 +839,7 @@ struct all_refs_cb {
 static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
-	struct object *object = get_reference(cb->all_revs, path, sha1,
-					      cb->all_flags);
-	add_pending_object(cb->all_revs, object, path);
+	add_pending_sha1(cb->all_revs, path, sha1, cb->all_flags);
 	return 0;
 }
 
diff --git a/revision.h b/revision.h
index 3d64ada..4541265 100644
--- a/revision.h
+++ b/revision.h
@@ -191,6 +191,7 @@ extern void add_object(struct object *obj,
 		       const char *name);
 
 extern void add_pending_object(struct rev_info *revs, struct object *obj, const char *name);
+extern void add_pending_sha1(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags);
 
 extern void add_head_to_pending(struct rev_info *);
 
-- 
1.7.7
