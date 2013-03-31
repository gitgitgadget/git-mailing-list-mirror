From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] peel_onion(): teach $foo^{object} peeler
Date: Sun, 31 Mar 2013 15:38:59 -0700
Message-ID: <7vy5d3nqik.fsf_-_@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
 <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu>
 <7vboa1qtnb.fsf@alter.siamese.dyndns.org>
 <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 01 00:39:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMQuS-00041a-D5
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 00:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755840Ab3CaWjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 18:39:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755663Ab3CaWjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 18:39:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBCEC11967;
	Sun, 31 Mar 2013 22:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0N5OaQOYw8K/ojLyYAiF02i3QEc=; b=odBv0M
	1T2RjDfqeysnw8ilZMdW6+Iu+5OCWzLS2Cv5Vzzn979zqjZyhlgioUMgX9fFMhLp
	RIb0qWt3sfMgHYPxjRrV4CwOPdWHnG332ciqU5DXGhI5QY4K+5UAi+empsymaW2N
	Hkgnqpm3DCM2MygErk1h1mC2S/jXDj2QkNrlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KkyiQHyOMj+DArSS/6ilStB7UdMZLExf
	/A8niT9OZLif9A4RB4JvvIwUoAs5upWDUAPITGy06+aMu0P2st/5ZtbhtLV76fJR
	s1QP0tN/i4yelmdzWddt54J+C7ZlQLBP837qiWhJAQM9C2VexlZT2KxFghw1eTAR
	fGyHMPbWiaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D01AA11966;
	Sun, 31 Mar 2013 22:39:01 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1F43611965; Sun, 31 Mar
 2013 22:39:01 +0000 (UTC)
In-Reply-To: <7vhajtpdtc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 30 Mar 2013 00:05:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8801EE4-9A53-11E2-AFB6-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219646>

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

This is necessary because the plumbing "rev-parse --verify" is only
about "make sure the argument is something we can feed to get_sha1()
and turn it into a raw 20-byte object name SHA-1" and is not about
"make sure that 20-byte object name SHA-1 refers to an object that
exists in our object store".  When the given $userstring is already
a 40-hex, by definition "rev-parse --verify $userstring" can turn it
into a raw 20-byte object name.  With "$userstring^{object}", we can
make sure that the 40-hex string names an object that exists in our
object store before "--verify" kicks in.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 45788df..85b6e75 100644
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
-- 
1.8.2-441-g6e6f07b
