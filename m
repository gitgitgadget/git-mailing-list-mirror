From: Joey Hess <joey@kitenet.net>
Subject: bug with partial commit and pre-commit hook updating the index
Date: Fri, 10 Oct 2014 13:18:34 -0400
Message-ID: <20141010171834.GB21355@kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 19:18:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xcdq2-00086R-RX
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 19:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932AbaJJRSn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2014 13:18:43 -0400
Received: from kite.kitenet.net ([66.228.36.95]:41790 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbaJJRSm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 13:18:42 -0400
Received: by kitenet.net
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=1.0 required=5.0 tests=RDNS_DYNAMIC,SPF_NEUTRAL
	autolearn=no autolearn_force=no version=3.4.0
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on kite.kitenet.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have found many uses for the feature that lets a pre-commit hook stag=
e
changes in the index that will be included in the commit. But now I see=
m
to have found a bug in the support for that, involving partial commits.

It seems that, after a partial commit in which the pre-commit hook
stages a modification of a file, the index is is left without that
staged change. This only occurs with "git commit $file", not "git commi=
t -a".

joey@darkstar:~/tmp/a>ls
joey@darkstar:~/tmp/a>date > foo
joey@darkstar:~/tmp/a>git add foo
joey@darkstar:~/tmp/a>git commit -m "added regular file foo"
[master 79d0f1d] added regular file foo
 1 file changed, 1 insertion(+)
 create mode 100644 foo
joey@darkstar:~/tmp/a>mv ~/pre-commit  .git/hooks/
joey@darkstar:~/tmp/a>cat > .git/hooks/pre-commit
#!/bin/sh
ln -vsf /etc/passwd foo
git add foo
joey@darkstar:~/tmp/a>date > foo
joey@darkstar:~/tmp/a>git commit foo -m update
=E2=80=98foo=E2=80=99 -> =E2=80=98/etc/passwd=E2=80=99
[master efa9f67] update
 1 file changed, 1 insertion(+), 1 deletion(-)
 rewrite foo (100%)
 mode change 100644 =3D> 120000

So, the pre-commit hook replaced file foo with a symlink, and staged it=
,
and we can see from the commit summary that was correctly included
in the commit. But, look here:

joey@darkstar:~/tmp/a>git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	typechange: foo

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working direct=
ory)

	typechange: foo

builtin/commit.c has a long comment that talks about a false index whic=
h
is set up and used during a partial commit. The pre-commit hook is run
using this false index, and the commit is generated from it. I guess th=
e
bug involves the real index not being updated afterwards to reflect the
changes made to the false index.

--=20
see shy jo, resending a mail that vger accepted yesterday but has still=
=20
            not posted
