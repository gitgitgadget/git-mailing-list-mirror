From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/02/RFC] implement a stat cache
Date: Sun, 20 Apr 2008 20:20:09 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804202016080.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org> <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl> <alpine.LFD.1.10.0804191515120.2779@woody.linux-foundation.org>
 <20080420111346.GA13411@bit.office.eurotux.com> <alpine.LFD.1.10.0804200836310.2779@woody.linux-foundation.org> <20080420215700.GA18626@bit.office.eurotux.com> <alpine.LFD.1.10.0804201520370.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804201556290.2779@woody.linux-foundation.org> <7vk5isatpe.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0804201959590.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Luciano Rocha <luciano@eurotux.com>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 05:21:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnmag-0003Ez-IE
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 05:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759406AbYDUDU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 23:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759255AbYDUDUZ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 23:20:25 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55067 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759134AbYDUDUY (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2008 23:20:24 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3L3KAUV018971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 Apr 2008 20:20:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3L3K9ku030381;
	Sun, 20 Apr 2008 20:20:09 -0700
In-Reply-To: <alpine.LFD.1.10.0804201959590.2779@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.929 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80011>



On Sun, 20 Apr 2008, Linus Torvalds wrote:
> On Sun, 20 Apr 2008, Junio C Hamano wrote:
> > 
> > If you have a tracked path a/b/c/d/e, and you changed your work tree to
> > make a/b to a symlink that points at a random directory, potentially
> > even outside work tree, that has c/d/e in it, we should not be fooled by
> > the fact that lstat("a/b/c/d/e") says "yup, the file exists".  As far as
> > git is concerned, that path does _not_ exist, as "a/b" is a symlink now.
> 
> Ok, I can see the logic behind that, but the code is really dense and hard 
> to read. And obviously very inefficient.

One more note: I think that if we really care about this, we should do 
this inside "ce_match_stat()", so that we catch it in *all* the cases 
where we match against the stat information. 

As it is, the "diff" mechanism (and "apply") knows to check whether a 
directory has changed into a symlink, but it looks like doing a simple 
"git update-index --refresh" will never even test it, so it will never 
notice that the index isn't actually up-to-date if a directory has been 
moved and the old directory has been replaced by a symlink to the new 
location.

Hmm?

		Linus
