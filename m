From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] attr: more matching optimizations from .gitignore
Date: Wed, 10 Oct 2012 13:03:36 -0700
Message-ID: <7vpq4qaycn.fsf@alter.siamese.dyndns.org>
References: <7vd30si665.fsf@alter.siamese.dyndns.org>
 <1349864466-28289-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:03:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM2VT-000314-AT
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 22:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176Ab2JJUDl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 16:03:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756211Ab2JJUDk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 16:03:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 775338E24;
	Wed, 10 Oct 2012 16:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=OUZF4eu7zQdw
	pcZ2Av85dcfcvD8=; b=uRH0et3XKxTTfeUdoBdjTTgZFJF4bTwwp5OAmOA3H186
	khKSg1tGSEVHF4QFhSShA9QkniHTwD5xSRNWL6T7TMYqMqehILteWmHmDJu46QmO
	R3hanhbN9ZerQkAccwqLYS4IDMCJB9y+wA0gMyuWbqiu5URnK1b6toNRkO0aMTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UCKcGT
	zLwHq6IIxNMzM09lS7RN2yriXIxcmhC32S67+pDllimQYEFC70TBGrejJTG6OPMz
	zWYDFjv6aO2aB2rDQFsWamGf6zociceYre0/Uzm6kOrSRSRX4NVQDUO+mWRbRJWX
	S5wiGiPPjPUzZIMeBt+vW9ETug7zn7KVRTOWQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663C48E22;
	Wed, 10 Oct 2012 16:03:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8B748E1F; Wed, 10 Oct 2012
 16:03:38 -0400 (EDT)
In-Reply-To: <1349864466-28289-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 10 Oct
 2012 17:21:06 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94D85CC0-1315-11E2-82C5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207435>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> .gitattributes and .gitignore share the same pattern syntax but has
> separate matching implementation. Over the years, ignore's
> implementation accumulates more optimizations while attr's stays the
> same.
>
> This patch adds those optimizations to attr. Basically it tries to
> avoid fnmatch as much as possible in favor of strncmp.
>
> A few notes from this work is put in the documentation:
>
> * "!pattern" syntax is not supported in .gitattributes as it's not

s/not supported/forbidden/;

A reader can take "not supported" as "silently ignored", which is
not the case.  An explicit "forbidden" does not have such a
misinterpretation.

It would save time from both of us if you can check what is queued
on 'pu'.  I do not think I touched the code for off-by-one bugs
there, though.

>   clear what it means (e.g. "!path attr" is about unsetting attr, or
>   undefining it..)
>
> * patterns applying to directories
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  How about this? Diff from the previous version:
>
>    diff --git a/Documentation/gitattributes.txt b/Documentation/gitat=
tributes.txt
>    index cc2ff1d..9a0ed19 100644
>    --- a/Documentation/gitattributes.txt
>    +++ b/Documentation/gitattributes.txt
>    @@ -23,7 +23,7 @@ Each line in `gitattributes` file is of form:
>     That is, a pattern followed by an attributes list,
>     separated by whitespaces.  When the pattern matches the
>     path in question, the attributes listed on the line are given to
>    -the path. Only files can be attached attributes to.
>    +the path.
>    =20
>     Each attribute can be in one of these states for a given path:
>    =20
>    @@ -58,6 +58,13 @@ attribute.  The rules how the pattern matches p=
aths are the
>     same as in `.gitignore` files; see linkgit:gitignore[5].
>     Unlike `.gitignore`, negative patterns are not supported.
>    =20
>    +Note that if a .gitignore rule matches a directory, the directory
>    +is ignored, which may be seen as assigning "ignore" attribute the
>    +directory and all files and directories inside. However, if a
>    +.gitattributes rule matches a directory, it manipulates
>    +attributes on that directory only, not files and directories
>    +inside.

Why do you even need to mention .gitignore in gitattributes manual
where it is irrelevant from the reader's point of view?

Besides, the interpretation the "may be seen as" suggests is
actively wrong.  It is assigning "ignore-this-and-below" attribute
to the directory, and there is no inconsistency between the two.

Again, I'd suggest dropping this addition.

>    diff --git a/attr.c b/attr.c
>    index 7e85f82..4faf1ff 100644
>    --- a/attr.c
>    +++ b/attr.c
>    @@ -250,7 +250,6 @@ static struct match_attr *parse_attr_line(cons=
t char *line, const char *src,
>     	else {
>     		char *p =3D (char *)&(res->state[num_attr]);
>     		memcpy(p, name, namelen);
>    -		p[namelen] =3D 0;
>     		res->u.pat.pattern =3D p;
>     		parse_exclude_pattern(&res->u.pat.pattern,
>     				      &res->u.pat.patternlen,
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
>     		return 0;
>    =20
>     	namelen =3D baselen ? pathlen - baselen - 1 : pathlen;
>     	name =3D pathname + pathlen - namelen;
>    =20
>    -	/* if the non-wildcard part is longer than the remaining
>    -	   pathname, surely it cannot match */
>    +	/*
>    +	 * if the non-wildcard part is longer than the remaining
>    +	 * pathname, surely it cannot match
>    +	 */
>     	if (!namelen || prefix > namelen)
>     		return 0;
