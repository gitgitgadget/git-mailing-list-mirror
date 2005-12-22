From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] sanity check in add_packed_git()
Date: Wed, 21 Dec 2005 20:58:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512212046340.25300@iabervon.org>
References: <1135208829.15567.18.camel@dv> <7v7j9xvrf3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 02:57:47 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpFi9-0006p2-ME
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 02:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVLVB5i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 20:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVLVB5i
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 20:57:38 -0500
Received: from iabervon.org ([66.92.72.58]:776 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965032AbVLVB5i (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Dec 2005 20:57:38 -0500
Received: (qmail 14065 invoked by uid 1000); 21 Dec 2005 20:58:45 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Dec 2005 20:58:45 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j9xvrf3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13929>

On Wed, 21 Dec 2005, Junio C Hamano wrote:

> Pavel Roskin <proski@gnu.org> writes:
> 
> > add_packed_git() tries to get the pack SHA1 by parsing its name.  It may
> > access uninitialized memory for packs with short names.
> 
> Thanks.
> 
> This fixes when there is ".git/objects/packs/junk-X.pack", so in
> that sense it is a real fix and I'll take it.
> 
> However, I feel a bit uneasy about this whole thing.  The core
> does not care how you name your packs, as long as .pack and .idx
> files have the same prefix, but we started relying on the prefix
> being "pack-" followed by 40 hexadecimal digits since we started
> packed repository support in http-fetch, and we also allowed
> sha1_pack_name() function that shares the assumption to sneak
> into the real core part of the system around the same time (end
> of July 2005).  git-repack and git-verify-pack stay ignorant
> about this prefix convention and I think that is a good
> property.  However, we might be better off if we declare that
> the pack files *must* be named following that convention
> (currently nobody enforces it, but as long as the user uses "git
> repack" to create packs, the packs automatically follow that
> convention), and make check_packed_git_idx() reject a packfile
> whose name does not begin with "pack-" or the 40 hexdigits that
> follow does not match the hash of the object names the index
> records.  If we go that route, then this patch becomes unneeded;
> more extensive check needs to be done in check_packed_git_idx().
> 
> Thoughts?

I'd like to require it to be a hash, just because that makes it 
prohibitively difficult to make something people will accept as
pack-05f611b3b8198b262acdf678584d365f8e879aec.pack other than the one from 
the git repository. Sure, it would only be a minor DoS and a bit of 
confusion, because it still couldn't do any worse than contain some 
different objects, but it would block people from getting the pack with 
the objects they want. Since nobody seems interested in naming their 
packs, so far as I know, it seems best to force the names to be 
universally unique, modulo an incredible coincidence.

	-Daniel
*This .sig left intentionally blank*
