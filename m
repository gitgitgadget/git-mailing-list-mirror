From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 10/21] send-pack: rename "new_refs" to "need_pack_data"
Date: Thu,  4 Sep 2014 13:04:46 -0700
Message-ID: <1409861097-19151-11-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:05:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdHu-0000jh-JH
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbaIDUFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61180 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755396AbaIDUFk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B0EC5381BB;
	Thu,  4 Sep 2014 16:05:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sT/u
	ciHomrh4DCkvkPI/JNwLETc=; b=B7/iSLeRJFh0OeWmr6Lezffs6IxEJqi2tA32
	eAH0WiQcwU5IHZlxwj5v8HR1az0vYCDRo3HI5KXVdUTQhHo63UlCj2p8vxgy8RJM
	NrPFqm0ScLL+JA6hDzJG6gMMC5Z/afmfzdpPHGTvodqxH80eAg9CsysATQowwJNb
	WWolVbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=DwDUF2
	ekFa1uYouFT2IMliIVL6+EKdfZqlVa9HDYFpj7BPGpRzhP3LyiXQ9res+utB05+1
	MgGSL+ELtMMJLQkxRgq7Hp9B/lf7TEYwg4pyeX/pDi6XF+yKHQQf4n1a/PFdFbM7
	yfoXRgF86SvFbEx46GvRdszTF6R0cDU0gJmU8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1037381BA;
	Thu,  4 Sep 2014 16:05:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 09328381A8;
	Thu,  4 Sep 2014 16:05:34 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D4E049DC-346E-11E4-82FE-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256468>

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
2.1.0-399-g1364b4d
