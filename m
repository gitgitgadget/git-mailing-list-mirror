From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Wed, 10 Oct 2012 14:41:38 -0700
Message-ID: <7v626iatt9.fsf@alter.siamese.dyndns.org>
References: <7vd30si665.fsf@alter.siamese.dyndns.org>
 <1349864466-28289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 23:41:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM42M-0006vl-4F
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 23:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940Ab2JJVln convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 17:41:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788Ab2JJVlm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 17:41:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1728B49;
	Wed, 10 Oct 2012 17:41:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QHbmMuh49qNS
	0ICF1C9M9yAye8g=; b=nqUOOx6zs4GLP1hP9/KEGlFtUTXiko2rKJHerZnb34OI
	cV3sNVSDOzdpNBD/R5AmL1vGa1Vu41Sfn3of2g/oI8tmiyNAgy74oxjs6brMMgiM
	/7L3y5KxigvLsrBYjaSra4c877mJWFB1OuBgyfvnTY+W7MHnojil+kyQpwcA29c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B6fUuI
	jVaGqmpuuo2dRE2cGbDgAr8Jfh+RlD+JX9sF9sFb6+MC5ux/Ybt8SkufkOGkUE06
	GbdZtyuC2ubKJwpc3ojmo/Dagb4kQ2rPNNjfajtp2wa8qQ8FuNHL8eVnDeKbLoqv
	1iHXpPcBlMDRi+felUuubqPzbYwvKbqW7yeeE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 797D78B48;
	Wed, 10 Oct 2012 17:41:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B89F18B47; Wed, 10 Oct 2012
 17:41:40 -0400 (EDT)
In-Reply-To: <1349864466-28289-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 10 Oct
 2012 17:21:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46D45200-1323-11E2-BB56-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207444>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>    @@ -690,16 +689,18 @@ static int path_matches(const char *pathname=
, int pathlen,
>     	 * contain the trailing slash
>     	 */
>    =20
>    -	if (pathlen < baselen ||
>    +	if (pathlen < baselen + 1 ||
>     	    (baselen && pathname[baselen] !=3D '/') ||
>    -	    strncmp(pathname, base, baselen))
>    +	    strncmp_icase(pathname, base, baselen))

Shouldn't the last comparison be

	strncmp_icase(pathname, base, baselen + 1)

instead, if you are trying to match this part from dir.c where
baselen does count the trailing slash?

		if (pathlen < x->baselen ||
		    (x->baselen && pathname[x->baselen-1] !=3D '/') ||
		    strncmp_icase(pathname, x->base, x->baselen))
			continue;

In other words, relative to what was queued to 'pu', something like
this instead....

-- >8 --
Subject: [PATCH] fixup: matching path_matches() in attr.c to that of di=
r.c

In this function, baselen does not count the trailing slash that
should come after the directory name held in "basename" variable, so
whenever the corresponding code in dir.c:excluded_from_list() refers
to x->baselen, we would need to use "baselen+1" consistently.

Also remove unnecessary NUL-termination of a buffer obtained from
calloc().

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 7e85f82..a9c04a8 100644
--- a/attr.c
+++ b/attr.c
@@ -250,7 +250,6 @@ static struct match_attr *parse_attr_line(const cha=
r *line, const char *src,
 	else {
 		char *p =3D (char *)&(res->state[num_attr]);
 		memcpy(p, name, namelen);
-		p[namelen] =3D 0;
 		res->u.pat.pattern =3D p;
 		parse_exclude_pattern(&res->u.pat.pattern,
 				      &res->u.pat.patternlen,
@@ -687,19 +686,21 @@ static int path_matches(const char *pathname, int=
 pathlen,
=20
 	/*
 	 * note: unlike excluded_from_list, baselen here does not
-	 * contain the trailing slash
+	 * count the trailing slash.
 	 */
=20
-	if (pathlen < baselen ||
+	if (pathlen < baselen + 1 ||
 	    (baselen && pathname[baselen] !=3D '/') ||
-	    strncmp(pathname, base, baselen))
+	    strncmp_icase(pathname, base, baselen + 1))
 		return 0;
=20
 	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
 	name =3D pathname + pathlen - namelen;
=20
-	/* if the non-wildcard part is longer than the remaining
-	   pathname, surely it cannot match */
+	/*
+	 * if the non-wildcard part is longer than the remaining
+	 * pathname, surely it cannot match.
+	 */
 	if (!namelen || prefix > namelen)
 		return 0;
=20
--=20
1.8.0.rc1.76.g5a375e6
