From: "Dmitry S. Kravtsov" <idkravitz@gmail.com>
Subject: Git pull --rebase with strategy ours doesn't work (possibly bug)
Date: Mon, 13 Jun 2011 14:05:31 +1100
Message-ID: <BANLkTi=jLQf6Wp-qqYoy7kND2M1=WRyxXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 05:05:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVxT8-0000xe-6L
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 05:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802Ab1FMDFd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2011 23:05:33 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:59018 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380Ab1FMDFc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2011 23:05:32 -0400
Received: by iyb14 with SMTP id 14so3525385iyb.19
        for <git@vger.kernel.org>; Sun, 12 Jun 2011 20:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=mg1zJsi54Ua6yjD272PIxVMmdD3MBSO+c6SBoaE7zQY=;
        b=hz/TxiisWR731zmM6KjJE0Y180iEfnJXOMqkU6D5PgFSbNPQXDDJLo8cU7UJflRB0p
         JU6Ir/6y36soqm4jKfUlqKp4hc26/Xvrhe2c1vKceJnm/5P67LCykqnej7mkmGUS/XMz
         SNrJE65FDd2c/LpQFiJNZqlsjT0BZi0H3YXkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CASN62zhFIGAyJKhSu+CDRSbIp9w23h2gNNyDZEx0c5JDNCaV4T2G9Wo3xRpfxPjxU
         nBOwX7pvG85AF63UHXwE0dK2OZI3WoOBNtSfzU2yFJF89aRstSiREg47ORKydDin523u
         n/XdBNUlzEwIyC65Yjacr8M1ok3WuSrUGwZTA=
Received: by 10.231.201.81 with SMTP id ez17mr3332262ibb.156.1307934331435;
 Sun, 12 Jun 2011 20:05:31 -0700 (PDT)
Received: by 10.231.20.69 with HTTP; Sun, 12 Jun 2011 20:05:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175676>

Hi,

So here the steps to reproduce:

$ git init A
Initialized empty Git repository in /home/catsadmin/git-test/A/.git/
$ (cd A && echo 123 > file && git add file && git commit -m "1st")
[master (root-commit) 1055edf] 1st
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
$ git clone A B
Cloning into B...
done.
$ git clone A C
Cloning into C...
done.
$ (cd B && echo 333 >file && git commit -am "2nd")
[master 4e9cd67] 2nd
 1 files changed, 1 insertions(+), 1 deletions(-)
$ (cd A && git pull ~/git-test/B master)
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom /home/catsadmin/git-test/B
 * branch            master     -> FETCH_HEAD
Updating 1055edf..4e9cd67
=46ast-forward
 file |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
$ (cd C && echo 111 > file && git commit -am "3rd")
[master 1c4a368] 3rd
 1 files changed, 1 insertions(+), 1 deletions(-)
$ cd C
$ git push origin master
To /home/catsadmin/git-test/A
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to '/home/catsadmin/git-test/A'
To prevent you from losing history, non-fast-forward updates were rejec=
ted
Merge the remote changes (e.g. 'git pull') before pushing again.  See t=
he
'Note about fast-forwards' section of 'git push --help' for details.

So my idea is to create a straight line history, that will look like
"1st"---"2nd"---"3rd",
and from git-rebase man page I read, that strategy ours allows us to
discard conflicing changes in favor
of ours.

$ git pull --rebase -s ours origin master
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
=46rom /home/catsadmin/git-test/A
 * branch            master     -> FETCH_HEAD
=46irst, rewinding head to replay your work on top of it...
Already applied: 0001 3rd
/usr/bin/git-rebase: line 157:
/home/catsadmin/git-test/C/.git/rebase-merge/rewritten: =D0=9D=D0=B5=D1=
=82 =D1=82=D0=B0=D0=BA=D0=BE=D0=B3=D0=BE
=D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=B8=D0=BB=D0=B8 =D0=BA=D0=B0=D1=82=D0=
=B0=D0=BB=D0=BE=D0=B3=D0=B0
All done.

This message not only looks weird, it also discard my "3rd" commit
from master tree:
$ git branch
* master
$ git log
commit 4e9cd6730b1215b22b65fbcc6cbf87e331e5eb92
Author: Your Name <you@example.com>
Date:   Mon Jun 13 13:53:27 2011 +1100

    2nd

commit 1055edf3618787ea53231ed6f4b00dfe571c8940
Author: Your Name <you@example.com>
Date:   Mon Jun 13 13:52:53 2011 +1100

    1st

Am I wrong at something?

--=20
Dmitry S. Kravtsov
