From: =?UTF-8?Q?Mikl=C3=B3s_Fazekas?= <mfazekas@szemafor.com>
Subject: Re: [PATCH] git p4: chdir resolves symlinks only for relative paths
Date: Thu, 7 Mar 2013 09:36:06 +0100
Message-ID: <CAAMmcSQszVbDERd964VLu1d4UG7SihC+Pn99D0gPvG7HAZp2UQ@mail.gmail.com>
References: <CAAMmcSSvrsZqEVf68Nrqy_ZG6r5ESKhtx7JdQ7vzypkZ3gOFnA@mail.gmail.com>
	<CAAMmcSSEzs3+vZDO=FDMV9c2rp-8HTdMuPeeQCkok6y7sRDYJw@mail.gmail.com>
	<20130203230803.GA25555@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 09:36:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDWJY-00009X-Oc
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 09:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab3CGIgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 03:36:09 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:59578 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794Ab3CGIgI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 03:36:08 -0500
Received: by mail-wg0-f48.google.com with SMTP id 16so241881wgi.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 00:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=tMTw2Z57X4DjNH5TZqVE+2R9gRxjhB4+UMLWUtHKXsk=;
        b=MlkUE6MgPh2nFexE8xXtjP50Xyipe+9CNTIBbmxKlFqx88NSV76DK7hG9Aoc2pFmpZ
         xwDhg5ebjOKpkaOEX9YRAUzwyaSj3c9CUXwT69uZ0AacWq4sbfVytjFGBMb4dIshASnk
         kOn8FtoZ5rDmPmvEZhtNaZZjqjWX5KPBTINJ4T+c0v2th6vbD+JU6F+3LrahVRYALhMu
         4sknTRIO8q49ORbauROb2CzW/Fatalq6mLGy39AEDqGrXmE22VHofeigJPk/pp4Uwf2q
         WYvOTsDFodd4b02bPOHEd+Ezg7D8MhlKxOUTkxj+x8SU1jwasv3DtxZpsjn2JAt5vjlf
         KVug==
X-Received: by 10.194.242.163 with SMTP id wr3mr52189996wjc.35.1362645366531;
 Thu, 07 Mar 2013 00:36:06 -0800 (PST)
Received: by 10.194.151.167 with HTTP; Thu, 7 Mar 2013 00:36:06 -0800 (PST)
In-Reply-To: <20130203230803.GA25555@padd.com>
X-Gm-Message-State: ALoCoQnmQ+NrD94mEr5WHzQd2tNbdp7uxeeg13/vH3FLmNP4GfeQTqu1Vv/VXH8N00oFQdGLdrBv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217579>

Sorry for the late turnaround here is an improved version. Now chdir
has an optional argument client_path, if it's true then we don't do
os.getcwd. I think that my first patch is also valid too - when the
path is absolute no need for getcwd no matter what is the context,
when it's relative we have to use os.getcwd() no matter of the
context.

---
If p4 client is configured to /p/foo which is a symlink:
/p/foo -> /vol/barvol/projects/foo.  Then resolving the
symlink will confuse p4:
"Path /vol/barvol/projects/foo/... is not under client root
/p/foo". While AltRoots in p4 client specification can be
used as a workaround on p4 side, git-p4 should not resolve
symlinks in client paths.
chdir(dir) uses os.getcwd() after os.chdir(dir) to resolve
relative paths, but as a sideeffect it resolves symlinks
too. Now for client paths we don't call os.getcwd().

Signed-off-by: Mikl=C3=B3s Fazekas <mfazekas@szemafor.com>
---
 git-p4.py |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0682e61..2bd8cc2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -68,12 +68,17 @@ def p4_build_cmd(cmd):
         real_cmd +=3D cmd
     return real_cmd

-def chdir(dir):
+def chdir(dir,client_path=3DFalse):
     # P4 uses the PWD environment variable rather than getcwd(). Since=
 we're
     # not using the shell, we have to set it ourselves.  This path cou=
ld
     # be relative, so go there first, then figure out where we ended u=
p.
+    # os.getcwd() will resolve symlinks, so we should avoid it for
+    # client_paths.
     os.chdir(dir)
-    os.environ['PWD'] =3D os.getcwd()
+    if client_path:
+        os.environ['PWD'] =3D dir
+    else:
+               os.environ['PWD'] =3D os.getcwd()

 def die(msg):
     if verbose:
@@ -1554,7 +1559,7 @@ class P4Submit(Command, P4UserMap):
             new_client_dir =3D True
             os.makedirs(self.clientPath)

-        chdir(self.clientPath)
+        chdir(self.clientPath,client_path=3DTrue)
         if self.dry_run:
             print "Would synchronize p4 checkout in %s" % self.clientP=
ath
         else:
--=20
1.7.10.2 (Apple Git-33)


On Mon, Feb 4, 2013 at 12:08 AM, Pete Wyckoff <pw@padd.com> wrote:
> mfazekas@szemafor.com wrote on Tue, 29 Jan 2013 09:37 +0100:
>> If a p4 client is configured to /p/foo which is a symlink
>> to /vol/bar/projects/foo, then resolving symlink, which
>> is done by git-p4's chdir will confuse p4: "Path
>> /vol/bar/projects/foo/... is not under client root /p/foo"
>> While AltRoots in p4 client specification can be used as a
>> workaround on p4 side, git-p4 should not resolve symlinks
>> in client paths.
>> chdir(dir) uses os.getcwd() after os.chdir(dir) to resolve
>> relative paths, but as a side effect it resolves symlinks
>> too. Now it checks if the dir is relative before resolving.
>>
>> Signed-off-by: Mikl=C3=B3s Fazekas <mfazekas@szemafor.com>
>> ---
>>  git-p4.py |    5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 2da5649..5d74649 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -64,7 +64,10 @@ def chdir(dir):
>>      # not using the shell, we have to set it ourselves.  This path =
could
>>      # be relative, so go there first, then figure out where we ende=
d up.
>>      os.chdir(dir)
>> -    os.environ['PWD'] =3D os.getcwd()
>> +    if os.path.isabs(dir):
>> +        os.environ['PWD'] =3D dir
>> +    else:
>> +        os.environ['PWD'] =3D os.getcwd()
>>
>>  def die(msg):
>>      if verbose:
>
> Thanks, this is indeed a bug and I have reproduced it with a test
> case.  Your patch works, but I think it would be better to
> separate the callers of chdir():  those that know they are
> cd-ing to a path from a p4 client, and everybody else.  The former
> should not use os.getcwd(), as you show.
>
> I'll whip something up soon, unless you beat me to it.
>
>                 -- Pete
