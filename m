From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] fix crash in path.c on Windows
Date: Thu, 05 Feb 2009 17:48:34 +0100
Message-ID: <498B1862.5070703@lsrfire.ath.cx>
References: <498A1E1E.8010901@lsrfire.ath.cx> <498A9C01.6020602@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 05 17:50:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LV7QW-0003Hh-R1
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 17:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755354AbZBEQsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Feb 2009 11:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbZBEQsm
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 11:48:42 -0500
Received: from india601.server4you.de ([85.25.151.105]:51595 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbZBEQsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 11:48:41 -0500
Received: from [10.0.1.101] (p57B7D5B1.dip.t-dialin.net [87.183.213.177])
	by india601.server4you.de (Postfix) with ESMTPSA id 2F2102F8056;
	Thu,  5 Feb 2009 17:48:39 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <498A9C01.6020602@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108582>

Johannes Sixt schrieb:
> Ren=E9 Scharfe schrieb:
>> 	set a=3D	getenv("a")
>> 	=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> 	c	c
>> 	/c	c:/
>> 	c/	c/
>> 	/c/	c:/
>> 	c:c	c:c
>> 	/c:c	c:c
>> 	c:/c	c:/c
>> 	/c:/c	c:/c
>> 	c/:/c	c\;c:\
>> 	/c:c/	c:c/
>> 	/c/:c	/c/:c
>> 	/c/:/c	c:\;c:\
>> 	/c:/c/	c:/c/
>> 	/c/:/c/	c:\;c:\
>=20
> Bash translates leading single-letter path components to drive prefix
> notation if it invokes a non-MSYS program; and it also translates ':'=
 to
> ';' if the value looks like a path list. Sometimes there is an ambigu=
ity
> and bash guesses wrong.

Sure, but what rules or heuristics does it follow?  Do we need to
post-process the results or can we simply change the test case in t1504=
?

>> @@ -387,7 +387,7 @@ int normalize_absolute_path(char *buf, const cha=
r *path)
>>  	assert(path);
>> =20
>>  	while (*comp_start) {
>> -		assert(*comp_start =3D=3D '/');
>> +		assert(is_absolute_path(comp_start));
>>  		while (*++comp_end && *comp_end !=3D '/')
>>  			; /* nothing */
>>  		comp_len =3D comp_end - comp_start;
>=20
> Junio has pointed out your thinko here. Furthermore, *all* uses of '/=
' in
> this loop must be replaced by is_dir_sep().

It's not a thinko because I didn't think there. :)  It's more a case of
mechanical refactoring resulting in confusing code.  If we inline
is_absolute_path() manually there, we get the following:

	assert(*comp_start =3D=3D '/' || has_dos_drive_prefix(comp_start));

The loop works because DOS drive prefixes never contain slashes.

Is is_absolute_path() too forgiving on Windows, i.e. should it stop
classifying paths starting with a slash as absolute on that platform?

> But I would really appreciate if you could unify normalize_absolute_p=
ath()
> with setup.c's sanitary_path_copy() because they do almost the same t=
hing
> (and the latter already works on Windows).

Good idea.

>> @@ -438,11 +438,20 @@ int longest_ancestor_length(const char *path, =
const char *prefix_list)
>>  		return -1;
>> =20
>>  	for (colon =3D ceil =3D prefix_list; *colon; ceil =3D colon+1) {
>> -		for (colon =3D ceil; *colon && *colon !=3D ':'; colon++);
>> +		for (colon =3D ceil; *colon && *colon !=3D PATH_SEP; colon++);
>>  		len =3D colon - ceil;
>>  		if (len =3D=3D 0 || len > PATH_MAX || !is_absolute_path(ceil))
>>  			continue;
>>  		strlcpy(buf, ceil, len+1);
>> +
>> +		if (has_dos_drive_prefix(buf)) {
>> +			char *p;
>> +			for (p =3D buf; *p; p++) {
>> +				if (*p =3D=3D '\\')
>> +					*p =3D '/';
>> +			}
>=20
> IMNSHO this is a kind of normalization and, therefore, must be done b=
y
> normalize_absolute_path() (sanitary_path_copy() already does this).

Makes sense.

Ren=E9
