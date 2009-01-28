From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-pack: Filter unknown commits from alternates of the
 remote
Date: Tue, 27 Jan 2009 19:33:11 -0800
Message-ID: <7vskn4xfyg.fsf@gitster.siamese.dyndns.org>
References: <7vk58gz04l.fsf@gitster.siamese.dyndns.org>
 <20090128013840.GA7224@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 04:34:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS1CU-00012X-9S
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 04:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbZA1Dd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2009 22:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZA1DdZ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 22:33:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43408 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbZA1DdY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 22:33:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8D6F94F1D;
	Tue, 27 Jan 2009 22:33:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ACE2594F1B; Tue,
 27 Jan 2009 22:33:13 -0500 (EST)
In-Reply-To: <20090128013840.GA7224@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Wed, 28 Jan 2009 02:38:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A22DC6A-ECEC-11DD-AFB8-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107463>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> Since 40c155ff14c, receive-pack on the remote also sends refs from it=
s
> alternates. Unfortunately, we don't filter commits that don't exist i=
n the
> local repository from that list.  This made us pass those unknown com=
mits
> to pack-objects, causing it to fail with a "bad object" error.
>
> Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
> ---
>  builtin-send-pack.c |   14 +++++++++-----
>  1 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index a9fdbf9..10d7016 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -52,11 +52,15 @@ static int pack_objects(int fd, struct ref *refs,=
 struct extra_have_objects *ext
>  	 * parameters by writing to the pipe.
>  	 */
>  	for (i =3D 0; i < extra->nr; i++) {
> -		memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
> -		buf[0] =3D '^';
> -		buf[41] =3D '\n';
> -		if (!write_or_whine(po.in, buf, 42, "send-pack: send refs"))
> -			break;
> +		if (!is_null_sha1(&extra->array[i][0]) &&
> +		    has_sha1_file(&extra->array[i][0])) {
> +			memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
> +			buf[0] =3D '^';
> +			buf[41] =3D '\n';
> +			if (!write_or_whine(po.in, buf, 42,
> +						"send-pack: send refs"))
> +				break;
> +		}
>  	}
> =20
>  	while (refs) {

Actually I changed my mind.

We have the exactly the same issue for the real refs the target reposit=
ory
has, not just borrowed phantom refs, in the code from day one of git-pu=
sh.
In other words, this issue predates the ".have" extension, and your upd=
ate
is in line with how the codepath for the real refs does its thing.  So
your fix is not worse than the existing code.

It can be argued that at least in the "real ref" case you are in contro=
l
of both ends and if you have a disconnected chain in your local reposit=
ory
that you do not have a ref for, you are screwing yourself, and it is yo=
ur
problem.  But when you forked your repository from somebody else on a
hosting site like github, you do not have much control over the other e=
nd
(because it is a closed site you cannot ssh in to diagnose what is real=
ly
going on), and if you do not exactly know from whom your hosted reposit=
ory
is borrowing, it is more likely that you will get into a situation wher=
e
you may have objects near the tip without having the full chain after a=
n
aborted transfer, and the insufficient check of doing only has_sha1_fil=
e()
may become a larger issue in such a settings.

But still, let's take the approach I labeled as *wrong* as an interim
solution for the immediate future.

I'd prefer a small helper function to consolidate the duplicated code,
like the attached patch, though.  How about doing it like this?

 builtin-send-pack.c |   46 ++++++++++++++++++++++++-------------------=
---
 1 files changed, 24 insertions(+), 22 deletions(-)

diff --git c/builtin-send-pack.c w/builtin-send-pack.c
index a9fdbf9..2d24cf2 100644
--- c/builtin-send-pack.c
+++ w/builtin-send-pack.c
@@ -15,6 +15,23 @@ static struct send_pack_args args =3D {
 	/* .receivepack =3D */ "git-receive-pack",
 };
=20
+static int feed_object(const unsigned char *theirs, int fd, int negati=
ve)
+{
+	char buf[42];
+
+	if (!has_sha1_file(theirs))
+		return 1;
+	/*
+	 * NEEDSWORK: we should not be satisfied by simply having
+	 * theirs, but should be making sure it is reachable from
+	 * some of our refs.
+	 */
+	memcpy(buf + negative, sha1_to_hex(theirs), 40);
+	if (negative)
+		buf[0] =3D '^';
+	buf[40 + negative] =3D '\n';
+	return write_or_whine(fd, buf, 41 + negative, "send-pack: send refs")=
;
+}
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
@@ -35,7 +52,6 @@ static int pack_objects(int fd, struct ref *refs, str=
uct extra_have_objects *ext
 	};
 	struct child_process po;
 	int i;
-	char buf[42];
=20
 	if (args.use_thin_pack)
 		argv[4] =3D "--thin";
@@ -51,31 +67,17 @@ static int pack_objects(int fd, struct ref *refs, s=
truct extra_have_objects *ext
 	 * We feed the pack-objects we just spawned with revision
 	 * parameters by writing to the pipe.
 	 */
-	for (i =3D 0; i < extra->nr; i++) {
-		memcpy(buf + 1, sha1_to_hex(&extra->array[i][0]), 40);
-		buf[0] =3D '^';
-		buf[41] =3D '\n';
-		if (!write_or_whine(po.in, buf, 42, "send-pack: send refs"))
+	for (i =3D 0; i < extra->nr; i++)
+		if (!feed_object(extra->array[i], po.in, 1))
 			break;
-	}
=20
 	while (refs) {
 		if (!is_null_sha1(refs->old_sha1) &&
-		    has_sha1_file(refs->old_sha1)) {
-			memcpy(buf + 1, sha1_to_hex(refs->old_sha1), 40);
-			buf[0] =3D '^';
-			buf[41] =3D '\n';
-			if (!write_or_whine(po.in, buf, 42,
-						"send-pack: send refs"))
-				break;
-		}
-		if (!is_null_sha1(refs->new_sha1)) {
-			memcpy(buf, sha1_to_hex(refs->new_sha1), 40);
-			buf[40] =3D '\n';
-			if (!write_or_whine(po.in, buf, 41,
-						"send-pack: send refs"))
-				break;
-		}
+		    !feed_object(refs->old_sha1, po.in, 1))
+			break;
+		if (!is_null_sha1(refs->new_sha1) &&
+		    !feed_object(refs->new_sha1, po.in, 0))
+			break;
 		refs =3D refs->next;
 	}
=20
=2E
