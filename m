From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Trapping exit in tests, using return for errors
Date: Thu, 11 Aug 2005 12:00:40 -0400
Message-ID: <1123776040.2326.6.camel@dv>
References: <1123732581.18644.37.camel@dv>
	 <7virydnh1o.fsf@assigned-by-dhcp.cox.net>
	 <7vzmrpm1q9.fsf@assigned-by-dhcp.cox.net>
	 <7vvf2dm1b8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 18:02:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3FUI-0000LF-ET
	for gcvg-git@gmane.org; Thu, 11 Aug 2005 18:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbVHKQAp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 12:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVHKQAp
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 12:00:45 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:1181 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932246AbVHKQAo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 12:00:44 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1E3FRq-0005or-I8
	for git@vger.kernel.org; Thu, 11 Aug 2005 11:58:26 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.52)
	id 1E3FU0-00057K-Ug; Thu, 11 Aug 2005 12:00:40 -0400
Received: (from proski@localhost)
	by dv.roinet.com (8.13.4/8.13.4/Submit) id j7BG0esD019671;
	Thu, 11 Aug 2005 12:00:40 -0400
X-Authentication-Warning: dv.roinet.com: proski set sender to proski@gnu.org using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvf2dm1b8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Junio!

On Wed, 2005-08-10 at 23:31 -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Sorry, sent it out without finishing.  The worst is "return".
> 
> Ah, my mistake.  You have the eval that can eval "return" in a
> function and let that "return" return from that function.
> Cleverly done.

I'm glad you appreciate it.  One more fix on top of the last patch is
needed.

"return" from a test would leave the exit trap set, which could cause a
spurious error message if it's the last test in the script or
--immediate is used.

The easiest solution would be to have a global trap that is set when
test-lib.sh is sourced and unset either by test_done(), error() or by
test_failure_() with --immediate.  This patch also depends on the patch
that adds test_done() the the scripts that don't have it.

Signed-off-by: Pavel Roskin <proski@gnu.org>

diff --git a/t/test-lib.sh b/t/test-lib.sh
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -36,6 +36,7 @@ unset SHA1_FILE_DIRECTORY
 
 error () {
 	echo "* error: $*"
+	trap - exit
 	exit 1
 }
 
@@ -74,6 +75,8 @@ fi
 test_failure=0
 test_count=0
 
+trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
+
 
 # You are not expected to call test_ok_ and test_failure_ directly, use
 # the text_expect_* functions instead.
@@ -89,7 +92,7 @@ test_failure_ () {
 	say "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
-	test "$immediate" == "" || exit 1
+	test "$immediate" == "" || { trap - exit; exit 1; }
 }
 
 
@@ -98,10 +101,8 @@ test_debug () {
 }
 
 test_run_ () {
-	trap 'echo >&5 "FATAL: Unexpected exit with code $?"; exit 1' exit
 	eval >&3 2>&4 "$1"
 	eval_ret="$?"
-	trap - exit
 	return 0
 }
 
@@ -132,6 +133,7 @@ test_expect_success () {
 }
 
 test_done () {
+	trap - exit
 	case "$test_failure" in
 	0)	
 		# We could:


-- 
Regards,
Pavel Roskin
