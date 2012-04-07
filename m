From: Jeff King <peff@peff.net>
Subject: Re: rs/commit-list-sort-in-batch
Date: Sat, 7 Apr 2012 03:32:32 -0400
Message-ID: <20120407073232.GA13076@sigill.intra.peff.net>
References: <7vwr5szi7z.fsf@alter.siamese.dyndns.org>
 <20120407072724.GA818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 09:32:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGQ8V-0003WD-3l
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 09:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab2DGHce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Apr 2012 03:32:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53203
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747Ab2DGHce (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 03:32:34 -0400
Received: (qmail 20624 invoked by uid 107); 7 Apr 2012 07:32:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 07 Apr 2012 03:32:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2012 03:32:32 -0400
Content-Disposition: inline
In-Reply-To: <20120407072724.GA818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194939>

On Sat, Apr 07, 2012 at 03:27:24AM -0400, Jeff King wrote:

> On Fri, Apr 06, 2012 at 02:02:56PM -0700, Junio C Hamano wrote:
>=20
> > * rs/commit-list-sort-in-batch (2012-04-02) 3 commits
> >  - revision: insert unsorted, then sort in prepare_revision_walk()
> >  - commit: use mergesort() in commit_list_sort_by_date()
> >  - add mergesort() for linked lists
>=20
> Looks like you applied these patches right on v1.7.9. However, they n=
eed
> Thomas's 5e8617f to compile, which comes later. There's no textual
> conflict, but test-mergesort.c need strbuf_getwholeline_fd, which is
> made public by 5e8617f.

By the way, building on top of Ren=C3=A9's patches[1], I was able to dr=
op the
time of a particular fetch into a repository with many refs from:

    real    0m2.081s
    user    0m2.180s
    sys     0m0.712s

to:

    real    0m1.784s
    user    0m1.936s
    sys     0m0.652s

with this patch:

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 7124c4b..5d80e65 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -503,7 +503,7 @@ static int mark_complete(const char *refname, const=
 unsigned char *sha1, int fla
 		struct commit *commit =3D (struct commit *)o;
 		if (!(commit->object.flags & COMPLETE)) {
 			commit->object.flags |=3D COMPLETE;
-			commit_list_insert_by_date(commit, &complete);
+			commit_list_insert(commit, &complete);
 		}
 	}
 	return 0;
@@ -615,6 +615,7 @@ static int everything_local(struct ref **refs, int =
nr_match, char **match)
 	if (!args.depth) {
 		for_each_ref(mark_complete, NULL);
 		for_each_alternate_ref(mark_alternate_complete, NULL);
+		commit_list_sort_by_date(&complete);
 		if (cutoff)
 			mark_recent_complete_commits(cutoff);
 	}

I'm not sure if that vindicates the patches, or implies that these
things are lurking everywhere and that we should really move to a bette=
r
data structure so we don't have to fix them all manually. :)

-Peff

[1] Actually, it was Ren=C3=A9's patches merged into v1.7.10. My ccdc60=
3
    (parse_object: try internal cache before reading object db,
    2012-01-05) makes such a huge difference it is not worth timing
    without it.
