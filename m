From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Ensure test-genrandom availability for t5301/t5302
Date: Sat, 28 Apr 2007 15:32:49 -0700
Message-ID: <7v3b2kjfji.fsf@assigned-by-dhcp.cox.net>
References: <4633A47A.4020508@cswitch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, danahow@gmail.com
To: Dana How <how@cswitch.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 00:33:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhvTL-00016I-BS
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 00:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030970AbXD1Wcw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Apr 2007 18:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031125AbXD1Wcw
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Apr 2007 18:32:52 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51602 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030970AbXD1Wcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2007 18:32:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070428223251.TYHY1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Apr 2007 18:32:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id smYp1W00D1kojtg0000000; Sat, 28 Apr 2007 18:32:50 -0400
In-Reply-To: <4633A47A.4020508@cswitch.com> (Dana How's message of "Sat, 28
	Apr 2007 12:46:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45797>

Dana How <how@cswitch.com> writes:

> Check for this as well as test-chmtime in test-lib.sh
>
> Signed-off-by: Dana L. How <danahow@gmail.com>
> ---
>  t/test-lib.sh |   13 ++++++++-----
>  1 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f2c6bd3..d7838fc 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -268,11 +268,14 @@ test -d ../templates/blt || {
>  	error "You haven't built things yet, have you?"
>  }
>  
> -if ! test -x ../test-chmtime; then
> -	echo >&2 'You need to build test-chmtime:'
> -	echo >&2 'Run "make test-chmtime" in the source (toplevel) directory'
> -	exit 1
> -fi
> +for prog in test-chmtime test-genrandom
> +do
> +	if ! test -x ../$prog; then
> +		echo >&2 "You need to build $prog:"
> +		echo >&2 "Run \"make $prog\" in the source (toplevel) directory"
> +		exit 1
> +	fi
> +done
>  
>  # Test repository
>  test=trash
> -- 
> 1.5.2.rc0.71.g4342-dirty

As these two are very small programs, why not always build them
upon "make all", like this?

---
 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 60c41fd..817f8ef 100644
--- a/Makefile
+++ b/Makefile
@@ -933,13 +933,17 @@ endif
 
 ### Testing rules
 
+TEST_PROGRAMS = test-chmtime$X test-genrandom$X
+
+all:: $(TEST_PROGRAMS)
+
 # GNU make supports exporting all variables by "export" without parameters.
 # However, the environment gets quite big, and some programs have problems
 # with that.
 
 export NO_SVN_TESTS
 
-test: all test-chmtime$X test-genrandom$X
+test: all
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
