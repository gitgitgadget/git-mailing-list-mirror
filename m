From: Junio C Hamano <gitster@pobox.com>
Subject: (warning) Tonight's 'pu' may fail its tests
Date: Fri, 06 Feb 2009 03:02:43 -0800
Message-ID: <7v7i437rqk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Marius Storm-Olsen" <mstormo_git@storm-olsen.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 12:04:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOVL-0001N6-Lf
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818AbZBFLCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbZBFLCt
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:02:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbZBFLCs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:02:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D5AB22A874;
	Fri,  6 Feb 2009 06:02:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 09BDF2A851; Fri, 
 6 Feb 2009 06:02:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B046C2BC-F43D-11DD-9A70-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108680>

I usually try to make sure all four integration branches (maint, master,
next and pu) pass the selftest before pushing the results out, but it
seems that there is a subtle breakage somewhere in 'pu' that breaks
t4203-mailmap.sh.  The breakage is not reliably reproducible but happens
very often when tests are run in parallel (e.g. "make -j4").

I originally was planning to merge ms/mailmap to 'next' before tonight's
pushout, but I ran out of time and had to yank the topic out of 'next' and
kicked it back to 'pu'.

Does the following log ring a bell to anybody?

----------------------------------------------------------------
Initialized empty Git repository in /git/git.git/t/trash directory.t4203-mailmap/.git/
* expecting success:
        echo one >one &&
        git add one &&
        test_tick &&
        git commit -m initial &&
        echo two >>one &&
        git add one &&
        git commit --author "nick1 <bugs@company.xx>" -m second

[master (root-commit) 3a2fdcb] initial
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 one
[master 7de6f99] second
 1 files changed, 1 insertions(+), 0 deletions(-)
*   ok 1: setup

* expecting success:
        git shortlog >actual &&
        test_cmp expect actual

--- expect      2009-02-06 10:47:25.000000000 +0000
+++ actual      2009-02-06 10:47:25.000000000 +0000
@@ -1,6 +0,0 @@
-A U Thor (1):
-      initial
-
-nick1 (1):
-      second
-
* FAIL 2: No mailmap

                git shortlog >actual &&
                test_cmp expect actual

make[2]: *** [t4203-mailmap.sh] Error 1
----------------------------------------------------------------

The frustrating thing is that

    GIT_SKIP_TESTS='t[0-35-9]??? t4[01]??' \
    GIT_TEST_OPTS='-i -v' \
    make -j4 test

fails very reliably with the above log, but:

 (1) running the same "../../git-shortlog" in  "t/trash directory.t4203-mailmap/"
     immediately after the test failed does emit the expected result;

 (2) going down to t/ and manually running t4203-mailmap.sh alone succeeds;

 (3) running the tests serially (i.e. without -j4) allows the test to succeed.
