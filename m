From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 3/4] diff --stat: report chmoded binary files like text
 files
Date: Tue, 01 May 2012 21:39:14 +0200
Message-ID: <4FA03BE2.2030107@in.waw.pl>
References: <1335892215-21331-1-git-send-email-zbyszek@in.waw.pl> <1335892215-21331-4-git-send-email-zbyszek@in.waw.pl> <7vvckf92pp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mj@ucw.cz
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:39:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPIv1-0006YP-TO
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 21:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2EATjX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 15:39:23 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:35805 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2EATjX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 15:39:23 -0400
Received: from ip-78-30-103-51.free.aero2.net.pl ([78.30.103.51])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SPIuv-0004dJ-JA; Tue, 01 May 2012 21:39:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <7vvckf92pp.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196731>

On 05/01/2012 08:27 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
>=20
>> Binary files chmoded without content change were reported as if they
>> were rewritten. At the same time, text files in the same situation
>> were reported as "unchanged". Let's treat binary files like text fil=
es
>> here, and simply say that they are unchanged.
>>
>> For text files, we knew that they were unchanged if the numbers of
>> lines added and deleted were both 0. For binary files this metric do=
es
>> not make sense and is not calculated, so a new way of conveying this
>> information is needed. A new flag is_unchanged is added in struct
>> diffstat_t that is set if the contents of both files are identical.
>> For consistency, this new flag is used both for text files and binar=
y
>> files.
>>
>> Output of --shortstat is modified in the same way.
>>
>> Reported-by: Martin Mare=C5=A1 <mj@ucw.cz>
>> Signed-off-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
>> ---
>>  diff.c               |   28 +++++++++++++++++-----------
>>  t/t4006-diff-mode.sh |    8 +-------
>>  2 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/diff.c b/diff.c
>> index 7da16c9..6eb2946 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -1299,6 +1299,7 @@ struct diffstat_t {
>>  		unsigned is_unmerged:1;
>>  		unsigned is_binary:1;
>>  		unsigned is_renamed:1;
>> +		unsigned is_unchanged:1;
>=20
> The name is somewhat misleading, as a filepair that consists of two b=
lobs
> with the same contents with different mode bits is still "changed", a=
nd
> you are trying to say that they have the same contents.
>=20
>> @@ -1471,7 +1472,7 @@ static void show_stats(struct diffstat_t *data=
, struct diff_options *options)
>>  		struct diffstat_file *file =3D data->files[i];
>>  		uintmax_t change =3D file->added + file->deleted;
>>  		if (!data->files[i]->is_renamed &&
>> -			 (change =3D=3D 0)) {
>> +		    data->files[i]->is_unchanged) {
>=20
> I am not sure if all these hunks are needed.  If you are going to sho=
w
> only "  Bin\n" for a filepair with the same binary contents, perhaps =
it is
> simpler to set added/deleted fields of such a filepair to 0?  Then mo=
st of
> the hunks in this patch can disappear, no?
>=20
>> @@ -2379,6 +2383,8 @@ static void builtin_diffstat(const char *name_=
a, const char *name_b,
>>  		return;
>>  	}
>> =20
>> +	data->is_unchanged =3D hashcmp(one->sha1, two->sha1) =3D=3D 0;
>=20
> Please write it as "!hashcmp(a, b)", not "hashcmp(a, b) =3D=3D 0".
>=20
> In any case, how about doing it like this instead?
Yeah, this is much nicer.

On top of this, 4/4 becomes:
-       else {
+       else if (hashcmp(one->sha1, two->sha1)) {
and the time improvement is the same (0.8 vs 2.0 s).

Do you want me to resend with your replacement patch?

Zbyszek
