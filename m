From: Andrew Waters <apwaters@googlemail.com>
Subject: [PATCH] Fix handling of git-p4 on deleted files
Date: Fri, 22 Oct 2010 13:26:02 +0100
Message-ID: <AANLkTikOXp7Tz3F0Of7Ua2N39Z1S22WKh0K_zJFLGa2K@mail.gmail.com>
References: <AANLkTimzN9ZGwQZ-pi6SMWGY9KS0fjmXu=1gjdfck=W-@mail.gmail.com>
	<AANLkTimHHbg1zVX+1L7Dwgj5VmMFdUZ5X_Vf6UK_26An@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 22 14:26:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9GhG-0003M3-Hs
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 14:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab0JVM0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 08:26:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34606 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0JVM0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 08:26:03 -0400
Received: by gyg4 with SMTP id 4so540365gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 05:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=4yUCoAe2VVuG+7UHWMPT0nN77pxvMq6CDs3usiJXL0A=;
        b=LA7wqQAWmoBjE3TAU4lUoLOZaIucmz8Ed7g3qfk+AFW9Y8jgAhIE14hi2Mj13eMSCi
         Ptzcy7tGBNktnlATvIHTnuzsN/k13TLgJiBPIHoIPhocluKwbDddggNCqkKeBCoyHCLO
         OJfZJ3Rgdo2ALbwk3YsEQiPO5NcWnl7Qcln+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=Viugkfgmu1ZlAUFQ65sdc45PXvbCw9QR6K5HYzJhWOAcBrSAjZ6d2FA/EeBI8j07OF
         babBjbEdKn8vBG+QEKBvgTAGV2+hF9wsNzTkOk9V8eJZoG8sWWQPB8ChNSNi+AFH1SWO
         OPpcDtVYhJYG0VOb+iL4eUR+w3giwTSKB5TsM=
Received: by 10.100.142.2 with SMTP id p2mr2098274and.67.1287750362231; Fri,
 22 Oct 2010 05:26:02 -0700 (PDT)
Received: by 10.100.194.5 with HTTP; Fri, 22 Oct 2010 05:26:02 -0700 (PDT)
In-Reply-To: <AANLkTimHHbg1zVX+1L7Dwgj5VmMFdUZ5X_Vf6UK_26An@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159685>

Signed-off-by: Andrew Waters <apwaters@googlemail.com>
---
 contrib/fast-import/git-p4 |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c1ea643..04ce7e3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -706,7 +706,9 @@ class P4Submit(Command):
             submitTemplate =3D self.prepareLogMessage(template, logMes=
sage)
             if os.environ.has_key("P4DIFF"):
                 del(os.environ["P4DIFF"])
-            diff =3D p4_read_pipe("diff -du ...")
+            diff =3D ""
+            for editedFile in editedFiles:
+                diff +=3D p4_read_pipe("diff -du %r" % editedFile)

             newdiff =3D ""
             for newFile in filesToAdd:
--=20
1.7.2.2


On 22 October 2010 11:20, Thomas Berg <merlin66b@gmail.com> wrote:
> Hi,
>
> On Mon, Oct 18, 2010 at 5:39 PM, Andrew Waters <apwaters@googlemail.c=
om> wrote:
>> When you submit changes containing deleted file the command 'p4 diff
>> -du ...' includes diffs for deleted files. This causes the failure:
>>
>> open for read: <deleted file>: No such file or directory
>> Command failed: p4 diff -du ...
>
> I'm a daily git-p4 user and noticed this problem too: 'git p4 submit'
> fails for commits with deleted files, with recent Perforce verions.
> The problem has been brought up earlier [1], but no patch has actuall=
y
> submitted yet.
>
>> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
>> index c1ea643..04ce7e3 100755
>> --- a/contrib/fast-import/git-p4
>> +++ b/contrib/fast-import/git-p4
>> @@ -706,7 +706,9 @@ class P4Submit(Command):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 submitTemplate =3D self.pr=
epareLogMessage(template, logMessage)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if os.environ.has_key("P4D=
IFF"):
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 del(os.envir=
on["P4DIFF"])
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff =3D p4_read_pipe("di=
ff -du ...")
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff =3D ""
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for editedFile in editedF=
iles:
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff +=3D p=
4_read_pipe("diff -du %r" % editedFile)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 newdiff =3D ""
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for newFile in filesToAdd:
>> --
>
> I just tested your patch, and it does indeed fix the problem. I think
> you need to "sign off" on the patch, other than that I support
> applying it.
>
> Regards,
> Thomas
>
> [1] http://kerneltrap.org/mailarchive/git/2010/5/28/31299
>
