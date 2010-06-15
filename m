From: bonneta <bonneta@ensimag.fr>
Subject: Re: [PATCH v2 2/3] textconv: support for blame
Date: Tue, 15 Jun 2010 12:32:56 +0200
Message-ID: <192517e06785fed4fa799bee9a11ae28@ensimag.fr>
References: <1275921713-3277-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275924218-20154-1-git-send-email-axel.bonnet@ensimag.imag.fr> <1275924218-20154-2-git-send-email-axel.bonnet@ensimag.imag.fr> <7vfx0p9wlm.fsf@alter.siamese.dyndns.org> <0091febb4a3832a6680a0fbc2209f841@ensimag.fr> <20100615095452.GA32624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 15 12:33:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOTS7-0001jt-P9
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 12:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab0FOKc7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jun 2010 06:32:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:54576 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752198Ab0FOKc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 06:32:59 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5FAOun2031751
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 12:24:56 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5FAWux4020430
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 12:32:56 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o5FAWuLM018002
	for <git@vger.kernel.org>; Tue, 15 Jun 2010 12:32:56 +0200
In-Reply-To: <20100615095452.GA32624@sigill.intra.peff.net>
X-Sender: bonneta@ensimag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 15 Jun 2010 12:24:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5FAOun2031751
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: bonneta@ensimag.fr
MailScanner-NULL-Check: 1277202297.51335@q59X/T51b5WGXAhCujvMqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149169>

On Tue, 15 Jun 2010 05:54:53 -0400, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 15, 2010 at 11:29:57AM +0200, Cl=C3=A9ment Poulain wrote:
>=20
>> > The same issue exists in Cl=C3=A9ment's patch to builtin/cat-file.=
c.
>>=20
>> We did this way because we found a similar cast in prep_temp_blob(),
>> diff.c:
>>=20
>> 	if (convert_to_working_tree(path,
>> 			(const char *)blob, (size_t)size, &buf)) {
>>=20
>> where size is an unsigned long.
>> Is it the same issue ? Or is it different because it's not a pointer
>> cast?
>=20
> Right. The compiler will handle conversion between integer types duri=
ng
> assignment itself, converting representations as necessary (in fact,
> that cast looks useless to me, as implicit conversions are allowed in
> C). The only problem is dereferencing a pointer to X as something oth=
er
> than X.
>=20
>> Otherwise, we thought of reversing the conversion. That is to say,
>> instead
>> of casting "long *" in "size_t *" when calling textconv_object(), is=
 it
>> better to cast size_t in "unsigned long" in textconv_object():
>>=20
>> 	*buf_size =3D (unsigned long) fill_textconv(textconv, df, buf); ?
>=20
> You shouldn't even have to cast there, for the same reason as above.
> That is why I wrote fill_textconv to return the size parameter, rathe=
r
> than writing to a passed-in pointer. It avoids the annoying
> size_t / unsigned long casting caused by different usage (in an ideal
> world, all of our sizes would be the same type, but the strbuf and di=
ff
> code obviously differ).

Thanks for your answer.

We have changed the declaration of textconv_object() to:

static int textconv_object(const char *path,
                           const unsigned char *sha1,
                           char **buf,
                           unsigned long *buf_size)

And now we can do:
*buf_size =3D fill_textconv(textconv, df, buf);
without any cast.

But we have to do:
textconv_object(read_from, null_sha1, &buf.buf, (unsigned long *)
&buf.len))
where buf.len is size_t.

Is that ok?
Our gcc doesn't report any strict-aliasing problem, so we don't know if=
 it
is better than the initial version or not...
