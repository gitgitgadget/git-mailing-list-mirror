From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] upload-pack: avoid parsing objects during ref
 advertisement
Date: Thu, 24 Jan 2013 09:25:39 -0800
Message-ID: <7vr4lacx2k.fsf@alter.siamese.dyndns.org>
References: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191740.GA12903@sigill.intra.peff.net>
 <7vehhiozkb.fsf@alter.siamese.dyndns.org>
 <20130124075008.GA3249@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 18:26:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyQYw-0005lc-52
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 18:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754717Ab3AXRZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 12:25:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34931 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab3AXRZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 12:25:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65911BF4C;
	Thu, 24 Jan 2013 12:25:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQhQ5waxsa5VGKz7hU4GLKL+3zI=; b=vcnekY
	pEixjt/yC7deKt3NBGVQDjXTczxrnDEiJLN1L6pmcAtcP+4iNvin9kROibFRttfz
	OsobnTfTt/hs+/yNT+SurBLIcJEdMYuLzh99CB1IYLqKpAbRaYPl9bgTEjY/tyoa
	MCWb3kUenTMGJ6iuCbJDeYwsSaZVegPVJXEbI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ES6YIc0KSh0827BevFoySahBaAHaB8iZ
	4Zx5XizYd78SOH+vc68ASFcOzQjAJnLU1xr4N09t+CGfemI0oi8q8Y8NP68qWcdV
	1aTc+gINVnF5xKU9Oz93RB0T/P3MZzuF4lJ+WC8BhLYBcWPxaoZCm8wLwP+zaDxL
	i946p/uazTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A18EBF4B;
	Thu, 24 Jan 2013 12:25:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A943FBF48; Thu, 24 Jan 2013
 12:25:40 -0500 (EST)
In-Reply-To: <20130124075008.GA3249@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 24 Jan 2013 02:50:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 134E5810-664B-11E2-8675-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214434>

Jeff King <peff@peff.net> writes:

> And yeah, this should use lookup_unknown_object to extend the
> optimization to mark_our_ref (and avoid removing it for the
> ref-advertisement case, of course).

Thanks for sanity checking.  Here is what is queued at the bottom of
the hide-refs topic.

-- >8 --
Date: Fri, 18 Jan 2013 15:48:49 -0800
Subject: [PATCH] upload-pack: share more code

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
1.8.1.1.525.gdace530
