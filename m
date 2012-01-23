From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH v2 3/3] git-p4: Add test case for complex branch import
Date: Mon, 23 Jan 2012 17:40:12 -0500
Message-ID: <20120123224012.GA10626@padd.com>
References: <1327105292-30092-1-git-send-email-vitor.hda@gmail.com>
 <1327105292-30092-4-git-send-email-vitor.hda@gmail.com>
 <7vehutd59p.fsf@alter.siamese.dyndns.org>
 <4F1A98A3.2090607@diamand.org>
 <20120121171130.GA6235@padd.com>
 <CAOpHH-W1LY3Q50otrcNJTYWN67k_pCZHEOkgbKy7kPgfUbGeQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpSYq-0000iy-DT
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608Ab2AWWkS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 17:40:18 -0500
Received: from honk.padd.com ([74.3.171.149]:39605 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017Ab2AWWkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:40:17 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 0C81320D2;
	Mon, 23 Jan 2012 14:40:16 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3FB6031453; Mon, 23 Jan 2012 17:40:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAOpHH-W1LY3Q50otrcNJTYWN67k_pCZHEOkgbKy7kPgfUbGeQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189022>

vitor.hda@gmail.com wrote on Mon, 23 Jan 2012 14:01 +0000:
> On Sat, Jan 21, 2012 at 5:11 PM, Pete Wyckoff <pw@padd.com> wrote:
> > luke@diamand.org wrote on Sat, 21 Jan 2012 10:51 +0000:
> >> However, one thing I noticed in reading through is that it will
> >> break if you end up importing a P4 branch that has spaces (or othe=
r
> >> shell chars) in its name. A quick test confirms this.
> >>
> >> - the code doesn't handle the names properly
> >> - git and p4 have different ideas about valid branch names
> >>
> >> But before rejecting Vitor's changes because of that it would be
> >> worth considering whether we care (much). My own opinion is that i=
f
> >> you have developers who are daft enough to put spaces or dollars i=
n
> >> their branch names then their project is already doomed anyway....
> >>
> >> Perhaps it would be enough just to issue a warning ("your project =
is
> >> doomed; start working on your CV") and skip such branch names rath=
er
> >> than falling over with inexplicable error messages.
> >
> > This doesn't seem like a big deal. =A0The read_pipe and
> > read_pipe_lines calls shoud be list-ified. =A0That gets rid
> > of the problem with shell interactions.
> >
> > For git branch name reserved characters, a little function
> > to replace the bogus characters with "_" would avoid needing
> > to go work on the resume. =A0Anything in bad_ref_char() and
> > check_refname_component(). =A0I agree this doesn't have to be
> > perfect.
> >
> > This could be a new patch unrelated to Vitor's series, which
> > verifies branch names anywhere a new commit is made.
>=20
> I would also prefer to include that fix on a separate patch series th=
at
> would include the test case Luke already prepared. In my opinion,
> updating read_pipe and read_pipe_lines is out of scope for the curren=
t
> patch series.

How about taking what's below and just squashing it in.  It's
incremental on your changes and would go well with Luke's series
that fixes a bunch of scattered quoting issues similarly.

The change to "describe %s" is unnecessary, but makes all the
invocations look similar.  You can leave it out.

This may conflict if you've already factored out the big
"if self.detectBranches" chunk into a separate function as
Junio recommended.

> BTW, and on an unrelated topic, are any test cases failing on your si=
de?

I do run the tests regularly, and your series is good.  There's
the 'clone --use-client-spec' one that is broken until my
2ea09b5 (git-p4: adjust test to adhere to stricter useClientSpec,
2012-01-11) is merged.  It's on pu.

		-- Pete


-----------8<-------------------
=46rom f1cfb3836f5150dca86238225da56fe0bd577df8 Mon Sep 17 00:00:00 200=
1
=46rom: Pete Wyckoff <pw@padd.com>
Date: Thu, 10 Nov 2011 07:40:14 -0500
Subject: [PATCH] git-p4: use list invoctaions to avoid shell mangling

Change git and p4 command invocations to avoid going through
the shell.  This allows branch names with spaces and wildcards
to work.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2e3b741..b440966 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1961,7 +1961,7 @@ class P4Sync(Command, P4UserMap):
     def importChanges(self, changes):
         cnt =3D 1
         for change in changes:
-            description =3D p4Cmd("describe %s" % change)
+            description =3D p4Cmd(["describe", str(change)])
             self.updateOptionDict(description)
=20
             if not self.silent:
@@ -2022,9 +2022,9 @@ class P4Sync(Command, P4UserMap):
                             self.commit(description, filesForCommit, t=
empBranch, [branchPrefix])
                             self.tempBranches.append(tempBranch)
                             self.checkpoint()
-                            for blob in read_pipe_lines("git rev-list =
--reverse --no-merges %s" % parent):
+                            for blob in read_pipe_lines(["git", "rev-l=
ist", "--reverse", "--no-merges", parent]):
                                 blob =3D blob.strip()
-                                if len( read_pipe("git diff-tree %s %s=
" % (blob, tempBranch)) ) =3D=3D 0:
+                                if len(read_pipe(["git", "diff-tree", =
blob, tempBranch])) =3D=3D 0:
                                     parentFound =3D True
                                     if self.verbose:
                                         print "Found parent of %s in c=
ommit %s" % (branch, blob)
--=20
1.7.9.rc2.33.g492ae
