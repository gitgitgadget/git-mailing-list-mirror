From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use lockfile.c routines in git_commit_set_multivar()
Date: Thu, 26 Jul 2007 21:53:54 -0700
Message-ID: <7v7iom5twd.fsf@assigned-by-dhcp.cox.net>
References: <11854689283208-git-send-email-bradford.carl.smith@gmail.com>
	<Pine.LNX.4.64.0707261926590.14781@racer.site>
	<f158199e0707261148r29419a39h7d83fc7bd0ea7df1@mail.gmail.com>
	<7vfy3a5uzv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Bradford Smith" <bradford.carl.smith@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 06:54:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEHq1-00020o-HU
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 06:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbXG0Ex4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 00:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752544AbXG0Ex4
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 00:53:56 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50312 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbXG0Exz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 00:53:55 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727045353.YVLI1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 27 Jul 2007 00:53:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UUtt1X00e1kojtg0000000; Fri, 27 Jul 2007 00:53:54 -0400
In-Reply-To: <7vfy3a5uzv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 26 Jul 2007 21:30:12 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53885>

Junio C Hamano <gitster@pobox.com> writes:

> "Bradford Smith" <bradford.carl.smith@gmail.com> writes:
>
>> FWIW, I have successfully run 'make test' and also verified that it
>> behaves as I expect with my ~/.gitconfig symlink (in conjunction with
>> the my other patch for resolving symlinks).
>
> Existing "make test" testsuite is not an appropriate thing to
> say this patch is safe, as we do not have much symlinking in the
> test git repository there.  Care to add a new test or two?

How about this?  On top of your "lockfile to keep symlink" and
"set-multivar to use lockfile protocol" patches.

---

 t/t1300-repo-config.sh |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 1c43cc3..187ca2d 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -595,4 +595,19 @@ echo >>result
 
 test_expect_success '--null --get-regexp' 'cmp result expect'
 
+test_expect_success 'symlinked configuration' '
+
+	ln -s notyet myconfig &&
+	GIT_CONFIG=myconfig git config test.frotz nitfol &&
+	test -h myconfig &&
+	test -f notyet &&
+	test "z$(GIT_CONFIG=notyet git config test.frotz)" = znitfol &&
+	GIT_CONFIG=myconfig git config test.xyzzy rezrov &&
+	test -h myconfig &&
+	test -f notyet &&
+	test "z$(GIT_CONFIG=notyet git config test.frotz)" = znitfol &&
+	test "z$(GIT_CONFIG=notyet git config test.xyzzy)" = zrezrov
+
+'
+
 test_done
