From: Spencer Nelson <s@spenczar.com>
Subject: git clone doesn't cleanup on failure when getcwd fails
Date: Wed, 18 Mar 2015 11:03:30 -0700
Message-ID: <etPan.5509bdf2.7a1ae87d.1766@ttvadmins-MacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 19:03:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYIJd-0007vX-Pe
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 19:03:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbbCRSDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 14:03:33 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35592 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755077AbbCRSDc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2015 14:03:32 -0400
Received: by pabyw6 with SMTP id yw6so49371361pab.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2015 11:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:message-id:subject:mime-version
         :content-type:content-transfer-encoding:content-disposition;
        bh=C+z+WoxILcpqz38CE6DJcoZfaxDkgYsDkxzux/0iS+8=;
        b=jub88gH6fe1cEQVMEj4NfLoGghDlIGLq9lwRowCAh8tarCGFSIUPpmEbvRTDeu1+X+
         qJTGY3sCJI3EFNMOUVfeCMJbaiZh4R6S/AfSXevKeisU63rph6wSWOAJT+y1yhymOfBk
         MUSt/eWuKk1HAfl4IXuDSvNUpH3tDDmbO1E6SmV71ge8nm0Hg1giy8mv0s+y8rCpEm/B
         brO6Ijop1DbbTSnCWNmiNNk4BUl7neBm9cHPAtYSu3Q3B9lpV9+XdCVdt84NZPkrDn7/
         mc2Gs8uITpiz2wc9c125BfUUm0/syOFgVcjK3l4J8EUQlZaSoU6jARzi6mIIBU8N2dLG
         fgsA==
X-Gm-Message-State: ALoCoQmIpnLtMBUx3GTOQSYuk48POtnegtyiIJ4VDIDXOkkckGPvJbI+3SFFN9Ahs+hq/HYldX/+
X-Received: by 10.66.102.34 with SMTP id fl2mr163905464pab.40.1426701812080;
        Wed, 18 Mar 2015 11:03:32 -0700 (PDT)
Received: from ttvadmins-MacBook-Pro.local ([2002:ae3e:4da0:0:f0c4:8d5d:66be:6aa7])
        by mx.google.com with ESMTPSA id zd14sm28708644pab.20.2015.03.18.11.03.31
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Mar 2015 11:03:31 -0700 (PDT)
X-Mailer: Airmail Beta (297)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265745>

=C2=A0
If you=E2=80=99re in a shell in a directory which no longer exists (bec=
ause, say, another terminal removed it), then getcwd() will fail, at le=
ast on OS X Yosemite 10.10.2. In this case, git clone will fail. That=E2=
=80=99s totally reasonable. =20

If you invoke git clone with the git clone <repo> <dir> syntax, then <d=
ir> will be created, but it will be empty.

This was unexpected - I would think the failure case shouldn=E2=80=99t =
leave this empty directory, but should instead clean up after itself.

I=E2=80=99m not alone: golang=E2=80=99s go get command for installing t=
hird-party packages performs a `git clone <repo> <dir>` only if <dir> d=
oes not already exist - if it does exist, then go believes that the pac=
kage is already installed, and so does nothing. So, if you call go get =
from within a directory which no longer exists, git will create the emp=
ty directory, putting go get into a bad state.


Concrete example:

Make a dummy repo in /tmp/somerepo:
tty1:
$ cd /tmp
$ git init somerepo

In another tty, make a /tmp/poof and enter it
tty2:
$ mkdir /tmp/poof
$ cd /tmp/poof

In the first tty, delete /tmp/poof
tty1:
$ rmdir /tmp/poof

=46inally, in the second tty, clone:
tty2:
$ git clone /tmp/somerepo /tmp/newcopy
fatal: Could not get current working directory: No such file or directo=
ry
$ ls /tmp/newcopy && echo "yes, it exists"
yes, it exists


My version details:

$ git version
git version 2.3.2

$ uname -a
Darwin mbp.local 14.1.0 Darwin Kernel Version 14.1.0: Thu Feb 26 19:26:=
47 PST 2015; root:xnu-2782.10.73~1/RELEASE_X86_64 x86_64
