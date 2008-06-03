From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Octopus merge: unique (?) to git, but is it useful?
Date: Tue, 03 Jun 2008 15:08:48 -0700
Message-ID: <7vk5h6189b.fsf@gitster.siamese.dyndns.org>
References: <200806030314.03252.jnareb@gmail.com>
 <alpine.LFD.1.10.0806021845210.3473@woody.linux-foundation.org>
 <7v3anv5fy3.fsf@gitster.siamese.dyndns.org>
 <7vskvv3xmx.fsf@gitster.siamese.dyndns.org> <20080603104009.GA559@neumann>
 <7vabi22u5h.fsf@gitster.siamese.dyndns.org> <20080603203924.GA6588@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:10:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3ehc-0003mU-Nl
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbYFCWJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 18:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbYFCWJG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:09:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYFCWJF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 18:09:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A32C712F2;
	Tue,  3 Jun 2008 18:09:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8629F12EF; Tue,  3 Jun 2008 18:08:56 -0400 (EDT)
In-Reply-To: <20080603203924.GA6588@neumann> (SZEDER =?utf-8?Q?G=C3=A1bor'?=
 =?utf-8?Q?s?= message of "Tue, 3 Jun 2008 22:39:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AC12061C-31B9-11DD-8763-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83717>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Tue, Jun 03, 2008 at 12:30:34PM -0700, Junio C Hamano wrote:
>> > ...  It
>> > fails at the line 'EDITOR=3D: git commit -a'.
>>=20
>> Sorry, because it works for me (and presumably for many others --- I
>> haven't seen anybody else reporting the breakage you have), you need=
 to
>> help others to diagnose it with a bit more details.
> With debug and verbose options it says following:
>
> * expecting success:=20
>
>         git rev-parse second master >expect &&
>         test_must_fail git merge second master &&
>         git checkout master g &&
>         echo "here comes the breakage" &&
>         EDITOR=3D: git commit -a &&
>         echo "survived!" &&
>         git cat-file commit HEAD | sed -n -e "s/^parent //p" -e "/^$/=
q" >actual &&
>         test_cmp expect actual
>
>
>
> *** Please tell me who you are.
> ...
> * failed 1 among 18 test(s)
> make: *** [t7502-commit.sh] Error 1
>
> My /bin/sh is dash, but it breaks with bash, too.
>
> What else could/should I provide?

Thanks, this is good enough.

I think the problem comes from the global removal of the two environmen=
t
variables, GIT_COMMITTER_{EMAIL,NAME} by an ealier bb1ae3f (commit: Sho=
w
committer if automatic, 2008-05-04).

Here is a potential fix.

The first hunk is the more relevant one; although the second one is als=
o a
fix, it is independent.  It is a fix to unnecessarily loosely written t=
est
that was done in early February.

 t/t7502-commit.sh |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 22a13f7..7b659b9 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -171,13 +171,16 @@ sed '$d' < expect.tmp > expect
 rm -f expect.tmp
 echo "# Committer:
 #" >> expect
-unset GIT_COMMITTER_EMAIL
-unset GIT_COMMITTER_NAME
=20
 test_expect_success 'committer is automatic' '
=20
 	echo >>negative &&
-	git commit -e -m "sample"
+	(
+		unset GIT_COMMITTER_EMAIL
+		unset GIT_COMMITTER_NAME
+		# must fail because there is no change
+		test_must_fail git commit -e -m "sample"
+	) &&
 	head -n 8 .git/COMMIT_EDITMSG |	\
 	sed "s/^# Committer: .*/# Committer:/" >actual &&
 	test_cmp expect actual
@@ -193,23 +196,24 @@ chmod +x .git/FAKE_EDITOR
=20
 test_expect_success 'do not fire editor in the presence of conflicts' =
'
=20
-	git clean
-	echo f>g
-	git add g
-	git commit -myes
-	git branch second
-	echo master>g
-	echo g>h
-	git add g h
-	git commit -mmaster
-	git checkout second
-	echo second>g
-	git add g
-	git commit -msecond
-	git cherry-pick -n master
-	echo "editor not started" > .git/result
-	GIT_EDITOR=3D`pwd`/.git/FAKE_EDITOR git commit && exit 1  # should fa=
il
-	test "`cat .git/result`" =3D "editor not started"
+	git clean -f &&
+	echo f >g &&
+	git add g &&
+	git commit -myes &&
+	git branch second &&
+	echo master >g
+	echo g >h
+	git add g h &&
+	git commit -mmaster &&
+	git checkout second &&
+	echo second >g
+	git add g &&
+	git commit -msecond &&
+	# Must fail due to conflict
+	test_must_fail git cherry-pick -n master &&
+	echo "editor not started" >.git/result &&
+	test_must_fail GIT_EDITOR=3D"$(pwd)/.git/FAKE_EDITOR" git commit &&
+	test "$(cat .git/result)" =3D "editor not started"
 '
=20
 pwd=3D`pwd`
