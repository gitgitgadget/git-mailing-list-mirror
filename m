From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/2] A loose object is not corrupt if it cannot be read
 due to EMFILE
Date: Thu, 18 Nov 2010 15:19:03 +0100
Message-ID: <AANLkTi=L1Z6kxubMf3yPUfpY9ugd+Qan+yCxi3dp4oR4@mail.gmail.com>
References: <1288299210-27092-1-git-send-email-gitster@pobox.com> <1288299210-27092-2-git-send-email-gitster@pobox.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 15:19:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ5Km-0006cN-ED
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 15:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab0KROT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Nov 2010 09:19:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54594 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab0KROT0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Nov 2010 09:19:26 -0500
Received: by fxm6 with SMTP id 6so1599212fxm.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=xAwn/VcRChInRZbpnueHkIAFUqzKyZTrreztNy4z63w=;
        b=aLn/rBNO87VqDbR384xaI8SFY1qRwy/F9WNdLsus9IB0z72sRlHgsY4aXPStJs1kIt
         INE0pkPLJ811mKJkcGcoLSR9d1sbYTfFqDUID0Q/Kkr9zkeaU5NV8qbTYkmGy6qEz2z4
         BvG1ioHCPS//i/fVTTDf2/TNBGxIB0FnbtEA0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=ARMh8jd7f6lZehJGi+D5Jdn9C3cVR6/w6Y/L2hufk9BAzQdoTYBxT3GPyGD6IyJSYf
         o59H56Q2eiSbFrZUpEekecrwDH/KMyH5YnnYAVXjXKDyujJY/MnKc4OxaDPN2tqXK7WA
         s9uh5y08MOiJXVqlqsUiR5fkATyUf3q7ZmWmg=
Received: by 10.223.107.16 with SMTP id z16mr629844fao.7.1290089964790; Thu,
 18 Nov 2010 06:19:24 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Thu, 18 Nov 2010 06:19:03 -0800 (PST)
In-Reply-To: <1288299210-27092-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161670>

On Thu, Oct 28, 2010 at 10:53 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> "git fsck" bails out with a claim that a loose object that cannot be
> read but exists on the filesystem to be corrupt, which is wrong when
> read_object() failed due to e.g. EMFILE.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> =A0sha1_file.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 5ed5497..f709ed6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2090,16 +2090,21 @@ void *read_sha1_file_repl(const unsigned char=
 *sha1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const unsigned cha=
r **replacement)
> =A0{
> =A0 =A0 =A0 =A0const unsigned char *repl =3D lookup_replace_object(sh=
a1);
> - =A0 =A0 =A0 void *data =3D read_object(repl, type, size);
> + =A0 =A0 =A0 void *data;
> =A0 =A0 =A0 =A0char *path;
> =A0 =A0 =A0 =A0const struct packed_git *p;
>
> + =A0 =A0 =A0 errno =3D 0;
> + =A0 =A0 =A0 data =3D read_object(repl, type, size);
> =A0 =A0 =A0 =A0if (data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (replacement)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*replacement =3D repl;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return data;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (errno !=3D ENOENT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("failed to read object %s", s=
ha1_to_hex(sha1));
> +
> =A0 =A0 =A0 =A0/* die if we replaced an object with one that does not=
 exist */
> =A0 =A0 =A0 =A0if (repl !=3D sha1)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("replacement %s not found for %s",
> --
> 1.7.3.2.191.g2d0e57
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

This patch seems to break clone/fetch on Windows:

$ GIT_TRACE=3D1 git clone http://github.com/kusma/rocket.git clone-test
trace: built-in: git 'clone' 'http://github.com/kusma/rocket.git' 'clon=
e-test'
Cloning into clone-test...
trace: run_command: 'git-remote-http' 'origin'
'http://github.com/kusma/rocket.git'
trace: run_command: 'fetch-pack' '--stateless-rpc' '--lock-pack'
'--thin' 'http://github.com/kusma/rocket.git/' 'refs/heads/master'
'refs/heads/work/icon' 'refs/heads/work/io-callback'
'refs/heads/work/sdl-example' 'refs/tags/v0.8'
trace: built-in: git 'fetch-pack' '--stateless-rpc' '--lock-pack'
'--thin' 'http://github.com/kusma/rocket.git/' 'refs/heads/master'
'refs/heads/work/icon' 'refs/heads/work/io-callback'
'refs/heads/work/sdl-example' 'refs/tags/v0.8'
fatal: failed to read object 7ea7cabd967429886c26e78b3ec573d54a95fa9d: =
No error
fatal: The remote end hung up unexpectedly

What happens, is that read_object returns NULL, but errno is 0.
=46urther, it looks to me like read_object can only return NULL through
the unpack_sha1_file (problem with the compressed data) or
read_packed_sha1 (find_pack_entry() failure) code-paths.

errno is set to ENOENT by open_sha1_file (through map_sha1_file)
before any possible error-points. I guess this makes the "errno =3D 0"
redundant, but I think it improves readability of the code. I'm
guessing that errno gets overwritten by some other call, losing the
ENOENT. Perhaps some unintended side-effect of one of the
compat/mingw.[ch]-wrappers?

I did find such a case, but fixing it doesn't do the trick for me:

---8<---
diff --git a/compat/mingw.c b/compat/mingw.c
index 29f4036..fdbf093 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -198,9 +198,10 @@ static inline time_t filetime_to_time_t(const FILE=
TIME *ft)
  */
 static int do_lstat(int follow, const char *file_name, struct stat *bu=
f)
 {
+	int err;
 	WIN32_FILE_ATTRIBUTE_DATA fdata;

-	if (!(errno =3D get_file_attr(file_name, &fdata))) {
+	if (!(err =3D get_file_attr(file_name, &fdata))) {
 		buf->st_ino =3D 0;
 		buf->st_gid =3D 0;
 		buf->st_uid =3D 0;
@@ -233,6 +234,7 @@ static int do_lstat(int follow, const char
*file_name, struct stat *buf)
 		}
 		return 0;
 	}
+	errno =3D err;
 	return -1;
 }

---8<---

The following patch makes clone complete again, but I doubt it's the
right solution. However, I'm out of ideas for now. Anyone? :)

diff --git a/sha1_file.c b/sha1_file.c
index 25f6965..9d4cb9c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2102,7 +2102,7 @@ void *read_sha1_file_repl(const unsigned char *sh=
a1,
 		return data;
 	}

-	if (errno !=3D ENOENT)
+	if (errno && errno !=3D ENOENT)
 		die_errno("failed to read object %s", sha1_to_hex(sha1));

 	/* die if we replaced an object with one that does not exist */
