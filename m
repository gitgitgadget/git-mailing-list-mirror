From: =?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@atlas-elektronik.com>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 15:06:21 +0100
Message-ID: <51013FDD.5030004@atlas-elektronik.com>
References: <20130123143816.GA579@krypton.darkbyte.org> <20130123200222.GB19832@sigill.intra.peff.net> <510124F5.9090505@atlas-elektronik.com> <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 15:06:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyNS6-0007cg-NS
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 15:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511Ab3AXOGa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2013 09:06:30 -0500
Received: from mail96.atlas.de ([194.156.172.86]:10634 "EHLO mail96.atlas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753008Ab3AXOG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 09:06:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail96.atlas.de (Postfix) with ESMTP id AA74A1012E;
	Thu, 24 Jan 2013 15:06:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail96.atlas.de
Received: from mail96.atlas.de ([127.0.0.1])
	by localhost (mail96.atlas.de [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id DuzX9zBS62Rp; Thu, 24 Jan 2013 15:06:25 +0100 (CET)
Received: from mgsrv01.atlas.de (mail01.atlas.mailrelays.atlas.de [10.200.101.16])
	by mail96.atlas.de (Postfix) with ESMTP;
	Thu, 24 Jan 2013 15:06:24 +0100 (CET)
Received: from [10.200.54.97] (as112671.atlas.de [10.200.54.97])
	by mgsrv01.atlas.de (Postfix) with ESMTP id CE8BA27169;
	Thu, 24 Jan 2013 15:06:21 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214430>

Am Donnerstag, 24. Januar 2013 14:40:47 schrieb Duy Nguyen:
> On Thu, Jan 24, 2013 at 7:11 PM, Stefan N=C3=A4we
> <stefan.naewe@atlas-elektronik.com> wrote:
>>> Does it fail with older versions of git? If so, can you bisect?
>>
>> I did. My bisection told me this is the suspect:
>>
>> ccdc603 (parse_object: try internal cache before reading object db)
>
> diff --git a/object.c b/object.c
> index d8d09f9..6b06297 100644
> --- a/object.c
> +++ b/object.c
> @@ -191,10 +191,15 @@ struct object *parse_object(const unsigned char=
 *sha1)
>         enum object_type type;
>         int eaten;
>         const unsigned char *repl =3D lookup_replace_object(sha1);
> -       void *buffer =3D read_sha1_file(sha1, &type, &size);
> +       void *buffer;
> +       struct object *obj;
> +
> +       obj =3D lookup_object(sha1);
> +       if (obj && obj->parsed)
> +               return obj;
>
> Any chance obj->parsed is 1 but ((struct commit*)obj)->buffer is NULL=
?
> What if you change that "if" to
>
> if (obj && obj->parsed && (obj->type !=3D OBJ_COMMIT || ((struct comm=
it
> *)obj)->buffer))
>

No more segfault!

> Also you did not encode commits in any specific encoding,

We're using Git for Windows and some commits contain 'umlauts' (=C3=A4=C3=
=B6=C3=BC).
But those characters should be encoded in UTF-8, shouldn't they?
But the 'git log...' only crashes on a Debian/Linux machine.

> nor set i18n.logOutputEncoding?

It's not set.

(only i18n.filesEncoding is set to utf-8 on my machine)

Oh, and it's not crashing if I do:

git log -p --submodule |cat

Stefan
--
----------------------------------------------------------------
/dev/random says: Dumb luck beats sound planning every time. Trust me.
python -c "print=20
'73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.de=
code('hex')"
