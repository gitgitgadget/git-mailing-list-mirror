From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git log - crash and core dump
Date: Tue, 16 Apr 2013 23:10:06 +0200
Message-ID: <516DBE2E.4060201@lsrfire.ath.cx>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com> <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ivan Lyapunov <dront78@gmail.com>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 23:10:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USD8p-0004bo-Fg
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 23:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965362Ab3DPVKJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Apr 2013 17:10:09 -0400
Received: from india601.server4you.de ([85.25.151.105]:48096 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965253Ab3DPVKI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 17:10:08 -0400
Received: from [192.168.2.105] (p579BE374.dip.t-dialin.net [87.155.227.116])
	by india601.server4you.de (Postfix) with ESMTPSA id 31EB318F;
	Tue, 16 Apr 2013 23:10:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <7v61zml0ow.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221473>

=46irst, lest I forget again: Thank you, Ivan, for the very useful
bug report!

Am 16.04.2013 21:45, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Does this patch help?
>>
>>   pretty.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/pretty.c b/pretty.c
>> index d3a82d2..713eefc 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -405,8 +405,8 @@ void pp_user_info(const struct pretty_print_cont=
ext *pp,
>>   	const char *mailbuf, *namebuf;
>>   	size_t namelen, maillen;
>>   	int max_length =3D 78; /* per rfc2822 */
>> -	unsigned long time;
>> -	int tz;
>> +	unsigned long time =3D 0;
>> +	int tz =3D 0;
>>  =20
>>   	if (pp->fmt =3D=3D CMIT_FMT_ONELINE)
>>   		return;
>> @@ -438,8 +438,10 @@ void pp_user_info(const struct pretty_print_con=
text *pp,
>>   	strbuf_add(&name, namebuf, namelen);
>>  =20
>>   	namelen =3D name.len + mail.len + 3; /* ' ' + '<' + '>' */
>> -	time =3D strtoul(ident.date_begin, &date, 10);
>> -	tz =3D strtol(date, NULL, 10);
>> +	if (ident.date_begin) {
>> +		time =3D strtoul(ident.date_begin, &date, 10);
>> +		tz =3D strtol(date, NULL, 10);
>> +	}
>>  =20
>>   	if (pp->fmt =3D=3D CMIT_FMT_EMAIL) {
>>   		strbuf_addstr(sb, "From: ");
>=20
> Looks like a sensible change.  split_ident_line() decided that the
> given input was mangled and decided there is no valid date (the
> input had <> where the timestamp string was required), so the
> updated code leaves the time/tz unspecified.

We'd need update pretty.c::format_person_part() and
builtin/blame.c::get_ac_line() as well, though.

How about making split_ident_line() a bit friendlier be letting it
provide the epoch as default time stamp instead of NULL?  We shouldn't
do that if we'd like to be able to tell a missing/broken time stamp
apart from a commit that was actually made back in 1970 (e.g. an
imported one).  Or if we'd like to not show a time stamp in git log
output at all in that case.

-- >8 --
Subject: ident: let split_ident_line() provide a default time stamp

If a commit has a broken time stamp, split_ident_line() sets
date_begin, date_end, tz_begin and tz_end to NULL.  Not all callers
are prepared to handle that case and segfault.

Instead of fixing them and having to be careful while implementing
the next caller, provide a string consisting of the number zero as
default value, representing the UNIX epoch.  That's the value that
git log showed before it was converted to use split_ident_line().

Reported-by: Ivan Lyapunov <dront78@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 ident.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/ident.c b/ident.c
index 1c123e6..ee840f4 100644
--- a/ident.c
+++ b/ident.c
@@ -191,6 +191,8 @@ static void strbuf_addstr_without_crud(struct strbu=
f *sb, const char *src)
 	sb->buf[sb->len] =3D '\0';
 }
=20
+static const char zero_string[] =3D "0";
+
 /*
  * Reverse of fmt_ident(); given an ident line, split the fields
  * to allow the caller to parse it.
@@ -254,10 +256,10 @@ int split_ident_line(struct ident_split *split, c=
onst char *line, int len)
 	return 0;
=20
 person_only:
-	split->date_begin =3D NULL;
-	split->date_end =3D NULL;
-	split->tz_begin =3D NULL;
-	split->tz_end =3D NULL;
+	split->date_begin =3D zero_string;
+	split->date_end =3D zero_string + strlen(zero_string);
+	split->tz_begin =3D zero_string;
+	split->tz_end =3D zero_string + strlen(zero_string);
 	return 0;
 }
=20
--=20
1.8.2.1
