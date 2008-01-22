From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [RFC] File system difference handling in git
Date: Tue, 22 Jan 2008 18:44:00 +0100
Message-ID: <0AEE94F5-C0B2-4B92-AD99-8BF2298428AF@zib.de>
References: <3f4fd2640801220121w60cb9a69u8519a7ceb81d3414@mail.gmail.com> <7vtzl6qhtk.fsf@gitster.siamese.dyndns.org> <3f4fd2640801220252q6a6557cdma4ca0a2c41223593@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 18:49:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHNFj-00039l-RP
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 18:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752450AbYAVRtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Jan 2008 12:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752486AbYAVRtJ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 12:49:09 -0500
Received: from mailer.zib.de ([130.73.108.11]:45863 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752390AbYAVRtI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Jan 2008 12:49:08 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0MHgxFT008910;
	Tue, 22 Jan 2008 18:42:59 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0MHgwxu007207
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 22 Jan 2008 18:42:58 +0100 (MET)
In-Reply-To: <3f4fd2640801220252q6a6557cdma4ca0a2c41223593@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71464>


On Jan 22, 2008, at 11:52 AM, Reece Dunn wrote:

>>>   2.  Case (in)sensitivity
>>>
>>> Here, you have the following cases:
>>> ...
>>>   3.  git says that the files are different, but the filesystem say=
s
>>> that the files are the same.
>>>
>>> Allow the move, updating the git directory tree only.
>>
>> Sorry, I cannot really tell what you are talking about.  You
>> seem to imply, with "Allow the move", that you are describing a
>> scenario that involves a move of one existing file to another,
>> but it is not clear.  E.g. did you mean, by 3, "When the user
>> says 'move a b', and if git says a and b are different but if
>> the filesystem says a and b are the same, then..."?
>
> This is what I am saying. For example, if you say:
>
>    git mv myfile.H myfile.h
>
> on a case sensitive filesystem (e.g. ext3), this will work, however o=
n
> a case insensitive filesystem (e.g. ntfs) git would complain that the
> files are the same.
>
> The workaround is to say:
>
>    git mv myfile.H myfile.h.tmp
>    git mv myfile.h.tmp myfile.h
>
> but this is not ideal, especially if you are automating some move =20
> operations.
>
> This also applies to the VCS importers (e.g. git-p4) that can delete =
a
> file that is a case-only move on case insensitive filesystems.
>
> The question then becomes what happens on Mac (with the Unicode
> decomposing behaviour) if they differ in the way they are stored (e.g=
=2E
> in Linus' '=E4' vs 'a=A8' example)?


You can work around the problem as you described; but later git
will hit you again and fails unexpectedly when you try to merge
your change.

So better avoid renames that only change case until git at least
passes the two test below.

	Steffen

---- snip ---

Git behaves strangely (from a user's point of view) on filesystems
that preserve case but do not distinguish it.  The two major examples
are Windows and Mac OS X.  Simple operations such as "git mv" or "git
merge" can fail unexpectedly.

This commit adds two simple tests.  Both tests currently fail on
Windows and Mac, although they pass on Linux.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
  t/t0050-filesystems.sh |   36 ++++++++++++++++++++++++++++++++++++
  1 files changed, 36 insertions(+), 0 deletions(-)
  create mode 100755 t/t0050-filesystems.sh

diff --git a/t/t0050-filesystems.sh b/t/t0050-filesystems.sh
new file mode 100755
index 0000000..953b02b
--- /dev/null
+++ b/t/t0050-filesystems.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description=3D'Various filesystems issues'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	touch camelcase &&
+	git add camelcase &&
+	git commit -m "initial" &&
+	git tag initial &&
+	git checkout -b topic &&
+	git mv camelcase tmp &&
+	git mv tmp CamelCase &&
+	git commit -m "rename" &&
+	git checkout -f master
+
+'
+
+test_expect_success 'rename (case change)' '
+
+	git mv camelcase CamelCase &&
+	git commit -m "rename"
+
+'
+
+test_expect_success 'merge (case change)' '
+
+	git reset --hard initial &&
+	git merge topic
+
+'
+
+test_done
--=20
1.5.4.rc4
