From: Peter Oberndorfer <kumbayo84@arcor.de>
Subject: Re: [StGit PATCH 4/5] Simplify editor selection logic
Date: Tue, 29 Jan 2008 21:09:37 +0100
Message-ID: <200801292109.37785.kumbayo84@arcor.de>
References: <20080129030059.926.29897.stgit@yoghurt> <20080129030349.926.45486.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 21:10:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJwmp-00044j-11
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 21:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYA2UJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2008 15:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbYA2UJy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 15:09:54 -0500
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:58856 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbYA2UJw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 15:09:52 -0500
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-17.arcor-online.net (Postfix) with ESMTP id 01D2C30E8D7;
	Tue, 29 Jan 2008 21:09:51 +0100 (CET)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 9CC06ABF3B;
	Tue, 29 Jan 2008 21:09:50 +0100 (CET)
Received: from fnoheim52.netpark.at (fnoheim52.netpark.at [83.68.151.52])
	(Authenticated sender: kumbayo84@arcor.de)
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 611991BF3DB;
	Tue, 29 Jan 2008 21:09:50 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20080129030349.926.45486.stgit@yoghurt>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92/5599/Tue Jan 29 17:27:10 2008 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71993>

Subject: [PATCH] use the same search order for picking a editor as git

Signed-off-by: Peter Oberndorfer <kumbayo84@arcor.de>
---
On Dienstag 29 Januar 2008, Karl Hasselstr=C3=B6m wrote:
> Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>=20
> ---
>=20
> There are a few other env variables we might like to look at, like
> VISUAL. And isn't there a git-specific variable too?
>=20
>  stgit/utils.py |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
>=20
>=20
> diff --git a/stgit/utils.py b/stgit/utils.py
> index 00776b0..43366c9 100644
> --- a/stgit/utils.py
> +++ b/stgit/utils.py
> @@ -175,12 +175,8 @@ def call_editor(filename):
> =20
>      # the editor
>      editor =3D config.get('stgit.editor')
> -    if editor:
> -        pass
> -    elif 'EDITOR' in os.environ:
> -        editor =3D os.environ['EDITOR']
> -    else:
> -        editor =3D 'vi'
> +    if not editor:
> +        editor =3D os.environ.get('EDITOR', 'vi')
>      editor +=3D ' %s' % filename
> =20
>      out.start('Invoking the editor: "%s"' % editor)

Since i personally dislike having a separate config for the editor in g=
it/stgit
i locally use this patch.
unfortunately it makes the whole editor searching thing more complex :-=
(
But i am sure it is possible to rewrite the code to something easier
with some more python knowledge :-/
So it is not meant for direct applying, just for discussion...

TODO: update sample gitconfig?
TODO: do the same for pager?

 Documentation/stg-new.txt |    6 ++++++
 stgit/utils.py            |   10 +++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/stg-new.txt b/Documentation/stg-new.txt
index fbf2f67..a728d8e 100644
--- a/Documentation/stg-new.txt
+++ b/Documentation/stg-new.txt
@@ -31,7 +31,10 @@ the patch, unless the '--message' flag already speci=
fied one.  The
 editor.  The editor to use is taken from the first of the following
 sources of information, and defaults to 'vi':
=20
+. the 'GIT_EDITOR' environment variable
 . the 'stgit.editor' GIT configuration variable
+. the 'core.editor' GIT configuration variable
+. the 'VISUAL' environment variable
 . the 'EDITOR' environment variable
=20
 The message and other GIT commit attributes can be modified later
@@ -101,13 +104,16 @@ ENVIRONMENT VARIABLES
 	GIT_AUTHOR_DATE
 	GIT_COMMITTER_NAME
 	GIT_COMMITTER_EMAIL
+	GIT_EDITOR
 	EDITOR
+	VISUAL
=20
 GIT CONFIGURATION VARIABLES
 ---------------------------
=20
 	user.name
 	user.email
+	core.editor
 	stgit.editor
=20
 StGIT
diff --git a/stgit/utils.py b/stgit/utils.py
index 2ff1d74..6b1d196 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -174,9 +174,17 @@ def call_editor(filename):
     """Run the editor on the specified filename."""
=20
     # the editor
-    editor =3D config.get('stgit.editor')
+    editor =3D None
+    if 'GIT_EDITOR' in os.environ:
+        editor =3D os.environ['GIT_EDITOR']
+    if not editor:
+        editor =3D config.get('stgit.editor')
+    if not editor:
+        editor =3D config.get('core.editor')
     if editor:
         pass
+    elif 'VISUAL' in os.environ:
+        editor =3D os.environ['VISUAL']
     elif 'EDITOR' in os.environ:
         editor =3D os.environ['EDITOR']
     else:
--=20
1.5.4.rc3
