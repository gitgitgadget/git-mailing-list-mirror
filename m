From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] git-split: Split the history of a git repository by
 subdirectories and ranges
Date: Mon, 23 Oct 2006 08:52:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610230846420.3962@g5.osdl.org>
References: <451A30E4.50801@freedesktop.org> <7vlko5d3bx.fsf@assigned-by-dhcp.cox.net>
 <453C96C9.4010005@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 17:53:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc26k-0000Eh-Gl
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 17:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWJWPwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 11:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWJWPwy
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 11:52:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14800 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751054AbWJWPwx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 11:52:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NFqlaX019119
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 08:52:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NFqkox028411;
	Mon, 23 Oct 2006 08:52:46 -0700
To: Josh Triplett <josh@freedesktop.org>
In-Reply-To: <453C96C9.4010005@freedesktop.org>
X-Spam-Status: No, hits=-0.978 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29838>



On Mon, 23 Oct 2006, Josh Triplett wrote:
> 
> > I wonder if using "git-log --full-history -- $project" to let the core 
> > side omit commits that do not change the $project (but still give you 
> > all merged branches) would have made your job any easier?
> 
> I don't think it would.  We still need to know what commit to use as the
> parent of any given commit, so we don't want commits in the log output
> with parents that don't exist in the log output.  And rewriting parents
> in git-log based on which revisions change the specified subdirectory
> seems like a bad idea.

Umm.. You didn't realize that git log already _does_ exactly that?

You need to rewrite the parents in order to get a nice and readable 
history, which in turn is needed for any visualizer. So git has long done 
the parent rewriting in order to be able to do things like

	gitk drivers/char

on the kernel.

And yes, that's done by the core revision parsing code, so when you do

	git log --full-history --parents -- $project

you do get the rewritten parent output (of course, it's not actually 
_simplified_, so you get a fair amount of duplicate parents etc which 
you'd still have to simplify and which don't do anything at all).

Without the "--full-history", you get a simplified history, but it's 
likely to be _too_ simplified for your use, since it will not only 
collapse multiple identical parents, it will also totally _remove_ parents 
that don't introduce any new content.

So there are multiple levels of history simplification, and right now the 
internal git revision parser only gives you two choices: "none" 
(--full-history) and "extreme" (which is the default when you give a set 
of filenames). 

			Linus
