From: Junio C Hamano <gitster@pobox.com>
Subject: Re:* [Resend PATCH] Fix segmentation fault when user doesn't have access permission to the repository.
Date: Fri, 30 Nov 2007 13:22:41 -0800
Message-ID: <7v3aunqvha.fsf_-_@gitster.siamese.dyndns.org>
References: <b8bf37780711211659i4d621533o6a3b97349bb75f8c@mail.gmail.com>
	<20071122160959.GA3411@steel.home>
	<b8bf37780711221427q5dda709dt38ce1837c0e56c1f@mail.gmail.com>
	<b8bf37780711251339y796286fbj2cd8d9225008e13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 22:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyDKJ-0004li-QJ
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 22:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXK3VWv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 16:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752181AbXK3VWv
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 16:22:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58486 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbXK3VWu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 16:22:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C43DB2EF;
	Fri, 30 Nov 2007 16:23:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1284A9B43F;
	Fri, 30 Nov 2007 16:23:05 -0500 (EST)
In-Reply-To: <b8bf37780711251339y796286fbj2cd8d9225008e13@mail.gmail.com>
	(=?utf-8?Q?Andr=C3=A9?= Goddard Rosa's message of "Sun, 25 Nov 2007
 19:39:10 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66662>

"Andr=C3=A9 Goddard Rosa" <andre.goddard@gmail.com> writes:

> On Nov 22, 2007 2:09 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> ...
> I tested it here before posting but luckly (or not, as I didn't catch
> this when compiling) it worked,
> as a pointer have the sizeof(int) in my x86 platform. >:|

Most of the changes look trivially correct.  Thanks.

> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index be9e3ea..84c8ed4 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -263,8 +263,13 @@ static void store_updated_refs(const char *url,
> struct ref *ref_map)
>         char note[1024];
>         const char *what, *kind;
>         struct ref *rm;
> +       char *filename =3D git_path("FETCH_HEAD");
>
> -       fp =3D fopen(git_path("FETCH_HEAD"), "a");
> +       fp =3D fopen(filename, "a");
> +       if (!fp) {
> +               error("cannot open %s: %s\n", filename, strerror(errn=
o));
> +               return 1;
> +       }
>         for (rm =3D ref_map; rm; rm =3D rm->next) {
>                 struct ref *ref =3D NULL;

I started to wonder if there was a particular reason you chose to retur=
n
1, not -1 (or just say 'return error("cannot open...", ...)')?

> @@ -404,7 +410,7 @@ static int fetch_refs(struct transport *transport=
,
> struct ref *ref_map)
>         if (ret)
>                 ret =3D transport_fetch_refs(transport, ref_map);
>         if (!ret)
> -               store_updated_refs(transport->url, ref_map);
> +               ret |=3D store_updated_refs(transport->url, ref_map);
>         transport_unlock_pack(transport);
>         return ret;
>  }

I think the callers of fetch_refs() are interested in seeing only 0 or
non-zero, so it seems more consistent to signal error with negative
return.  I modified the hunk that starts at line 263 to return the
return value from error() and applied.

That made me follow the transport code, fetch_refs_via_pack().  This is
not your code, so Shawn and Daniel are CC'ed.

The code calls fetch_pack() to get the list of refs it fetched, and
discards refs and always returns 0 to signal success.

But builtin-fetch-pack.c::fetch_pack() has error cases.  The function
returns NULL if error is detected (shallow-support side seems to choose
to die but I suspect that is easily fixable to error out as well).

Shouldn't fetch_refs_via_pack() propagate that error to the caller?

---
 transport.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 50db980..048df1f 100644
--- a/transport.c
+++ b/transport.c
@@ -655,7 +655,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	free(heads);
 	free_refs(refs);
 	free(dest);
-	return 0;
+	return (refs ? 0 : -1);
 }
=20
 static int git_transport_push(struct transport *transport, int refspec=
_nr, const char **refspec, int flags)
