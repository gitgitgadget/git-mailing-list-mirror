From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: git-archive and core.eol
Date: Wed, 15 Dec 2010 23:32:51 +0100
Message-ID: <AANLkTi=kfE88F7dY5F_xtbEuh9DyUcN+ymeXqLMWztGQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: eyvind.bernhardsen@gmail.com
To: Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 23:33:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSzuR-0008Iw-4B
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 23:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946Ab0LOWdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Dec 2010 17:33:14 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:53681 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab0LOWdN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Dec 2010 17:33:13 -0500
Received: by fxm18 with SMTP id 18so2643169fxm.2
        for <git@vger.kernel.org>; Wed, 15 Dec 2010 14:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to:from
         :date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Yq6vkbiwBMYX9SsZlBJ4UDy5LT4fTWbX09Xj/8A0/QY=;
        b=NnBkneKWIKDrBgzH6TOb5D3ORFsaOpPJ/F0NhIziKxQTsxhGpAiEh+LGGnoIDe7WQO
         GJgd7gzpWLUF/H5tJzPX+RsjPi6LIbEXTwl0kIUfLYIoaMf3U6XixYErEn3NBbPsPIxp
         Bb1NkivkjXu4UQHViKJge/mTB7TSwkrR0OzWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        b=TLEQqQNP2dNSPGJjfiMHXWYDxy9Rbry4XTj7CJgicwTCe/HWdqv+j7jVuQuXOdPDrP
         /djKXFCbgdc5FbT45HKSru4qfYFaU7QuINVJGxLStktwrZ6tNrzOLe/9ln4FhK8v5yhM
         K5UoFrgbo2AeoX/uQYCENMpcwDUymY1wHzPGA=
Received: by 10.223.81.70 with SMTP id w6mr8231442fak.18.1292452392194; Wed,
 15 Dec 2010 14:33:12 -0800 (PST)
Received: by 10.223.96.71 with HTTP; Wed, 15 Dec 2010 14:32:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163794>

I recently tried the following on Windows:

$ git init
Initialized empty Git repository in c:/Users/kusma/test/.git/
$ echo "foo
bar" > test.txt
$ git -c core.autocrlf=3Dtrue add test.txt
warning: LF will be replaced by CRLF in test.txt.
The file will have its original line endings in your working directory.
$ git commit -m.
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
$ git -c core.autocrlf=3Dtrue -c core.eol=3Dlf archive --format=3Dtar H=
EAD > test.tar
$ tar xvf test.tar
$ od -c test.txt
0000000   f   o   o  \r  \n   b   a   r  \r  \n
0000012

Just to be sure, I checked this:

$ git show HEAD:test.txt | od -c
0000000   f   o   o  \n   b   a   r  \n
0000010

Yep, the file has LF in the repo, as expected... the warning from
git-add is a bit confusing, but OK.

Hmm, so git-archive writes CRLF even if I said I wanted LF. But then I
tried this on Linux:

$ git init
Initialized empty Git repository in /home/kusma/src/test/.git/
$ echo "foo
bar" > test.txt
$ git add test.txt
$ git commit -m.
[master (root-commit) c6f195e] .
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 test.txt
$ git -c core.autocrlf=3Dtrue -c core.eol=3Dcrlf archive --format=3Dtar=
 HEAD
> test.tar
$ tar xvf test.tar
test.txt
$=A0od -c test.txt
0000000   f   o   o  \r  \n   b   a   r  \r  \n
0000012

This leaves me a bit puzzled. On Linux, I can override the default
new-line style CRLF for git-archive, but I can't override it to LF on
Windows?

I expected it to work because sha1_file_to_archive calls
convert_to_working_tree. I've tried stepping through the code, but I
don't quite understand where it goes wrong. Or even how the code is
supposed to work :P

Does anyone have any clue what's going on? I'm running with the
current master, git version 1.7.3.3.585.g74f6e.
