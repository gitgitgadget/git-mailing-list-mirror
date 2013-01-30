From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/8] upload-pack: share more code
Date: Wed, 30 Jan 2013 10:45:35 -0800
Message-ID: <1359571542-19852-2-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg3-0004fU-P3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756669Ab3A3Spx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:45:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33629 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756648Ab3A3Spq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AB58C3F4;
	Wed, 30 Jan 2013 13:45:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Hzmq
	FnwHj5MFwdpCXjCM6ol54r8=; b=akq984U8nKPB2uqSEUUZEXDNiojZRCz2QoN+
	RazAqPKXPbCfouKo6WG9V+NlBc3u6gry4og2B7D/0yLJhIVmHyKyvS7acBV6q5j4
	OLv3KI8BnK6TgSvD93yRHFsjDVU0dpda+/MdA8slhR+MRJBwxqjLDNO/RpHu8uMA
	h0YX9p4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	NTCqF3ND4cpXzbK69Uuef6kp6ThmjKs6xvPuuGN3Bvebg6/l3cMGLcl/Sxyrcnct
	uiRSIDelPXLoJU/UwPfdY6gzGr3uWdHok5r8lBZkayX22zeIR34//CYZmcJ6mkpx
	dvMoJ5bmpagRol2BPI0SlDPLRKIzTQcuJ6CFJekZRiA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40C71C3F1;
	Wed, 30 Jan 2013 13:45:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 854CBC3EF; Wed, 30 Jan 2013
 13:45:45 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 41B2DCA0-6B0D-11E2-970C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215049>

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
1.8.1.2.589.ga9b91ac
