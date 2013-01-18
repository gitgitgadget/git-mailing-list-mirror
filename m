From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] upload-pack: avoid parsing objects during ref
 advertisement
Date: Fri, 18 Jan 2013 15:12:52 -0800
Message-ID: <7vehhiozkb.fsf@alter.siamese.dyndns.org>
References: <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120106191740.GA12903@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jan 19 00:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwL7c-0005ly-2j
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 00:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab3ARXMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 18:12:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869Ab3ARXMy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 18:12:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39A76A04E;
	Fri, 18 Jan 2013 18:12:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qAweIRJNbL59566Kiar9GKUjxW0=; b=CR2pvu
	TaAJD1c8yRqreHHK8xCitADTyDm7CZrlwEkb9/FwrkzjoGKQvhdY7KXWIpbPrGAC
	VO8Orja/sbRU5d+k3Va9OXBzsSGA99bNtWtESXho7lhNc33nToTL1k3v1rRYjUkc
	NASocM5idoIgmg8IvzsYHmrGcfZe9hRYLIAcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bGp44YiGfsYA8qmcVzU2Jwa6jzokfzIa
	2jcW3W/qtGTwQUx2fRb+oeI8fEPFMk6m7EJRUsf/fuI4TwckwFRX9b5hIQYXlnn2
	rxGhIIIpN8grZtQ6j9RT7Ko68YCnbN994nTfOLDiAQXw3LNwAs6a7dxVvyfdLW3o
	LE0rYH8fdJA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287B2A04C;
	Fri, 18 Jan 2013 18:12:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 846C1A04A; Fri, 18 Jan 2013
 18:12:53 -0500 (EST)
In-Reply-To: <20120106191740.GA12903@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 Jan 2012 14:17:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 962C408E-61C4-11E2-A08C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213949>

Jeff King <peff@peff.net> writes:

> When we advertise a ref, the first thing we do is parse the
> pointed-to object. This gives us two things:
>
>   1. a "struct object" we can use to store flags
>
>   2. the type of the object, so we know whether we need to
>      dereference it as a tag
>
> Instead, we can just use lookup_unknown_object to get an
> object struct, and then fill in just the type field using
> sha1_object_info (which, in the case of packed files, can
> find the information without actually inflating the object
> data).
>
> This can save time if you have a large number of refs, and
> the client isn't actually going to request those refs (e.g.,
> because most of them are already up-to-date).
>
> The downside is that we are no longer verifying objects that
> we advertise by fully parsing them (however, we do still
> know we actually have them, because sha1_object_info must
> find them to get the type). While we might fail to detect a
> corrupt object here, if the client actually fetches the
> object, we will parse (and verify) it then.
>...

This is an old news, but do you recall why this patch did not update
the code in mark_our_ref() that gets "struct object *o" from parse_object()
the same way and mark them with OUR_REF flag?

I was wondering about code consolidation like this.

 upload-pack.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 95d8313..609cd6c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -722,15 +722,18 @@ static void receive_needs(void)
 	free(shallows.objects);
 }
 
+static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data);
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
@@ -740,10 +743,6 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
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
@@ -751,7 +750,7 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
 
 static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(sha1); /* lookup-unknown??? */
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
 	if (!(o->flags & OUR_REF)) {
