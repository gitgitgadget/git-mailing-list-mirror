From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the 
	replaced one
Date: Thu, 5 Aug 2010 08:07:45 +1000
Message-ID: <AANLkTimVnAO6kCAo8N6DM9GX3z+DjKJgKizdTnktyb8Q@mail.gmail.com>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com>
	<201008041358.13081.chriscool@tuxfamily.org>
	<AANLkTimPQcZN-ASP+N+h9GaOSkgbnyNxiSktL+z-nBRu@mail.gmail.com>
	<201008041457.31975.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368339a2e11137048d06a968
Cc: git <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Aug 05 00:07:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogm7t-0001MX-MH
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 00:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756588Ab0HDWHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 18:07:49 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48719 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0HDWHr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 18:07:47 -0400
Received: by wyb39 with SMTP id 39so6004627wyb.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=cyIaZP6uf7ZOxdX5fUlfyJy6gRaQAWf5r7uA4bwLJJ0=;
        b=jWd1pWjgOT6WrbNJ+Y7VSZXJlr736mLipRoGvIUGP5wQseZpRIp4Md4zKsU7/z981k
         p489Zq2Zsk+jcW/hmuGkGfiJDzM+5PXhkdjuE4unTVH95xM4x2qgLKq76DkxRIL46aBJ
         MVkFM5Y7sJVh5K9qgj+7/dCUBM3ofuFebWTeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YINkTxnzUlQeXGnODAniOdv43VlOjgaafhcuyXAc9ondbmaem4LlLVvItqH7lvr7uv
         whCQreGZ3uIjJ3hWjiBBSpEjTUizZdfXHyVbvyKqUNoLCTzOTwSrDrziu0QmzZgp/FP6
         s7t6Yl/VADTHZzaasbLpFYVZ2/q+RZF40suec=
Received: by 10.227.128.18 with SMTP id i18mr8326450wbs.135.1280959666261; 
	Wed, 04 Aug 2010 15:07:46 -0700 (PDT)
Received: by 10.216.173.199 with HTTP; Wed, 4 Aug 2010 15:07:45 -0700 (PDT)
In-Reply-To: <201008041457.31975.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152605>

--0016368339a2e11137048d06a968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 4, 2010 at 10:57 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> On Wednesday 04 August 2010 14:42:50 Nguyen Thai Ngoc Duy wrote:
>> On Wed, Aug 4, 2010 at 9:58 PM, Christian Couder
>>
>> <chriscool@tuxfamily.org> wrote:
>> >> > I will
>> >> > try to have a deeper look at that, but it would help if you could g=
ive
>> >> > an example of a command that triggers this behavior.
>> >>
>> >> The following patch add "sha1" command. These commands give different
>> >> sha1:
>> >>
>> >> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` A
>> >> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B
>> >
>> > Yes, but that does not mean that the content of the object returned by
>> > lookup_commit(A) is not the content of A.
>> >
>> > Or do you have an example where the content of the object returned by
>> > lookup_commit(A) is not the content of A?
>>
>> Both return the content of B. I modified my patch a bit to also show
>> the content, ((struct commit*)obj)->buffer.
>
> I also modified your patch but I don't get any content shown when using
> lookup_commit()
>
> I use:
>
> diff --git a/builtin/sha1.c b/builtin/sha1.c
> new file mode 100644
> index 0000000..8e081b2
> --- /dev/null
> +++ b/builtin/sha1.c
> @@ -0,0 +1,27 @@
> +#include "cache.h"
> +#include "commit.h"
> +
> +int cmd_sha1(int argc, char **argv)
> +{
> + =C2=A0 =C2=A0 =C2=A0 unsigned char old[20];
> + =C2=A0 =C2=A0 =C2=A0 unsigned char new[20];
> + =C2=A0 =C2=A0 =C2=A0 struct object *obj;
> +
> + =C2=A0 =C2=A0 =C2=A0 get_sha1_hex(argv[1], old);
> + =C2=A0 =C2=A0 =C2=A0 get_sha1_hex(argv[2], new);
> + =C2=A0 =C2=A0 =C2=A0 printf("old =C2=A0=3D %s\nnew =C2=A0=3D %s\n", arg=
v[1], argv[2]);
> + =C2=A0 =C2=A0 =C2=A0 replace_pair(old, new);
> + =C2=A0 =C2=A0 =C2=A0 if (argv[3][0] =3D=3D 'A')
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0obj =3D parse_object(ol=
d);
> + =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit *com =3D =
lookup_commit(old);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (com->buffer)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0printf("commit buffer:\n%s", com->buffer);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0printf("no commit buffer\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0obj =3D (struct object =
*)com;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 printf("sha1 =3D %s\n", sha1_to_hex(obj->sha1));
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
>
> and I get:
>
> $ git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B
> old =C2=A0=3D 5b4585a035e2ba61573273dacc6d17d7e8fcbc7d
> new =C2=A0=3D c9b402bd93105f80f3c5d67ecfccc8ba36810613
> no commit buffer
> sha1 =3D 5b4585a035e2ba61573273dacc6d17d7e8fcbc7d
>
> Could you show what code you use?

You need parse_commit() (unless somebody already did that before
lookup_commit()).
--=20
Duy

--0016368339a2e11137048d06a968
Content-Type: application/octet-stream; name="sha1.c"
Content-Disposition: attachment; filename="sha1.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcgq86vp0

I2luY2x1ZGUgImNhY2hlLmgiCiNpbmNsdWRlICJjb21taXQuaCIKCmludCBjbWRfc2hhMShpbnQg
YXJnYywgY2hhciAqKmFyZ3YpCnsKCXVuc2lnbmVkIGNoYXIgb2xkWzIwXTsKCXVuc2lnbmVkIGNo
YXIgbmV3WzIwXTsKCXN0cnVjdCBvYmplY3QgKm9iajsKCglnZXRfc2hhMV9oZXgoYXJndlsxXSwg
b2xkKTsKCWdldF9zaGExX2hleChhcmd2WzJdLCBuZXcpOwoJcHJpbnRmKCJvbGQgID0gJXNcbm5l
dyAgPSAlc1xuIiwgYXJndlsxXSwgYXJndlsyXSk7CglyZXBsYWNlX3BhaXIob2xkLCBuZXcpOwoJ
aWYgKGFyZ3ZbM11bMF0gPT0gJ0EnKQoJCW9iaiA9IHBhcnNlX29iamVjdChvbGQpOwoJZWxzZQoJ
CW9iaiA9IGxvb2t1cF9jb21taXQob2xkKTsKCglwYXJzZV9jb21taXQoKHN0cnVjdCBjb21taXQg
KilvYmopOwoJcHJpbnRmKCJzaGExID0gJXNcbiIsIHNoYTFfdG9faGV4KG9iai0+c2hhMSkpOwoJ
cHJpbnRmKCIlc1xuIiwgKChzdHJ1Y3QgY29tbWl0KilvYmopLT5idWZmZXIpOwoJcmV0dXJuIDA7
Cn0K
--0016368339a2e11137048d06a968--
