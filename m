From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Sane use of test_expect_failure
Date: Sat, 02 Feb 2008 02:06:35 -0800
Message-ID: <7vhcgr3c5w.fsf_-_@gitster.siamese.dyndns.org>
References: <47975FE6.4050709@viscovery.net>
	<7v7ihtqfm8.fsf@gitster.siamese.dyndns.org>
	<7vve5dox0o.fsf_-_@gitster.siamese.dyndns.org>
	<200802010534.55925.robin.rosenberg.lists@dewire.com>
	<7vabmlb0y0.fsf@gitster.siamese.dyndns.org>
	<7vwspp9f9e.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 11:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLFHR-0001yJ-Os
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 11:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758577AbYBBKGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 05:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758259AbYBBKGr
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 05:06:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758009AbYBBKGq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 05:06:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 80FA24838;
	Sat,  2 Feb 2008 05:06:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DF0E94837;
	Sat,  2 Feb 2008 05:06:38 -0500 (EST)
In-Reply-To: <7vwspp9f9e.fsf_-_@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 01 Feb 2008 01:50:53 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72242>

As I promised, a patch to revamp test_expect_failure semantics
has been applied to 'master' and pushed out.

The rule used to be that test_expect_failure is to see if the
command sequence exits with non-zero status.  It was tempting to
incorrectly use it like this:

    test_expect_failure 'this should fail' '
	setup1 &&
        setup2 &&
        setup3 &&
        what you expect to fail
    '

but was very error prone, because the failure can come from the
earlier "setup" stages.

The new world order is that test_expect_failure is used to mark
a known breakage, so that people can run "git grep t/" to see if
there are things to work on.

We have an example in cvsserver test:

    #TODO: cvsserver doesn't support update w/o -d
    test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" '
       ...
       test ! -d test
    '

If git-cvsserver did not have this bug, this should succeed, but
there is a known breakage that is waiting to be fixed.

I may have missed tests that were using test_expect_failure to
mark known bug that need to be fixed and converted that to
test_expect_success to check an error exit status from the last
command in the sequence.  IOW, a mistranslation of the above
might have done:

    test_expect_success "cvs update w/o -d doesn't create subdir (TODO)" '
       ...
       test -d test
    '

which would be wrong.  Fixing the bug would then "break" this
test.

Could people who added test_expect_failure in the past that this
patch updated, look them over to catch such a misconversion
please?
