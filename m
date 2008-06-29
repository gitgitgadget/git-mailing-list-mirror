From: Junio C Hamano <gitster@pobox.com>
Subject: Re: perl t9700 failures?
Date: Sun, 29 Jun 2008 13:18:08 -0700
Message-ID: <7v4p7c9erj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Lea Wiemann <LeWiemann@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 22:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD3Mm-0000Pn-Rg
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 22:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759369AbYF2USY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 16:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757549AbYF2USY
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 16:18:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43513 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbYF2USX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 16:18:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0EADCD6F6;
	Sun, 29 Jun 2008 16:18:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 41F3FD6F5; Sun, 29 Jun 2008 16:18:15 -0400 (EDT)
In-Reply-To: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org>
 (Linus Torvalds's message of "Sun, 29 Jun 2008 12:52:00 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 84B30878-4618-11DD-A26B-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86827>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Am I the only one who gets this error:
>
> 	*** t9700-perl-git.sh ***
> 	*   ok 1: set up test repository
> 	*  run 2: Perl API (perl ../t9700/test.pl)
> 	* FAIL 2: Perl API
> 	        perl ../t9700/test.pl
> 	* FAIL 3: no stderr: Perl API
> 	        perl ../t9700/test.pl
> 	* failed 2 among 3 test(s)
>
> which I have no idea about, since to me perl is a black box, and doing  
> run of the tests with '-i -v' doesn't actually tell any more about which 
> part of the perl script is failing, or why.. Trying to run the perl thing 
> by hand, though, gives me this:
>
> 	Can't locate Test/More.pm in @INC (@INC contains: ...)
>
> which is presumably the problem. It looks like it is assuming I have the 
> Test::More perl libs, which I presumably don't have, don't have any clue 
> where they are, nor really any interest in installing.
>
> Wouldn't it be a lot more polite to just not run the test when the 
> Test::More stuff doesn't exist? Rather than failing the testsuite? From a 
> quick "git grep", this test is the only one that uses Test::More..

Hmm.  I was told that Test::More was part of the std Perl distribution
(and my quick check showed I happened to have that installed on my boxes
even though I do not use it myself and assumed it was there because the
claim is true).  Another test that does rely on more obscure Perl library
does refrain from running when it is not available, though...

Perlhaps something liek this should be sufficient.

diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b2fb9ec..9b57ad1 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -6,6 +6,11 @@
 test_description='perl interface (Git.pm)'
 . ./test-lib.sh
 
+perl -MTest::More -e 0 2>/dev/null || {
+	say_color skip >&3 "Perl Test::More not available, skipping test"
+	test_done
+}
+
 # set up test repository
 
 test_expect_success \
