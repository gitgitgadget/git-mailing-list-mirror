From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git diff-files weirdness (bug?)
Date: Fri, 23 May 2008 09:14:19 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805230906110.3081@woody.linux-foundation.org>
References: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 18:15:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzZvI-0001Td-7O
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 18:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754643AbYEWQOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 12:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbYEWQOY
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 12:14:24 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38486 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752231AbYEWQOX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 May 2008 12:14:23 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4NGEL2K013878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 May 2008 09:14:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4NGEJHn030297;
	Fri, 23 May 2008 09:14:20 -0700
In-Reply-To: <b0943d9e0805230720h61cbabbbw180908e1b28a34cc@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.41 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82719>


Looks like a real bug.

On Fri, 23 May 2008, Catalin Marinas wrote:
>
> I was investigating a bug in "stg refresh" failing with moved files
> and noticed that it was caused by Git (HEAD pulled yesterday):
> 
>   git init
>   touch a
>   git add a
>   git commit -m "test"
>   git mv a b
> 
> These are OK:
> 
>   git diff-files -- a
>   git diff-files -- b
> 
> These fail:
> 
>   git diff-files -- a b
>   git diff-files -- a c

Yes, that's buggy.

What happens is that we get to run_diff_files_cmd(), but then we don't 
actually do "run_diff_files()", because we go into the NO_INDEX case:

	if (DIFF_OPT_TST(&revs->diffopt, NO_INDEX)) {
		...

instead.

Which in turn is because "setup_diff_no_index()" is broken.

And I think "setup_diff_no_index()" is broken exactly because it sees that 
'--' and then totally ignores it and says "if I see two paths, we'll say 
it's the non-index case".

		Linus
