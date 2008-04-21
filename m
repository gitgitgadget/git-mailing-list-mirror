From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Mon, 21 Apr 2008 12:09:43 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804211203460.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com> <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org> <20080420215700.GA18626@bit.office.eurotux.com> <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org> <7vk5isatpe.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0804201959590.2779@woody.linux-foundation.org> <7v3apfawry.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 21:11:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo1QD-0003vV-5A
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 21:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbYDUTKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 15:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYDUTKj
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 15:10:39 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48345 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753759AbYDUTKi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Apr 2008 15:10:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3LJ9ifQ019378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Apr 2008 12:09:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3LJ9hP6001820;
	Mon, 21 Apr 2008 12:09:44 -0700
In-Reply-To: <7v3apfawry.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.919 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80035>



On Mon, 21 Apr 2008, Junio C Hamano wrote:
> 
> Doesn't it become very tempting to replace lstat() calls we make to check
> the status of a work tree path, with a function git_wtstat() that is:

Yes.

That looks like a very good abstraction.

>                 /*
>                  * As far as git is concerned, this does not exist in
>                  * the work tree!
>                  */
>                 errno = ENOENT;
>                 return -1;
>         }

Well, how about returning something else than "ENOENT" here? 

As you point out, git doesn't actually think this is a "does not exist" 
case, but something else that may require more work:

> This unfortunately is not enough to hide the need for has_symlink calls
> from outside callers.  When we check out a new path "a/b/c/d/e", for
> example, if we naively checked if we creat(2) "a/b/c/d/e" (and otherwise
> we try the equivalent of "mkdir -p"), we would be tricked by a symlink
> "a/b" that points at some random place that has "c/d" subdirectory in it,
> and we need to unlink "a/b" first, and the above git_wtstat() does not
> really help such codepath.

Maybe ENOTDIR would be a better error return? That would conceptually be 
what an OS that refuses to follow symlinks at path walk time (because it 
doesn't support symlinks as such) would return: the symlink component 
would not be a directory, so it's as if you were trying to use a path 
a/b/c/d/e where "a/b" isn't even a directory.

In fact, even on Linux, ENOTDIR is what an lstat() would return if "b" had 
been turned from a directory into a regular file - which is conceptually 
(for git) _exactly_ the same as "b" being a symlink.

No?

			Linus
