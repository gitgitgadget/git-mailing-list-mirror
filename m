From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] upload-pack: share more code
Date: Fri, 18 Jan 2013 16:37:05 -0800
Message-ID: <1358555826-11883-2-git-send-email-gitster@pobox.com>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
Cc: spearce@spearce.org, mfick@codeaurora.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 01:37:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwMRK-0002GN-SM
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 01:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992Ab3ASAhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 19:37:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751835Ab3ASAhL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 19:37:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2DEDDA0B0;
	Fri, 18 Jan 2013 19:37:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dWe5
	vNh9ZOZG/MN5nK1gRCmV41Y=; b=Y6Kdo7SKTlZk+UzF125uF0TyuIlv/eneaytb
	O4zWFFLI/Wf6CGa+b4EQ/Ekuo8Sem/ixpM4prbwzw9jf/zt6TtkgZqhfV0ofg64r
	dLG4sMZrsnOVGHJNaNQEOLLV3VmBpcy77f42KGvpmRvMRi/WgvMjCuhHFJF6Aemt
	QlY12LQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	MdcEfehgttgsbuNFTIE4EEDPBPBI/d9tbRvGsJHWtpaAQXqjbUodDlPq8SsYE382
	/URwElkhHGGejzC3eeiUYWWyV1Rex7Ha/j9gB3u1kHZCVGcOOfcLDcqopWMAVtJt
	MJWb/3pgolfp4Sn2UG2wCPv+JGoGKncBT65v5djid/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24208A0AF;
	Fri, 18 Jan 2013 19:37:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93934A0AD; Fri, 18 Jan 2013
 19:37:10 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.454.g48d39c0
In-Reply-To: <1358555826-11883-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5C6A8714-61D0-11E2-BEF8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213952>

We mark the objects pointed at our refs with "OUR_REF" flag in two
functions (mark_our_ref() and send_ref()), but we can just use the
former as a helper for the latter.

Update the way mark_our_ref() prepares in-core object to use
lookup_unknown_object() to delay reading the actual object data,
just like we did in 435c833 (upload-pack: use peel_ref for ref
advertisements, 2012-10-04).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 95d8313..3dd220d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -722,15 +722,28 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
+static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct object *o = lookup_unknown_object(sha1);
+	if (!o)
+		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
+	if (!(o->flags & OUR_REF)) {
+		o->flags |= OUR_REF;
+		nr_our_refs++;
+	}
+	return 0;
+}
+
 static int send_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	static const char *capabilities = "multi_ack thin-pack side-band"
 		" side-band-64k ofs-delta shallow no-progress"
 		" include-tag multi_ack_detailed";
-	struct object *o = lookup_unknown_object(sha1);
 	const char *refname_nons = strip_namespace(refname);
 	unsigned char peeled[20];
 
+	mark_our_ref(refname, sha1, flag, cb_data);
+
 	if (capabilities)
 		packet_write(1, "%s %s%c%s%s agent=%s\n",
 			     sha1_to_hex(sha1), refname_nons,
@@ -740,27 +753,11 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 	else
 		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
 	capabilities = NULL;
-	if (!(o->flags & OUR_REF)) {
-		o->flags |= OUR_REF;
-		nr_our_refs++;
-	}
 	if (!peel_ref(refname, peeled))
 		packet_write(1, "%s %s^{}\n", sha1_to_hex(peeled), refname_nons);
 	return 0;
 }
 
-static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
-{
-	struct object *o = parse_object(sha1);
-	if (!o)
-		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
-	if (!(o->flags & OUR_REF)) {
-		o->flags |= OUR_REF;
-		nr_our_refs++;
-	}
-	return 0;
-}
-
 static void upload_pack(void)
 {
 	if (advertise_refs || !stateless_rpc) {
-- 
1.8.1.1.454.g48d39c0
