From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9001: set TERM=dumb to prevent ANSI output
Date: Thu, 06 Mar 2008 22:16:47 -0800
Message-ID: <7vskz33vow.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803061752340.3941@racer.site>
 <7vmypb8muj.fsf@gitster.siamese.dyndns.org>
 <200803070541.15793.chriscool@tuxfamily.org>
 <7v7igf5cpk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 07 07:18:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXVu8-00024v-S3
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 07:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760186AbYCGGRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 01:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754407AbYCGGQ7
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 01:16:59 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865AbYCGGQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 01:16:58 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 792A53F6B;
	Fri,  7 Mar 2008 01:16:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 54C003F6A; Fri,  7 Mar 2008 01:16:51 -0500 (EST)
In-Reply-To: <7v7igf5cpk.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 06 Mar 2008 21:23:51 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76463>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
> ...
>> This may not work well with colored output.
>> In test-lib.sh line 62 there is :
>>
>> [ "x$TERM" != "xdumb" ] &&
>> 	[ -t 1 ] &&
>> 	tput bold >/dev/null 2>&1 &&
>> 	tput setaf 1 >/dev/null 2>&1 &&
>> 	tput sgr0 >/dev/null 2>&1 &&
>> 	color=t
>
> Ahh.  Sorry about that.

Ahem, third time lucky.

-- >8 --
[PATCH] test-lib: fix TERM to dumb for test repeatability

Dscho noticed that Term::ReadLine (used by send-email) colorized its
output for his TERM settings, inside t9001 tests.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib.sh |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index c0c5e21..44f5776 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -3,12 +3,16 @@
 # Copyright (c) 2005 Junio C Hamano
 #
 
+# Keep the original TERM for say_color
+ORIGINAL_TERM=$TERM
+
 # For repeatability, reset the environment to known value.
 LANG=C
 LC_ALL=C
 PAGER=cat
 TZ=UTC
-export LANG LC_ALL PAGER TZ
+TERM=dumb
+export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
 VISUAL=:
 unset GIT_EDITOR
@@ -58,12 +62,14 @@ esac
 # This test checks if command xyzzy does the right thing...
 # '
 # . ./test-lib.sh
-
-[ "x$TERM" != "xdumb" ] &&
-	[ -t 1 ] &&
-	tput bold >/dev/null 2>&1 &&
-	tput setaf 1 >/dev/null 2>&1 &&
-	tput sgr0 >/dev/null 2>&1 &&
+[ "x$ORIGINAL_TERM" != "xdumb" ] && (
+		TERM=$ORIGINAL_TERM &&
+		export TERM &&
+		[ -t 1 ] &&
+		tput bold >/dev/null 2>&1 &&
+		tput setaf 1 >/dev/null 2>&1 &&
+		tput sgr0 >/dev/null 2>&1
+	) &&
 	color=t
 
 while test "$#" -ne 0
@@ -91,6 +97,9 @@ done
 
 if test -n "$color"; then
 	say_color () {
+		(
+		TERM=$ORIGINAL_TERM
+		export TERM
 		case "$1" in
 			error) tput bold; tput setaf 1;; # bold red
 			skip)  tput bold; tput setaf 2;; # bold green
@@ -101,6 +110,7 @@ if test -n "$color"; then
 		shift
 		echo "* $*"
 		tput sgr0
+		)
 	}
 else
 	say_color() {
-- 
1.5.4.3.587.g0bdd73

