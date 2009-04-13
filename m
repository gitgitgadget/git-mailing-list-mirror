From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t1301-shared-repo: Fix forced modes test, but it
 still shows a flaw
Date: Sun, 12 Apr 2009 19:49:41 -0700
Message-ID: <7vd4bhxo6y.fsf@gitster.siamese.dyndns.org>
References: <49E10C55.1050005@kdbg.org> <200904122122.03040.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 13 04:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtCGl-00025o-Ac
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 04:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbZDMCuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 22:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753845AbZDMCuA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 22:50:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753693AbZDMCt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 22:49:59 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 40AF3E36B;
	Sun, 12 Apr 2009 22:49:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 49C97E368; Sun,
 12 Apr 2009 22:49:55 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C6AEC844-27D5-11DE-BA10-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116402>

Johannes Sixt <j6t@kdbg.org> writes:

> This test was added recently (5a688fe, "core.sharedrepository = 0mode"
> should set, not loosen; 2009-03-28). It checked the result of a sed
> invocation for emptyness, but in some cases it forgot to print anything
> at all, so that those checks would never be false.
>
> Due to this mistake, it went unnoticed that the files in objects/info are
> not necessarily 0440, but can also be 0640. This directory is now exempt
> from the check.
>
> Moreover, COMMIT_EDITMSG is still world-readable. This is either a bug in
> git, or a flaw in the test (the first sed expression). This patch does not
> disambiguate these two cases, but only declares the test case as an
> expected failure.
>
> Finally, this test cannot be run on Windows (requires POSIXPERM).
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
> Sorry, the first round was whitespace damaged for some reason.

So is this one but that was minor and I fixed up by hand.

> I could now test the result on Linux, and, lo and behold, it shows a bug:
> Either in git, or in the test: COMMIT_EDITMSG is still world-readable, as
> is shown by the first sed expression that was fixed (2nd hunk).

I personally do not think it is worth worrying about transient stuff that
are meant for repositories with a work tree, such as COMMIT_EDITMSG file
and the index.  If you are working on a shared machine and on a sekrit
stuff, the root of the work tree would be with mode 0700 (or 0750 to allow
peeking by other people in the group), and that would mean that neither
the index nor .git/COMMIT_EDITMSG in it would be readable by the strangers
anyway.

The index happens to be protected already as-is and I am not saying we
should loosen it.  I am just saying it is not as important as what would
appear in a bare repository).

Also, in the real-world use case, .git/COMMIT_EDITMSG will be given to an
arbitrary editor the user happens to use, and we have no guarantee what it
does (e.g. it may create a new file with umask and replace, it may rewrite
in place, it may leave an editor backup file but use umask to create it,
etc.), and the protection of the file lies majorly on the protection of
the root of the work tree.

But objects/info is meant for users of a bare repository used as a
distribution point, and it should obey the stricter mode.  If the code
makes it world readable, that is indeed a breakage.  If it makes it 0660,
then the test case is broken.

The thing is, these tests are meant to cover the 0mode protection, and not
about "because object files are immutable, they should not have w-bit".
The rule should apply no matter what core.sharedrepository setting is in
effect for the repository, and such a test should be done elsewhere.  It
is not a part of core.sharedrepository settings topic.

So how about doing it this way instead?  If somebody cares, s/he can fix
the COMMIT_EDITMSG codepath and then drop the exclusion of it, but as I
already stated why, I do not think it is worth it.

	Side note: I think info/refs and objects/info/packs files are made
	0660, not 0640, as you stated.  As far as I can remember, these
	are updated by the usual creat-write-rename and do not have be
	writable, but it is a separate matter.

Note that this patch is against the tip of the original jc/shared-literally
topic (1b89eaa) that can be merged to 'maint'; I'll have a fix-up to add
POSIXPERM when merging it to 'master'.

-- >8 --
From: Johannes Sixt <j6t@kdbg.org>
Date: Sun, 12 Apr 2009 21:22:02 +0200
Subject: [PATCH] t1301-shared-repo: fix forced modes test

This test was added recently (5a688fe, "core.sharedrepository = 0mode"
should set, not loosen; 2009-03-28). It checked the result of a sed
invocation for emptyness, but in some cases it forgot to print anything
at all, so that those checks would never be false.

Due to this mistake, it went unnoticed that the files in objects/info are
not necessarily 0440, but can also be 0660.  Because the 0mode setting
tries to guarantee that the files are accessible only to the people they
are meant to be used by, we should only make sure that they are readable
by the user and the group when the configuration is set to 0660.  It is a
separate matter from the core.shredrepository settings that w-bit from
immutable object files under objects/[0-9a-f][0-9a-f] directories should
be dropped.

COMMIT_EDITMSG is still world-readable, but it (and any transient files
that are meant for repositories with a work tree) does not matter.  If you
are working on a shared machine and on a sekrit stuff, the root of the
work tree would be with mode 0700 (or 0750 to allow peeking by other
people in the group), and that would mean that .git/COMMIT_EDITMSG in such
a repository would not be readable by the strangers anyway.

Also, in the real-world use case, .git/COMMIT_EDITMSG will be given to an
arbitrary editor the user happens to use, and we have no guarantee what it
does (e.g. it may create a new file with umask and replace, it may rewrite
in place, it may leave an editor backup file but use umask to create it,
etc.), and the protection of the file lies majorly on the protection of
the root of the work tree.

This test cannot be run on Windows; it requires POSIXPERM when merged to
'master'.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1301-shared-repo.sh |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 3c8a237..3fddc9e 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -141,11 +141,14 @@ test_expect_success 'forced modes' '
 		git commit -a -m initial &&
 		git repack
 	) &&
-	find new/.git -print |
+	# List repository files meant to be protected; note that
+	# COMMIT_EDITMSG does not matter---0mode is not about a
+	# repository with a work tree.
+	find new/.git -type f -name COMMIT_EDITMSG -prune -o -print |
 	xargs ls -ld >actual &&
 
 	# Everything must be unaccessible to others
-	test -z "$(sed -n -e "/^.......---/d" actual)" &&
+	test -z "$(sed -e "/^.......---/d" actual)" &&
 
 	# All directories must have either 2770 or 770
 	test -z "$(sed -n -e "/^drwxrw[sx]---/d" -e "/^d/p" actual)" &&
@@ -156,10 +159,11 @@ test_expect_success 'forced modes' '
 		p
 	}" actual)" &&
 
-	# All files inside objects must be 0440
+	# All files inside objects must be accessible by us
 	test -z "$(sed -n -e "/objects\//{
 		/^d/d
-		/^-r--r-----/d
+		/^-r.-r.----/d
+		p
 	}" actual)"
 '
 
-- 
1.6.2.2.527.gea4fd
