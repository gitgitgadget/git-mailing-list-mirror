From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH 2/2] make remote hangup warnings more friendly
Date: Wed, 4 Mar 2009 11:04:52 -0800
Message-ID: <20090304190452.GJ14365@spearce.org>
References: <20090303184106.GH14365@spearce.org> <20090304084245.GB31798@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 20:07:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LewQF-00016S-Jh
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 20:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755860AbZCDTE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 14:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755656AbZCDTEy
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 14:04:54 -0500
Received: from george.spearce.org ([209.20.77.23]:40895 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434AbZCDTEy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 14:04:54 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4A56C38211; Wed,  4 Mar 2009 19:04:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090304084245.GB31798@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112236>

Jeff King <peff@peff.net> wrote:
> When a user asks to do a remote operation but the remote
> side thinks the operation is invalid (e.g., because the user
> pointed to a directory which is not actually a repository),
> then we generally end up showing the user two fatal
> messages: one from the remote explaining what went wrong, and
> one from the local side complaining of an unexpected hangup.
> 
> For example:
> 
>   $ git push /nonexistent master
>   fatal: '/nonexistent' does not appear to be a git repository
>   fatal: The remote end hung up unexpectedly
 
> In this case, the second message is useless noise, and the
> user is better off seeing just the first.
> 
> This patch tries to suppress the "hung up" message when it
> is redundant (but still exits with an error code, of
> course).

Hmm.  It would be nice to clean up these messages, but I
think the better way to do it is...
 
>      I think this would be improved somewhat with stderr processing to:
> 
>        remote: sh: bogus: command not found

... because then we can have positive proof that the remote said
something to the user, and we tagged it as being from the remote
side, just like we do with progress data in sideband, and then the
user can work from that information.  Any local side errors are
very likely caused by the remote errors, so we shouldn't bother
displaying them.

But its a lot more invasive of a patch to setup stderr processing
for pipe/SSH.

Actually, the remote stderr processing is desired for more than
just the bad path case.  Its good for when the remote aborts with
a write error from a write_or_die(), at least we know it was on
the remote side and not the local.  Its good for when the remote
shell says a "git-upload-pack: command not found".  Its good for
when the remote hook prints output, the client knows it came from
the remote side and not something local, so its messages should be
read in the context of the remote side.  Etc.
 
-- 
Shawn.
