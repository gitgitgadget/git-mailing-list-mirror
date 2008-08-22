From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9301-fast-export: move unset of config variable into
 its own test function
Date: Fri, 22 Aug 2008 01:18:42 -0700
Message-ID: <7vbpzlbgyl.fsf@gitster.siamese.dyndns.org>
References: <7vtzdhkfo2.fsf@gitster.siamese.dyndns.org>
 <ZdQ6b4vecqtrZ-7Mze6M9UBwrI9qQRUu-BoApXUv0v2zM76stzXd3w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 22 10:19:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRsD-0004OC-Mj
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 10:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824AbYHVISw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 04:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbYHVISv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 04:18:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYHVISt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 04:18:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B6434647F7;
	Fri, 22 Aug 2008 04:18:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F146C647F6; Fri, 22 Aug 2008 04:18:44 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1B4A358-7022-11DD-918A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93272>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> On platforms with a broken iconv it may be necessary to skip the fourth
> test in this script. Test four sets the i18n.commitencoding config variable.
> If test four is skipped, then a later unset of the i18n.commitencoding
> config variable will return a non-zero exit status and cause a test to fail.
> So move the 'config --unset' into its own test function which allows it to
> be skipped independently.

I do not know if this is worth it, and I am reasonably sure this is not an
optimal solution for this particular case.

Many existing pieces in the test scripts, I even suspect majority of them,
do depend on earlier piece in the sequence to succeed and try to build on
top of the state they have left.  In the ideal world, especially when the
software is young and flaky, perhaps that should not be the case and
having test pieces that are as independent as each other would be easier
to fix many tests that do not pass, but these days we expect all tests to
pass, so running tests has become like reading the error output from
compilers --- very often, the first error is the only one that counts.

Even though test-lib.sh does support skipping individual test pieces by
adding t9301.12 to GIT_TEST_SKIP, it is not very useful in practice with
the current set of tests, it would involve huge effort to make it reliably
usable, and individual test pieces in the end result from such an effort
will have to perform their own set-up from scratch, which would mean the
test will take even longer to run, to catch occasional breakages.

For this particular case, what we are interested in testing is not that
"config --unset" exits with 0 status.  We are however interested in making
sure that i18n.commitencoding is not set when the body of #12 runs.

So I think a more appropriate change would be something like this for this
particular case.

 t/t9301-fast-export.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git c/t/t9301-fast-export.sh i/t/t9301-fast-export.sh
index 3cb9f80..2ce2aff 100755
--- c/t/t9301-fast-export.sh
+++ i/t/t9301-fast-export.sh
@@ -190,7 +190,9 @@ export GIT_COMMITTER_NAME='C O Mitter'
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
+	git config --unset i18n.commitencoding
+
+	test -z $(git config i18n.commitencoding) &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
