From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Use line buffering for standard output
Date: Sun, 3 Aug 2008 22:50:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808032241260.3668@nehalem.linux-foundation.org>
References: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk> <alpine.LFD.1.10.0808031444270.3668@nehalem.linux-foundation.org> <87hca1ogto.fsf@cup.kalibalik.dk> <7vej557hlq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anders Melchiorsen <mail@cup.kalibalik.dk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 07:52:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPszz-0006vK-8w
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 07:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753679AbYHDFvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 01:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753544AbYHDFvt
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 01:51:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41261 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751850AbYHDFvs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Aug 2008 01:51:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m745ol31029551
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 3 Aug 2008 22:50:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m745oiNZ025621;
	Sun, 3 Aug 2008 22:50:45 -0700
In-Reply-To: <7vej557hlq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-5.414 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91318>



On Sun, 3 Aug 2008, Junio C Hamano wrote:

> Anders Melchiorsen <mail@cup.kalibalik.dk> writes:
> >  
> >  #ifndef __MINGW32__
> > +	/* Flush output before fork() to avoid cloning the buffer */
> > +	fflush(stdout);
> > +
> >  	async->pid = fork();
> >  	if (async->pid < 0) {
> >  		error("fork (async) failed: %s", strerror(errno));
> 
> I think this with s/stdout/NULL/ would be a reasonable thing to do.

Agreed, I think that's the right thing to do. 

There's another fork there in start_command(), I suspect we should do it 
there too: it's a "generic" path, so it should try to be safe.

The other ones look ok from a quick scan. I don't know the imap-send.c 
code, but it's from outside people who hopefully know what they were 
doing. The other ones don't seem to be using stdio before the fork (except 
for things like "die()" ;)

There is a "fork()" in a _comment_ in builtin-ls-tree.c, and that one 
definitely should have a fflush(NULL) in front of it. But it _is_ just a 
comment, and rather than addign a fflush() there, it would probably be 
better to turn it into a "start_command()" or something like that.

			Linus.
