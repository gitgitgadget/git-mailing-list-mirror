From: Jeff King <peff@peff.net>
Subject: Re: reset reports file as modified when it's in fact deleted
Date: Mon, 7 Nov 2011 11:26:42 -0500
Message-ID: <20111107162642.GA27055@sigill.intra.peff.net>
References: <20111107094330.GB10936@beez.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 17:26:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNS28-0002a6-DX
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 17:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755006Ab1KGQ0s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011 11:26:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35797
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483Ab1KGQ0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 11:26:46 -0500
Received: (qmail 27323 invoked by uid 107); 7 Nov 2011 16:26:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 11:26:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 11:26:42 -0500
Content-Disposition: inline
In-Reply-To: <20111107094330.GB10936@beez.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184992>

On Mon, Nov 07, 2011 at 10:43:30AM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> When I delete a file (git rm) and then reset so it exists in the inde=
x
> again, the message tells me 'M file.txt' even though the file doesn't
> exist in the worktree anymore. Running git status afterwards does giv=
e
> the correct output. So, here's the minimal steps to reproduce:
>=20
>     $ git init
>     Initialized empty Git repository in /home/carlos/test/reset-err/.=
git/
>     $ touch file.txt
>     $ git add file.txt
>     $ git ci file.txt -m initial
>     [master (root-commit) a536393] initial
>      0 files changed, 0 insertions(+), 0 deletions(-)
>      create mode 100644 file.txt
>     $ git rm file.txt
>     rm 'file.txt'
>     $ git reset -- file.txt
>     Unstaged changes after reset:
>     M		 file.txt
>     $ git status -b -s
>     ## master
>      D file.txt

You can simplify this even further by not touching the index at all:

  git init -q &&
  >file && git add file && git commit -q -m initial &&
  rm file &&
  git reset

produces:

  Unstaged changes after reset:
  M       file

> I'd expect the output after "Unstaged changes after reset" to tell me
> file.txt has been deleted instead of modified. This happens with
> 1.7.8-rc0, 1.7.7 and 1.7.4.1 and I expect with many more that I don't
> have here.
>=20
> I thought the index diff code might have been checking the index at t=
he
> wrong time, but I can run 'git reset HEAD -- file.txt' as many times
> as I want, and it will still say 'M', so now I'm not sure.

The index diff code isn't running at all. Those messages are produced b=
y
refresh_index, which outputs only two flags: modified or unmerged. I
think the reason for this is somewhat historical. You would run
"update-index --refresh", and it would helpfully say "by the way, when
refreshing this entry, I noticed that it is in need of being updated in
the index". The text was "file.txt: needs update".

Later, many porcelain commands started to refresh the index themselves,
and the "needs update" message was very confusing. So it was switched t=
o
the more familiar "M file.txt" (though you can still see the original
plumbing message if you run update-index yourself).

I think it is a little more friendly to distinguish deletion from just
modification. And there's shouldn't be any compatibility questions, as
these are explicitly porcelain output (plumbing will still say "needs
update").

There are a few other cases users might expect to see. We'll never show
copies or renames, of course, because we aren't actually doing a diff
with copy detection. We won't see an "A"dded file, because such a file
would be in the working tree but not the index, meaning it is not
tracked.

We could see a "T"ypechange, but the distinction between that and a
modified file is lost by the time we get to refresh_index. We could pas=
s
it up, but I wonder if it's really worth it.

The patch to do "D"eleted is pretty simple:

diff --git a/read-cache.c b/read-cache.c
index dea7cd8..cc1ebdf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1103,9 +1103,11 @@ int refresh_index(struct index_state *istate, un=
signed int flags, const char **p
 	int in_porcelain =3D (flags & REFRESH_IN_PORCELAIN);
 	unsigned int options =3D really ? CE_MATCH_IGNORE_VALID : 0;
 	const char *needs_update_fmt;
+	const char *needs_rm_fmt;
 	const char *needs_merge_fmt;
=20
 	needs_update_fmt =3D (in_porcelain ? "M\t%s\n" : "%s: needs update\n"=
);
+	needs_rm_fmt =3D (in_porcelain ? "D\t%s\n" : "%s: needs update\n");
 	needs_merge_fmt =3D (in_porcelain ? "U\t%s\n" : "%s: needs merge\n");
 	for (i =3D 0; i < istate->cache_nr; i++) {
 		struct cache_entry *ce, *new;
@@ -1145,7 +1147,10 @@ int refresh_index(struct index_state *istate, un=
signed int flags, const char **p
 			}
 			if (quiet)
 				continue;
-			show_file(needs_update_fmt, ce->name, in_porcelain, &first, header_=
msg);
+			if (cache_errno =3D=3D ENOENT)
+				show_file(needs_rm_fmt, ce->name, in_porcelain, &first, header_msg=
);
+			else
+				show_file(needs_update_fmt, ce->name, in_porcelain, &first, header=
_msg);
 			has_errors =3D 1;
 			continue;
 		}
