From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Subject: [PATCH] fix stg edit command
Date: Tue, 12 Feb 2008 23:05:05 +0100
Message-ID: <200802122305.05696.kumbayo84@arcor.de>
References: <20080210203846.17683.43153.stgit@yoghurt> <20080210204359.17683.41935.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP3GD-0003Y6-TX
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 23:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756505AbYBLWE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 17:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756449AbYBLWEz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 17:04:55 -0500
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:50634 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756338AbYBLWEw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 17:04:52 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id F24B718771D;
	Tue, 12 Feb 2008 23:04:50 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id D74D12D37E7;
	Tue, 12 Feb 2008 23:04:50 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id 7F4E48C466;
	Tue, 12 Feb 2008 23:04:50 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080210204359.17683.41935.stgit@yoghurt>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92/5793/Tue Feb 12 21:01:20 2008 on mail-in-12.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73702>

The comparison of two Commitdata objects returned False.
Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---

On Sonntag 10 Februar 2008, Karl Hasselstr=C3=B6m wrote:
> This refactoring is specific to the new infrastructure, so only new
> and edit use it currently, but other commands can start using it as
> they are converted.
>=20
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

While testing my editor searching ordering patch i found that
this patch(Refactor --author/--committer options) seems to break
"stg edit" (without arguments) starting a interactive editor for me.
When i issue "stg edit" it silently does nothing.

It seems the following comparison does not return True

># Let user edit the patch manually.
>if cd =3D=3D orig_cd or options.edit:

I can work around this by adding a comparison function to Commitdata
but maybe __eq__ or __ne__ should be used instead(prevent similar bugs =
caused
by =3D=3D comparison)?
I would guess the initial cause for this is that the following line whi=
ch unconditionally replaces cd.

> -    # Specify author and committer data.
> -    if options.author !=3D None:
> -        options.authname, options.authemail =3D common.name_email(op=
tions.author)
> -    for p, f, val in [('author', 'name', options.authname),
> -                      ('author', 'email', options.authemail),
> -                      ('author', 'date', gitlib.Date.maybe(options.a=
uthdate)),
> -                      ('committer', 'name', options.commname),
> -                      ('committer', 'email', options.commemail)]:
> -        if val !=3D None:
> -            cd =3D getattr(cd, 'set_' + p)(
> -                getattr(getattr(cd, p), 'set_' + f)(val))
> +    # Modify author and committer data.
> +    cd =3D (cd.set_author(options.author(cd.author))
> +            .set_committer(options.committer(cd.committer)))

So another way to fix this might be, to not overwrite cd unconditionall=
y.

Greetings Peter

 stgit/commands/edit.py |    2 +-
 stgit/lib/git.py       |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index 037425b..9439fb6 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -146,7 +146,7 @@ def func(parser, options, args):
         return utils.STGIT_SUCCESS
=20
     # Let user edit the patch manually.
-    if cd =3D=3D orig_cd or options.edit:
+    if cd.is_same(orig_cd) or options.edit:
         fn =3D '.stgit-edit.' + ['txt', 'patch'][bool(options.diff)]
         cd, failed_diff =3D update_patch_description(
             stack.repository, cd, utils.edit_string(
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6ee8a71..b62d14c 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -202,6 +202,14 @@ class Commitdata(Repr):
         return ('Commitdata<tree: %s, parents: %s, author: %s,'
                 ' committer: %s, message: "%s">'
                 ) % (tree, parents, self.author, self.committer, self.=
message)
+
+    def is_same(self, other):
+        return (self.__tree =3D=3D other.__tree and
+                self.__parents =3D=3D other.__parents and
+                self.__author =3D=3D other.__author and
+                self.__committer =3D=3D other.__committer and
+                self.__message =3D=3D other.__message)
+
     @classmethod
     def parse(cls, repository, s):
         cd =3D cls()
--=20
1.5.4.rc3
