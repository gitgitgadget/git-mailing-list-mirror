From: Simeon Maxein <smaxein@googlemail.com>
Subject: Problems with extra files on git filter-branch when core.ignorecase
 is true
Date: Sun, 29 Aug 2010 00:21:41 +0200
Message-ID: <AANLkTinEYNxKAAhq2O3joNYYrAmr=zRrUR3BakircnJW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 29 00:21:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpTmV-00062S-B8
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 00:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab0H1WVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Aug 2010 18:21:42 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51222 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0H1WVm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Aug 2010 18:21:42 -0400
Received: by vws3 with SMTP id 3so4004400vws.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 15:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        bh=qKT9Uy8wxTIoaXBXrUEJvysdHoHPMGu7wov6N7ZTqqY=;
        b=T5dIKNQSoY/yDBCt2VVHF3rgPhpNQU7lhcmg6YmImUimKWgcfrj8WnLORT0X12lGZA
         Vjqz+25isnatqqHdk3uHNlouIojMVmn1+wW9QX/OZeIvUkHcYQhLvb9w76/UAA1A/oe6
         korp+VAAuXpepKeXqzPTyXdCAxLJNSKlJIRKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=OReIWw/DmvxbQE98Vrj3j7PZIzH9hRh7CEbWibmxgEjsXJ/IBgoNKf4RY1CvufqlDd
         6RRcOjxFhbsZoqt5SbOr5LPbJoc2tYTGCFrVAGSci9Et1OQkgSSONWIWWX+zNyk7iZBm
         85FAmbDy8pZrO03Zn4VS0U9kP6Wbv5Y9qqvcQ=
Received: by 10.220.49.28 with SMTP id t28mr1525525vcf.93.1283034101406; Sat,
 28 Aug 2010 15:21:41 -0700 (PDT)
Received: by 10.220.164.137 with HTTP; Sat, 28 Aug 2010 15:21:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154662>

Today when trying to change the contents of a repository with git
filter-branch, a tool that was run on a part of the working tree for
each version reported an extra file that couldn't be accounted for.
After some testing and a small discussion on the irc channel, I was
able to come up with the following scenario to reproduce the issue.
The test was performed under Ubuntu with Git 1.7.0.4 on a case
sensitive file system:

> ~$ mkdir gittest
> ~$ cd gittest
> ~/gittest$ git init
> Initialized empty Git repository in /home/user/gittest/.git/
> ~/gittest$ git config core.ignorecase true
> ~/gittest$ echo 'foo' > testfile.txt
> ~/gittest$ git add testfile.txt
> ~/gittest$ git commit -m "initial commit"
> [master (root-commit) 794888c] initial commit
> =C2=A01 files changed, 1 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 testfile.txt
> ~/gittest$ git rm testfile.txt
> rm 'testfile.txt'
> ~/gittest$ echo 'bar' > testFile.txt
> ~/gittest$ git add testFile.txt
> ~/gittest$ git commit -m "additional commit"
> [master a669956] additional commit
> =C2=A02 files changed, 1 insertions(+), 1 deletions(-)
> =C2=A0create mode 100644 testFile.txt
> =C2=A0delete mode 100644 testfile.txt
> ~/gittest$ git filter-branch --tree-filter 'ls' master
> Rewrite 794888cdbe107aa7408cc5ed4132dcd3bc2753c8 (1/2)testfile.txt
> Rewrite a66995628af5710828a6a59628553938bc30ee37 (2/2)testfile.txt=C2=
=A0 testFile.txt
>
> WARNING: Ref 'refs/heads/master' is unchanged

In the second rewrite line, I would only expect testFile.txt to
appear, regardless of the core.ignorecase setting. On a case
insensitive filesystem the above example works correctly.

It might seem strange to set core.ignorecase to true on a case
sensitive filesystem, however, this issue also appears when using a
(case sensitive) tmpfs temp directory to filter a case insensitive
repository.

Thanks in advance for your help.

Simeon
