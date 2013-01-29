From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] upload-pack: share more code
Date: Mon, 28 Jan 2013 16:13:30 -0800
Message-ID: <1359418412-26602-2-git-send-email-gitster@pobox.com>
References: <1359418412-26602-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 01:14:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzypq-0005Sy-RS
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 01:13:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436Ab3A2ANj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 19:13:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380Ab3A2ANh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 19:13:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE60CC7F2
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=yp/q
	XcpUAzxkSTATDqPnLNg2Ryg=; b=Grz4qScqqeKScAijBMoE2gDo8BlvuCW8oUmd
	+8C1OomFo21D/C0KjupylUpLN65OqicSxGyopdOTnaSdFg6o6R7NB22PUxmZxhdh
	ZchtbhXL5h8Q3ADnc8Cn6ItLECn9gAvN19ZwCFvXKdxIz2+FG+PdQkewdZAMVfNc
	eet0Arg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=k+b0gK
	hN9bcr9ainWjOf43Nm2M9GWAqfTzBC6ftOJuYKGQAHn2kBkq6BOBfeFlOKWAKDNk
	195jgPjcD1cQ8F3ofAMls3RmvDnM2ww2CPFOPEw+FVGNy9HVUCWqVuYi5irRb4Do
	rC2+F0IotejRAJ9IA7KJ+abmZMoNi81V7GGnc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D20F3C7F1
	for <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:36 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 471AAC7F0 for
 <git@vger.kernel.org>; Mon, 28 Jan 2013 19:13:36 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.548.g0e4986f
In-Reply-To: <1359418412-26602-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: B98CEA4C-69A8-11E2-BFCC-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214889>

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
1.8.1.2.548.g0e4986f
