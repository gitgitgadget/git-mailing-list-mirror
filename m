From: Jeff King <peff@peff.net>
Subject: [PATCH] add_submodule_odb: initialize alt_odb list earlier
Date: Wed, 28 Oct 2015 10:07:25 -0400
Message-ID: <20151028140725.GA15304@sigill.intra.peff.net>
References: <5630B876.7080407@sociomantic.com>
 <5630BE79.40708@gmail.com>
 <5630CF1B.9000706@sociomantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Victor Leschuk <vleschuk@gmail.com>, git@vger.kernel.org,
	vleschuk@accesssoftek.com
To: "Mathias L. Baumann" <mathias.baumann@sociomantic.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:07:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrRO8-0005uT-Rk
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 15:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966013AbbJ1OHc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2015 10:07:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:49165 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965731AbbJ1OH2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 10:07:28 -0400
Received: (qmail 9501 invoked by uid 102); 28 Oct 2015 14:07:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 09:07:27 -0500
Received: (qmail 1858 invoked by uid 107); 28 Oct 2015 14:07:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Oct 2015 10:07:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Oct 2015 10:07:25 -0400
Content-Disposition: inline
In-Reply-To: <5630CF1B.9000706@sociomantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280365>

On Wed, Oct 28, 2015 at 02:35:23PM +0100, Mathias L. Baumann wrote:

> I was using the latest git version 2.6.2 already.
> I suspect it is due to a .gitconfig. This is what is probably require=
d:
>=20
> =E2=9E=9C  ~  cat .gitconfig
> [diff]
>     submodule =3D log

Yeah, I can reproduce it easily with that. Thanks for providing the
repository. It takes a rather convoluted set of conditions to trigger
the bug. :)

Here's the fix:

-- >8 --
Subject: add_submodule_odb: initialize alt_odb list earlier

The add_submodule_odb function tries to add a submodule's
object store as an "alternate". It needs the existing list
to be initialized (from the objects/info/alternates file)
for two reasons:

  1. We look for duplicates with the existing alternate
     stores, but obviously this doesn't work if we haven't
     loaded any yet.

  2. We link our new entry into the list by prepending it to
     alt_odb_list. But we do _not_ modify alt_odb_tail.
     This variable starts as NULL, and is a signal to the
     alt_odb code that the list has not yet been
     initialized.

     We then call read_info_alternates on the submodule (to
     recursively load its alternates), which will try to
     append to that tail, assuming it has been initialized.
     This causes us to segfault if it is NULL.

This rarely comes up in practice, because we will have
initialized the alt_odb any time we do an object lookup. So
you can trigger this only when:

  - you try to access a submodule (e.g., a diff with
    diff.submodule=3Dlog)

  - the access happens before any other object has been
    accessed (e.g., because the diff is between the working
    tree and the index)

  - the submodule contains an alternates file (so we try to
    add an entry to the NULL alt_odb_tail)

To fix this, we just need to call prepare_alt_odb at the
start of the function (and if we have already initialized,
it is a noop).

Note that we can remove the prepare_alt_odb call from the
end. It is guaranteed to be a noop, since we will have
called it earlier.

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 5879cfb..88af54c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -130,6 +130,7 @@ static int add_submodule_odb(const char *path)
 		goto done;
 	}
 	/* avoid adding it twice */
+	prepare_alt_odb();
 	for (alt_odb =3D alt_odb_list; alt_odb; alt_odb =3D alt_odb->next)
 		if (alt_odb->name - alt_odb->base =3D=3D objects_directory.len &&
 				!strncmp(alt_odb->base, objects_directory.buf,
@@ -148,7 +149,6 @@ static int add_submodule_odb(const char *path)
=20
 	/* add possible alternates from the submodule */
 	read_info_alternates(objects_directory.buf, 0);
-	prepare_alt_odb();
 done:
 	strbuf_release(&objects_directory);
 	return ret;
--=20
2.6.2.572.g6ed22dd
