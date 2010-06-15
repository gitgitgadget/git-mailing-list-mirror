From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 11:29:57 +0200
Organization: Ensimag
Message-ID: <0091febb4a3832a6680a0fbc2209f841@ensimag.fr>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr> <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 11:30:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOSTT-0006Fo-Mr
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 11:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab0FOJaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 05:30:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:58570 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751915Ab0FOJaV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 05:30:21 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5F9LvuW011873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jun 2010 11:21:59 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5F9TvtE019933;
	Tue, 15 Jun 2010 11:29:57 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o5F9Tvxd000338;
	Tue, 15 Jun 2010 11:29:57 +0200
In-Reply-To: <7vfx0p9wlm.fsf@alter.siamese.dyndns.org>
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 11:21:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5F9LvuW011873
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
MailScanner-NULL-Check: 1277198520.4862@rgis8wUmzcAc4rF69Tl1Cw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149167>

On Mon, 14 Jun 2010 13:40:21 -0700, Junio C Hamano <gitster@pobox.com>
wrote:
> Axel Bonnet <axel.bonnet@ensimag.imag.fr> writes:
>=20
>> @@ -86,16 +87,49 @@ struct origin {
>> ...
>> +static void fill_origin_blob(struct diff_options *opt,
>> +			     struct origin *o, mmfile_t *file)
>>  {
>>  	if (!o->file.ptr) {
>>  		enum object_type type;
>>  		num_read_blob++;
>> -		file->ptr =3D read_sha1_file(o->blob_sha1, &type,
>> -					   (unsigned long *)(&(file->size)));
>> +
>> +		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
>> +		    textconv_object(o->path, o->blob_sha1, &file->ptr,
>> +				    (size_t *) &file->size))
>=20
> This cast is not correct, as there is no guarantee that your size_t a=
nd
> typeof(mmfile_t.size) are compatible.  Depending on the gcc version, =
you
> would get "dereferencing type-punned pointer will break strict-aliasi=
ng
> rules" error.
>=20
> The same issue exists in Cl=C3=A9ment's patch to builtin/cat-file.c.

We did this way because we found a similar cast in prep_temp_blob(),
diff.c:

	if (convert_to_working_tree(path,
			(const char *)blob, (size_t)size, &buf)) {

where size is an unsigned long.
Is it the same issue ? Or is it different because it's not a pointer ca=
st?

Otherwise, we thought of reversing the conversion. That is to say, inst=
ead
of casting "long *" in "size_t *" when calling textconv_object(), is it
better to cast size_t in "unsigned long" in textconv_object():

	*buf_size =3D (unsigned long) fill_textconv(textconv, df, buf); ?
