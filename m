From: Jeff King <peff@peff.net>
Subject: Re: git cat-file -e behavior
Date: Mon, 29 Feb 2016 06:44:55 -0500
Message-ID: <20160229114455.GD29769@sigill.intra.peff.net>
References: <56D41645.4050800@cihar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michal =?utf-8?B?xIxpaGHFmQ==?= <michal@cihar.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 12:45:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaMG7-0006Gm-Gz
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 12:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010AbcB2LpA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Feb 2016 06:45:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:51333 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753490AbcB2Lo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 06:44:58 -0500
Received: (qmail 15236 invoked by uid 102); 29 Feb 2016 11:44:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:44:57 -0500
Received: (qmail 25301 invoked by uid 107); 29 Feb 2016 11:45:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 06:45:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 06:44:55 -0500
Content-Disposition: inline
In-Reply-To: <56D41645.4050800@cihar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287828>

On Mon, Feb 29, 2016 at 10:58:29AM +0100, Michal =C4=8Ciha=C5=99 wrote:

> the documentation for "git cat-file -e" says:
>=20
> > Suppress all output; instead exit with zero status if <object> exis=
ts
> and is a valid object.
>=20
> However running it on non existing object will complain "fatal: Not a
> valid object name".
>=20
> $ git cat-file -e master:README.rst
> $ echo $?
> 0
> $ git cat-file -e master:foo
> fatal: Not a valid object name master:foo
> $ echo $?
> 128
>=20
> Is the output in this case expected?
>=20
> I'm currently running 2.7.0.

It looks like it has been this way forever. The first thing we do with
the object is resolve its name to a sha1, and that's where the error yo=
u
see comes from. And then we actually check whether we have the object.

I think the intended use was to feed it a sha1 to see if it exists. The=
n
the name-resolution step is a noop.

I'm not sure if the behavior you are seeing is all that bad (the
documentation could be read as suppressing the normal stdout output, bu=
t
error messages remain), but it would be easy to change:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 54db118..afde169 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -35,6 +35,9 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name,
 	if (unknown_type)
 		flags |=3D LOOKUP_UNKNOWN_OBJECT;
=20
+	if (opt =3D=3D 'e')
+		return !has_sha1_file(sha1);
+
 	if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
 		die("Not a valid object name %s", obj_name);
=20
@@ -58,9 +61,6 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name,
 		printf("%lu\n", size);
 		return 0;
=20
-	case 'e':
-		return !has_sha1_file(sha1);
-
 	case 'c':
 		if (!obj_context.path[0])
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
