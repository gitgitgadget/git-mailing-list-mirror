From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/18] send-pack: rename "new_refs" to "need_pack_data"
Date: Tue, 19 Aug 2014 15:06:18 -0700
Message-ID: <1408485987-3590-10-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:08:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJrZc-0006A7-MD
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbaHSWII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:08:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59099 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbaHSWIG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:08:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E25983311A;
	Tue, 19 Aug 2014 18:08:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=CtQw
	2JR/9YZ6CN/JsGq/CzaKH+U=; b=sIJZ0lzQO3kqzXCwN6zyIFNu2DD0qElbd5xk
	F5IDN8X4lNZyaxNBBw7t55wUWPjtsZfgUBPCS4KizMmcLHtdntsq4AkUA4yPUMSz
	aeBFulMC+nMnyb6rsfACuaSEvbD+Jg2zKkxC4xjbY6pPz92wseUUPqdYEpJvWOUC
	WDM6Bpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=fInR7l
	LUngMQDvIWDMW7whxC4it0UHG48T8r0gFj/2m2QXsph8TGR4A9XJzNmgiawTkANU
	pnIq7qyyvQasvmJqFmq9wEKqEEuPOMA5XfzrYsXRmXd2dRG7igMTxlJpNO+9sULp
	1xu1bB0D0yiuilbooy/SnPmoRyJ/MoPLwg1Ik=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA46733119;
	Tue, 19 Aug 2014 18:08:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 322283310E;
	Tue, 19 Aug 2014 18:07:58 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4722DC6E-27ED-11E4-9CE4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255529>

The variable counts how many non-deleting command is being sent, but
is only checked with 0-ness to decide if we need to send the pack
data.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index c1c64ee..590eb0a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -220,7 +220,7 @@ int send_pack(struct send_pack_args *args,
 	struct strbuf req_buf = STRBUF_INIT;
 	struct strbuf cap_buf = STRBUF_INIT;
 	struct ref *ref;
-	int new_refs;
+	int need_pack_data = 0;
 	int allow_deleting_refs = 0;
 	int status_report = 0;
 	int use_sideband = 0;
@@ -276,13 +276,12 @@ int send_pack(struct send_pack_args *args,
 	/*
 	 * Finally, tell the other end!
 	 */
-	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		if (!ref_update_to_be_sent(ref, args))
 			continue;
 
 		if (!ref->deletion)
-			new_refs++;
+			need_pack_data = 1;
 
 		if (args->dry_run) {
 			ref->status = REF_STATUS_OK;
@@ -327,7 +326,7 @@ int send_pack(struct send_pack_args *args,
 		in = demux.out;
 	}
 
-	if (new_refs && cmds_sent) {
+	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
 			for (ref = remote_refs; ref; ref = ref->next)
 				ref->status = REF_STATUS_NONE;
-- 
2.1.0-301-g54593e2
