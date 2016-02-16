From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge_blobs: use strbuf instead of manually-sized
 mmfile_t
Date: Tue, 16 Feb 2016 15:35:26 -0500
Message-ID: <20160216203526.GA27484@sigill.intra.peff.net>
References: <56C2459B.5060805@uni-graz.at>
 <20160216011258.GA11961@sigill.intra.peff.net>
 <20160216050915.GA5765@flurp.local>
 <20160216055043.GB28237@sigill.intra.peff.net>
 <56C31291.1010308@uni-graz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>
X-From: git-owner@vger.kernel.org Tue Feb 16 21:35:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVmLQ-0008Dq-Aw
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 21:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbcBPUfa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 15:35:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:43533 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932484AbcBPUf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 15:35:29 -0500
Received: (qmail 1138 invoked by uid 102); 16 Feb 2016 20:35:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 15:35:28 -0500
Received: (qmail 30412 invoked by uid 107); 16 Feb 2016 20:35:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Feb 2016 15:35:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2016 15:35:26 -0500
Content-Disposition: inline
In-Reply-To: <56C31291.1010308@uni-graz.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286429>

On Tue, Feb 16, 2016 at 01:14:09PM +0100, Stefan Fr=C3=BChwirth wrote:

> On 2016-02-16 at 06:50, Jeff King wrote:
> >Yeah, maybe. There were two reasons I avoided adding a test.
> >
> >One, I secretly hoped that by dragging my feet we could get consensu=
s on
> >just ripping out merge-tree entirely. ;)
>=20
> Since I cannot comment on the code quality or maturity of merge-tree,=
 but
> would appreciate if this tool worked as expected, let me quote Chris'
> comment[1] on why he uses merge-tree instead of just "git merge", hop=
ing
> that it has an impact upon your decision whether to keep the code or
> "ripping it out":
>=20
> "One might ask, why not use the porcelain 'git merge' command? One
> reason is, in the context of the two phase commit protocol, we'd rath=
er
> do pretty much everything we possibly can in the voting stage, leavin=
g
> ourselves with nothing to do in the finish phase except updating the
> head to the commit we just created, and possibly updating the working
> directory--operations that are guaranteed to work. Since 'git merge'
> will update the head, we'd prefer to do it during the final phase of =
the
> commit, but we can't guarantee it will work. There is not a convenien=
t
> way to do a merge dry run during the voting phase. Although I can
> conceive of ways to do the merge during the voting phase and roll bac=
k
> to the previous head if we need to, that feels a little riskier. Doin=
g
> the merge ourselves, here, also frees us from having to work with a
> working directory, required by the porcelain 'git merge' command. Thi=
s
> means we can use bare repositories and/or have transactions that use
> a head other than the repositories 'current' head."

Yeah, I agree there isn't a great solution in git here. Using "git
merge" is definitely wrong if you don't want to touch HEAD or have a
working directory.  If you _just_ care about doing the tree-level merge
without content-level merging inside blobs, you can do it in the index
like:

  export GIT_INDEX_FILE=3Dtemp.index
  base=3D$(git merge-base $ours $theirs)
  git read-tree -i -m --aggressive $base $ours $theirs

If you want to do content-level resolving on top of that, you can do it
with:

  git merge-index git-merge-one-file -a

though it will need a temp directory to write out conflicts and
resolved content.

That was what powered GitHub's "merge" button for many years, though we
recently switched to using libgit2's merge (mostly because the
merge-one-file bit can be slow; we didn't care about seeing the
conflicts, and as a shell script it runs O(# of merged files)
processes).

I don't think merge-tree is at all the wrong tool, in the sense that it
is being used as designed. But it is using merge code that is different
from literally the rest of git. That means you're going to run into
weird bugs (like this one), and places where it does not behave the
same.  This add/add case, for instance, is usually a conflict in a
normal git merge (try your test case with "git merge"), but merge-tree
tries to do a partial content merge with a base that never actually
existed[1].

So I worry that merge-tree's existence is a disservice to people like
Chris, because there is no disclaimer that it is effectively
unmaintained.

> >Two, I'm not sure what the test output _should_ be. I think this cas=
e is
> >buggy. So we can check that we don't corrupt the heap, which is nice=
,
>=20
> What do you mean exactly by "this case is buggy"? Doesn't make sense =
to me.

Actually, I'm not sure now.  Look at the output of git-merge-tree on
your test case, once my patch is applied[2]:

  $ git merge-tree HEAD~1 master other
  added in both
    our    100644 9fe188c32cdde9723a119c69548e3768882827d1 b
    their  100644 2e65efe2a145dda7ee51d1741299f848e5bf752e b
  @@ -1,2 +1,5 @@
  +<<<<<<< .our
  =20
  +=3D=3D=3D=3D=3D=3D=3D
  +>>>>>>> .their
   a
  \ No newline at end of file

We blindly stick the "No newline at end of file" marker into the base
file content (which is what caused the overflow in the first place). So
our three-way merge is proceeding from a bogus state that has that extr=
a
marker in it.  I _thought_ that was what I was seeing in the output
above.

But I think in practice it magically works, because it looks like both
sides remove that (so the correct merge resolution is to drop it, as
well). And the output above is because it shows the file content as a
diff against the "ours" version (you can tell from the hunk header that
the "No newline" marker is not part of the diff content).

So merge-blobs.c:generate_common_file() is definitely buggy, but I thin=
k
the bug gets unintentionally canceled out by the follow-on three-way
merge. Which is...good, I guess?

-Peff

[1] So one obvious alternative to my patch (besides killing off
    merge-tree entirely) would be to rip out the weird add/add handling=
=2E
    That would bring merge-tree in line with the rest of git, and would
    eliminate the buffer-overflowing code entirely.

[2] You can trigger it without my patch, too, but you need input files
    which differ by more than 29 bytes.
