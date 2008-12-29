From: "Hannes Eder" <hannes@hanneseder.net>
Subject: Re: [STGIT][PATCH] new: translate non word characters in patch name to '-'
Date: Mon, 29 Dec 2008 21:15:44 +0100
Message-ID: <154e089b0812291215h72dfe04aod080f665eb7f5592@mail.gmail.com>
References: <49562413.0437560a.287d.5133@mx.google.com>
	 <20081228204938.GA13143@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 21:17:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHOY3-0003ox-7G
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 21:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbYL2UPs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Dec 2008 15:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752396AbYL2UPs
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 15:15:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:23187 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752354AbYL2UPr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 15:15:47 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1788176fgg.17
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 12:15:45 -0800 (PST)
Received: by 10.86.84.18 with SMTP id h18mr8320692fgb.69.1230581744848;
        Mon, 29 Dec 2008 12:15:44 -0800 (PST)
Received: by 10.86.84.16 with HTTP; Mon, 29 Dec 2008 12:15:44 -0800 (PST)
In-Reply-To: <20081228204938.GA13143@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104124>

On 12/28/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2008-12-27 13:37:20 +0100, Hannes Eder wrote:
>
>  > This allows following usage:
>  >
>  > $ stg new full/path/file-fix-foobar
>  > Now at patch "full-path-file-fix-foobar"
>  >
>  > Signed-off-by: Hannes Eder <hannes@hanneseder.net>
>  > ---
>  >
>  > I ran into as a '/' in a patch messed up stgit.
>  >
>  > I find this useful as 'stg uncommit' does the same translation.
>
>
> Clearly, bad path names shouldn't mess anything up -- see
>
>   https://gna.org/bugs/?10919
>
>  But I would prefer "stg new" to quit with an error message when give=
n
>  an illegal patch name, not silently mangle it. (Of course, the
>  commands that generate patch names from commit messages -- such as
>  "stg new" when not given an explicit patch name -- should mangle the
>  commit message as much as necessary. But when the user gives us a
>  patch name, we should either use that as is or fail with an
>  informative message.)
>
>  I think the right thing to do would be to construct a function that
>  validates patch names (I don't think we have one right now), and the=
n
>  call it whenever we need to check if a patch name is OK. Such as whe=
n
>  the user gives us the name of a new patch. And when we've
>  auto-generated a patch name from a commit message, we should probabl=
y
>  assert that that the check function is OK with the name.

What about instead of 'fail with an informative message', just issue a
warning that
the name has been mangled. I use pathnames in patch names frequently,
so this would be very handy.
I guess some with with more python skills needs to clean that up, this
is the first stuff I do in python ;).

---

diff --git a/stgit/commands/new.py b/stgit/commands/new.py
index 151cfe9..ed5c9ce 100644
--- a/stgit/commands/new.py
+++ b/stgit/commands/new.py
@@ -58,7 +58,7 @@ def func(parser, options, args):
     if len(args) =3D=3D 0:
         name =3D None
     elif len(args) =3D=3D 1:
-        name =3D args[0]
+        name =3D utils.sanitize_patch_name(args[0])
         if stack.patches.exists(name):
             raise common.CmdException('%s: patch already exists' % nam=
e)
     else:
diff --git a/stgit/commands/rename.py b/stgit/commands/rename.py
index 8a593ac..455b67e 100644
--- a/stgit/commands/rename.py
+++ b/stgit/commands/rename.py
@@ -50,6 +50,8 @@ def func(parser, options, args):
         old, [new] =3D crt, args
     else:
         parser.error('incorrect number of arguments')
+
+    new =3D utils.sanitize_patch_name(new)

     out.start('Renaming patch "%s" to "%s"' % (old, new))
     crt_series.rename_patch(old, new)
diff --git a/stgit/utils.py b/stgit/utils.py
index 81035a5..8ffe5a3 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -231,6 +231,31 @@ def make_patch_name(msg, unacceptable,
default_name =3D 'patch'):
         patchname =3D default_name
     return find_patch_name(patchname, unacceptable)

+class PatchNameException(StgException):
+    pass
+
+def sanitize_patch_name(patchname):
+    # '..' is for patch ranges only, so it is not allowed here
+    if patchname.find('..') !=3D -1:
+         raise PatchNameException('Patch name must not contain "..".')
+
+    # if patch name contains non word characters, replace them but war=
n user
+    # about that
+    if re.search('\W', patchname):
+        out.warn('replacing non word characters in patch name');
+        patchname =3D re.sub('[\W]+', '-', patchname).strip('-')
+
+    # limit patch name length
+    name_len =3D config.get('stgit.namelength')
+    if not name_len:
+        name_len =3D 30
+
+    if len(patchname) > name_len:
+        out.warn('truncating the patch name to %d characters' % name_l=
en)
+        patchname =3D patchname[:name_len]
+
+    return patchname
+
 # any and all functions are builtin in Python 2.5 and higher, but not
 # in 2.4.
 if not 'any' in dir(__builtins__):
