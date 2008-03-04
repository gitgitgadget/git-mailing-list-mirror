From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] fsck.c: fix bogus "empty tree" check
Date: Tue, 4 Mar 2008 15:26:35 +0300
Message-ID: <20080304152635.40451f7c.vsu@altlinux.ru>
References: <7vbq5u91lf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__4_Mar_2008_15_26_35_+0300_NbUhztsLijhEbIlE"
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 13:59:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWWkE-000423-13
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:59:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764598AbYCDM7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 07:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764599AbYCDM7H
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 07:59:07 -0500
Received: from mivlgu.ru ([195.20.195.134]:59880 "EHLO mail.mivlgu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764551AbYCDM7F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 07:59:05 -0500
X-Greylist: delayed 1939 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2008 07:59:04 EST
Received: from center4.mivlgu.local (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with SMTP
	id 7EB16808C; Tue,  4 Mar 2008 15:26:35 +0300 (MSK)
In-Reply-To: <7vbq5u91lf.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.12.1; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76082>

--Signature=_Tue__4_Mar_2008_15_26_35_+0300_NbUhztsLijhEbIlE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 04 Mar 2008 03:21:16 -0800 Junio C Hamano wrote:

>  * I've wasted a few hours tonight hunting for random breakages in "git
>    push", the symptom of which is "fatal: unresolved deltas left after
>    unpacking."  I was hoping this patch would fix it, but it seems that
>    the problem is elsewhere.
>
>    I'll revert the following two commits for now:
>
>    d5ef408 (unpack-objects: prevent writing of inconsistent objects)
>    28f72a0 (receive-pack: use strict mode for unpacking objects)
>
>    as I have verified that running with receive.fsckobjects set to false
>    fixes the issues for me, and the repository at the receiving end (both
>    before and after the push) pass git-fsck without problems.  Needless to
>    say, I am not a happy camper right now.

This part of commit d5ef408 changes is bogus:

> @@ -144,9 +205,36 @@ static void added_object(unsigned nr, enum object_type type,
>  static void write_object(unsigned nr, enum object_type type,
>  			 void *buf, unsigned long size)
>  {
> -	if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
> -		die("failed to write object");
>  	added_object(nr, type, buf, size);

The write_sha1_file() call here was calculating obj_list[nr].sha1; now
it is removed, but added_object() needs this value:

| static void added_object(unsigned nr, enum object_type type,
| 			 void *data, unsigned long size)
| {
| 	struct delta_info **p = &delta_list;
| 	struct delta_info *info;
|
| 	while ((info = *p) != NULL) {
| 		if (!hashcmp(info->base_sha1, obj_list[nr].sha1) ||
					      ^^^^^^^^^^^^^^^^^
| 		    info->base_offset == obj_list[nr].offset) {
| 			*p = info->next;
| 			p = &delta_list;
| 			resolve_delta(info->nr, type, data, size,
| 				      info->delta, info->size);
| 			free(info);
| 			continue;
| 		}
| 		p = &info->next;
| 	}
| }

However, I do not have time to create a proper test case for this.

> +	if (!strict) {
> +		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
> +			die("failed to write object");
> +		free(buf);
> +		obj_list[nr].obj = 0;
> +	} else if (type == OBJ_BLOB) {
> +		struct blob *blob;
> +		if (write_sha1_file(buf, size, typename(type), obj_list[nr].sha1) < 0)
> +			die("failed to write object");
> +		free(buf);
> +
> +		blob = lookup_blob(obj_list[nr].sha1);
> +		if (blob)
> +			blob->object.flags |= FLAG_WRITTEN;
> +		else
> +			die("invalid blob object");
> +		obj_list[nr].obj = 0;
> +	} else {
> +		struct object *obj;
> +		int eaten;
> +		hash_sha1_file(buf, size, typename(type), obj_list[nr].sha1);
> +		obj = parse_object_buffer(obj_list[nr].sha1, type, size, buf, &eaten);
> +		if (!obj)
> +			die("invalid %s", typename(type));
> +		/* buf is stored via add_object_buffer and in obj, if its a tree or commit */
> +		add_object_buffer(obj, buf, size);
> +		obj->flags |= FLAG_OPEN;
> +		obj_list[nr].obj = obj;
> +	}
>  }
>
>  static void resolve_delta(unsigned nr, enum object_type type,

The simplest way to fix this would be to duplicate the added_object()
call in all branches; invoking hash_sha1_file() unconditionally will
work too, but may be wasteful if we need to call write_sha1_file()
afterwards.

--Signature=_Tue__4_Mar_2008_15_26_35_+0300_NbUhztsLijhEbIlE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHzT/7W82GfkQfsqIRAiZoAJwOkWsReskG4qRW2RQPdOuKX/Cf2QCfQp5k
TwmWcGE+8nBa6mfTJeKA5Bo=
=g5pm
-----END PGP SIGNATURE-----

--Signature=_Tue__4_Mar_2008_15_26_35_+0300_NbUhztsLijhEbIlE--
