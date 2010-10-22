From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [PATCH] Fix handling of git-p4 on deleted files
Date: Fri, 22 Oct 2010 12:20:46 +0200
Message-ID: <AANLkTimHHbg1zVX+1L7Dwgj5VmMFdUZ5X_Vf6UK_26An@mail.gmail.com>
References: <AANLkTimzN9ZGwQZ-pi6SMWGY9KS0fjmXu=1gjdfck=W-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andrew Waters <apwaters@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 22 12:21:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9EkC-0001qH-HR
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 12:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab0JVKUs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 06:20:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:53896 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0JVKUr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Oct 2010 06:20:47 -0400
Received: by yxn35 with SMTP id 35so487148yxn.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 03:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yn+alOcFv3+R5aCLLsZ1Z+E7uv/efi81k25Jb0NLMtg=;
        b=Cj+xStefx6szxVJZpywOTHBJcKI1ojRGr+ooviuc1hI8hSnfJjKW5KAHirivfiF1W6
         YdZZzLjq9Z9XxbIL8UiX8CBIoa3l5FC7YoxymH50xha7tYM3IgS4qXqlndDqungt4rDc
         pvHMlkiKUY0jMVX9F/SFCr5O9t+sLUSiwtg5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d/mRGARO57Q7WlWOB1jP3kHTam8Vjm084dHJorS9zH5LQePkk3f2qTdqohauC1eygZ
         ddX0pRSKH/peBf10iRtJqetKI2gWSaxvg72SenEqRoV4Xh8DuhzEchd3hQQAMw+yEhHB
         e/sTTpMW7D440hmTfBuPtdVXudeRcToQIgng8=
Received: by 10.229.65.159 with SMTP id j31mr2022594qci.212.1287742846876;
 Fri, 22 Oct 2010 03:20:46 -0700 (PDT)
Received: by 10.229.62.160 with HTTP; Fri, 22 Oct 2010 03:20:46 -0700 (PDT)
In-Reply-To: <AANLkTimzN9ZGwQZ-pi6SMWGY9KS0fjmXu=1gjdfck=W-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159674>

Hi,

On Mon, Oct 18, 2010 at 5:39 PM, Andrew Waters <apwaters@googlemail.com=
> wrote:
> When you submit changes containing deleted file the command 'p4 diff
> -du ...' includes diffs for deleted files. This causes the failure:
>
> open for read: <deleted file>: No such file or directory
> Command failed: p4 diff -du ...

I'm a daily git-p4 user and noticed this problem too: 'git p4 submit'
fails for commits with deleted files, with recent Perforce verions.
The problem has been brought up earlier [1], but no patch has actually
submitted yet.

> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index c1ea643..04ce7e3 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -706,7 +706,9 @@ class P4Submit(Command):
> =A0 =A0 =A0 =A0 =A0 =A0 submitTemplate =3D self.prepareLogMessage(tem=
plate, logMessage)
> =A0 =A0 =A0 =A0 =A0 =A0 if os.environ.has_key("P4DIFF"):
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 del(os.environ["P4DIFF"])
> - =A0 =A0 =A0 =A0 =A0 =A0diff =3D p4_read_pipe("diff -du ...")
> + =A0 =A0 =A0 =A0 =A0 =A0diff =3D ""
> + =A0 =A0 =A0 =A0 =A0 =A0for editedFile in editedFiles:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0diff +=3D p4_read_pipe("diff -du %r"=
 % editedFile)
>
> =A0 =A0 =A0 =A0 =A0 =A0 newdiff =3D ""
> =A0 =A0 =A0 =A0 =A0 =A0 for newFile in filesToAdd:
> --

I just tested your patch, and it does indeed fix the problem. I think
you need to "sign off" on the patch, other than that I support
applying it.

Regards,
Thomas

[1] http://kerneltrap.org/mailarchive/git/2010/5/28/31299
