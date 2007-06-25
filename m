From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Mon, 25 Jun 2007 15:20:16 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
References: <87r6nzu666.fsf@rho.meyering.net>
 <alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
 <878xa7u2gh.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Tue Jun 26 00:20:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2wvJ-0007ba-Q3
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 00:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032AbXFYWUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 18:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755000AbXFYWUe
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 18:20:34 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55474 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754909AbXFYWUd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jun 2007 18:20:33 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PMKLED016335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 25 Jun 2007 15:20:22 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5PMKG3I012425;
	Mon, 25 Jun 2007 15:20:16 -0700
In-Reply-To: <878xa7u2gh.fsf@rho.meyering.net>
X-Spam-Status: No, hits=-4.575 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50932>



On Mon, 25 Jun 2007, Jim Meyering wrote:
> 
> Remember: I'm trying to improve existing code here.
> You should save some of your ire for the person who wrote that code.

Ehh. Remind me who I should be pissed at when the old code was _better_ 
before your change?

With the current git.c, we report write errors quite well. We don't give 
the exact output you want, but on a scale of 1-10, how important is that? 
Pretty damn low on the list.

And the reason I'm really really irritated at you is that you ignore me 
when I tell you what your bugs are.

 - I *told* you that EPIPE is special. What did you do? Ignore my advice, 
   and made a broken patch that did exactly the opposite of what I told 
   you.

 - And I *told* you that you shouldn't care about errno for stdio, because 
   stdio was broken. What did you do? You again ignored my advice, and 
   made _another_ broken patch, exactly the _opposite_ of what I told you.

If you really really *must* get that ENOSPC error string output, create a 
helper function like

	void flush_or_die(FILE *f, const char *desc)
	{
		if (ferror(f))
			die("write failure on %s", desc)
		if (fflush(f)) {
			if (errno == EPIPE)
				exit(0);
			die("write failure on %s: %s",
				desc, strerror(errno));
		}
	}

and then you can start adding calls to "flush_or_die()" to appropriate 
places. You could replace the "fflush()" in builtin-rev-list.c with a 
"flush_or_die()".

And then you could add a call to "log_tree_commit()" (in log-tree.c), and 
that would probably be an improvement too (especially if we start having 
things like gitk parse "git log" output, and try to deprecate the old 
really low-level plumbing a bit).

			Linus
