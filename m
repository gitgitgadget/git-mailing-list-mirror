From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Tue, 22 May 2012 14:27:51 -0700
Message-ID: <7vlikj3nzc.fsf@alter.siamese.dyndns.org>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
 <4FBBE012.6090702@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue May 22 23:28:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWwcb-0005q2-FL
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 23:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928Ab2EVV14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 17:27:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53430 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625Ab2EVV1z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 May 2012 17:27:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0E8296B6;
	Tue, 22 May 2012 17:27:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tkN6mIe0CZjz
	5OMPY1mprpzgWDw=; b=tmQrLSn2LD/eAveL8xX1P5/rArHhVKCr7Wosisr+07rt
	Syow+vdI4YHGzQ/IntksDfWrwVnMDfiGy9l7kId20OHomsB5i4iwj2sXXl1qXrVx
	W0/FGtduCSH/K2oNbo1D2FDrTIElh5TxeGldImS4Ix0EAZpNTwQlO3SuxFvTq7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sVv4Qg
	/cjjbGn+/ew1nO7urFDV7ef9pTO12e/VNZGdkYV2EYlGKmwcAkzQ7Upwop/ZmXbn
	ue+J4aQ5OY+0yKbRyE4e+YR5cKRbW9tvENTcN9mtlzDQDkisMJKoVlGYMcwoRcoE
	esyJnJEoYZrufcBwtr9HVFnxWdXHm1rkcgL44=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7AA196B5;
	Tue, 22 May 2012 17:27:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79D6796B2; Tue, 22 May 2012
 17:27:53 -0400 (EDT)
In-Reply-To: <4FBBE012.6090702@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Tue, 22 May 2012 20:50:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD80938A-A454-11E1-9DD2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198256>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Why allocate a NUL-terminated copy at all when we can teach the code =
to
> stop after a given number of characters just as easily?  Alas, this
> will still trigger an allocation in search_ref_dir() (see first patch=
).

Yeah, but it is only because search_ref_dir() tries to use ref_entry_cm=
p(),
whose signature is geared more towards being used as a qsort(3) callbac=
k,
as the comparison function for bsearch(3).

A bsearch() callback takes two pointers, one is for the key and the oth=
er
for an array element, and there is no reason to require the two types b=
e
the same.

In other words, something like this patch and we won't need an allocati=
on
of the ref_entry that did not have to be a full ref_entry in the first
place (it only had to be something that supplies the "key" into a sorte=
d
array).

 refs.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 96e943c..52709ab 100644
--- a/refs.c
+++ b/refs.c
@@ -315,6 +315,23 @@ static int ref_entry_cmp(const void *a, const void=
 *b)
=20
 static void sort_ref_dir(struct ref_dir *dir);
=20
+struct string_slice {
+	size_t len;
+	const char *str;
+};
+
+static int ref_entry_cmp_sslice(const void *key_, const void *ent_)
+{
+	struct string_slice *key =3D (struct string_slice *)key_;
+	struct ref_entry *ent =3D *(struct ref_entry **)ent_;
+	int entlen =3D strlen(ent->name);
+	int cmplen =3D key->len < entlen ? key->len : entlen;
+	int cmp =3D memcmp(key->str, ent->name, cmplen);
+	if (cmp)
+		return cmp;
+	return key->len - entlen;
+}
+
 /*
  * Return the entry with the given refname from the ref_dir
  * (non-recursively), sorting dir if necessary.  Return NULL if no
@@ -323,20 +340,17 @@ static void sort_ref_dir(struct ref_dir *dir);
 static struct ref_entry *search_ref_dir(struct ref_dir *dir,
 					const char *refname, size_t len)
 {
-	struct ref_entry *e, **r;
+	struct ref_entry **r;
+	struct string_slice key;
=20
 	if (refname =3D=3D NULL || !dir->nr)
 		return NULL;
=20
 	sort_ref_dir(dir);
-
-	e =3D xmalloc(sizeof(struct ref_entry) + len + 1);
-	memcpy(e->name, refname, len);
-	e->name[len] =3D '\0';
-
-	r =3D bsearch(&e, dir->entries, dir->nr, sizeof(*dir->entries), ref_e=
ntry_cmp);
-
-	free(e);
+	key.len =3D len;
+	key.str =3D refname;
+	r =3D bsearch(&key, dir->entries, dir->nr, sizeof(*dir->entries),
+		    ref_entry_cmp_sslice);
=20
 	if (r =3D=3D NULL)
 		return NULL;
