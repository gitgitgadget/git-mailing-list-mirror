From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] find_pack_entry(): do not keep packed_git pointer
 locally
Date: Tue, 31 Jan 2012 10:02:35 -0800
Message-ID: <7vr4yf92dg.fsf@alter.siamese.dyndns.org>
References: <1327922750-12106-1-git-send-email-pclouds@gmail.com>
 <1328010239-29669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, nico@fluxnic.net
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 19:02:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsI2W-0004OP-VX
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 19:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090Ab2AaSCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 13:02:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39281 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753505Ab2AaSCj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 13:02:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D763562F6;
	Tue, 31 Jan 2012 13:02:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e6jDilT/TYeH
	Xepr7o4I3cTtaMA=; b=gwbCtgrSkxvrN9nCk39LTzBuKLghyot6zlQ1HBCGB2r7
	EPt4TGUaLLCLHrFshrUhWSV+1XvFwJndvhs8BNjzKp02UPYwXnHvfweLHJ2QknVJ
	nvSd5ASov9UA4jvKbxn6e6ePpj8mYz5Zo0CvJtMxku60D0a5ZEi7u6bP0nrrmYc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pPknvG
	CZIWXTrMUmqIH1m/oJIoNnwWd5+/Gsv1LUlkHnhDG2z3oz+1WRHuapEd+P7Wd0M7
	3MAVsQF8YL44gDbb9NC1DXysY8gnOrjoNpCLoy/PjB5gXYPDgMboUzXPawYSIZfy
	0q13PkWvuwzSod6Ma/FVWaVfcBQ0eXBCt2lj4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFB4A62F5;
	Tue, 31 Jan 2012 13:02:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 308F062F4; Tue, 31 Jan 2012
 13:02:37 -0500 (EST)
In-Reply-To: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 31 Jan
 2012 18:43:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2265DDC-4C35-11E1-A458-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189462>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  Changing INVALID_PACK to NULL breaks at least t1050.4. We may
>  restructure the p assignments at the end of find_pack_entry() to
>  allow setting INVALID_PACK to NULL.
> =20
>  But I'm not really excited about that.

The patch to do so should be a trivial one on top of this anyway
(attached).

> -		if (p =3D=3D last_found)
> +		if (p =3D=3D find_pack_entry_last_found)
>  			p =3D packed_git;
>  		else
>  			p =3D p->next;
> -		if (p =3D=3D last_found)
> +		/*
> +		 * p can be NULL from the else clause above, if initial
> +		 * f_p_e_last_found value (i.e. INVALID_PACK) is NULL, we may
> +		 * advance p again to an imaginary pack in invalid memory
> +		 */
> +		if (p =3D=3D find_pack_entry_last_found)
>  			p =3D p->next;

But I think the real issue is that the original loop is written in an
obscure way.  The conversion in f7c22cc (always start looking up object=
s
in the last used pack first, 2007-05-30) wanted to turn the traversal t=
hat
always went from the tip of a linked list to instead first probe the
promising one, and then scan the list from the tip like it used to do,
except that it did not want to probe the one it thought promising again=
=2E

So perhaps restructuring the loop by making the logic to probe into a
single pack into a helper function, e.g.

static int find_pack_entry(const unsigned char *sha1, struct pack_entry=
 *e)
{
	if (last_found) {
		if (find_one(sha1, e, last_found))
			return 1;
	}
        for (p =3D packed_git; p; p =3D p->next) {
        	if (p =3D=3D last_found || !find_one(sha1, e, p))
			continue;
		last_found =3D p;
		return 1;
	}
        return 0;
}

would make the resulting flow far easier to follow, no?


 sha1_file.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 77512a3..2286789 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -54,9 +54,7 @@ static struct cached_object empty_tree =3D {
 	0
 };
=20
-/* INVALID_PACK cannot be NULL, see comments in find_pack_entry */
-#define INVALID_PACK (struct packed_git *)1
-static struct packed_git *find_pack_entry_last_found =3D INVALID_PACK;
+static struct packed_git *find_pack_entry_last_found;
=20
 static struct cached_object *find_cached_object(const unsigned char *s=
ha1)
 {
@@ -725,7 +723,7 @@ void free_pack_by_name(const char *pack_name)
 			free(p->bad_object_sha1);
 			*pp =3D p->next;
 			if (find_pack_entry_last_found =3D=3D p)
-				find_pack_entry_last_found =3D INVALID_PACK;
+				find_pack_entry_last_found =3D NULL;
 			free(p);
 			return;
 		}
@@ -2024,7 +2022,7 @@ static int find_pack_entry(const unsigned char *s=
ha1, struct pack_entry *e)
 	prepare_packed_git();
 	if (!packed_git)
 		return 0;
-	p =3D find_pack_entry_last_found =3D=3D INVALID_PACK ? packed_git : f=
ind_pack_entry_last_found;
+	p =3D !find_pack_entry_last_found ? packed_git : find_pack_entry_last=
_found;
=20
 	do {
 		if (p->num_bad_objects) {
@@ -2060,12 +2058,8 @@ static int find_pack_entry(const unsigned char *=
sha1, struct pack_entry *e)
 			p =3D packed_git;
 		else
 			p =3D p->next;
-		/*
-		 * p can be NULL from the else clause above, if initial
-		 * f_p_e_last_found value (i.e. INVALID_PACK) is NULL, we may
-		 * advance p again to an imaginary pack in invalid memory
-		 */
-		if (p =3D=3D find_pack_entry_last_found)
+
+		if (p && p =3D=3D find_pack_entry_last_found)
 			p =3D p->next;
 	} while (p);
 	return 0;
