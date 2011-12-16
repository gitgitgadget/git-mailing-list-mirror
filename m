From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: How to automatically correct an almost correct auto-merge?
Date: Fri, 16 Dec 2011 21:32:15 +0100
Message-ID: <20111216203215.GG1868@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 21:32:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbeS5-0006L4-SK
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 21:32:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774Ab1LPUcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Dec 2011 15:32:18 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:59162 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932640Ab1LPUcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 15:32:16 -0500
Received: from localhost6.localdomain6 (p5B1305DF.dip0.t-ipconnect.de [91.19.5.223])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LnUpq-1R54mv2IMI-00h57u; Fri, 16 Dec 2011 21:32:15 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:8A06cgqVatvayAvTzH+tvkm9pZg3rpQn0txbbFVuqrM
 GDBz0RIiFljh+TRr2mRfuyw+g96KclCyKlz4UQO2C56BT/FsUV
 WbH9bt7LKKg9B1woDuzi1YokBlUN7WPAkgzvRfXHLOJe9iKT9i
 0e4g0ZqchWe2zlaYsud50doJVjyKJwWcIjIs1j+H+bS7v0b3ZO
 ONrIOb9kpKxBqx7EQgTs50+796bM+W8k4Mcb1v3y4B8FsPmdvi
 jk6neC/X1+6qeK5oISE+9SC+Ckn+9ghUsJiyYX1yQuYJuwjxjA
 OyktvVacbfZzwClpnfF2u4mvP4uaR+3V7cgKHWPXSEP6OIlElr
 yRFoRWsCrPTTWB0w2NvA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187314>

Hi,


Briefly:

Neighboring areas of a file are modified in two branches.  Git merges
the two branches without conflicts, but the result is not semantically
correct.  How can I teach git to produce the correct merge result when
performing the same merge later on?


Longer:

The following commands create a file and two branches, both of them
modifying the file by adding lines in the same area:

git init
cat >file <<\EOF
1

2
EOF
git add file
git commit -m file
git apply <<\EOF
diff --git a/file b/file
index 1c3e7efc..121366a2 100644
--- a/file
+++ b/file
@@ -1,3 +1,5 @@
 1

+a
+
 2
EOF
git commit -a -m a
git checkout -b branch HEAD^
git apply <<\EOF
diff --git a/file b/file
index 1c3e7efc..f2e91d4f 100644
--- a/file
+++ b/file
@@ -1,3 +1,6 @@
 1
+b
+
+c

 2
EOF
git commit -a -m 'b c'
git checkout master


At this point I merge 'branch' and git produces the following result:

$ git merge branch
Auto-merging file
Merge made by the 'recursive' strategy.
 file |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
$ cat file
1
b

c

a

2


Now, these changes and the merge above are the minimal receipe which
corresponds to a real merge I'm having trouble with at dayjob.  Just
imagine that '1' and '2' are the beginning and end of a function, 'b'
is the declaration of a new local variable, and 'a' and 'c' are new
code blocks.  As it happens, the semantically correct result would be
the following:

1
b

a

c

2

i.e. 'a' must be executed before 'c'.

I corrected the merge result manually, but these two branches are
merged a couple of times a day into an integration branch, and they
will likely cook for a few weeks, which means a lot of merges, and a
lot of manual corrections.  So I'm looking for a way to teach git to
produce the semantically correct merge result.  Something like
'rerere' would be great, but of course I can't use 'rerere' in this
case, because there are no merge conflicts at all...

Any ideas?  Did someone deal with similar issues before?


Thanks,
G=E1bor
