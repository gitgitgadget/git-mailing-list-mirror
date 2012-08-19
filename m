From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Sun, 19 Aug 2012 10:57:47 +0200
Message-ID: <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com> <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de> <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "'Shawn Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Aug 19 10:58:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T31L7-0006nj-SC
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 10:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab2HSI62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 04:58:28 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:65012 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511Ab2HSI6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 04:58:25 -0400
Received: from DualCore (dsdf-4db5d806.pool.mediaWays.net [77.181.216.6])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MVb0p-1TBajN1uAx-00Z3N2; Sun, 19 Aug 2012 10:58:02 +0200
In-Reply-To: <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7EfAdIAjkoB0Br5KJXuoL5A
Content-Language: de
X-Provags-ID: V02:K0:m7ys4UNJWruAYNw+9lqsjJULIrfkLsuQaAiuJkGXdP/
 54lv41krWgUpvoRXH5uvwp6hRjOkB6/U+0ODCz8aUApX3PrSmB
 EqinktVHpDeibNXR/mCFk6obIwjO2R+nj/JZ7bzIxCqhjSPace
 g1vjE/RzU13qiyNPb91pYKqnXe+vgxFX7m+z1gf0TGm0SEH0sA
 Q2abP/By/ZXdyf1cjQKXoqNb1Mj8WHZFppFDd0B6E7vbEUzkR9
 zmewurW2JXskYA6Wq3YZAIt/4/pdJUUsXNxg03i211O0T57oYr
 rKzPDWXqhMPfnM1XYrW72geSvbnk2Uhfav//x+4BCtdi1ti6Z7
 GlSdo8hN6tkK4tym9zgPu0D0zD/vYb0Mp0bhZ7VZ29+3ki4rmH
 XsBKVyxfK55tg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203714>

> From: Shawn Pearce [mailto:spearce@spearce.org]
> Sent: Friday, August 10, 2012 7:38 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> On Fri, Aug 10, 2012 at 10:32 AM, Joachim Schmitz
<jojo@schmitz-digital.de>
> wrote:
> >> then use `git init --bare` in a new directory to copy in the
> >> templates,
> > and see if
> >> its the template copying code that is making an incorrect copy.
> >
> > "git init --bare" gives the same error. It isn't copying any of the
> > subdirectories, only the file 'description'
> 
> Time to start debugging copy_templates_1 in builtin/init-db.c. :-(

Found the problem: our mkdir(dir,flags) fails with ENOENT when dir ends with
a '/'.
Not sure whether this us a bug on out platform or just allowed by POSIX and
as such a wrong assumption in git though?

[shortly after]
A bit of googleing revealed that there is a GNUlib solution for this, which
claims that at least NetBSD 1.5.2 has the same problem.
(http://www.opensource.apple.com/source/gpatch/gpatch-2/patch/mkdir.c)

And apparently this has been discussed on the git mailing list too, 2 years
ago:
http://lists-archives.com/git/728359-git-s-use-of-mkdir-2.html, there's a
patch too.

For now I've fixed it like this:
/usr/local/bin/diff -EBbu ./builtin/init-db.c.orig ./builtin/init-db.c
--- ./builtin/init-db.c.orig    2012-08-19 03:55:50 -0500
+++ ./builtin/init-db.c 2012-08-19 03:39:57 -0500
@@ -25,7 +25,16 @@

 static void safe_create_dir(const char *dir, int share)
 {
+#ifdef __TANDEM /* our mkdir() can't cope with a trailing '/' */
+       char mydir[PATH_MAX];
+
+       strcpy(mydir,dir);
+       if (dir[strlen(dir)-1] == '/')
+               mydir[strlen(dir)-1] = '\0';
+       if (mkdir(mydir, 0777) < 0) {
+#else
        if (mkdir(dir, 0777) < 0) {
+#endif
                if (errno != EEXIST) {
                        perror(dir);
                        exit(1);



Bye, Jojo 
