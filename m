From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Weird problem with long $PATH and alternates (bisected)
Date: Sun, 26 Oct 2008 11:07:18 -0700
Message-ID: <7v63nf5iy1.fsf@gitster.siamese.dyndns.org>
References: <237967ef0810260746w10e930c1sf36a2674f49afbe1@mail.gmail.com>
 <7vljwb5o4p.fsf@gitster.siamese.dyndns.org> <4904AE8D.9090706@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mikael Magnusson <mikachu@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Oct 26 19:08:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuA2d-00074l-B7
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 19:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678AbYJZSHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbYJZSHa
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 14:07:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41843 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYJZSH3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Oct 2008 14:07:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 944EC90182;
	Sun, 26 Oct 2008 14:07:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0F6B590181; Sun, 26 Oct 2008 14:07:22 -0400 (EDT)
In-Reply-To: <4904AE8D.9090706@lsrfire.ath.cx> (=?utf-8?Q?Ren=C3=A9?=
 Scharfe's message of "Sun, 26 Oct 2008 18:53:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F36E7CC0-A388-11DD-BA76-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99176>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Junio C Hamano schrieb:
>> "Mikael Magnusson" <mikachu@gmail.com> writes:
>>=20
>>> % mkdir 1; cd 1
>>> % echo > a; git add a; git commit -m a
>>> % cd ..
>>> % git clone -s 1 2
>>> % git push . master:master
>>> fatal: Could not switch to
>>> '/tmp/a/1/.git/objects/n:/usr/games/bin:/usr/local/ipod-chain'
>>> fatal: The remote end hung up unexpectedly
>>=20
>> I think I see a bug in foreach_alt_odb() to add_refs_from_alternate(=
)
>> callchain, but I cannot explain why the contents of $PATH leaks to t=
he
>> error message.
>
> With the following patch, I can no longer reproduce the problem.  Doe=
s it
> work fo you, too?
>
> Thanks,
> Ren=C3=A9
>
> diff --git a/sha1_file.c b/sha1_file.c
> index ab2b520..8044e9c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -269,7 +269,7 @@ static int link_alt_odb_entry(const char * entry,=
 int len, const char * relative
>  		entlen +=3D base_len;
>  		pfxlen +=3D base_len;
>  	}
> -	ent =3D xmalloc(sizeof(*ent) + entlen);
> +	ent =3D xcalloc(1, sizeof(*ent) + entlen);

Ah, that would explain the "filled with garbage from $PATH" issue, but =
I
don't think it fixes the fundamental issue.

In the alternate_object_database structure, ent->base[] is a buffer the
users can use to form pathnames to loose objects, and ent->name is a
pointer into that buffer (it points at one beyond ".git/objects/").  If
you get a call to add_refs_from_alternate() after somebody used the ent=
ry
(has_loose_object() has been called, for example), *ent->name would not=
 be
NUL, and ent->base[] won't be the path to the object store.

This caller is expecting to read the path to the object store in ent->b=
ase[];
it needs to NUL terminate the buffer if it wants to.

I think the previous patch to sha1_file.c, while it may fix the issue, =
is
not quite nice.  Here is a replacement that should work.

 builtin-receive-pack.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git c/builtin-receive-pack.c w/builtin-receive-pack.c
index 45e3cd9..9f60f31 100644
--- c/builtin-receive-pack.c
+++ w/builtin-receive-pack.c
@@ -466,12 +466,17 @@ static int delete_only(struct command *cmd)
=20
 static int add_refs_from_alternate(struct alternate_object_database *e=
, void *unused)
 {
-	char *other =3D xstrdup(make_absolute_path(e->base));
-	size_t len =3D strlen(other);
+	char *other;
+	size_t len;
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *extra;
=20
+	e->name[-1] =3D '\0';
+	other =3D xstrdup(make_absolute_path(e->base));
+	e->name[-1] =3D '/';
+	len =3D strlen(other);
+
 	while (other[len-1] =3D=3D '/')
 		other[--len] =3D '\0';
 	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
