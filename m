From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Allow git mv FileA fILEa when core.ignorecase = true
Date: Wed, 16 Mar 2011 14:05:04 +0100
Message-ID: <AANLkTin2s_=TVaKx6yv+nDvXB41BxebWHX4iaDYSGd-e@mail.gmail.com>
References: <201103042240.38969.tboegi@web.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 14:21:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzqf7-0008GF-ML
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 14:21:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1CPNVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 09:21:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58356 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1CPNVM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 09:21:12 -0400
Received: by fxm17 with SMTP id 17so1636738fxm.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RSpxjbl2lpNTAZP+NKwk852M2uU4TLE6Ps5EKUovmR0=;
        b=uxPpk0u0HnPd57aaVmTjk4E7o6UZpcPINeyq+4mIhKdlfHkqvjwVFakZG46Uez7eXR
         KS3TDHjHSJcHc9Lxy07nnPMi2rANMFPGIHxTF7hs2EK10WzWBW+w/tUY5O3PejMVdI2Y
         QBPAe5kEej68ZcOpqym0wND1V8vkCA6o93sac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ioE385vt48u9GjSK97f2YJJaj42/lut2dYzg6XlLcqiRDbaaC1NLcsltPa972fdYWc
         vmQ/lhytJ4CW9fW5mTKUVuh69dxTYEIRJEcrPAWDhX5jmyr5DcSRlNSDpwt9aCCUd2bS
         a82OR4c981u494TEZtMHEHLsTpNPeEvWennoA=
Received: by 10.223.143.75 with SMTP id t11mr921992fau.49.1300281098168; Wed,
 16 Mar 2011 06:11:38 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Wed, 16 Mar 2011 06:05:04 -0700 (PDT)
In-Reply-To: <201103042240.38969.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169151>

2011/3/4 Torsten B=F6gershausen <tboegi@web.de>:
> =A0 =A0The typical use case is when a file "FileA" should be renamed =
into fILEa
> =A0 =A0and we are on a case insenstive file system (system core.ignor=
ecase =3D true).
> =A0 =A0Source and destination are the same file, it can be accessed u=
nder both names.
> =A0 =A0This makes git think that the destination file exists.
> =A0 =A0Unless used with --forced, git will refuse the "git mv FileA f=
ILEa".
> =A0 =A0This change will allow "git mv FileA fILEa", when core.ignorec=
ase =3D true
> =A0 =A0and source and destination filenames only differ in case and t=
he file length
> =A0 =A0is identical.
> =A0 =A0On Linux/Unix/Mac OS X the mv is allowed when the inode of the=
 source and
> =A0 =A0destination are equal.
> =A0 =A0On =A0this allows renames of M=C4RCHEN into M=E4rchen on Mac O=
S X.
> =A0 =A0(As a side effect, a file can be renamed to a name which is al=
ready
> =A0 =A0hard-linked to the same inode)
>
> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
> ---
> =A0builtin/mv.c =A0| =A0 20 +++++++++++++++-----
> =A0t/t7001-mv.sh | =A0 29 +++++++++++++++++++++++++++++
> =A02 files changed, 44 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 93e8995..e0aad62 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -62,7 +62,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
> =A0 =A0 =A0 =A0};
> =A0 =A0 =A0 =A0const char **source, **destination, **dest_path;
> =A0 =A0 =A0 =A0enum update_mode { BOTH =3D 0, WORKING_DIRECTORY, INDE=
X } *modes;
> - =A0 =A0 =A0 struct stat st;
> + =A0 =A0 =A0 struct stat st, st_dst;
> =A0 =A0 =A0 =A0struct string_list src_for_dst =3D STRING_LIST_INIT_NO=
DUP;
>
> =A0 =A0 =A0 =A0git_config(git_default_config, NULL);
> @@ -164,15 +164,25 @@ int cmd_mv(int argc, const char **argv, const c=
har *prefix)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (cache_name_pos(src, length)=
 < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bad =3D "not under ver=
sion control";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lstat(dst, &st) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (lstat(dst, &st_dst) =3D=3D 0) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int allow_force =3D for=
ce;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bad =3D "destination e=
xists";
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (force) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Allow when src and d=
st have the same inode (Mac OS X) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Allow when ignore_ca=
se and same file length (Windows) */

Wait, what? Same file length is sufficient to trigger overwriting
without -f? I find this to be a very dubious heuristic...

Shouldn't you be checking something like nFileIndexLow/High from
BY_HANDLE_FILE_INFORMATION instead? (ref:
http://msdn.microsoft.com/en-us/library/aa363788(v=3DVS.85).aspx)

Sure, we'd need some API to check that, but if we assume that this
code path is rare-ish we could do something like this (note,
untested):

diff --git a/compat/mingw.c b/compat/mingw.c
index 6750e67..fee4113 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -299,6 +299,21 @@ void mingw_mark_as_git_dir(const char *dir)
 		 "dotGitOnly" : "true"));
 }

+int is_same_file(const char *a, const char *b)
+{
+	BY_HANDLE_FILE_INFORMATION hia, hib;
+	HANDLE ha =3D OpenFileA(a, NULL, OF_READ),
+	       hb =3D OpenFileA(b, NULL, OF_READ);
+	if (!ha || !hb ||
+	    !GetFileInformationByHandle(ha) ||
+	    !GetFileInformationByHandle(hb))
+		return 0;
+
+	return hia.dwVolumeSerialNumber =3D=3D hib.dwVolumeSerialNumber &&
+	    hia.nFileSizeLow =3D=3D hib.nFileSizeLow &&
+	    hia.nFileSizeHigh =3D=3D hib.nFileSizeHigh;
+}
+
 #undef mkdir
 int mingw_mkdir(const char *path, int mode)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 9c00e75..43c0b5f 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -297,6 +297,9 @@ void mingw_open_html(const char *path);
 void mingw_mark_as_git_dir(const char *dir);
 #define mark_as_git_dir mingw_mark_as_git_dir

+int mingw_is_same_file(const char *a, const char *b);
+#define is_same_file mingw_is_same_file
+
 /*
  * helpers
  */
diff --git a/git-compat-util.h b/git-compat-util.h
index 2ca2fad..b95b9e2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -558,6 +558,17 @@ int remove_or_warn(unsigned int mode, const char *=
path);
 #define mark_as_git_dir(x) /* noop */
 #endif

+#ifndef is_same_file
+static inline int mingw_is_same_file(const char *a, const char *b)
+{
+	struct stat sta, stb;
+	if (lstat(a, &sta) ||
+	    lstat(b, &stb))
+		return 0;
+	return sta.st_dev =3D=3D stb.st_deb && sta.st_ino =3D=3D stb.st_ino;
+}
+#endif
+
 #ifndef get_home_directory
 #define get_home_directory() getenv("HOME")
 #endif
