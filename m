From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Wed, 18 Apr 2012 20:53:37 +0100
Message-ID: <4F8F1BC1.3030607@ramsay1.demon.co.uk>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:07:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbA8-0004Wn-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754443Ab2DRUHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:07:31 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:59448 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754278Ab2DRUHa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 16:07:30 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SKbA0-0005mZ-hl; Wed, 18 Apr 2012 20:07:29 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4F8E6A12.9090708@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195893>

Johannes Sixt wrote:
> Am 4/16/2012 8:44, schrieb Junio C Hamano:
>> * nd/threaded-index-pack (2012-04-11) 3 commits
>>  - index-pack: support multithreaded delta resolving
>>  - index-pack: split second pass obj handling into own function
>>  - compat/win32/pthread.h: Add an pthread_key_delete() implementation
> 
> With this series, t9300.92 (fast-import, Q: verify pack) consistently
> fails for me on Windows.
> 
> I'll have to see when I can dig deeper into this topic...

Hmm, this works just fine for me.

[I know that doesn't help you much :(, but it at least provides another
data-point.]

With the exception of t9300.62 (a fix for which I have already sent to
the list), all of the following tests pass:

    t/t5300-pack-object.sh
    t/t5301-sliding-window.sh
    t/t5302-pack-index.sh
    t/t5303-pack-corruption-resilience.sh
    t/t5510-fetch.sh
    t/t6050-replace.sh
    t/t7700-repack.sh
    t/t7701-repack-unpack-unreachable.sh
    t/t9300-fast-import.sh

Just to be clear, I have to apply a patch (given below) to pu in order to
do any meaningful testing. This patch is the one I had ready to send to the
list to fix the SHELL_PATH breakage, but you beat me to the punch! :-P
(Also, your commit message was *much* better than mine!)

[my MinGW was installed from msysGit-fullinstall-1.7.4-preview20110204.exe
on Windows XP SP3]

ATB,
Ramsay Jones

--- >8 ---
diff --git a/run-command.c b/run-command.c
index 5be1b4b..53a081b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -4,7 +4,10 @@
 #include "sigchain.h"
 #include "argv-array.h"
 
-#ifndef SHELL_PATH
+#if defined(WIN32)
+# undef SHELL_PATH
+# define SHELL_PATH "sh"
+#elif !defined(SHELL_PATH)
 # define SHELL_PATH "/bin/sh"
 #endif
 
--- 8< ---
