From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in "git rev-parse --verify"
Date: Sat, 30 Mar 2013 00:05:51 -0700
Message-ID: <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
 <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu>
 <7vboa1qtnb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 30 08:06:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULprr-0005MN-Fa
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 08:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575Ab3C3HFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 03:05:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45308 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753625Ab3C3HFy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 03:05:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BC36F6F9;
	Sat, 30 Mar 2013 07:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yWD5AfBkM50Eqg4cOAjIAB1ZFU8=; b=qrWBxs
	tOX6hLfMDZWi1hc3G1JZOCaRFn9ykm2ptPDj78R3WmqEwgnwbzwl7qX559ls9B8w
	MU332SIaEE9acDCg0Lda6PNCb5NAfzojIBzTt0K8k4TamteP72TB0Rgq2Z+bb2hx
	mQeleAZ031pac7G/3bHWGzzbqbdzovNOST/B0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uUWxUlbF1WdnLHatIooQPvJx6STajHmX
	RYD9BQGYUyEkMrcnLPaMRnEWAds5YwEkDQv7j3B5SBnTF2pxW/uSsvSrmaP1q3rh
	cD/Qwh3zYFSIJFxBASSWcF8n00ARZ8ZWcHYfNqKwY9/E2u+4iDlPsIIr9Vdpv/Wx
	onP8qefMHn8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31F3AF6F3;
	Sat, 30 Mar 2013 07:05:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69DC0F6F0; Sat, 30 Mar 2013
 07:05:53 +0000 (UTC)
In-Reply-To: <7vboa1qtnb.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 29 Mar 2013 23:38:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 42D2BF6E-9908-11E2-9747-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219563>

Junio C Hamano <gitster@pobox.com> writes:

> What we may want is another type peeling operator, ^{object}.
> that makes sure it is an object, like this:
>
>     rev-parse --verify 572a535454612a046e7dd7404dcca94d6243c788^{object}
>
> It asks "I have this 40-hex; I want an object out of it", just like
> frotz^{tree} is "I have 'frotz'; I want a tree-ish" for any value of
> 'frotz'.
>
> With that, a use case that it wants to see _any_ object can safely
> use 'rev-parse --verify "$userinput^{object}' without an annotated
> tag getting in the way.
>
> How does that sound?

Perhaps something like this.  Note that the last hunk is unrelated
thinko-fix I noticed while browsing the code.

-- >8 --
Subject: sha1_name.c: ^{object} peeler

A string that names an object can be suffixed with ^{type} peeler to
say "I have this object name; peel it until you get this type. If
you cannot do so, it is an error".  v1.8.2^{commit} asks for a commit
that is pointed at an annotated tag v1.8.2; v1.8.2^{tree} unwraps it
further to the top-level tree object.  A special suffix ^{} (i.e. no
type specified) means "I do not care what it unwraps to; just peel
annotated tag until you get something that is not a tag".

When you have a random user-supplied string, you can turn it to a
bare 40-hex object name, and cause it to error out if such an object
does not exist, with:

	git rev-parse --verify "$userstring^{}"

for most objects, but this does not yield the tag object name when
$userstring refers to an annotated tag.

Introduce a new suffix, ^{object}, that only makes sure the given
name refers to an existing object.  Then

	git rev-parse --verify "$userstring^{object}"

becomes a way to make sure $userstring refers to an existing object.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index c50630a..85b6e75 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -594,7 +594,7 @@ struct object *peel_to_type(const char *name, int namelen,
 	while (1) {
 		if (!o || (!o->parsed && !parse_object(o->sha1)))
 			return NULL;
-		if (o->type == expected_type)
+		if (expected_type == OBJ_ANY || o->type == expected_type)
 			return o;
 		if (o->type == OBJ_TAG)
 			o = ((struct tag*) o)->tagged;
@@ -645,6 +645,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		expected_type = OBJ_TREE;
 	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
 		expected_type = OBJ_BLOB;
+	else if (!prefixcmp(sp, "object}"))
+		expected_type = OBJ_ANY;
 	else if (sp[0] == '}')
 		expected_type = OBJ_NONE;
 	else if (sp[0] == '/')
@@ -654,6 +656,8 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 
 	if (expected_type == OBJ_COMMIT)
 		lookup_flags = GET_SHA1_COMMITTISH;
+	else if (expected_type == OBJ_TREE)
+		lookup_flags = GET_SHA1_TREEISH;
 
 	if (get_sha1_1(name, sp - name - 2, outer, lookup_flags))
 		return -1;
