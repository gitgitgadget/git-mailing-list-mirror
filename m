From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Thu, 13 Nov 2008 01:46:20 -0800
Message-ID: <7v63mshsb7.fsf@gitster.siamese.dyndns.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org>
 <7v8wrpyhhs.fsf@gitster.siamese.dyndns.org>
 <200811121515.48277.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 10:48:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0YoK-0007o8-8t
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 10:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbYKMJrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Nov 2008 04:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbYKMJrI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 04:47:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYKMJrG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 04:47:06 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EACAF16933;
	Thu, 13 Nov 2008 04:47:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 25A3E16931; Thu, 13 Nov 2008 04:46:23 -0500 (EST)
In-Reply-To: <200811121515.48277.chriscool@tuxfamily.org> (Christian Couder's
 message of "Wed, 12 Nov 2008 15:15:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0596B9A2-B168-11DD-AA38-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100862>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le mercredi 12 novembre 2008, Junio C Hamano a =C3=A9crit :
> ...
>> When you want to hunt for a bug, it is certainly possible that your =
tests
>> fail for a bug that is unrelated to what you are hunting for for a r=
ange
>> of commits.  Borrowing from your picture:
>>
>>     ...--O--A--X1--X2--...--Xn--B--...
>>
>> non of the commit marked as Xi may not be testable.
>>
>> But at that point, will you really spend time to rebuild history bet=
ween
>> A and B by fixing an unrelated bug that hinders your bisect, so that=
 you
>> can have a parallel history that is bisectable?  I doubt anybody wou=
ld.
>
> I think kernel developers and perhaps others do that somehow. I mean,=
 there=20
> is the following text in the git-bisect(1) documentation:
>
> "
> You may often find that during bisect you want to have near-constant =
tweaks=20
> (e.g., s/#define DEBUG 0/#define DEBUG 1/ in a header file, or "revis=
ion=20
> that does not have this commit needs this patch applied to work aroun=
d=20
> other problem this bisection is not interested in") applied to the re=
vision=20
> being tested.
>
> To cope with such a situation, after the inner git-bisect finds the n=
ext=20
> revision to test, with the "run" script, you can apply that tweak bef=
ore=20
> compiling,...
> "
>
> So we suggest that people patch at bisect time in case of problems. B=
ut I=20
> think creating a parallel branch should be better in the long run, be=
cause=20
> you can easily keep the work you did to make things easier to bisect =
and=20
> you can easily share it with other people working with you.

I strongly disagree.

Maybe you hit X2 which does have a breakage, and you would need to patc=
h
up that one before being able to test for your bug, but after you say g=
ood
or bad on that one, the next pick will be far away from that Xi segment=
=2E
You will test many more revisions before you come back to X3 or X5.  Wh=
y
should we force the users to fix all the commits in the segment "just i=
n
case" somebody's bisect falls into the range before that actually happe=
ns?

In other words, unless the breakage you are hunting for exists between
point A and B that you cannot bisect for that other breakage, you won't
need to patch-up _every single revision_ in the range for the breakage.
Doing so beforehand is wasteful.

And if you know the range of A..B and the fix, the procedure to follow =
the
suggestion you quoted above from the doc can even be automated relative=
ly
easily.  Your "run" script would need to do two merge-base to see if th=
e
version to be tested falls inside the range, and if so apply the known =
fix
before testing (and clean it up afterwards).

Come to think of it, you do not even need to have a custom run script.
How about an approach illustrated by this patch?

I think it also needs to call unapply_fixup when "bisect reset" is give=
n
to clean up, but this is more about a possible approach and not about a
adding a polished and finished shiny new toy, so...

-- >8 --
bisect: use canned "fixup patch"

This allows you to have $GIT_DIR/bisect-fixup directory, populated with
"fixup" patch files.  When revisions between A and B (inclusive) cannot=
 be
tested for your bisection purpose because they have other unrelated
breakage whose fix is already known, you can store a fix-up patch in th=
e
file whose name is A-B (the commit object name of A, a dash, then the
commit object name of B).  When "git bisect" suggests you to test a
revision that falls in that range, the patch will automatically be
applied to the working tree, so that you can test with the known fix
already in place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh           |   36 ++++++++++++++++++++++++++
 t/t6035-bisect-fixup.sh |   64 +++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 100 insertions(+), 0 deletions(-)

diff --git c/git-bisect.sh w/git-bisect.sh
index 0d0e278..600d9aa 100755
--- c/git-bisect.sh
+++ w/git-bisect.sh
@@ -338,13 +338,48 @@ exit_if_skipped_commits () {
 	fi
 }
=20
+apply_fixup() {
+	>"$GIT_DIR/BISECT_FIXUP"
+	(
+		cd "$GIT_DIR" 2>/dev/null &&
+		find bisect-fixup -type f -print
+	) |
+	while read _fixup
+	do
+		_btm=3D$(expr "$_fixup" : 'bisect-fixup/\([0-9a-f]*\)-[0-9a-f]*$') &=
&
+		_btm=3D$(git rev-parse --quiet --verify "$_btm" 2>/dev/null) &&
+		_top=3D$(expr "$_fixup" : 'bisect-fixup/[0-9a-f]*-\([0-9a-f]*\)$') &=
&
+		_top=3D$(git rev-parse --quiet --verify "$_top" 2>/dev/null) ||
+		continue
+		if	test "z$(git merge-base $_btm "$1")" =3D z$_btm &&
+			test "z$(git merge-base "$1" $_top)" =3D "z$1"
+		then
+			echo "Applying $_fixup..."
+			git apply "$GIT_DIR/$_fixup" || exit 1
+			echo >>"$GIT_DIR/BISECT_FIXUP" "$_fixup"
+		fi
+	done
+}
+
+unapply_fixup() {
+	test -r "$GIT_DIR/BISECT_FIXUP" || return 0
+	@@PERL@@ -e "print reverse <>" "$GIT_DIR/BISECT_FIXUP" |
+	while read _fixup
+	do
+		echo "Unapplying $_fixup..."
+		git apply -R "$GIT_DIR/$_fixup" || exit
+	done
+}
+
 bisect_checkout() {
+	unapply_fixup || exit ;# should not happen but try to be careful
 	_rev=3D"$1"
 	_msg=3D"$2"
 	echo "Bisecting: $_msg"
 	mark_expected_rev "$_rev"
 	git checkout -q "$_rev" || exit
 	git show-branch "$_rev"
+	apply_fixup "$_rev" || exit
 }
=20
 is_among() {
@@ -532,6 +567,7 @@ bisect_clean_state() {
 	do
 		git update-ref -d $ref $hash || exit
 	done
+	rm -f "$GIT_DIR/BISECT_FIXUP" &&
 	rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
 	rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
 	rm -f "$GIT_DIR/BISECT_LOG" &&
diff --git c/t/t6035-bisect-fixup.sh w/t/t6035-bisect-fixup.sh
new file mode 100755
index 0000000..4745b73
--- /dev/null
+++ w/t/t6035-bisect-fixup.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+# Copyright (c) 2008, Junio C Hamano
+
+test_description=3D'bisect fixup'
+
+. ./test-lib.sh
+
+cat >test-fixup <<\EOF
+diff a/elif b/elif
+--- a/elif
++++ b/elif
+@@ -1 +1 @@
+-0
++Z
+EOF
+
+test_expect_success setup '
+	echo 0 >elif
+	git add elif
+	for i in 1 2 3 4 5 6 7 8 9
+	do
+		test_tick &&
+		echo $i >file &&
+		git add file &&
+		git commit -m $i &&
+		git tag t$i
+	done &&
+
+	mkdir ".git/bisect-fixup" &&
+
+	btm=3D$(git rev-parse --short t3) &&
+	top=3D$(git rev-parse --short t5) &&
+	cat test-fixup >".git/bisect-fixup/$btm-$top" &&
+
+	btm=3D$(git rev-parse --short t7) &&
+	top=3D$(git rev-parse --short t8) &&
+	sed -e "s|Z|A|" test-fixup >".git/bisect-fixup/$btm-$top"
+'
+
+test_expect_success 'bisect fixup' '
+	t1=3D$(git rev-parse t1) &&
+	t5=3D$(git rev-parse t5) &&
+	t6=3D$(git rev-parse t6) &&
+	t7=3D$(git rev-parse t7) &&
+	t9=3D$(git rev-parse t9) &&
+
+	git bisect start &&
+	test $(git rev-parse HEAD) =3D $t9 &&
+	git bisect bad t9 &&
+	test $(git rev-parse HEAD) =3D $t9 &&
+	git bisect good t1 &&
+	test $(git rev-parse HEAD) =3D $t5 &&
+	grep Z elif &&
+
+	git bisect good &&
+	test $(git rev-parse HEAD) =3D $t7 &&
+	grep A elif &&
+
+	git bisect bad &&
+	test $(git rev-parse HEAD) =3D $t6 &&
+	grep 0 elif
+'
+
+test_done
