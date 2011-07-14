From: Jeff King <peff@peff.net>
Subject: Re: git-archive and tar options
Date: Thu, 14 Jul 2011 14:18:58 -0400
Message-ID: <20110714181858.GA25172@sigill.intra.peff.net>
References: <ivla29$liu$1@dough.gmane.org>
 <20110714015656.GA20136@sigill.intra.peff.net>
 <4E1F2468.6080409@lsrfire.ath.cx>
 <20110714172718.GA21341@sigill.intra.peff.net>
 <4E1F2B23.1020908@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Jul 14 20:19:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQVO-0008Me-CG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab1GNSTB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 14:19:01 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55280
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400Ab1GNSTB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:19:01 -0400
Received: (qmail 9063 invoked by uid 107); 14 Jul 2011 18:19:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 14:19:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 14:18:58 -0400
Content-Disposition: inline
In-Reply-To: <4E1F2B23.1020908@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177144>

On Thu, Jul 14, 2011 at 07:45:07PM +0200, Ren=C3=A9 Scharfe wrote:

> > We didn't when git-archive was written, but these days we have
> > get_sha1_with_context to remember incidental things about an object=
 we
> > look up. It should perhaps remember the commit (if any) we used to =
reach
> > a treeish, and then the above command line could still insert the p=
ax
> > header.
>=20
> That's a good idea to increase consistency, as there shouldn't really=
 be
> a difference in output between the two subdirectory syntaxes.

The patch to do this is pretty tiny. See below.

There are a few issues, though:

  1. I think this is probably the right thing to do, and most people
     will be happy about it. But I guess I can see an argument that the
     commit-id should not be there, as the subtree does not represent
     that commit.

     IOW, if you assume the commit-id in the output means
     "by the way, this came from commit X", this change is a good thing=
=2E
     If you assume it means "this is the tree from commit X", then it's
     not.  I have no idea how people use it. I never have, but I always
     assumed the use case was "I have this random tarball. Where did it
     come from?".

  2. The object_context already has the sha1 we want, but it is under
     the name "tree", which is not an accurate name. It's actually
     "whatever is on the left side of the :". Which should be a
     tree-ish, but could be a commit or a tree.

  3. It looks like we fill in object_context whenever we see something
     like "tree-ish:path". But we should perhaps also do so when peelin=
g
     something like "tree-ish^{tree}".

> I always wondered, however, if the embedded commit ID has really been
> used to identify the corresponding version of an archive that somehow
> lost its filename (due to being piped?).

I dunno. I've never used it.

-- >8 --
Subject: [PATCH] archive: look harder for commit id

When "git archive" is given a commit, the output will
contain the commit sha1 (either as a pax header for tar
format, or in a file comment for zip).

When it's given a name that resolves to a tree, like:

  git archive git-1.7.0:Documentation

then the archive code never sees the commit, and no
commit-id is output. We can use get_sha1_with_context to
remember the commit that led us to that tree (if any).

Signed-off-by: Jeff King <peff@peff.net>
---
 archive.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/archive.c b/archive.c
index 42f2d2f..d0ba7fb 100644
--- a/archive.c
+++ b/archive.c
@@ -256,11 +256,14 @@ static void parse_treeish_arg(const char **argv,
 	struct tree *tree;
 	const struct commit *commit;
 	unsigned char sha1[20];
+	struct object_context oc;
=20
-	if (get_sha1(name, sha1))
+	if (get_sha1_with_context(name, sha1, &oc))
 		die("Not a valid object name");
=20
 	commit =3D lookup_commit_reference_gently(sha1, 1);
+	if (!commit)
+		commit =3D lookup_commit_reference_gently(oc.tree, 1);
 	if (commit) {
 		commit_sha1 =3D commit->object.sha1;
 		archive_time =3D commit->date;
--=20
1.7.6.38.ge5b33
