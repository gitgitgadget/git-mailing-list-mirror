From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] allow setting GIT_WORK_TREE to "no work tree"
Date: Fri, 08 Feb 2008 08:21:25 +0100
Message-ID: <47AC02F5.9080705@viscovery.net>
References: <20080206102608.GA1007@coredump.intra.peff.net> <47A98F07.4000402@viscovery.net> <alpine.LSU.1.00.0802071855550.8543@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:22:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNNYi-0000HT-3k
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 08:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbYBHHVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 02:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbYBHHVb
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 02:21:31 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22895 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932225AbYBHHVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 02:21:30 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JNNXk-0003jF-Jz; Fri, 08 Feb 2008 08:21:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 36C8DA33B; Fri,  8 Feb 2008 08:21:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.LSU.1.00.0802071855550.8543@racer.site>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73047>

Johannes Schindelin schrieb:
> Hi,
> 
> On Wed, 6 Feb 2008, Johannes Sixt wrote:
> 
>> Jeff King schrieb:
>>> In setup_git_directory_gently, we have a special rule that says "if 
>>> GIT_DIR is set but GIT_WORK_TREE is not, then use the current working 
>>> directory as the work tree." This is the intended behavior for the 
>>> user perspective.
>>>
>>> However, setup_git_directory_gently sets GIT_DIR itself, meaning that 
>>> further setups (either because we are executing a command via alias, 
>>> or in a subprocess) will see the non-existent GIT_WORK_TREE and assume 
>>> we fall into the "current working directory is the working tree" 
>>> codepath.
>>>
>>> Instead, we now use a special value of GIT_WORK_TREE to indicate that 
>>> we have already checked for a worktree and that there isn't one, 
>>> setting it when we set GIT_DIR and checking for it in the special case 
>>> path.
>>>
>>> The special value is a blank GIT_WORK_TREE; it could be any value, but 
>>> this should not conflict with any user values (and as a bonus, you can 
>>> now tell git "I don't have a work tree" with "GIT_WORK_TREE= git", 
>>> though I suspect the use case for that is limited).
>> Hrm. Unfortunately, on Windows there is no such thing as an empty 
>> environment string. setenv(x, "") *removes* the environment variable.
> 
> That might be a shortcoming of our implementation of setenv():

No, it is not. It's Windows's putenv(), and it's even documented.

> -- snip --
> cd /git
> 
> cat > a1.c << EOF
> #include <stdio.h>
> #include "compat/setenv.c"
> #include "compat/unsetenv.c"
> 
> static void p()
> {
> 	const char *abc = getenv("ABC");
> 	printf("env ABC: %s\n", abc ? abc : "(null)");
> }
> 
> int main()
> {
> 	p();
> 	gitsetenv("ABC", "Hello", 1);
> 	p();
> 	gitsetenv("ABC", "", 1);
> 	p();
> 	gitunsetenv("ABC");
> 	p();
> 	return 0;
> }
> EOF
> 
> gcc -DNO_MMAP=1 -I. -Icompat -o a1.exe a1.c
> 
> ABC="" ./a1.exe 
> -- snap --
> 
> This will show
> 
> env ABC: 
> env ABC: Hello
> env ABC: (null)
> env ABC: (null)
> 
> So it seems that environment variables _can_ be empty.  Just our 
> relatively stupid implementation of setenv() does not do it.
> 
> Maybe something like compat/unsetenv.c is needed in setenv(), too.

This only shows that, yes, variables _can_ be empty - if the setenv/putenv
implementation is "sane", like MSYS/bash's.

That said, we probably should modify environ directly in gitsetenv().

-- Hannes
