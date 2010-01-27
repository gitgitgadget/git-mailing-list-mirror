From: Johan Herland <johan@herland.net>
Subject: Re: git notes issues (was: cvs revision number -> git commit name?)
Date: Wed, 27 Jan 2010 12:28:50 +0100
Message-ID: <201001271228.50992.johan@herland.net>
References: <hbf.20100126bda0@bombur.uio.no>
 <201001270043.44614.johan@herland.net>
 <7vpr4wq6w3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Aaron Crane <git@aaroncrane.co.uk>,
	Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 12:29:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na64w-0004z2-Fq
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044Ab0A0L2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 06:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823Ab0A0L2z
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:28:55 -0500
Received: from smtp.getmail.no ([84.208.15.66]:41049 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751755Ab0A0L2y (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:28:54 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00EZEL84LYD0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:28:52 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWW00E58L83N330@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Jan 2010 12:28:52 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.27.111219
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vpr4wq6w3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138128>

On Wednesday 27 January 2010, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > The notes feature is still very new, and there are still outstanding
> > patches to be merged, but the basics are there in v1.6.6.
> 
> By the way, we should seriously rethink how notes should propagate
>  through rebases and amends.  I've been using this in my post-applypatch
>  hook lately:
> 
> [...]
> 
> A few observations I made myself so far:
> 
>  - I used to fix minor issues (styles, decl-after-stmt, etc.) using
>    rebase-i long after running "am" in bulk, but these days I find myself
>    going back to my "inbox" and fix them in MUA; this is only because I
>    know these notes do not propagate across rebases and
>  amends---adjusting the workflow to the tool's limitation is not very
>  good.

Agreed. I simply haven't had time to look much into this yet. We should 
probably add options (both command-line options and config variables) to 
'git rebase', 'git commit --amend', 'git cherry-pick', etc. for bringing 
notes across a commit rewrite. We should probably also add "git notes 
move/copy <old_object> <new_object>" subcommands to make the same operations 
available to scripts (and users).

>  - The interface to tell tools to use which notes ref to use should be
>    able to say "these refs", not just "this ref" i.e. GIT_NOTES_REF=a:b
>    just like PATH=a:b:c...); I am fairly certain that we would want to
>    store different kind of information in separate notes trees and
>    aggregate them, as we gain experience with notes.

Agreed.

>  - There should be an interface to tell tools to use which notes refs via
>    command line options; "!alias" does not TAB-complete, and "git lgm"
>    above doesn't, either. "git log --notes=notes/amlog
>  --notes=notes/other" would probably be the way to go.

Agreed.

>  - While reviewing the "inbox", I sometimes wonder if I applied a message
>    to somewhere already, but there is no obvious way to grep in the notes
>    tree and get the object name that a note is attached to.  Of course I
>    know I can "git grep -c johan@herland.net notes/amlog" and it will
>  give me something like:
> 
>     notes/amlog:65807ee697a28cb30b8ad38ebb8b84cebd3f255d:1
>     notes/amlog:c789176020d6a008821e01af8b65f28abc138d4b:1
> 
>    but this won't scale and needs scripting to mechanize, once we start
>    rebalancing the notes tree with different fan-outs.  The end user (me
>    in this case) is interested in "set of objects that match this grep
>    criteria", not "the pathnames the notes tree's implementation happens
>    to use to store notes for them in the hierarchy".

Agreed. Should add a "git notes grep" subcommand.

I hope that once the updated notes API is in (I'll send an update to what's 
in 'pu' shortly), people will have the tools they need to start integrating 
notes with their pet Git features. As you illustrate perfectly above, there 
are many corners to be smoothed out before this is well integrated with the 
other Git tools.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
