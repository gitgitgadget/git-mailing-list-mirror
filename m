From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git diff-files weirdness (bug?)
Date: Fri, 23 May 2008 09:50:55 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805230942480.3081@woody.linux-foundation.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com> <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 23 18:53:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzaVh-0001Py-C7
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 18:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYEWQwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 12:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752383AbYEWQwA
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 12:52:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55884 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751109AbYEWQv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 12:51:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4NGour5016743
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 May 2008 09:50:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4NGot6K031644;
	Fri, 23 May 2008 09:50:55 -0700
In-Reply-To: <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.409 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82722>



On Fri, 23 May 2008, Linus Torvalds wrote:
> 
> And I think "setup_diff_no_index()" is broken exactly because it sees that 
> '--' and then totally ignores it and says "if I see two paths, we'll say 
> it's the non-index case".

Actually, I think it's broken not so much because it ignores '--', but 
because it's just way too eager to do the "non-git" case.

Basically, it is trying to act like a traditional "diff", but in doing so 
it disables the normal "git diff" semantics. Which is incorrect, when you 
actually _want_ the normal "git diff" behaviour.

So I would suggest that we make it *much* harder to trigger the "make it 
act like a traditional 'diff'" thing.

I would suggest that we *not* invoce the traditional 'diff' behaviour 
when:

 - we're called as "git-diff-files". That's clearly a git thing. Don't try 
   to make it act like an external non-git diff. Only do the special case 
   for plain "git diff" itself.

 - even for plain "git diff", make it much harder to trigger non-git 
   behaviour. Don't do it if the files don't exist. Don't do it if there 
   is '--' there.

In fact, maybe we should remove that thing entirely, or *require* a flag 
to enable it (at least if we're in a git directory). It's a cute hack, but 
when the cute hack actually makes it impossible to do certain real git 
operations, it's a cute hack that is detrimental.

		Linus
