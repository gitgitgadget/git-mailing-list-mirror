From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Tue, 02 Nov 2010 09:48:22 +0100
Message-ID: <201011020948.22677.johan@herland.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <20101102065208.GA4280@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Kenny Root <kroot@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 02 09:48:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDCXg-00043f-Uy
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 09:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab0KBIs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 04:48:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:38717 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927Ab0KBIs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 04:48:26 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LB90055J1SPVY80@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 02 Nov 2010 09:48:25 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 349DE179906F_CCFD059B	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 08:48:25 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id F41FC1796203_CCFD058F	for <git@vger.kernel.org>; Tue,
 02 Nov 2010 08:48:23 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LB900LSE1SNSI10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 02 Nov 2010 09:48:23 +0100 (MET)
User-Agent: KMail/1.13.5 (Linux/2.6.35-ARCH; KDE/4.5.2; x86_64; ; )
In-reply-to: <20101102065208.GA4280@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160511>

On Tuesday 02 November 2010, Jonathan Nieder wrote:
> (+cc: Johan, Thomas)
> 
> Kenny Root wrote:
> > Git notes were restricted to refs/notes/* in the command line
> > utilities, but setting things like GIT_NOTES_REF to something outside
> > of that structure would work.
> > 
> > This removes the restrictions on the git notes command line interface.

Why do you need to set GIT_NOTES_REF to something outside refs/notes/ at 
all?

> Could you explain what those restrictions are (perhaps through an
> example in the form of a patch to the t/ subdirectory)?

Yes, please do. As it stands, I'm pretty sure the patch below breaks at 
least TCs t3301.4 and t3301.5.

> Cc-ing some people more knowledgeable about notes than I am; maybe
> they can give more information about what this notes.rewriteref
> protection and other check are about.

Well, I guess we originally decided to limit notes refs to within 
refs/notes/ in order to clearly separate notes from non-notes, and to 
prevent notes code from accidentally messing up non-notes refs.

Later, we have discovered that in order to work with remote notes refs, we 
probably have to lift this restriction, and allow (at least) notes refs 
somewhere within refs/remotes/, e.g. refs/remotes/*/notes/.

http://thread.gmane.org/gmane.comp.version-control.git/159469/focus=159703 
and its sub-thread contains more discussion on sharing notes with remote 
repos.

So, in conclusion, this patch is a move in the right direction, but in some 
respects it might be going a bit _too_ far: Maybe we should restrict notes 
to refs/notes/ and refs/remotes/*/notes/? ...or maybe I'm too paranoid, and 
allowing notes "everywhere" is ok. Then again, in other respects this patch 
isn't going far enough, since it doesn't deal with setting up the refspecs 
needed to make notes sharing easy and straighforward for end users.

> [patch follows for their convenience.]
> [...]
> > @@ -844,7 +837,7 @@ int cmd_notes(int argc, const char **argv, const
> > char *prefix)
> > 
> >  	if (override_notes_ref) {
> >  	
> >  		struct strbuf sb = STRBUF_INIT;
> > 
> > -		if (!prefixcmp(override_notes_ref, "refs/notes/"))
> > +		if (!prefixcmp(override_notes_ref, "refs/"))
> > 
> >  			/* we're happy */;
> >  		
> >  		else if (!prefixcmp(override_notes_ref, "notes/"))
> >  		
> >  			strbuf_addstr(&sb, "refs/");

FTR, this hunk will surely conflict with the introduction of 
expand_notes_ref() which is in patch 09/23 in the 'git notes merge' series 
in 'pu'.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
