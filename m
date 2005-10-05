From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on git clone
Date: Wed, 05 Oct 2005 09:59:41 -0700
Message-ID: <7v64sbyk5e.fsf@assigned-by-dhcp.cox.net>
References: <4343F480.30501@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 19:04:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENCdA-0007IM-DQ
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 19:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbVJERAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 13:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbVJERAP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 13:00:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50909 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030255AbVJERAN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 13:00:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005165935.EVCK776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 12:59:35 -0400
To: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9723>

Luben Tuikov <luben_tuikov@adaptec.com> writes:

> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?

Because HTTP support in git-fetch chooses not to trust the
directory index the HTTP server may spit out, and relies solely
on having info/refs file available there for discovering refs.

It is debatable if HTTP support in git-fetch should fall back on
discovery using "wget -r" like Cogito does, when the info/refs
file is not found.  I've written about this once on this list --
I demonstrated what you would see if you do "wget -r" against
git.git/refs/ on kernel.org; you will see why I do not think it
is necessarily a better approach.

Not doing refs discovery using directory index forces the owner
of an HTTP reachable repository to create info/refs by running
update-server-info.  This is a good thing -- it trains him to
behave.

update-server-info does not just create info/refs. It also
creates another file objects/info/packs, which is needed for
fetching over a commit walker if the repository is packed.
AFAIK, even if you are using Cogito, you would not succeed
pulling from a repository that is packed and does not have this
file.

There was a discussion about helping Cogito's tag-tracking.  The
downloading side needs to know if any new tag available on the
other side refers to a commit on the branches the downloader
tracks, without pulling everything that tag object refers to
first.  One way to help achieving this has been offered, which
would involve adding a bit more information to info/refs, to say
what object each tag refers to.  It could be done on the client
side, but it is far simpler if this kind of help is given on the
server side.

I anticipate in the future we may need to have more auxiliary
files, or to add more information to existing auxiliary files,
that summarize what the repository has for downloaders, and 
code to do so would be added to update-server-info, so the
repository owner needs to learn to run only one command.
