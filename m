From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] t5570: forward git-daemon messages in a different way
Date: Thu, 26 Apr 2012 20:16:37 +0200
Message-ID: <4F999105.200@kdbg.org>
References: <1334393070-7123-1-git-send-email-zbyszek@in.waw.pl> <20120414121358.GA26372@ecki> <20120414122127.GA31220@ecki> <4F8C3E0F.2040300@in.waw.pl> <20120416174230.GA19226@sigill.intra.peff.net> <20120416224424.GA10314@ecki> <20120419060326.GA13982@sigill.intra.peff.net> <4F8FB779.60004@viscovery.net> <20120426130129.GA27785@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Clemens Buchacher <drizzd@aon.at>,
	=?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpl?= =?UTF-8?B?d3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>, git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 26 20:16:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNTFI-0004MI-8W
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 20:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295Ab2DZSQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 14:16:43 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:53155 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757952Ab2DZSQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 14:16:42 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D66CC10010;
	Thu, 26 Apr 2012 20:12:32 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6FA6619F6CA;
	Thu, 26 Apr 2012 20:16:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.28) Gecko/20120306 SUSE/3.1.20 Thunderbird/3.1.20
In-Reply-To: <20120426130129.GA27785@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196385>

Am 26.04.2012 15:01, schrieb Jeff King:
> On Thu, Apr 19, 2012 at 08:58:01AM +0200, Johannes Sixt wrote:
> 
>>> What? The shell is literally redirecting the cat process's stdin from
>>> /dev/null. I'm totally confused.
>>
>> You don't have to be; it's mandated by POSIX:
>>
>> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_03_02
> 
> Sorry for the delayed response.
> 
> Thanks for the pointer; I looked in POSIX but couldn't find that
> passage. It does say "In all cases, explicit redirection of standard
> input shall override this activity". It looks like dash interprets that
> as "open /dev/null, then open the redirected stdin". Which leaves a race
> condition.

I don't see a race condition. The specs are clear: First redirect stdin
to /dev/null, and if there are other redirections, apply them later.
But in our code we have only:

	cat >&4 &

i.e., there are no other redirections. It does not matter that the
whole block where this command occurs is redirected from
git_daemon_output; that redirection was applied before the command was
executed, and it was already overridden by the implicit /dev/null
redirection.

>  So I think a custom wrapper like the one posted by Clemens
> is our only portable option.

I don't think so. How about this?

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index ef2d01f..7245ab3 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -30,10 +30,10 @@ start_git_daemon() {
 		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
 		>&3 2>git_daemon_output &
 	GIT_DAEMON_PID=$!
+	exec 7<git_daemon_output &&
 	{
-		read line
+		read line <&7
 		echo >&4 "$line"
-		cat >&4 &
 
 		# Check expected output
 		if test x"$(expr "$line" : "\[[0-9]*\] \(.*\)")" != x"Ready to rumble"
@@ -43,7 +43,9 @@ start_git_daemon() {
 			trap 'die' EXIT
 			error "git daemon failed to start"
 		fi
-	} <git_daemon_output
+		cat <&7 >&4 &
+		exec 7<&-
+	}
 }
 
 stop_git_daemon() {


i.e., we open the readable end of the pipe in the shell, and dup
it from there to 'read' and later to 'cat'. Finally, we can
close it, because 'cat' has it still open in the background.

This works with dash, bash, and (half-way through) ksh. (The failure
with ksh is an unrelated problem.)

-- Hannes
