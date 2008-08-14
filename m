From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why doesn't git-apply remove empty file
Date: Thu, 14 Aug 2008 12:57:09 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141246190.3324@nehalem.linux-foundation.org>
References: <38b2ab8a0808120917h10f15c81v4d1f04c0174dc994@mail.gmail.com>  <7vod3xpxq2.fsf@gitster.siamese.dyndns.org>  <38b2ab8a0808130048t506dbb7ah1d6fcd6bd4f3c90c@mail.gmail.com>  <48A357BA.8060003@lsrfire.ath.cx>  <alpine.LFD.1.10.0808131602200.3462@nehalem.linux-foundation.org>
 <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 21:59:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTiyX-0001do-Fk
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 21:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYHNT6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 15:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753517AbYHNT6H
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 15:58:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45612 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947AbYHNT6G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 15:58:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EJvACq011481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 12:57:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EJv9wF026684;
	Thu, 14 Aug 2008 12:57:10 -0700
In-Reply-To: <38b2ab8a0808141242k4bd6867dt8ef54f160713061f@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92392>



On Thu, 14 Aug 2008, Francis Moreau wrote:
> 
> Well patch(1) is so used out there that makes git-apply often do the
> wrong thing for such corner cases when applying a patch made by
> patch(1).
> 
> Maybe git-apply would be more friendly regarding patch(1) if it has an
> option to emulate GNU patch for some situations. Or if this means
> adding too many quirks in git-apply code, maybe give the possibity for
> git-am to use patch(1) instead of git-apply.

The thing is, "patch" is a total piece of utterly unbelievable SH*T.

git-apply acts differently, yes, but it acts differently for a damn good 
reason. No, you cannot replace git-apply with that horrible crap that is 
GNU patch.

Some of the reasons are purely trivial implementation issues:

 - git-apply knows about the index, and knows about updating it properly, 
   including tracking new files automatically.

That's an important thing, but yeah, it's an implementation issue.

The other things that git-apply do right are much more fundamental:

 - git apply doesn't leave half-applied state turds around when a patch 
   fails.

   People who actually use "patch" for large projects will know the pain 
   here: if a diff fails in the middle, GNU patch will have applied the 
   previous parts (including to other files), and it's now your problem to 
   fix it up. There's no way to do an all-or-nothing patch, which is often 
   a huge requirement.

 - git apply doesn't guess (unless you really tell it to, and even then it 
   will guess a whole lot less than GNU patch). If a "git apply" succeeds, 
   it was probably good. If a GNU patch invocation succeeds, it might have 
   been total and utter crap, but hey, it tried to apply that piece of 
   shit very aggressively even when it made no sense and the context 
   didn't actually match even _remotely_.

   Yeah, context diffs can still mis-apply even with git apply, but they 
   do so a hell of a lot less than with GNU patch, and if you want it to 
   just generate a random end result, you at least have to _ask_ for it.

So no. There's no way in hell that git am should use GNU patch.

But as mentioned, if somebody wants to parse the dates, we could do that. 

			Linus
