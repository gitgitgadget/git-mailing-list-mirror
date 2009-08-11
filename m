From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v2 2/4] gitignore: read from index if .gitignore is 
	assume-unchanged
Date: Tue, 11 Aug 2009 08:57:30 +0700
Message-ID: <fcaeb9bf0908101857x7a44d3dfge20e45d24daee9bf@mail.gmail.com>
References: <1249917562-5931-1-git-send-email-pclouds@gmail.com> 
	<1249917562-5931-2-git-send-email-pclouds@gmail.com> <1249917562-5931-3-git-send-email-pclouds@gmail.com> 
	<alpine.DEB.1.00.0908101826250.8324@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 11 03:58:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Magcq-0007Mu-47
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 03:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbZHKB5u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 21:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbZHKB5u
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 21:57:50 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:42975 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbZHKB5u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 21:57:50 -0400
Received: by yxe5 with SMTP id 5so4354411yxe.33
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 18:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HxCNq/Fp6swYgkyLjlUsJ9msYLV7hIu9IS06lAIePac=;
        b=UVjPGg530oPUv2hDhZSiEfgX0EalhMHeK3WnGgYbFhpVG4eVM6TVL6AQgreWqR1FXM
         18YPlhYy45Cj7gkdGWTQiCZ5zVvzDXftl3ObFh7pq/g0Yg2uWXwEL2iGhfDoXNm5r611
         aCRjANIKmanzJjhrMK2yu+/Ui8mvewQejy/KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nsq1rBRhSMzQdVwLMcsWYhdVcwqkQ51Pvxl2Bol4rAE3j/tWS+3vd8hFU1i0W1YS1D
         lNFn4XiVl0PO/km6jhVjue4Ott9J8AVgyV72/Rxiw1t8jE5prMicOMCXI35fmSS3ZUFK
         rdVn7XqOqLmuTuRjGKeXtIJ5887pwkWINM85o=
Received: by 10.100.177.14 with SMTP id z14mr4461129ane.185.1249955870121; 
	Mon, 10 Aug 2009 18:57:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908101826250.8324@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125511>

2009/8/10 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 10 Aug 2009, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> diff --git a/dir.c b/dir.c
>> index e05b850..e55344f 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -200,11 +200,36 @@ void add_exclude(const char *string, const cha=
r *base,
>> =C2=A0 =C2=A0 =C2=A0 which->excludes[which->nr++] =3D x;
>> =C2=A0}
>>
>> +static void *read_index_data(const char *path, size_t *size)
>
> How about calling it "read_assume_unchanged_from_index()" instead? =C2=
=A0I
> suggest this because it does not read the index from the data if the =
path
> is not marked assume unchanged...

Agree.

>> @@ -212,27 +237,31 @@ static int add_excludes_from_file_1(const char=
 *fname,
>>
>> [...]
>>
>> =C2=A0 =C2=A0 =C2=A0 if (buf_p)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *buf_p =3D buf;
>> - =C2=A0 =C2=A0 buf[size++] =3D '\n';
>> =C2=A0 =C2=A0 =C2=A0 entry =3D buf;
>> - =C2=A0 =C2=A0 for (i =3D 0; i < size; i++) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf[i] =3D=3D '\n') =
{
>> + =C2=A0 =C2=A0 for (i =3D 0; i <=3D size; i++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i =3D=3D size || buf=
[i] =3D=3D '\n') {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (entry !=3D buf + i && entry[0] !=3D '#') {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[i - (i && buf[i-1] =3D=3D '\r')=
] =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_exclude(entry, base, baselen, w=
hich);
>
> Should this change not rather be a separate one?

You meant a separate patch? It is tied to this patch, because if bus
is read from read_index_data, it does not have extra space for '\n' at
the end.

>> @@ -241,17 +270,12 @@ static int add_excludes_from_file_1(const char=
 *fname,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> -
>> - err:
>> - =C2=A0 =C2=A0 if (0 <=3D fd)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);
>> - =C2=A0 =C2=A0 return -1;
>> =C2=A0}
>>
>> =C2=A0void add_excludes_from_file(struct dir_struct *dir, const char=
 *fname)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 if (add_excludes_from_file_1(fname, "", 0, NULL=
,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dir->exclude_list[=
EXC_FILE]) < 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&dir->exclude_list[=
EXC_FILE], 0) < 0)
>
> Could you mention in the commit message why this function does not wa=
nt to
> check the index (I _guess_ it is because this code path only tries to=
 read
> .git/info/exclude, but it would be better to be sure).

To retain old behaviour. But I have to check its callers. Maybe we
want to check the index too.

>> @@ -85,6 +85,26 @@ test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 >output &&
>> =C2=A0 =C2=A0 =C2=A0 test_cmp expect output'
>>
>> +test_expect_success 'setup sparse gitignore' '
>> + =C2=A0 =C2=A0 git add .gitignore one/.gitignore one/two/.gitignore=
 &&
>> + =C2=A0 =C2=A0 git update-index --assume-unchanged .gitignore one/.=
gitignore one/two/.gitignore &&
>> + =C2=A0 =C2=A0 rm .gitignore one/.gitignore one/two/.gitignore
>> +'
>
> You're probably less sloppy than me; I'd have defined a variable like
> this:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0ignores=3D".gitignore one/.gitignore one/t=
wo/.gitignore"
>
> and used it for the three calls, just to make sure that I do not fsck
> anything up there due to fat fingers.

I have slim ones :-) But "git add $ignores && git update-index
$ignores && rm $ignores" is easier to read.
--=20
Duy
