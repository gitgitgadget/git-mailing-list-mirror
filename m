From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC/PATCH] t0081-*.sh: Fix failure of the 'long read' tests
Date: Tue, 26 Apr 2011 19:05:38 +0100
Message-ID: <4DB70972.20308@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 20:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEmjx-0000uq-Sv
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 20:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757839Ab1DZSL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 14:11:56 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:48041 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757633Ab1DZSLz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2011 14:11:55 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1QEmjq-0001EM-mO; Tue, 26 Apr 2011 18:11:54 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172120>


In particular, the subshell feeding the input pipe, using the
shell function generate_tens_of_lines(), dies early due to a
broken pipe (SIGPIPE). The test-line-buffer command reads all
of the data it needs and closes the pipe, but the generate_\
tens_of_lines() function is still attempting to write to the
pipe, since it is in an infinite loop. This causes the later
"kill $!" to fail, since the process no longer exists.

The infinite loop is caused by the loop variable increment
expression, which looks something like this:

    : $((i = $i + 1)) || return

This expression does not actually increment the loop variable
at all, so $i remains at zero, leading to the infinite loop.

A simple fix, for some shells, would be to remove the '$'
from the '$i' within the arithmetic expansion. However, some
older shells don't support assignment as part of an arithmetic
expansion. Therefore, in order to fix the problem, we replace
the loop increment expression with the simpler:

    i=$(($i + 1))

which solves the problem, while also being more portable.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Junio,

I only remembered last night that I have been skipping some tests
on Linux (oops!); this fixes one of the failures for me. One of
the reasons for me simply skipping this test, rather than fixing
it up earlier, was that it looked like (indeed *is*) another
example of a syntax error due to using an older dash shell.
(Also, I thought there was some talk of scrapping this test).

However, when I tried bash and an up-to-date dash, the problem
changed from a syntax error to an infinite loop! ;-P

The reason for the RFC is that I don't understand why (apparently)
I'm the only person seeing this failure; I suspect that a newer
version of bash than I have does not have this problem (ie the
original arithmetic expansion actually works). dunno :-(

Also, I considered changing the kill statement thus:

    -	kill $! &&
    +	if kill -0 $! 2>/dev/null
    +	then
    +		kill $!
    +	fi &&

but I'm not sure that actually helps, and was not necessary to
fix the failure for me.

[BTW, the other tests failing for me are t4034 tests #21 (diff 
driver 'bibtex'), #25 (diff driver 'html); I haven't had time to
investigate yet]

ATB,
Ramsay Jones

 t/t0081-line-buffer.sh |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/t/t0081-line-buffer.sh b/t/t0081-line-buffer.sh
index 5067d1e..9b79e3b 100755
--- a/t/t0081-line-buffer.sh
+++ b/t/t0081-line-buffer.sh
@@ -25,8 +25,7 @@ generate_tens_of_lines () {
 		do
 			echo "$line"
 		done &&
-		: $((i = $i + 1)) ||
-		return
+		i=$(($i + 1))
 	done
 }
 
-- 
1.7.4
