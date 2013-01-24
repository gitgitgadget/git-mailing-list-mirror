From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] read-cache: refuse to create index referring to
 external objects
Date: Thu, 24 Jan 2013 11:15:55 -0800
Message-ID: <7vpq0ubdec.fsf@alter.siamese.dyndns.org>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <1359016940-18849-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:16:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySHd-0006Bl-QI
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755092Ab3AXTQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 14:16:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49697 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770Ab3AXTP6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2013 14:15:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07EFDC088;
	Thu, 24 Jan 2013 14:15:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rqP5lnO+cbUS
	ZCCWqMbExi+1NcI=; b=e45LwN9DrvNJPBPR7c2D8EXJeA/9kPisjbnqTWNb0XyW
	gatv3oTY7LnVyy8URsVxxQ5NFvLf8eF4RF4IISKqK1vLMPe1rcgAN0Cg34ibROs1
	m0esJySYoMOeey3Pj9oGrtwU1xbCt+GJE78k03hhrPIjzHVwXyLqB4KSX+WCnXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M5eV9U
	0HjxP1NOcu9+Fjixa577d0ZEFuemoDj2xiweetEpB+PDeAgPh3lOOGToHhBIW8n3
	D1vlsB8Mz7rVzmn/2SF8OI43sjjucU4BPCpmxgErhn6FAPABdijvOjQknQwF98Te
	XL2Ks6Y3Ov6N7cEckhJEx785YEqcdWkKuoLUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F125FC086;
	Thu, 24 Jan 2013 14:15:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E77B5C085; Thu, 24 Jan 2013
 14:15:56 -0500 (EST)
In-Reply-To: <1359016940-18849-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 24 Jan
 2013 15:42:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AE690AA-665A-11E2-B2A7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214441>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  read-cache.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index fda78bc..4579215 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1720,6 +1720,26 @@ static int ce_write_entry(git_SHA_CTX *c, int =
fd, struct cache_entry *ce,
>  			      ce->name + common, ce_namelen(ce) - common);
>  	}
> =20
> +	if (object_database_contaminated) {
> +		struct object_info oi;
> +		switch (ce->ce_mode) {
> +		case S_IFGITLINK:
> +			break;
> +		case S_IFDIR:
> +			if (sha1_object_info_extended(ce->sha1, &oi) !=3D OBJ_TREE ||

This case should never happen.  Do we store any tree object in the
index in the first place?

> +			    (oi.alt && oi.alt->external))
> +				die("cannot create index referring to an external tree %s",
> +				    sha1_to_hex(ce->sha1));
> +			break;
> +		default:
> +			if (sha1_object_info_extended(ce->sha1, &oi) !=3D OBJ_BLOB ||
> +				    (oi.alt && oi.alt->external))
> +				die("cannot create index referring to an external blob %s",
> +				    sha1_to_hex(ce->sha1));
> +			break;
> +		}
> +	}
> +
>  	result =3D ce_write(c, fd, ondisk, size);
>  	free(ondisk);
>  	return result;

I think the check you want to add is to the cache-tree code; before
writing the new index out, if you suspect you might have called
cache_tree_update() before, invalidate any hierarchy that is
recorded to produce a tree object that refers to an object that is
only available through external object store.

As to the logic to check if a object is something that we should
refuse to create a new dependent, I think you should not butcher
sha1_object_info_extended(), and instead add a new call that checks
if a given SHA-1 yields an object if you ignore alternate object
databases that are marked as "external", whose signature may
resemble:

	int has_sha1_file_proper(const unsigned char *sha1);

or something.

This is a tangent, but in addition, you may want to add an even
narrower variant that checks the same but ignoring _all_ alternate
object databases, "external" or not:

        int has_sha1_file_local(const unsigned char *sha1);

That may be useful if we want to later make the alternate safer to
use; instead of letting the codepath to create an object ask
has_sha1_file() to see if it already exists and refrain from writing
a new copy, we switch to ask has_sha1_file_locally() and even if an
alternate object database we borrow from has it, we keep our own
copy in our repository.

Not tested beyond syntax, but rebasing something like this patch on
top of your "mark external sources" change may take us closer to
that.

 cache.h     |  2 ++
 sha1_file.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++-----
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 1f96f65..8d651b6 100644
--- a/cache.h
+++ b/cache.h
@@ -766,6 +766,8 @@ extern int move_temp_to_file(const char *tmpfile, c=
onst char *filename);
=20
 extern int has_sha1_pack(const unsigned char *sha1);
 extern int has_sha1_file(const unsigned char *sha1);
+extern int has_sha1_file_proper(const unsigned char *sha1);
+extern int has_sha1_file_local(const unsigned char *sha1);
 extern int has_loose_object_nonlocal(const unsigned char *sha1);
=20
 extern int has_pack_index(const unsigned char *sha1);
diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..1a3192a 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -420,11 +420,18 @@ static int has_loose_object_local(const unsigned =
char *sha1)
 	return !access(name, F_OK);
 }
=20
-int has_loose_object_nonlocal(const unsigned char *sha1)
+enum odb_origin {
+	odb_default =3D 0, odb_proper, odb_local
+};
+
+static int has_loose_object_nonlocal_limited(const unsigned char *sha1=
,
+					     enum odb_origin origin)
 {
 	struct alternate_object_database *alt;
 	prepare_alt_odb();
 	for (alt =3D alt_odb_list; alt; alt =3D alt->next) {
+		if (origin =3D=3D odb_proper && 0 /* alt->external */)
+			continue;
 		fill_sha1_path(alt->name, sha1);
 		if (!access(alt->base, F_OK))
 			return 1;
@@ -432,6 +439,11 @@ int has_loose_object_nonlocal(const unsigned char =
*sha1)
 	return 0;
 }
=20
+int has_loose_object_nonlocal(const unsigned char *sha1)
+{
+	return has_loose_object_nonlocal_limited(sha1, odb_default);
+}
+
 static int has_loose_object(const unsigned char *sha1)
 {
 	return has_loose_object_local(sha1) ||
@@ -2062,12 +2074,28 @@ int is_pack_valid(struct packed_git *p)
 	return !open_packed_git(p);
 }
=20
+static int limit_pack_odb_origin(enum odb_origin origin, struct packed=
_git *p)
+{
+	switch (origin) {
+	default:
+		return 0;
+	case odb_proper:
+		return 0; /* p->external */
+	case odb_local:
+		return !p->pack_local;
+	}
+}
+
 static int fill_pack_entry(const unsigned char *sha1,
 			   struct pack_entry *e,
-			   struct packed_git *p)
+			   struct packed_git *p,
+			   enum odb_origin origin)
 {
 	off_t offset;
=20
+	if (limit_pack_odb_origin(origin, p))
+		return 0;
+
 	if (p->num_bad_objects) {
 		unsigned i;
 		for (i =3D 0; i < p->num_bad_objects; i++)
@@ -2096,7 +2124,8 @@ static int fill_pack_entry(const unsigned char *s=
ha1,
 	return 1;
 }
=20
-static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
+static int find_pack_entry_limited(const unsigned char *sha1, struct p=
ack_entry *e,
+				   enum odb_origin origin)
 {
 	struct packed_git *p;
=20
@@ -2104,11 +2133,11 @@ static int find_pack_entry(const unsigned char =
*sha1, struct pack_entry *e)
 	if (!packed_git)
 		return 0;
=20
-	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack))
+	if (last_found_pack && fill_pack_entry(sha1, e, last_found_pack, orig=
in))
 		return 1;
=20
 	for (p =3D packed_git; p; p =3D p->next) {
-		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p))
+		if (p =3D=3D last_found_pack || !fill_pack_entry(sha1, e, p, origin)=
)
 			continue;
=20
 		last_found_pack =3D p;
@@ -2117,6 +2146,11 @@ static int find_pack_entry(const unsigned char *=
sha1, struct pack_entry *e)
 	return 0;
 }
=20
+static int find_pack_entry(const unsigned char *sha1, struct pack_entr=
y *e)
+{
+	return find_pack_entry_limited(sha1, e, odb_default);
+}
+
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
 				  struct packed_git *packs)
 {
@@ -2630,6 +2664,22 @@ int has_sha1_file(const unsigned char *sha1)
 	return has_loose_object(sha1);
 }
=20
+int has_sha1_file_local(const unsigned char *sha1)
+{
+	struct pack_entry e;
+	if (find_pack_entry_limited(sha1, &e, odb_local))
+		return 1;
+	return has_loose_object_local(sha1);
+}
+
+int has_sha1_file_proper(const unsigned char *sha1)
+{
+	struct pack_entry e;
+	return (!!find_pack_entry_limited(sha1, &e, odb_proper) ||
+		has_loose_object_local(sha1) ||
+		has_loose_object_nonlocal_limited(sha1, odb_proper));
+}
+
 static void check_tree(const void *buf, size_t size)
 {
 	struct tree_desc desc;
