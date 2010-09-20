From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: tig show <commit> not working anymore?
Date: Sun, 19 Sep 2010 23:25:22 -0500
Message-ID: <20100920042522.GA21880@bluemoon.alumni.iitm.ac.in>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
 <4C922112.404@drmicha.warpmail.net>
 <20100918050122.GA24656@bluemoon.alumni.iitm.ac.in>
 <AANLkTinwTSOVfdZkt8CM9DHy9mm9nPt133nvUNjUcQO1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Sep 20 06:25:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxXwq-0000hr-0g
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 06:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773Ab0ITEZ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 00:25:29 -0400
Received: from ironclad.mail.utexas.edu ([146.6.25.7]:1401 "EHLO
	ironclad.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab0ITEZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 00:25:28 -0400
X-IronPort-MID: 55525286
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAHJ/lkyAU36G/2dsb2JhbACiJHHDHYVBBIRO
Received: from wb1-a.mail.utexas.edu ([128.83.126.134])
  by ironclad.mail.utexas.edu with ESMTP; 19 Sep 2010 23:25:27 -0500
Received: (qmail 73541 invoked from network); 20 Sep 2010 04:25:26 -0000
Received: from cpe-24-27-28-128.austin.res.rr.com (HELO bluemoon.WORKGROUP) (a.kumar@24.27.28.128)
  by wb1.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSA; 20 Sep 2010 04:25:26 -0000
Received: from kumar by bluemoon.WORKGROUP with local (Exim 4.72)
	(envelope-from <a.kumar@alumni.iitm.ac.in>)
	id 1OxXwQ-000755-Hj; Sun, 19 Sep 2010 23:25:22 -0500
Mail-Followup-To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTinwTSOVfdZkt8CM9DHy9mm9nPt133nvUNjUcQO1@mail.gmail.com>
X-OS: Linux bluemoon 2.6.32-5-amd64 x86_64
X-Operating-System: Linux bluemoon 2.6.32-5-amd64 x86_64
X-Editor: GNU Emacs 22.3.1
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156549>

Dear Jonas,

On Sun, Sep 19, 2010 at 02:46:22PM -0400, Jonas Fonseca wrote:
> > Well, I was exploring the code a little, and I could not understand
> > some aspects fully. First, I discovered that the following hack fix=
es
> > the problem to an extent:
> >
> > [snip]
> >
> > However, I am pretty certain that that is not the intended use of
> > opt_rev_args and ref_commit, and that they should be used in a
> > different way. For example, tig show HEAD^^^..HEAD should show me
> > three commits combined, but it shows me only one, since I haven't r=
un
> > it through rev-list or the like=B8 probably.
>=20
> You fix is not that far off but to fix the second issue I had to do
> change the function responsible for expanding %(commit). Anyway,
> should be fixed in 0.16.1.

Unfortunately, this has introduced another (albeit minor) bug: it
breaks the tree view in some cases. For example:

git clone git://gitorious.org/taggrepper/taggrepper.git

and run tig there, and press `t'. It always gives me a blank tree.

The cause for this is that view->parent is null when the tree view
is invoked, but you merely pass !view->parent in the call to
format_argv in prepare_io.

A simple patch to fix this is attached below, but you might have other
ideas or I might have missed something, or not added sufficient checks
for the argv vector.

As always, if I have missed something above, please do let me know.

Thanks!

Kumar

=46rom 1295e58dbb3035bba3ebaf8686dc328b2b457ae2 Mon Sep 17 00:00:00 200=
1
=46rom: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Date: Sun, 19 Sep 2010 23:19:16 -0500
Subject: [PATCH] Add check to fix tree view

---
 tig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 7bc5daa..08042ec 100644
--- a/tig.c
+++ b/tig.c
@@ -3332,7 +3332,7 @@ static bool
 prepare_io(struct view *view, const char *dir, const char *argv[], boo=
l replace)
 {
 	view->dir =3D dir;
-	return format_argv(&view->argv, argv, replace, !view->parent);
+	return format_argv(&view->argv, argv, replace, !view->parent && strcm=
p(argv[1], "ls-tree"));
 }
=20
 static bool
--=20
1.7.1
