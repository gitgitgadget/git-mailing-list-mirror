From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/6] builtin-tag: add sort by date -D
Date: Sun, 22 Feb 2009 10:33:57 -0800
Message-ID: <7vhc2mxqwa.fsf@gitster.siamese.dyndns.org>
References: <e29894ca0902221006j3d602553x15807b41698f51a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:35:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJAs-0004Ke-Os
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbZBVSeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZBVSeG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:34:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44415 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbZBVSeE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:34:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FE539C02D;
	Sun, 22 Feb 2009 13:34:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8EA5A9C02B; Sun,
 22 Feb 2009 13:33:59 -0500 (EST)
In-Reply-To: <e29894ca0902221006j3d602553x15807b41698f51a1@mail.gmail.com>
 (=?utf-8?Q?Marc-Andr=C3=A9?= Lureau's message of "Sun, 22 Feb 2009 20:06:45
 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 60B532AE-010F-11DE-A79C-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111043>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
> ---
>  builtin-tag.c |  162 +++++++++++++++++++++++++++++++++++++++++++++--=
----------
>  1 files changed, 129 insertions(+), 33 deletions(-)
>
> diff --git a/builtin-tag.c b/builtin-tag.c
> index 01e7374..8ff9d03 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -16,7 +16,7 @@
>  static const char * const git_tag_usage[] =3D {
>  	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<=
head>]",
>  	"git tag -d <tagname>...",
> -	"git tag -l [-n[<num>]] [<pattern>]",
> +	"git tag -l [-n[<num>] -D] [<pattern>]",

Please don't use a short-and-sweet "-D" for something whose usefulness =
is
not proven yet.  Especially this risks grief from typo-confusion with t=
he
existing "-d" option that is destructive.

> +		if (object->type !=3D OBJ_TAG) {
> +			struct light_tag *light_tag;
> +			struct object *o;
> +
> +			o =3D xmalloc(sizeof(struct light_tag));
> +			light_tag =3D (struct light_tag*)o;
> +			o->parsed =3D 1;
> +			o->used =3D 0;
> +			o->type =3D OBJ_LIGHT_TAG;
> +			o->flags =3D 0;
> +			light_tag->tagged =3D object;
> +			light_tag->refname =3D xstrdup(refname);
> +			object =3D o;

I really do not like this.  The only place you need a stand-in tag obje=
ct
is inside this "sort tag objects and commits together", and you cannot
even handle lightweight tags that point at blobs or trees sanely with t=
his
code anyway. It is not a good excuse to contaminate the object layer.

I think it might be a lot more sensible to introduce a structure like
this:

	struct tag_entry {
        	struct object *object;
                unsigned long date_for_sorting;
	};

and allocate and queue this structure in your for_each_ref callback
function, instead of the low-level objects.  If object *is* not a tag, =
you
can at that point find a suitable timestamp to stuff in date_for_sortin=
g
(and if it is a tag, you can find a tagger field and parse the date int=
o
date_for_sorting, which implies you do not necessarily need your patch =
2/6
either and we can keep sizeof(struct tag) to the minimum as before).

Then your sort and output functions can sort and iterate over a list of
this structure.

You still need to think about what to do with lightweight tag that poin=
ts
at a blob or a tree, though.
