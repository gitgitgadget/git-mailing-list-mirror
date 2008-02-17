From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sun, 17 Feb 2008 23:28:58 +0000
Message-ID: <20080217232858.GA6249@hashpling.org>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org> <alpine.LSU.1.00.0802170045210.30505@racer.site> <20080217005620.GB504@hashpling.org> <7vbq6g758h.fsf@gitster.siamese.dyndns.org> <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de> <20080217214942.GJ8905@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Feb 18 00:30:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQsxV-0007ZE-7o
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 00:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbYBQX3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 18:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbYBQX3e
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 18:29:34 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:59687 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501AbYBQX3e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 18:29:34 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1JQswV-0000Ij-9o; Sun, 17 Feb 2008 23:29:07 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HNSxom007154;
	Sun, 17 Feb 2008 23:28:59 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HNSwRv007153;
	Sun, 17 Feb 2008 23:28:58 GMT
Content-Disposition: inline
In-Reply-To: <20080217214942.GJ8905@mit.edu>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 2a12202f5526ae73b87ea1c4dd48eb12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74205>

On Sun, Feb 17, 2008 at 04:49:42PM -0500, Theodore Tso wrote:
> I think it *would* be better to use %(foo) extrapolation that
> environment variables, so that it's not required for users to write
> shell scripts unless absolutely necessary.

I understand that %(foo) is neater, but this would make the shell
implementation significantly more complex, and also potentially less
flexible (e.g. if you needed to do the opendiff style |cat trick or
some similar shell trickery).

The reason that I first posted a patch for a different config variable
for baseless merges was because I was that a significant number of
merge tools have significantly different syntaxes for two and three
way merges and I thought that it might be easier for users to do
something like:

git config mergetool.mymerge.cmd 'mytool --3way "$BASE" "$LOCAL" \
"$REMOTE" "$MERGED"'

git config mergetool.mymerge.cmdNoBase 'mytool --2way "$LOCAL" \
"$REMOTE" "$MERGED"'

than it would be to do something like (totally untested):

git config mergetool.mymerge.cmd 'if test -f "$BASE"; then;\
 mytool --3way "$BASE" "$LOCAL" "$REMOTE" "$MERGED"; else; \
 mytool --2way "$LOCAL" "$REMOTE" "$MERGED"; fi'

So in the former case you are still using shell syntax, but a simple
subset of shell should suffice for most needs.  The later case
requires more wizardry.

> When we get around to rewriting git-mergetool in C, it might make
> sense to put the tool support in the various shell scripts that are
> installed in the git helper binary directory (i.e.,
> git-mergetool-kdiff3, git-mergetool-meld, etc.)  That would make it
> easier for users to create new shell scripts to support new tools if
> necessary.
> 
> 					- Ted

This makes sense to me, although I have to say that I'm not really
sure I see the value of turning git-mergetool into C.  It seems to
make a lot of sense as a shell helper, but is it a general principle
that all of git's commands should eventually be converted to C?

Charles.
