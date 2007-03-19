From: Theodore Tso <tytso@mit.edu>
Subject: Re: git push to a non-bare repository
Date: Sun, 18 Mar 2007 23:33:40 -0400
Message-ID: <20070319033340.GG11371@thunk.org>
References: <vpq648ye9w6.fsf@olympe.imag.fr> <20070319020053.GA11371@thunk.org> <7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net> <20070319022143.GF20658@spearce.org> <20070319024744.GD11371@thunk.org> <20070319025603.GG20658@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8d0-0007Wl-OB
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933818AbXCSDdp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933827AbXCSDdp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:33:45 -0400
Received: from THUNK.ORG ([69.25.196.29]:49414 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933818AbXCSDdo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:33:44 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HT8il-0001cg-6l; Sun, 18 Mar 2007 23:39:43 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HT8cu-000075-Hq; Sun, 18 Mar 2007 23:33:40 -0400
Content-Disposition: inline
In-Reply-To: <20070319025603.GG20658@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42576>

On Sun, Mar 18, 2007 at 10:56:03PM -0400, Shawn O. Pearce wrote:
> > When I was talking about a hook to enforce the BitKeeper semantics,
> > the question is whether we have enough to enforce the following:
> > 
> > 	* Only accept the push if it will result in a fast-forward
> > 		merge (and if not, tell the user to do a git pull, merge
> > 		locally, and then redo the git push)
> 
> Yes, the update hook can detect this.  Actually receive-pack by
> default rejects *all* non-fast-forward pushes, even if the client
> side uses --force.

Ah, so that's controlled by receive.denyNonFastForwards, right?  Cool,
I missed that.  Thanks!!

Documentation/config.txt doesn't say it defaults to true, but from
your comments that is the default?

> > 	* Only accept the push if there are no locally modified files
> > 		that would be affected when the working directory is
> > 		updated to reflect the new HEAD
> 
> The update hook could also perform this check; test if the ref
> being updated is the current branch, and if so, verify the index and
> working directory is clean.  That's a simple run of git-symbolic-ref
> (to get the current branch) and git-runstatus (to check the index
> and working directory), is it not?
> 
> If git-runstatus exits to indicate the tree is clean (nothing to
> commit) then a simple `read-tree -m -u HEAD $new` should update
> the working directory and index, right?

What git-runstatus will allow me to do is to abort if there are any
local modifications, regardless of whether or not they would conflict
with the working tree update.  The key phrase in my criteria was no
locally modified files "THAT WOULD BE AFFECTED".

What I could do with BitKeeper is that I could modify some file like
schedule.html on my webserver, and then push a changeset from my
laptop to would update sermons.html, and it would allow the push ---
since it would change the file sermons.html, and not touch
schedule.html.

But if I modified schedule.html on my laptop and then committed it,
and *then* try to push that changeset to the webserver, it would abort
since in order to accept the changeset, it would have to update the
working tree, and that would clash with the locally modified
schedule.html file.  At thta point I'd have to login to the webserver,
revert the local modification and bring it back down my laptop and
include it in a proper changeset.

Yeah, I probably shouldn't have ever modified the file locally on the
webserver, but that would sometimes happen when I was in a rush, and
it was nice when it Just Worked.

						- Ted
