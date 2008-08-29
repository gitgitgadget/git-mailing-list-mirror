From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: [RFC/PATCH 1/2 v2] for-each-ref: add new format 'refbasename'
Date: Fri, 29 Aug 2008 18:45:08 +0200
Message-ID: <20080829164508.GF8000@neumann>
References: <0329f1ab2642e1dab701b5fc6517bfb1b4ea2d46.1220004755.git.szeder@ira.uka.de>
	<20080829143448.GC7403@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 18:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ772-0004NZ-Ox
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 18:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbYH2QpL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Aug 2008 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbYH2QpL
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 12:45:11 -0400
Received: from francis.fzi.de ([141.21.7.5]:14076 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753105AbYH2QpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 12:45:09 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 29 Aug 2008 18:45:07 +0200
Content-Disposition: inline
In-Reply-To: <20080829143448.GC7403@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 29 Aug 2008 16:45:07.0297 (UTC) FILETIME=[97F7BD10:01C909F6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94312>

for-each-ref's refname format outputs each ref in its full format, e.g.
'refs/heads/foo' and 'refs/tags/bar'.  However, there are tools that
need only the last part of the refname, e.g. only 'foo' and 'bar'.  Suc=
h
a tool is git's bash completion script, which spends considerable amoun=
t
of time removing the unneeded parts from for-each-ref's output.

Therefore, we introduce a new for-each-ref format called 'refbasename',
which strips the leading parts of the refname:

  * If the refname doesn't contain any '/', then it is printed as is.

  * If the refname contains one '/', then the string following the '/'
    is printed (e.g. 'refs/foo' becomes 'foo').

  * If the refname contains two (or more) '/', then the string followin=
g
    the second '/' is printed (e.g. 'refs/heads/foo' becomes 'foo').
   =20
Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
---

On Fri, Aug 29, 2008 at 07:34:48AM -0700, Shawn O. Pearce wrote:
> SZEDER GGGbor <szeder@ira.uka.de> wrote:
> > +		} else if (!strcmp(name, "refbasename")) {
> > +			char * p =3D strchr(ref->refname, '/');
> > +			p =3D strchr(p+1, '/');
> > +			v->s =3D p+1;
>=20
> Please be careful here and check for !p.  A refname may be missing
> one or two '/' in which case you will cause the process to segfault.
>=20
> I don't think its a good idea to assume you'll always have to '/'
> in the name.  "refs/foo" can be created by git-update-ref.  Or if
> we ever started to report on HEAD this output tag would crash.
Ah, I feared as much.

This raises the question what should the refbasename format print in
those cases.  The first case (no '/' at all) is trivial, but the other
two are a bit problematic:

  * The refname 'foo/bar' seems to be valid, or at least the command
    sequence 'mkdir .git/foo; cp .git/refs/heads/master .git/foo/bar;
    git checkout foo/bar' works as expected.  OTOH, 'git for-each-ref
    --format=3D"%(refname)"' doesn't print anything.

  * The refname 'refs/head/foo/bar' should become 'foo/bar':  it's in=20
    sync with how 'git branch' lists it, and this behaviour is needed
    by the bash completion changes.  However, unfortunately it
    contradicts to the format's name, because basename removes all
    directory components.  Maybe someone has a better idea on how to
    name this format...


 builtin-for-each-ref.c  |   12 ++++++++++++
 t/t6300-for-each-ref.sh |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 21e92bb..23d064b 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -66,6 +66,7 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
+	{ "refbasename" },
 };
=20
 /*
@@ -577,6 +578,17 @@ static void populate_value(struct refinfo *ref)
 			char *s =3D xmalloc(len + 4);
 			sprintf(s, "%s^{}", ref->refname);
 			v->s =3D s;
+		} else if (!strcmp(name, "refbasename")) {
+			char * slash1 =3D strchr(ref->refname, '/');
+			if (!slash1)
+				v->s =3D ref->refname;
+			else {
+				char * slash2 =3D strchr(slash1 + 1, '/');
+				if (!slash2)
+					v->s =3D slash1 + 1;
+				else
+					v->s =3D slash2 + 1;
+			}
 		}
 	}
=20
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 8ced593..b317a01 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -66,6 +66,7 @@ test_atom head subject 'Initial'
 test_atom head body ''
 test_atom head contents 'Initial
 '
+test_atom head refbasename 'master'
=20
 test_atom tag refname refs/tags/testtag
 test_atom tag objecttype tag
@@ -95,6 +96,7 @@ test_atom tag subject 'Tagging at 1151939927'
 test_atom tag body ''
 test_atom tag contents 'Tagging at 1151939927
 '
+test_atom tag refbasename 'testtag'
=20
 test_expect_success 'Check invalid atoms names are errors' '
 	test_must_fail git-for-each-ref --format=3D"%(INVALID)" refs/heads
--=20
1.6.0.1.149.g903b0
