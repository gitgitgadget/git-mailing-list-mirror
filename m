From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 8 Apr 2012 01:01:40 -0400
Message-ID: <20120408050140.GA5862@sigill.intra.peff.net>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 08 07:02:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGkGb-00060N-Hj
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 07:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab2DHFBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 01:01:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54212
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744Ab2DHFBo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 01:01:44 -0400
Received: (qmail 31762 invoked by uid 107); 8 Apr 2012 05:01:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 08 Apr 2012 01:01:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Apr 2012 01:01:40 -0400
Content-Disposition: inline
In-Reply-To: <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194977>

On Sun, Apr 08, 2012 at 06:07:48AM +0300, Felipe Contreras wrote:

> +	cat >expected <<-\EOF &&
> +	fetch 
> +	filter-branch 
> +	filter-branch.sh 
> +	format-patch 
> +	fsck 
> +	EOF
> +	test_completion "git f"

This test fails for me. The problem is that I have other git-f* programs
in my PATH, and the completion finds and displays them. In other words,
the environment outside the test suite can pollute the result.

I'm not sure of the right solution. We can't just sanitize the PATH in
test-lib.sh, since those git programs might be in /usr/bin or some other
directory containing other commands necessary to run the test suite. We
could sanitize it temporarily just for the _git completion invocation,
which consists only of builtins (and we know we're running under bash,
so we can trust that things like "test" are builtins). But it still
feels horribly hacky.

That patch might look like this:

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7eb80dd..713f4b1 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -58,8 +58,11 @@ test_completion ()
 	_words=( $1 )
 	test $# -gt 1 && echo "$2" > expected
 	(( _cword = ${#_words[@]} - 1 ))
+	saved_path=$PATH
+	PATH=$MINIMAL_PATH
 	_git && print_comp &&
 	test_cmp expected out
+	PATH=$saved_path
 }
 
 test_expect_success 'basic' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index b7d7100..348b68d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -466,12 +466,14 @@ then
 	IFS=$OLDIFS
 	PATH=$GIT_VALGRIND/bin:$PATH
 	GIT_EXEC_PATH=$GIT_VALGRIND/bin
+	MINIMAL_PATH=$GIT_VALGRIND/bin
 	export GIT_VALGRIND
 elif test -n "$GIT_TEST_INSTALLED" ; then
 	GIT_EXEC_PATH=$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
 	PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR:$PATH
 	GIT_EXEC_PATH=${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
+	MINIMAL_PATH=$GIT_TEST_INSTALLED:$GIT_BUILD_DIR
 else # normal case, use ../bin-wrappers only unless $with_dashes:
 	git_bin_dir="$GIT_BUILD_DIR/bin-wrappers"
 	if ! test -x "$git_bin_dir/git" ; then
@@ -482,8 +484,10 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	fi
 	PATH="$git_bin_dir:$PATH"
 	GIT_EXEC_PATH=$GIT_BUILD_DIR
+	MINIMAL_PATH=$git_bin_dir
 	if test -n "$with_dashes" ; then
 		PATH="$GIT_BUILD_DIR:$PATH"
+		MINIMAL_PATH=$MINIMAL_PATH:$GIT_BUILD_DIR
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
