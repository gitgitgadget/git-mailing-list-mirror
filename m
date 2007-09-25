From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: commit when continuing after "edit"
Date: Tue, 25 Sep 2007 14:50:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709251439070.28395@racer.site>
References: <20070923224502.GB7249@potapov> <Pine.LNX.4.64.0709240121080.28395@racer.site>
 <7vlkav71bv.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709251249450.28395@racer.site>
 <46F90C95.5060903@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 15:52:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaAp6-00067Y-MW
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 15:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbXIYNva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 09:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbXIYNva
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 09:51:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:44455 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750977AbXIYNv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 09:51:29 -0400
Received: (qmail invoked by alias); 25 Sep 2007 13:51:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 25 Sep 2007 15:51:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX198S2cev6V8t/ykxRySH0cf1OL6bLiapNzVfaLMOl
	heAJTcV4Z/L8Ai
X-X-Sender: gene099@racer.site
In-Reply-To: <46F90C95.5060903@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59121>

Hi,

On Tue, 25 Sep 2007, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > On Mon, 24 Sep 2007, Junio C Hamano wrote:
> > > >  do_next () {
> > > >  	test -f "$DOTEST"/message && rm "$DOTEST"/message
> > > >  	test -f "$DOTEST"/author-script && rm "$DOTEST"/author-script
> > > > +	test -f "$DOTEST"/amend && rm "$DOTEST"/amend
> > > As you do not check the error from "rm", how are these different from rm
> > > -f "$DOTEST/frotz"?
> > 
> > The difference: the user will not see many irritating error messages.
> > 
> > I changed this code to use a newly written function "remove_if_exists",
> > which die()s if the file exists and could not be removed.
> 
> Why? rm -f does nothing if the file does not exist, and fails if it cannot
> remove an existing file. It all boils down to:
> 
> 	rm -f "$DOTEST"/message "$DOTEST"/author-script \
> 		"$DOTEST"/amend || exit

You're completely right.  I somehow assumed that it would print an 
annoying message, but I was wrong.

BTW I am continually amazed at the ease of rebase -i to fix issues like 
these in a patch series.  Thanks Eric!

> > > >  			# This is like --amend, but with a different message
> > > >  			eval "$author_script"
> > > >  			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
> > > > GIT_AUTHOR_DATE
> > > >  			$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
> > > >  			;;
> > > The "export" here makes me somewhat nervous -- no chance these
> > > leak into the next round?
> > 
> > I am somewhat wary: I get quoting wrong all the time.  Would
> > 
> > 	$USE_OUTPUT $author_script git commit -F "$MSG" $EDIT_COMMIT
> > 
> > work?  I have the slight suspicion that it would not, since
> > 
> > 	eval "$author_script"
> > 
> > needs extra quoting in $author_script, no?
> 
> How about:
> 
> 	eval "$author_script"
> 	GIT_AUTHOR_NAME="$GIT_AUTHOR_NAME" \
> 	GIT_AUTHOR_EMAIL="$GIT_AUTHOR_EMAIL" \
> 	GIT_AUTHOR_DATE="$GIT_AUTHOR_DATE" \
> 	$USE_OUTPUT git commit -F "$MSG" $EDIT_COMMIT
> 
> and if you dislike that, put the two questionable lines in parenthesis.

That looks ugly.  I'd rather have something like

	eval "$USE_OUTPUT $author_script git commit -F \"$MSG\" $EDIT_COMMIT"

but I'm not quite certain if that is enough, what with the funny 
characters people put into path names these days ($MSG points to 
"$DOTEST"/message).

BTW I just realised that the _same_ issue should have occurred in the 
"squash" case, but there I _forgot_ to export the environment variables.

Ciao,
Dscho
