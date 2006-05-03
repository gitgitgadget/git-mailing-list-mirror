From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitk highlight feature
Date: Wed, 3 May 2006 16:25:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605031612230.4086@g5.osdl.org>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0605021659430.4086@g5.osdl.org> <Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
 <17496.7073.507895.484698@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
 <17497.14311.121872.249120@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 01:26:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbQjZ-0007L5-Sr
	for gcvg-git@gmane.org; Thu, 04 May 2006 01:26:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWECX0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 19:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWECX0G
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 19:26:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5263 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751393AbWECX0E (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 19:26:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k43NPwtH023333
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 3 May 2006 16:25:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k43NPvLg019862;
	Wed, 3 May 2006 16:25:57 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17497.14311.121872.249120@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19534>



On Thu, 4 May 2006, Paul Mackerras wrote:
> 
> On my G5:
> 
> $ git-rev-list HEAD >all-revs
> $ time git-rev-list HEAD -- arch/powerpc >ppc-revs
> real    0m2.463s
> user    0m2.265s
> sys     0m0.191s
> $ time git-diff-tree -s --stdin -- arch/powerpc <all-revs >ppc-revs2
> real    0m5.269s
> user    0m4.794s
> sys     0m0.462s

Right. One of them prunes the history (git-rev-list). The other one does 
not.

That said, you need an "-r", I guess, to "git-diff-tree".

> Why does git-diff-tree -s --stdin produce so many more revisions than
> git-rev-list?

I guess it's officially a FAQ by now: see the "bug in git log" thread the 
other day, and

        http://www.gelato.unsw.edu.au/archives/git/0604/19180.html

so in general you can get _more_ of the "real commits" with "git-rev-list 
| git-diff-tree --stdin", because it won't prune out history on 
uninteresting branches. At the same time, that effect is counter-acted by 
git-diff-tree normally ignoring merges by default, which is a bigger 
issue.

Your big problem is just the lack of "-r", though:

> The git-diff-tree output includes commits such as
> 6ba815de, which only affects arch/i386/kernel/timers/timer_tsc.c.
> Confused.

Without the -r, git-diff-tree won't actually recurse, so it hits the 
"arch/" part (which does differ, and matches te revspec), and decides it's 
done.

With the "-r" thing, you still have a noticeable difference, but now it's 
due to the difference between "log" and "diff":

   git-rev-list HEAD -- arch/powerpc | wc -l
    -> 892
   git-rev-list HEAD | git-diff-tree -r -s --stdin -- arch/powerpc/ | wc -l
    -> 838

ie "diff" doesn't show merges nomally (with -m, you _will_ get merges, but 
you'll sometimes get them twice - once against each parent ;)

		Linus
