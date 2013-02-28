From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] describe: Exclude --all --match=PATTERN
Date: Thu, 28 Feb 2013 13:50:53 -0800
Message-ID: <7vtxowglaa.fsf@alter.siamese.dyndns.org>
References: <20130225053152.GI5688@biohazard-cafe.mit.edu>
 <7v1uc1jyq0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Greg Price <price@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:51:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBNz-0007yM-A6
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 22:51:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760717Ab3B1VvA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Feb 2013 16:51:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63762 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760716Ab3B1Vu4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Feb 2013 16:50:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE007A655;
	Thu, 28 Feb 2013 16:50:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F6MLIotdOEVu
	v2OkZ0HK0eL+KJE=; b=GZbPJ1yYNq/0HfS/n1UsRR/Q6ggJ+GYychPaZ8DsKssY
	gNXT9LkJMknVwKGnivdfKVxFxpxn4rKxpuYEFs+LaU8SZEZag7m4JWAW3ibruife
	X0cTmfexmtLQ7wcZtMrL0TAINxa4iDO244+l5sOWkIvjdBPUx00w2PKoo2XTwng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I/VtMP
	ed76Mkr8+W93AazF45CqXSX//h2/VrJgahunT2YrovNxo9MBmYK3cDn6NOv6rFe0
	Mn2kLz5CGR4PUVQe5gLtWkVpVZtEUKgUNOHQFGpDP27nVghzAWeYEuAMeO/wxI/g
	S214w6YIHW4Ewk8M8ICSyRdDCNMxlvAavmOqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E367AA654;
	Thu, 28 Feb 2013 16:50:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 335CEA653; Thu, 28 Feb 2013
 16:50:55 -0500 (EST)
In-Reply-To: <7v1uc1jyq0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Feb 2013 12:20:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED8DF4CA-81F0-11E2-9196-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217258>

Junio C Hamano <gitster@pobox.com> writes:

> I am not sure if this is (1) "behaviour is sometimes useful in
> narrow cases but is not explained well", (2) "behaviour does not
> make sense in any situation", or (3) "the combination can make sense
> if corrected, but the current behaviour is buggy".  If it is (2) or
> (3), I think it makes sense to forbid the combination. Also, if it
> is (3), we should later come up with an improved behaviour and then
> re-enable the combination.
>
> Without "--all" the command considers only the annotated tags to
> base the descripion on, and with "--all", a ref that is not
> annotated tags can be used as a base, but with a lower priority (if
> an annotated tag can describe a given commit, that tag is used).
>
> So na=C3=AFvely I would expect "--all" and "--match" to base the
> description on refs that match the pattern without limiting the
> choice of base to annotated tags, and refs that do not match the
> given pattern should not appear even as the last resort.  It appears
> to me that the current situation is (3).
>
> Will queue and cook in 'next'; thanks.

A fix to the broken semantics may look like this.  There are a few
points to note:

 * The local variable names "is_tag" and "might_be_tag" were
   inconsistent with the rest of the program, where the global
   variable "tags" is used to mean "the user gave --tags to allow
   lightweight ones to be used".  By that definition of the tag, a
   ref under refs/tags/ *is* a tag, and a ref that peels to a
   different object is an annotated tag.  These two variable names
   have been fixed.

 * The function returns early for a ref outside refs/tags/ when
   "--all" is not given with or without this patch.  At the end of
   the function, it also returned when (!all && !prio), but prio
   becomes zero only when the ref is outside refs/tags/ (or the tag
   does not match the pattern) in the original code.  With this
   patch, we reject refs outside refs/tags/ early when "--all" is
   not given, so the last-minute check before add_to_known_names()
   becomes unnecessary (hence removed).

 * If somebody is crazy enough to have an annotated tag under
   refs/heads/, the code would treat it as an annotated tag and
   assign prio=3D=3D2 to it, with or without this patch.  We may want t=
o
   tighten this further by checking with is_tag, but this patch does
   not do anything about it; I wanted it to focus on only one bug,
   i.e. interaction between "--all" and "--match=3D<pattern>".

 * When "--tags" is not given, we still give an unannotated tag to
   add_to_known_names(), only to issue a hint when the given commit
   is not describable with annotated tags but it could be described
   if "--tags" were given.  I think this is optimizing for the wrong
   case, and wasting resources.


 builtin/describe.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 04c185b..b2b740d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -137,40 +137,39 @@ static void add_to_known_names(const char *path,
=20
 static int get_name(const char *path, const unsigned char *sha1, int f=
lag, void *cb_data)
 {
-	int might_be_tag =3D !prefixcmp(path, "refs/tags/");
+	int is_tag =3D !prefixcmp(path, "refs/tags/");
 	unsigned char peeled[20];
-	int is_tag, prio;
+	int is_annotated, prio;
=20
-	if (!all && !might_be_tag)
+	/* Reject anything outside refs/tags/ unless --all */
+	if (!all && !is_tag)
 		return 0;
=20
+	/* Accept only tags that match the pattern, if given */
+	if (pattern && (!is_tag || fnmatch(pattern, path + 10, 0)))
+		return 0;
+
+	/* Is it annotated? */
 	if (!peel_ref(path, peeled)) {
-		is_tag =3D !!hashcmp(sha1, peeled);
+		is_annotated =3D !!hashcmp(sha1, peeled);
 	} else {
 		hashcpy(peeled, sha1);
-		is_tag =3D 0;
+		is_annotated =3D 0;
 	}
=20
-	/* If --all, then any refs are used.
-	 * If --tags, then any tags are used.
-	 * Otherwise only annotated tags are used.
+	/*
+	 * By default, we only use annotated tags, but with --tags
+	 * we fall back to lightweight ones (even without --tags,
+	 * we still remember lightweight ones, only to give hints
+	 * in an error message).  --all allows any refs to be used.
 	 */
-	if (might_be_tag) {
-		if (is_tag)
-			prio =3D 2;
-		else
-			prio =3D 1;
-
-		if (pattern && fnmatch(pattern, path + 10, 0))
-			prio =3D 0;
-	}
+	if (is_annotated)
+		prio =3D 2;
+	else if (is_tag)
+		prio =3D 1;
 	else
 		prio =3D 0;
=20
-	if (!all) {
-		if (!prio)
-			return 0;
-	}
 	add_to_known_names(all ? path + 5 : path + 10, peeled, prio, sha1);
 	return 0;
 }
