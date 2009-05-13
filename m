From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Cross-Platform Version Control
Date: Wed, 13 May 2009 10:12:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905130951100.3343@localhost.localdomain>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <20090512151403.GS30527@spearce.org> <20090512161638.GB29566@coredump.intra.peff.net> <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 13 19:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4I3f-0005vx-DC
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 19:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760402AbZEMRPn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 13:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760151AbZEMRPm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 13:15:42 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53528 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755758AbZEMRPk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 13:15:40 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DHCkdL023673
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 13 May 2009 10:13:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4DHCjbj029894;
	Wed, 13 May 2009 10:12:46 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0905130915540.3343@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119070>



On Wed, 13 May 2009, Linus Torvalds wrote:
>=20
> utf-8 normalization was one goal, and shouldn't be _that_ hard to do.=
 But=20
> quite frankly, the index is only part of it, and probably not the wor=
st=20
> part.
>=20
> The real pain of filename handling is all the "read tree recursively =
with=20
> readdir()" issues. Along with just an absolute sh*t-load of issues ab=
out=20
> what to do when people ended up using different versions of the "same=
"=20
> name in different branches.

Btw, if people care mainly just about OS X, and don't worry so much abo=
ut=20
case, but about the idiotic and insane OS X behavior of turning UTF-8=20
filenames into that crazy NFD format, here's a simple patch that may be=
=20
useful for that.

There _will_ certainly be other places, but this handles the one big ca=
se=20
of "read_directory_recursive()", and can turn NFD into the sane NFC=20
format.

Since OS X will then accept NFC (and internally turn it back to NFD) wh=
en=20
you pass them as filenames, that means that converting the other way is=
=20
not necessary.

NOTE NOTE NOTE! This really just handles one case, and is not enough fo=
r=20
any kind of general case. For example, it does NOT handle the case wher=
e=20
you do

	git add filename_with_=E5=E4=F6

explicitly, because if the "filename_with_=E5=E4=F6" is done using NFD=20
(tab-completion etc), now git won't _match_ it with the filename it rea=
ds=20
using readdir() any more (which got converted to NFC), so at a minimum=20
we'd need to do that crazy NFD->NFC conversion in all the pathspecs too=
=2E=20

See "get_pathspec()" in setup.c for that latter case.

But with that, and this crazy thing, OS X users might be already a lot=20
better off. Totally untested, of course.=20

Oh, and somebody needs to fill in that=20

	convert_name_from_nfd_to_nfc()

implementation. It's designed so that if it notices that the string is=20
just plain US-ASCII, it can return 0 and no extra work is done. That, i=
n=20
turn, can easily be done by some simple and efficient pre-processign th=
at=20
checks that there are no high bits set (on a 64-bit platform, do it 8=20
characters at a time with a "& 0x8080808080808080"), so that the common=
=20
case doesn't need to have barely any overhead at all.

Use <stringprep.h> and stringprep_utf8_nfkc_normalize() or something to=
 do=20
the actual normalization if you find characters with the high bit set. =
And=20
since I know that the OS X filesystems are so buggy as to not even do t=
hat=20
whole NFD thing right, there is probably some OS-X specific "use this f=
or=20
filesystem names" conversion function.

Hmm. Anybody want to take this on? It really shouldn't be too complex t=
o=20
get it working for the common case on just OS X. It's really the case=20
sensitivity that is the biggest problem, if you ignore that for now, th=
e=20
problem space is _much_ smaller.

In other words, I think we can reasonably easily support a subset of=20
_common_ issues with some trivial patches like this. But getting it rig=
ht=20
in _all_ the cases is going to be much more work (there are lots of oth=
er=20
uses of "readdir()" too, this one just happens to be one of the more=20
central ones).

Of course, it probably makes sense to have a whole "git_readdir()" that=
=20
does this thing in general. That "create_full_path()" thing makes sense=
=20
regardless, though, in that it also simplifies a lot of "baselen+len"=20
usage in just "len".

		Linus

---
 dir.c |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/dir.c b/dir.c
index 6aae09a..4cbfc24 100644
--- a/dir.c
+++ b/dir.c
@@ -566,6 +566,30 @@ static int get_dtype(struct dirent *de, const char=
 *path)
 }
=20
 /*
+ * Take the readdir output, in (d_name,len), and append it to
+ * our base name in (fullname,baselen) with any required
+ * readdir fs->internal translation.
+ *
+ * Put the result in 'fullname', and return the final length.
+ *
+ * Right now we have no translation, and just do a memcpy()
+ * (the +1 is to copy the final NUL character too).
+ */
+static int create_full_path(char *fullname, int baselen, const char *d=
_name, int len)
+{
+#ifdef OS_X_IS_SOME_CRAZY_SHxAT
+	char temp[256], nlen;
+	nlen =3D convert_name_from_nfd_to_nfc(d_name, len, temp, sizeof(temp)=
);
+	if (nlen) {
+		len =3D nlen;
+		d_name =3D temp;
+	}
+#endif
+	memcpy(fullname + baselen, d_name, len + 1);
+	return baselen + len;
+}
+
+/*
  * Read a directory tree. We currently ignore anything but
  * directories, regular files and symlinks. That's because git
  * doesn't handle them at all yet. Maybe that will change some
@@ -595,15 +619,15 @@ static int read_directory_recursive(struct dir_st=
ruct *dir, const char *path, co
 			/* Ignore overly long pathnames! */
 			if (len + baselen + 8 > sizeof(fullname))
 				continue;
-			memcpy(fullname + baselen, de->d_name, len+1);
-			if (simplify_away(fullname, baselen + len, simplify))
+			len =3D create_full_path(fullname, baselen, de->d_name, len);
+			if (simplify_away(fullname, len, simplify))
 				continue;
=20
 			dtype =3D DTYPE(de);
 			exclude =3D excluded(dir, fullname, &dtype);
 			if (exclude && (dir->flags & DIR_COLLECT_IGNORED)
-			    && in_pathspec(fullname, baselen + len, simplify))
-				dir_add_ignored(dir, fullname, baselen + len);
+			    && in_pathspec(fullname, len, simplify))
+				dir_add_ignored(dir, fullname, len);
=20
 			/*
 			 * Excluded? If we don't explicitly want to show
@@ -630,9 +654,9 @@ static int read_directory_recursive(struct dir_stru=
ct *dir, const char *path, co
 			default:
 				continue;
 			case DT_DIR:
-				memcpy(fullname + baselen + len, "/", 2);
+				memcpy(fullname + len, "/", 2);
 				len++;
-				switch (treat_directory(dir, fullname, baselen + len, simplify)) {
+				switch (treat_directory(dir, fullname, len, simplify)) {
 				case show_directory:
 					if (exclude !=3D !!(dir->flags
 							& DIR_SHOW_IGNORED))
@@ -640,7 +664,7 @@ static int read_directory_recursive(struct dir_stru=
ct *dir, const char *path, co
 					break;
 				case recurse_into_directory:
 					contents +=3D read_directory_recursive(dir,
-						fullname, fullname, baselen + len, 0, simplify);
+						fullname, fullname, len, 0, simplify);
 					continue;
 				case ignore_directory:
 					continue;
@@ -654,7 +678,7 @@ static int read_directory_recursive(struct dir_stru=
ct *dir, const char *path, co
 			if (check_only)
 				goto exit_early;
 			else
-				dir_add_name(dir, fullname, baselen + len);
+				dir_add_name(dir, fullname, len);
 		}
 exit_early:
 		closedir(fdir);
