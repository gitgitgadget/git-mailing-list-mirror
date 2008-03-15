From: SZEDER =?iso-8859-2?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: recent 'unpack_trees()'-related changes break 'git stash'
Date: Sat, 15 Mar 2008 02:41:33 +0100
Message-ID: <20080315014133.GB32265@neumann>
Reply-To: szeder@ira.uka.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 02:42:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaLQC-00069R-Ad
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 02:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYCOBlu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Mar 2008 21:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbYCOBlt
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 21:41:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:62148 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbYCOBlt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Mar 2008 21:41:49 -0400
Received: from elysium (p5B1332E0.dip0.t-ipconnect.de [91.19.50.224])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1JaLOv0VEQ-0004Zw; Sat, 15 Mar 2008 02:41:38 +0100
Received: from fzi.de (neumann.wired [192.168.1.2])
	by elysium (Postfix) with SMTP id C2A0511C338;
	Sat, 15 Mar 2008 02:41:32 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Provags-ID: V01U2FsdGVkX19bZ1lSY6UfVVvoh2EUroTarcSZttoH4VHQDyo
 GNtE0b0ogzsG72xGK9MUwa8WUx9BZqQ3Y5l62C3OWYT4KtBoUl
 ryRI2gUfcztqLmtDjiShw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77299>

Hi,

t3903-stash.sh _sometimes_ fails at the 'drop middle stash' testcase.
After playing around with it this evening I was able to narrow it
down, and turned out that it has nothing to do with 'git stash drop',
but something is broken behind 'stash'.

Unfortunately, I can't reproduce the bug reliably.  Here is a
testcase, that sometimes fails:


test_description=3D'Test git-stash'
=2E ./test-lib.sh
test_expect_success 'try to catch some rare occurring stash bug' '
	echo 1 > file &&
	git add file &&
	test_tick &&
	git commit -m initial &&
	echo 2 > file &&
	test_tick &&
	git stash &&
	test 2 =3D $(git stash show stash@{0} | wc -l) &&
	echo "after first show test"
	echo 3 > file &&
	git stash &&
	test 2 =3D $(git stash show stash@{0} | wc -l) &&
	echo "after second show test"
'
test_done


and here is a loop to run the above testcase until it fails (take
care, it deletes ./trash at the beginning!):


ret=3D0
i=3D0
while test $ret =3D 0 ; do
	rm -rf ./trash
	./mystashtest.sh --verbose
	ret=3D$?
	i=3D$((++i))
done
echo "test failed at ${i}. run"


Both should go into t/ directory.

The testcase usually fails during the first 25 run, but sometimes it
runs more than 100 times before failing.  The test fails because the
second 'git stash' sometimes does something wrong:  there is no
difference between stash@{0} and the clean working tree.  There is no
error message from 'git stash' upon failure.  During all the test runs
I never saw a failure occuring at the first 'git stash'.

I ran bisect using these scripts, and it turned out that the bug was
introduced by 34110cd4 (Make 'unpack_trees()' have a separate source
and destination index, 2008-03-06).

I have tried whether it has already been fixed in next or pu, but
those branches are affected, too.


Best,
G=E1bor
