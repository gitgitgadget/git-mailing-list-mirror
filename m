From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Thu, 17 Jul 2014 19:05:41 +0200
Message-ID: <53C80265.5030903@web.de>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 19:06:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7p8A-0005o8-Ko
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 19:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbaGQRGC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 13:06:02 -0400
Received: from mout.web.de ([212.227.15.14]:60688 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbaGQRGA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 13:06:00 -0400
Received: from [192.168.178.27] ([79.250.176.74]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MOzrj-1XEAWH1ZAd-006QXJ; Thu, 17 Jul 2014 19:05:50
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:0iqnLjl3LvInvqJjkPbgifTVQaidiye8FIVYN6lUdVMFUH92pPR
 JQeKSbBPDpGrU8hCTwsUCH7DJi0pthiXLIKVRFWWycq4reFCjqYoQ0YX3s/dUvMUUjO4ySB
 gUQxYeL76TX2laFSxCLWxjQLQQMA4AOwlAgWLFAZBG3TcwflqafNbfm5zmfoXZfIEV9qXuR
 faQolgunQK1iIwJoA58hA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253760>

Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> This array 'cwd' is used to store the result from getcwd() and chdir(=
)
> back. PATH_MAX is the right constant for the job.

PATH_MAX may be better than 1024, but there can't really be a correct
constant.  The actual limit depends on the file system.

> On systems with
> longer PATH_MAX (eg. 4096 on Linux), hard coding 1024 fails stuff,
> e.g. "git init".=20

Out of curiosity, I just created a path with over 130000 characters on
Linux.  It's not actually usable but it shows that 4096 is not a real
limit on Linux.  Here's how I created that insane path:

	a=3D1234567890
	x=3D$a$a$a$a$a
	y=3D$x$x$x$x$x
	cd /tmp
	while true
	do
		mkdir $y || break
		cd $y || break
	done
	pwd >/tmp/y
	cd /tmp
	wc -c <y

Another experiment with the program listed below shows that getcwd() on
Linux works fine with such paths if the provided buffer is large
enough, even though PATH_MAX is 4096:

	#include <limits.h>
	#include <stdio.h>
	#include <string.h>
	#include <unistd.h>
	int main(int argc, char **argv)
	{
		char cwd[200000];
		printf("PATH_MAX =3D %d\n", PATH_MAX);
		if (getcwd(cwd, sizeof(cwd)))
			printf("strlen(getcwd()) =3D %zu\n", strlen(cwd));
		return 0;
	}

> Make it static too to reduce stack usage.

Why is that needed?  Is recursion involved?  (Didn't find any in the
function itself after a very brief look.)


There is get_current_dir_name(), a GNU extension that allocates the
necessary memory.  Perhaps we can use it instead and provide a
compatibility implementation based on getcwd() for platforms that don't
have it?

But then there's also this advice from the getcwd(3) manpage on OpenBSD=
:

"These routines have traditionally been used by programs to save the
name of a working directory for the purpose of returning to it. A much
faster and less error-prone method of accomplishing this is to open the
current directory (.) and use the fchdir(2) function to return."

So, how about something like this?

---
 abspath.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/abspath.c b/abspath.c
index ca33558..7fff13a 100644
--- a/abspath.c
+++ b/abspath.c
@@ -38,10 +38,10 @@ static const char *real_path_internal(const char *p=
ath, int die_on_error)
=20
 	/*
 	 * If we have to temporarily chdir(), store the original CWD
-	 * here so that we can chdir() back to it at the end of the
+	 * here so that we can fchdir() back to it at the end of the
 	 * function:
 	 */
-	char cwd[1024] =3D "";
+	int cwd_fd =3D -1;
=20
 	int buf_index =3D 1;
=20
@@ -80,7 +80,9 @@ static const char *real_path_internal(const char *pat=
h, int die_on_error)
 		}
=20
 		if (*buf) {
-			if (!*cwd && !getcwd(cwd, sizeof(cwd))) {
+			if (cwd_fd < 0)
+				cwd_fd =3D open(".", O_RDONLY);
+			if (cwd_fd < 0) {
 				if (die_on_error)
 					die_errno("Could not get current working directory");
 				else
@@ -142,8 +144,11 @@ static const char *real_path_internal(const char *=
path, int die_on_error)
 	retval =3D buf;
 error_out:
 	free(last_elem);
-	if (*cwd && chdir(cwd))
-		die_errno("Could not change back to '%s'", cwd);
+	if (cwd_fd >=3D 0) {
+		if (fchdir(cwd_fd))
+			die_errno("Could not change back to the original working directory"=
);
+		close(cwd_fd);
+	}
=20
 	return retval;
 }
--=20
2.0.2
