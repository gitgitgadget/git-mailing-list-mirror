From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] {fetch,receive}-pack: skip sha-1 integrity test on
 objects from new pack
Date: Thu, 15 Mar 2012 14:57:02 -0700
Message-ID: <7vsjh9il3l.fsf@alter.siamese.dyndns.org>
References: <7vfwdq8914.fsf@alter.siamese.dyndns.org>
 <1331736055-21019-1-git-send-email-pclouds@gmail.com>
 <7vy5r1inax.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 22:57:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8IfZ-000580-Nn
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 22:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760431Ab2COV5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Mar 2012 17:57:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761170Ab2COV5G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Mar 2012 17:57:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C4F86C73;
	Thu, 15 Mar 2012 17:57:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0mBFglb5iG0q
	VVxmslXUGZeiGW8=; b=uoWxhVr6crFoLsa+Q+M90nHafsOZXWh13wMbi59AfqVh
	v56IcTomzV1P85piZd7u3zk3aob3jwzA2dxrRKVwI2VbOJ7d9udUt7cZqglOA+Nj
	yReppGWKQP259BJY1IVRdCFFltP8lfDFLILU+zknYSVFnDflqgmgPQ7KSfoSvwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jhZXH9
	cMsuQl234UkB3QNz/U1Swvic0CEzmrxxfN+lh2yrFxxMLdcZQdZ59DDzjEF+U/DF
	A7+eHPje2gpInFvG5c27/I+XwzSUM36TsZpBYGEScaKSlJn3I5IiKJQegV2Srqiv
	kT/mwn1zDYD72fVljE5pFgdWMF/OWo9lNXUFk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2390C6C72;
	Thu, 15 Mar 2012 17:57:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 59E096C71; Thu, 15 Mar 2012
 17:57:04 -0400 (EDT)
In-Reply-To: <7vy5r1inax.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Mar 2012 14:09:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD032312-6EE9-11E1-92FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193228>

Junio C Hamano <gitster@pobox.com> writes:

> After thinking about this a bit more, I am beginning to think that th=
e
> validation of object contents is unnecessary in _all_ cases that invo=
lve
> "git fetch". ...
> So the right solution is probably use --objects for connectivity chec=
ks as
> before; we could add a fetch.paranoid configuration to allow people t=
o
> still use it (with this patch to remove the over-pessimism from the c=
ode)
> but only if they want to.

=46ollowing the above train of thought, the patch to revert what 6d4bb3=
8
(fetch: verify we have everything we need before updating our ref,
2011-09-01) did which caused this performance regression should look li=
ke
this.  "tag --contains 6d4bb38" tells me that this affects everything
since v1.7.8-rc0 so we may want to issue maintenance updates once this
proves good in 1.7.10.

Nguy=E1=BB=85n, sorry for being dense.  I think this ended up being ver=
y close to
your initial patch.

-- >8 --
Subject: fetch/receive: remove over-pessimistic connectivity check

Git 1.7.8 introduced an object and history re-validation step after
"fetch" or "push" causes new history to be added to a receiving
repository, in order to protect a malicious server or pushing client to
corrupt it by taking advantage of an existing corrupt object that is
unconnected to existing history of the receiving repository.

But this is way over-pessimistic, and often adds 5x to 8x runtime overh=
ead
for a little gain.  During "fetch" or "receive-pack" (the server side o=
f
"push"), unpack-objects and index-pack already validate individual obje=
cts
that are received, and the only thing we would want to catch are object=
s
that already happened to exist in our repository but were not reference=
d
from our refs.  But such objects must have been written by an earlier r=
un
of our codepaths that write out loose objects or packfiles, and they mu=
st
have done the validation of individual objects when they did so.  The o=
nly
thing left to worry about is the connectivity integrity, which can be d=
one
with much cheaper "rev-list --objects".

Remove this over-pessimistic check, while leaving the door open for lat=
er
changes, hinting the possibility in an in-code comment.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c |    2 +-
 connected.c     |   14 +++++++++-----
 connected.h     |    3 ++-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8761a33..b2f7d5b 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -505,7 +505,7 @@ static int quickfetch(struct ref *ref_map)
 	 */
 	if (depth)
 		return -1;
-	return check_everything_connected(iterate_ref_map, 1, &rm);
+	return check_everything_connected(iterate_ref_map, CONN_CHECK_QUIET, =
&rm);
 }
=20
 static int fetch_refs(struct transport *transport, struct ref *ref_map=
)
diff --git a/connected.c b/connected.c
index d762423..3564a9f 100644
--- a/connected.c
+++ b/connected.c
@@ -6,22 +6,26 @@
 /*
  * If we feed all the commits we want to verify to this command
  *
- *  $ git rev-list --verify-objects --stdin --not --all
+ *  $ git rev-list --objects --stdin --not --all
  *
  * and if it does not error out, that means everything reachable from
- * these commits locally exists and is connected to some of our
- * existing refs.
+ * these commits locally exists and is connected to our existing refs.
  *
  * Returns 0 if everything is connected, non-zero otherwise.
+ *
+ * We may want to introduce CONN_CHECK_PARANOIA option the caller can
+ * pass to use --verify-objects instead of --objects to optionally hav=
e
+ * individual objects re-validated.
  */
-int check_everything_connected(sha1_iterate_fn fn, int quiet, void *cb=
_data)
+int check_everything_connected(sha1_iterate_fn fn, unsigned flags, voi=
d *cb_data)
 {
 	struct child_process rev_list;
-	const char *argv[] =3D {"rev-list", "--verify-objects",
+	const char *argv[] =3D {"rev-list", "--objects",
 			      "--stdin", "--not", "--all", NULL, NULL};
 	char commit[41];
 	unsigned char sha1[20];
 	int err =3D 0;
+	int quiet =3D !!(flags & CONN_CHECK_QUIET);
=20
 	if (fn(cb_data, sha1))
 		return err;
diff --git a/connected.h b/connected.h
index 7e4585a..6f17e07 100644
--- a/connected.h
+++ b/connected.h
@@ -15,6 +15,7 @@ typedef int (*sha1_iterate_fn)(void *, unsigned char =
[20]);
  *
  * Return 0 if Ok, non zero otherwise (i.e. some missing objects)
  */
-extern int check_everything_connected(sha1_iterate_fn, int quiet, void=
 *cb_data);
+extern int check_everything_connected(sha1_iterate_fn, unsigned flags,=
 void *cb_data);
+#define CONN_CHECK_QUIET 01
=20
 #endif /* CONNECTED_H */
