From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 10/22] send-pack: rename "new_refs" to "need_pack_data"
Date: Fri,  5 Sep 2014 13:54:58 -0700
Message-ID: <1409950510-10209-11-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:56:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xw-0005bR-QL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbaIEUzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53956 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505AbaIEUzi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F19B36696;
	Fri,  5 Sep 2014 16:55:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=z21m
	5Uea0Jx6+c2YJ8tHC16RLEY=; b=SxCWZkWyvehAtVrEw2GYkJkMSFKypc5E/hti
	od27u9W5Xqud9pbIvUPn7w3FaykC0YxQDDmpj/yMl0WJm5uU0ygspUX3fmTa0lXo
	uYgELzEP1mDcl+ny7xR4LWfOPOCNdnS4CNNXuzagP8tZVUq4DIUTo5+dMVKwiRX7
	Jw28+XM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=mp8ILj
	B5DkAFtzWhUeIGQorOoMzzWz4ZYUamJWJo+DrMxZXA6T3nF4ZX9Q2PhVWEL0LYe4
	ee2L+6eUWSthufXC2V+QYfkCkzxUlaeTZMuMKW01202A4nBiHbTdFScwI0pX4QZa
	cpMmiHi9VP7ZyLWWWkG946+howyAsWrQUxYz4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3ABDA36692;
	Fri,  5 Sep 2014 16:55:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0F25C36690;
	Fri,  5 Sep 2014 16:55:36 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: FCA27E6A-353E-11E4-A83C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256531>

The variable counts how many non-deleting command is being sent, but
is only checked with 0-ness to decide if we need to send the pack
data.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 send-pack.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index 0cb44ab..716c11b 100644
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
2.1.0-399-g2df620b
