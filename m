From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Mon, 17 Nov 2014 10:08:10 +0100
Message-ID: <5469BAFA.7070709@web.de>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu> <CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGE=?= =?UTF-8?B?dXNlbg==?= 
	<tboegi@web.de>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 17 10:09:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqIJA-0007p4-RR
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 10:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbaKQJJK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Nov 2014 04:09:10 -0500
Received: from mout.web.de ([212.227.15.14]:61967 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751768AbaKQJJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 04:09:09 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MCqmp-1XhjRv2Pqt-009hiS; Mon, 17 Nov 2014 10:09:00
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>
X-Provags-ID: V03:K0:YVJrnEfjNCzYWrJCQ0wdGpS+/bVIglZOwBCjzQiv7tlRbKlBWB6
 e5fj0QsOlurQCAMpeSOcJnCneOIHWoi9ZRK5C2NQYb80zD0e5ZC7ae1AsyublW3nnmyy8q1
 gIVL5+UPvrUVSzZ0AfhRjmA3Q4CNKXvRjZE0Y8Rco5ioK3uGDi8Rj9TxmSFSwitSMbhEar0
 AAU7apvSYjaqHlHNCfxbA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/17/2014 02:40 AM, Eric Sunshine wrote:
> On Sun, Nov 16, 2014 at 2:21 AM, Michael Haggerty <mhagger@alum.mit.e=
du> wrote:
>> Since time immemorial, the test of whether to set "core.filemode" ha=
s
>> been done by trying to toggle the u+x bit on $GIT_DIR/config and the=
n
>> testing whether the change "took". It is somewhat odd to use the
>> config file for this test, but whatever.
>>
>> The test code didn't set the u+x bit back to its original state
>> itself, instead relying on the subsequent call to git_config_set() t=
o
>> re-write the config file with correct permissions.
>>
>> But ever since
>>
>>      daa22c6f8d config: preserve config file permissions on edits (2=
014-05-06)
>>
>> git_config_set() copies the permissions from the old config file to
>> the new one. This is a good change in and of itself, but it interact=
s
>> badly with create_default_files()'s sloppiness, causing "git init" t=
o
>> leave the executable bit set on $GIT_DIR/config.
>>
>> So change create_default_files() to reset the permissions on
>> $GIT_DIR/config after its test.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
> Should this patch include a test in t1300 to ensure that this bug doe=
s
> not resurface (and to prove that this patch indeed fixes it)?
>
>>   builtin/init-db.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/builtin/init-db.c b/builtin/init-db.c
>> index 56f85e2..4c8021d 100644
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -255,6 +255,7 @@ static int create_default_files(const char *temp=
late_path)
>>                  filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &=
&
>>                                  !lstat(path, &st2) &&
>>                                  st1.st_mode !=3D st2.st_mode);
>> +               filemode &=3D !chmod(path, st1.st_mode);
>>          }
>>          git_config_set("core.filemode", filemode ? "true" : "false"=
);
>>
>> --
Sorry for the late reply, I actually had prepared a complete different =
patch
for a different problem, but it touches the very same lines of code.

(And we may want to add a
!chmod(path, st1.st_mode & ~S_IXUSR)
at the end of the operation)

There are systems when a file created with 666 have 766, and we
do not handle this situation yet.

Michael, if there is a chance that you integrate my small code changes=20
in your patch ?

-------------

commit 3228bedef6d45bfaf8986b6367f9388738476345
Author: Torsten B=C3=B6gershausen <tboegi@web.de>
Date:   Sun Oct 19 00:15:00 2014 +0200

     Improve the filemode trustability check

     Some file systems do not fully support the executable bit:
     a) The user executable bit is always 0
     b) The user executable bit is always 1
     c) Is similar to b):
        When a file is created with mode 0666 the file mode on disc is =
766
        and the user executable bit is 1 even if it should be 0 like b)

        There are smbfs implementations where the file mode can be=20
maintained
        locally and chmod -x changes the file mode from 0766 to 0666.
        When the file system is unmounted and remounted,
        the file mode is 0766 and executable bit is 1 again.

     A typical example for a) is a VFAT drive mounted with -onoexec,
     or cifs with -ofile_mode=3D0644.
     b) is VFAT mounted with -oexec or cifs is mounted with -ofile_mode=
=3D0755

     The behaviour described in c) has been observed when a Windows=20
machine with
     NTFS exports a share via smb (or afp) to Mac OS X.
     (CIFS is an enhanced version of SMB
      The command to mount on the command line may differ,
      e.g mount.cifs under Linux or mount_smbfs under Mac OS X)

     Case a) and b) are detected by the current code.
     Case c) qualifies as "non trustable executable bit",
     and core.filemode should be false by default.

     Solution:
     Detect when ".git/config" has the user executable bit set after
     creat(".git/config", 0666) and set core.filemode to false.

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 587a505..d3e4fb3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -249,13 +249,11 @@ static int create_default_files(const char=20
*template_path)
      strcpy(path + len, "config");

      /* Check filemode trustability */
-    filemode =3D TEST_FILEMODE;
-    if (TEST_FILEMODE && !lstat(path, &st1)) {
-        struct stat st2;
-        filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
-                !lstat(path, &st2) &&
-                st1.st_mode !=3D st2.st_mode);
-    }
+    filemode =3D TEST_FILEMODE &&
+        !lstat(path, &st1) &&    !(st1.st_mode & S_IXUSR) &&
+        !chmod(path, st1.st_mode | S_IXUSR) &&
+        !lstat(path, &st1) && (st1.st_mode & S_IXUSR);
+
      git_config_set("core.filemode", filemode ? "true" : "false");

      if (is_bare_repository())
