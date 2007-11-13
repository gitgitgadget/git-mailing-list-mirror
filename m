From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revert/cherry-pick: allow starting from dirty work tree.
Date: Tue, 13 Nov 2007 23:37:34 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711132154370.4362@racer.site>
References: <7vd4udsv6b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:38:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5LA-0002m9-Tx
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743AbXKMXhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761997AbXKMXhz
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:37:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:40226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761965AbXKMXhx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:37:53 -0500
Received: (qmail invoked by alias); 13 Nov 2007 23:37:52 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp005) with SMTP; 14 Nov 2007 00:37:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19iun0+b5liyvX1fllkl1KXzrA+M45E7RexE5hR1q
	mFHEHhh6NDyVDr
X-X-Sender: gene099@racer.site
In-Reply-To: <7vd4udsv6b.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64907>

Hi,

On Tue, 13 Nov 2007, Junio C Hamano wrote:

> There is no reason to forbid a dirty work tree when reverting or
> cherry-picking a change, as long as the index is clean.
> 
> The scripted version used to allow it:
> 
>     case "$no_commit" in
>     t)
>     	# We do not intend to commit immediately.  We just want to
>     	# merge the differences in.
>     	head=$(git-write-tree) ||
>     		die "Your index file is unmerged."
>     	;;
>     *)
>     	head=$(git-rev-parse --verify HEAD) ||
>     		die "You do not have a valid HEAD"
>     	files=$(git-diff-index --cached --name-only $head) || exit
>     	if [ "$files" ]; then
>     		die "Dirty index: cannot $me (dirty: $files)"
>     	fi
>     	;;
>     esac
> 
> but C rewrite tightened the check, probably by mistake.

Probably.  Thanks.

While we're at cherry-pick: Two days ago I had to rebase in a dirty 
working directory.  Why?  Because one of the submodules was not yet ready 
to be committed to the superproject.

And you cannot easily stash away a submodule.

Now, my quick and dirty solution was to hack a GIT_IGNORE_SUBMODULES 
patch: 
http://repo.or.cz/w/git/mingw/4msysgit.git?a=commitdiff;h=9ef6b6bff4e368934c4262af13b0a309be19ebd4

But the more fundamental question is: should we eventually have a mode in 
cherry-pick (or for that matter, apply!) which can change the submodule?  
And if so, how to go about it?

I could imagine that in this case, both apply and cherry-pick should call 
submodule with a to-be-created subcommand to reset the named submodule to 
a given commit, given the current commit (to avoid races, just as with 
update-ref <ref> <newsha1> <oldsha1>).  Of course, this subcommand would 
fail if the submodule's working directory is dirty.

Thoughts?

Ciao,
Dscho
