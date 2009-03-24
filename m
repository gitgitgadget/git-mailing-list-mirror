From: Jeff King <peff@peff.net>
Subject: Re: How to go to git from svn without checkout
Date: Tue, 24 Mar 2009 04:10:50 -0400
Message-ID: <20090324081050.GA660@coredump.intra.peff.net>
References: <22640020.post@talk.nabble.com> <20090322032008.GA9526@coredump.intra.peff.net> <FB1F526D99571D4DBF84F456D358792901CC7F6F@leasrv003.imagitek.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Samman, Bassel" <Bsamman@imagitekltd.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:12:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1kP-0007xg-Bi
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbZCXILB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753285AbZCXILA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:11:00 -0400
Received: from peff.net ([208.65.91.99]:47911 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753088AbZCXIK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:10:59 -0400
Received: (qmail 27969 invoked by uid 107); 24 Mar 2009 08:11:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 04:11:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 04:10:50 -0400
Content-Disposition: inline
In-Reply-To: <FB1F526D99571D4DBF84F456D358792901CC7F6F@leasrv003.imagitek.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114422>

On Mon, Mar 23, 2009 at 10:21:41AM -0500, Samman, Bassel wrote:

> Yes, unfortunately they do change occasionally and they grow with
> time.  It's a product catalogue, so new products are added all the
> time, just not daily.  That's part of why I want to move to Git, SVN

Well, I would first try just importing _one_ repo into git and seeing
how it behaves. I suspect you may run into assumptions that a 50G repo
breaks.

In theory, I think you could pack all of the large files once into a
single pack, mark it with .keep, and then not have it negatively impact
further repacks.

> has been giving me lots of trouble when adding files at deep levels
> and I like how Git does adding files and how each repository is really
> it's own repository.  Also, I'm not really concerned about history as
> the main purpose of the repository is really to make the syncing job
> easier.  The code is very minimal and I do the majority of the

Well, if you're not too concerned about the history, then I would
suggest setting up something like this:

  - all of the big files get a unique name; new versions of the same
    file have names unique from their previous version (you can do this
    either with human-readable names, or just using the sha-1 of the
    file contents)

  - make all of the big files available through rsync, http, ftp, or
    whatever

  - the git (or svn) repo contains a list of all desired files, and a
    script that checks what you have versus what is desired (deleting
    any that aren't wanted, and pulling any that are missing)

Your repository of big files will grow, but each file within it is
immutable. The git repository points to the files by name, but doesn't
contain them. So updating from a client is just:

  git pull && ./update-script

but you can still go back to a snapshot in history if you want to:

  git checkout HEAD@{3.weeks.ago} && ./update-script

Make sense?

> can be crazy at times, but what can we do.  Also, this is a far fetch,
> since all the projects are installed under the same directories and
> are really exact clones of each other in every way, can I copy the
> .git directory and hope to God that it will magically work.  I really
> doubt it, but I figure it's worth asking.

I'm not sure what you mean by that. You can copy the .git directory to a
new working tree, yes. It will be a new repo, and you can see how what
it thinks should be checked out differs from what is in the new working
tree by running "git diff".

-Peff
