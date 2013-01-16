From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] push: update remote tags only with force
Date: Wed, 16 Jan 2013 09:10:10 -0800
Message-ID: <7vfw21xde5.fsf@alter.siamese.dyndns.org>
References: <1354239700-3325-1-git-send-email-chris@rorvick.com>
 <DBF53EC2-A669-4B77-B88E-BFCDF43C862E@quendi.de>
 <20130116160131.GB22400@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Horn <max@quendi.de>, Chris Rorvick <chris@rorvick.com>,
	git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 18:11:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvWW0-0008Ff-9N
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 18:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757114Ab3APRKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 12:10:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755595Ab3APRKN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 12:10:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 906ABBCAD;
	Wed, 16 Jan 2013 12:10:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=768zhzTecZ0SUeUyahKOukVMZw0=; b=xfyBrF
	+309LdveR0McXyteWXntnhtKmlb9ywAKZFe5OCM+YMaLIH8xdl1cwiu0C5xELS7v
	vZ26QM/2jL6JAeebgf6NtVbtfK/LbzkR2+owzTsv6xszoJxBHcX7tI8m/qQZlFQY
	6XKcbO0VacvwZ3+Jdld0ud6V7WHyiV8suIW+A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cCUHyvHWLEdlD9mIYFtYmYtHZ8Jw6ghE
	1vfFPPgPTNcETtj70eCmw6XNa9czP8MIyIfcIXaBlvsNFa/OnVqNfeB8kt/qrIW/
	JE1MXDZaxe7Ihewhh9V5qlj0b3ADYP4y19ZLEE/UBx0UrmILz9jtKa1Wv9k4UcbQ
	WYzL+CPVr5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81EFABCAC;
	Wed, 16 Jan 2013 12:10:12 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92F57BCA8; Wed, 16 Jan 2013
 12:10:11 -0500 (EST)
In-Reply-To: <20130116160131.GB22400@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 16 Jan 2013 08:01:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 963CB4D0-5FFF-11E2-9A41-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213772>

Jeff King <peff@peff.net> writes:

> I.e., we trigger the "!o" branch after the parse_object in your example.

Heh, I didn't see this message until now (gmane seems to be lagging
a bit).

I am very tempted to do this.

 * Remove unnecessary not_forwardable from "struct ref"; it is only
   used inside set_ref_status_for_push();

 * "refs/tags/" is the only hierarchy that cannot be replaced
   without --force;

 * Remove the misguided attempt to force that everything that
   updates an existing ref has to be a commit outside "refs/tags/"
   hierarchy.  This code does not know what kind of objects the user
   wants to place in "refs/frotz/" hierarchy it knows nothing about.

I feel moderately strongly about the last point.  Defining special
semantics for one hierarchy (e.g. "refs/tags/") and implementing a
policy for enforcement is one thing, but a random policy that
depends on object type that applies globally is simply insane.  The
user may want to do "refs/tested/" hierarchy that is meant to hold
references to commit, with one annotated tag "refs/tested/latest"
that points at the "latest tested version" with some commentary, and
maintain the latter by keep pushing to it.  If that is the semantics
the user wanted to ahve in the "refs/tested/" hierarchy, it is not
reasonable to require --force for such a workflow.  The user knows
better than Git in such a case.


 cache.h               |  1 -
 remote.c              | 24 +-----------------------
 t/t5516-fetch-push.sh | 21 ---------------------
 3 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/cache.h b/cache.h
index a32a0ea..a942bbd 100644
--- a/cache.h
+++ b/cache.h
@@ -1004,7 +1004,6 @@ struct ref {
 		requires_force:1,
 		merge:1,
 		nonfastforward:1,
-		not_forwardable:1,
 		update:1,
 		deletion:1;
 	enum {
diff --git a/remote.c b/remote.c
index aa6b719..2c747c4 100644
--- a/remote.c
+++ b/remote.c
@@ -1279,26 +1279,6 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	return 0;
 }
 
-static inline int is_forwardable(struct ref* ref)
-{
-	struct object *o;
-
-	if (!prefixcmp(ref->name, "refs/tags/"))
-		return 0;
-
-	/* old object must be a commit */
-	o = parse_object(ref->old_sha1);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-
-	/* new object must be commit-ish */
-	o = deref_tag(parse_object(ref->new_sha1), NULL, 0);
-	if (!o || o->type != OBJ_COMMIT)
-		return 0;
-
-	return 1;
-}
-
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	int force_update)
 {
@@ -1344,8 +1324,6 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 *     passing the --force argument
 		 */
 
-		ref->not_forwardable = !is_forwardable(ref);
-
 		ref->update =
 			!ref->deletion &&
 			!is_null_sha1(ref->old_sha1);
@@ -1355,7 +1333,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 				!has_sha1_file(ref->old_sha1)
 				  || !ref_newer(ref->new_sha1, ref->old_sha1);
 
-			if (ref->not_forwardable) {
+			if (!prefixcmp(ref->name, "refs/tags/")) {
 				ref->requires_force = 1;
 				if (!force_ref_update) {
 					ref->status = REF_STATUS_REJECT_ALREADY_EXISTS;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6009372..8f024a0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -950,27 +950,6 @@ test_expect_success 'push requires --force to update lightweight tag' '
 	)
 '
 
-test_expect_success 'push requires --force to update annotated tag' '
-	mk_test heads/master &&
-	mk_child child1 &&
-	mk_child child2 &&
-	(
-		cd child1 &&
-		git tag -a -m "message 1" Tag &&
-		git push ../child2 Tag:refs/tmp/Tag &&
-		git push ../child2 Tag:refs/tmp/Tag &&
-		>file1 &&
-		git add file1 &&
-		git commit -m "file1" &&
-		git tag -f -a -m "message 2" Tag &&
-		test_must_fail git push ../child2 Tag:refs/tmp/Tag &&
-		git push --force ../child2 Tag:refs/tmp/Tag &&
-		git tag -f -a -m "message 3" Tag HEAD~ &&
-		test_must_fail git push ../child2 Tag:refs/tmp/Tag &&
-		git push --force ../child2 Tag:refs/tmp/Tag
-	)
-'
-
 test_expect_success 'push --porcelain' '
 	mk_empty &&
 	echo >.git/foo  "To testrepo" &&
