From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] rev-parse: Fix shell scripts whose cwd is a symlink into
 a git work-dir
Date: Tue, 25 Nov 2008 07:50:12 +0100
Message-ID: <492BA024.7080506@op5.se>
References: <cover.1226759762.git.marcel@oak.homeunix.org> <1227389614-10946-1-git-send-email-marcel@oak.homeunix.org> <m31vx3l94x.fsf@localhost.localdomain> <49290203.7060808@op5.se> <492B9321.8090706@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Tue Nov 25 07:51:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4rly-0005wg-3K
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 07:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbYKYGua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 01:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbYKYGu3
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 01:50:29 -0500
Received: from mail.op5.se ([193.201.96.20]:34706 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbYKYGu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 01:50:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id ED0461B80052;
	Tue, 25 Nov 2008 07:46:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3hsao2v31-H; Tue, 25 Nov 2008 07:46:01 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 5F41F1B80005;
	Tue, 25 Nov 2008 07:46:01 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <492B9321.8090706@oak.homeunix.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101650>

Marcel M. Cary wrote:
>> AFAIR, it was introduced to make test-builds of really large projects in
>> really deep directories with a ton of symlinks leading to the path work a
>> lot faster.
> 
> Andreas,
> 
> I see value in keeping Git very fast.  That is, after all, why I chose
> Git over Mercurial.  Do you know where that discussion was, if was in
> the archives?  I found these reasons to avoid absolute paths in the git
> archives:
> 
> * paths with more components are slower to work with (in the context of
>   add and diff, which deal with many many paths)
> * absolute paths may exceed PATH_MAX while relative ones didn't
> * getcwd() will fail if parent directories are not executable, or on
>   some platforms, if parent directories are not readable
> 
> My impression is that the performance issue is probably not significant
> for cd_to_toplevel since it's not in a tight inner loop, and dito for
> other potential callers of --show-cdup.  The PATH_MAX seems to be a
> restriction elsewhere in the code already.
> 

The performance issue does not come from cd_to_toplevel itself, but from
its callers. That is, if scripts start to use absolute paths from *other*
tight loops, that's when we hit a problem.

> Even if there were a scenario that put --show-cdup in a tight loop, I
> wonder whether current implementation provides much performance benefit,
> at least when bash is the calling language: bash seems to make the
> relative path absolute anyway inside the "cd" builtin.
> 
> The commit (5f94c730) that introduces that code doesn't mention
> performance.  It compares to:
> 
>   git rev-parse --show-prefix | sed -e 's|[^/][^/]*|..|g'
> 
> 
> I also noticed that this failure case with "--show-cdup" in a symlinked
> directory has come up more than once before.
> http://marc.info/?l=git&m=122452534912000&w=2
> http://marc.info/?l=git&m=121613416212958&w=2
> https://kerneltrap.org/mailarchive/git/2007/4/25/244653/thread
> 

I can imagine. However, --show-cdup has a different use too. It's nifty
for printing relative paths from commands running inside a subdirectory
of the repository. If you need the absolute path to the root of the repo,
I'd suggest you add "--show-absolute-path" instead.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
