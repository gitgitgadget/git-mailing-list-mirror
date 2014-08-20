From: Davide Fiorentino <davide.fiorentino@gmail.com>
Subject: [BUG] rewriting history with filter-branch --commit-filter
Date: Wed, 20 Aug 2014 10:16:11 +0200
Message-ID: <17DBA232-E993-4B3C-9952-90424976A28D@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 10:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XK14C-0006co-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 10:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbaHTIQT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2014 04:16:19 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:37729 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaHTIQR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2014 04:16:17 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so7516255wgg.7
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 01:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=oSFceRX9IPJ13pgeQo51d2pXskd03EEbNVmPjECdfzM=;
        b=yKHuI2AkBVVWk/65FzDvXbqE2caBS+dWeAaZo2Y5y9z+kfHJHxYuFTCktigsRScmih
         pVLjp8ajDT8BXmw15YCNVr62c/RE0NIduXacAqvVAtm4He8ICv2Mh6NENfmIZi02N9qu
         FnXtd0/pgvxggqBuHbDHXJdrFW99vcTwVSCtSl24LJzHePaEOBzNmJviuRU+KwCX1+PT
         +0xmdWTmQPMXv9wUgHfDVykH4fYPx1HWRpefys2NDFBhGawXQ/uzfmgMVG+U9YMP0Vi5
         qdOf0GGkJbZ4BpkBNWA7T7WZh6Izhk+K6YaoS5eL+jsjcvXLGlgd4XZj/RIJoV7x3hJU
         RISA==
X-Received: by 10.194.103.41 with SMTP id ft9mr9190154wjb.93.1408522575822;
        Wed, 20 Aug 2014 01:16:15 -0700 (PDT)
Received: from [10.12.6.10] (ppp-136-37.98-62.inwind.it. [62.98.37.136])
        by mx.google.com with ESMTPSA id kz6sm45362914wjb.47.2014.08.20.01.16.13
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 01:16:14 -0700 (PDT)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255557>

Hi,

I was in the need to rewrite author name and email and commit date for =
a single commit and I guess I found a bug.
I run this git-filter script

$ git filter-branch --commit-filter =91
    if [ "$GIT_COMMIT"=3D"9cfca27" ];=20
        then GIT_AUTHOR_NAME=3D=93Michelle=94;=20
            GIT_AUTHOR_EMAIL=3D=93michelle@email.com=94;=20
            GIT_AUTHOR_DATE=3D"2009-12-31T23:59:59=94;=20
            git commit-tree "$@=93;=20
        else=20
            git commit-tree "$@=93;
    fi' HEAD

and found that all history was rewritten as if =93Michelle=94 not only =
commit 9cfca27.

I also tried using full length commit id and a non-existing commit id: =
nothing changes.
In the following example to replicate the replicate the bug I=92m using=
 a non-existing commit id to make the effect more evident.


$ git --version
git version 2.0.1

$ mkdir project

$ cd project

$ git init

$ for i in 1 2 3; do echo "foo" >> foo$i.txt; git add foo$i.txt; git co=
mmit -m "foo$i"; done
[master (root-commit) 89dec6e] foo1
 1 file changed, 1 insertion(+)
 create mode 100644 foo1.txt
[master 8a3c8e5] foo2
 1 file changed, 1 insertion(+)
 create mode 100644 foo2.txt
[master a3ca061] foo3
 1 file changed, 1 insertion(+)
 create mode 100644 foo3.txt

$ git log --graph --all --pretty=3Dformat:'%C(yellow)%h%C(cyan)%d%Crese=
t %s %C(white)- %an, %ar%Creset'
* a3ca061 (HEAD, master) foo3 - David, 4 seconds ago
* 8a3c8e5 foo2 - David, 4 seconds ago
* 89dec6e foo1 - David, 4 seconds ago

$ git filter-branch --commit-filter '
    if [ "$GIT_COMMIT"=3D"308add7" ];=20
        then GIT_AUTHOR_NAME=3D"Michelle";=20
            GIT_AUTHOR_EMAIL=3D"michelle@email.com";=20
            GIT_AUTHOR_DATE=3D"2009-12-31T23:59:59";=20
            git commit-tree "$@";=20
        else=20
            git commit-tree "$@";
    fi' HEAD

$ git log --graph --all --pretty=3Dformat:'%C(yellow)%h%C(cyan)%d%Crese=
t %s %C(white)- %an, %ar%Creset'
* 8937dff (HEAD, master) foo3 - Michelle, 4 years, 8 months ago
* 30e494e foo2 - Michelle, 4 years, 8 months ago
* 2a2ba4f foo1 - Michelle, 4 years, 8 months ago
* a3ca061 (refs/original/refs/heads/master) foo3 - David, 8 seconds ago
* 8a3c8e5 foo2 - David, 8 seconds ago
* 89dec6e foo1 - David, 8 seconds ago

$ git log
commit 8937dff7e6a3f5545c2242e3fd5d33acbabe6df4
Author: Michelle <michelle@email.com>
Date:   Thu Dec 31 23:59:59 2009 +0100

    foo3

commit 30e494ef27f16c5456e66214ea46b780581dfb48
Author: Michelle <michelle@email.com>
Date:   Thu Dec 31 23:59:59 2009 +0100

    foo2

commit 2a2ba4fd6b9627e237a12b47570a3f020a202b55
Author: Michelle <michelle@email.com>
Date:   Thu Dec 31 23:59:59 2009 +0100

    foo1


using env-filter, I managed to rewrite the history with this:

$ git filter-branch --env-filter '
=20
name=3D"$GIT_AUTHOR_NAME"
email=3D"$GIT_AUTHOR_EMAIL"
=20
if [ "$GIT_COMMIT" =3D "89dec6e4bc1fb3cff694ea83f5ed900dad43449e" ]
then
    name=3D"Michelle"
    email=3D"Michelle@email.com"
fi

export GIT_AUTHOR_NAME=3D=93$name"
export GIT_AUTHOR_EMAIL=3D=93$email"
'

Hope this helped.

Davide