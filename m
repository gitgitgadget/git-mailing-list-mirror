From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Add init-serve, the remote side of "git init
	--remote=host:path"
Date: Sun, 1 Mar 2009 09:04:36 -0800
Message-ID: <20090301170436.GA14365@spearce.org>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com> <1235865822-14625-2-git-send-email-gitster@pobox.com> <1235865822-14625-3-git-send-email-gitster@pobox.com> <20090301031609.GA30384@coredump.intra.peff.net> <7v63itbxe7.fsf@gitster.siamese.dyndns.org> <20090301100039.GD4146@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 01 18:06:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldp78-0005ky-Vv
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 18:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652AbZCAREk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 12:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbZCAREj
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 12:04:39 -0500
Received: from george.spearce.org ([209.20.77.23]:51349 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034AbZCAREi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 12:04:38 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C385D38210; Sun,  1 Mar 2009 17:04:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090301100039.GD4146@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111855>

Jeff King <peff@peff.net> wrote:
> On Sat, Feb 28, 2009 at 09:54:56PM -0800, Junio C Hamano wrote:
> 
> > One issue I did not describe in the message was to what extent we would
> > want to allow operations other than the creating of a new repository
> > itself.
> > 
> > "Other than the creation" includes things like these:
> 
> Hmph. I am not too excited by this list. What is the advantage of doing
> them over the git protocol versus some out-of-band method?

My feelings echo Peff's here.
 
>      Furthermore, in the case of many providers (e.g., github,
>      repo.or.cz), there is already a separate out-of-band interface for
>      doing "meta" stuff, like managing user accounts and repos. Isn't it
>      more natural for them to integrate these features with their
>      existing interfaces?

Don't forget about my day-job project, Gerrit Code Review.

I'm already hosting 138 projects on review.source.android.com, and
based on weekly downloads of Gerrit builds I'd estimate another ~60
deployments at internal servers within organizations.  (I'm doing
weekly "stable" builds and I'm seeing an average of ~70 downloads
for each build.)
 
> But let's say that there really is some value in setting up this
> channel (because we want a uniform way of doing these things so we can
> add more automated tool support from the client side). Then I think it
> makes sense to look at what the people in (2) above are doing already.
> That is, what sorts of things can you already do (and not do) in
> github's or repo.or.cz's interface? On top of that, it probably makes
> sense to ask them if they are interested in such a feature, as they
> would be primary users. And if they are, what do they want out of it?

Earlier last week a co-worker who is new to git complained that he
can't create a repository easily from his desktop.  There may be
value in being able to create a repository remotely, as it removes
that confusion.

But I think that's only true for situations where you are likely the
owner of the repository in your own home directory, such as ~you
on kernel.org.  For "hosted repositories" like any of the systems
you described above, there is a lot more to the creation than just
executing "git init" somewhere.

FWIW, JGit automatically creates a repository over the amazon-s3://
transport during push if it doesn't exist yet.  In my mind, this is
somewhat like scp or rsync automatically creating the destination
directory when recursively copying a directory.  For the usage of
creating a new repository in your own home directory on some remote
server, why isn't this just an option to git push?

  git push --create me@george:my/new/repo.git master

It fits better with the push-creates-a-branch feature.


Gitosis allows repositories to be created during the first push
into that repository, if the repository is listed in the config
and the user is permitted to write to it.

GitHub and repo.or.cz allow you to create empty repositories,
but both do so through the web interface.

Gerrit Code Review still requires you to manually run "git init"
and also do a SQL INSERT by hand.  Its missing some sort of user
friendly repository creation feature.  But I'm starting to consider
doing it automatically during "git push", like gitosis does.

Repository creation in Gerrit is more than just "git init" and
a SQL INSERT.  I also have to run rsync a few times to replicate
the repository onto multiple servers, so that subsequent pushes
to those servers won't fail.

I suspect the situation is the same for GitHub; I know they have
a custom daemon that handles repository mapping, and some database
behind that daemon to store those translations.

IMHO, _if_ we do support remote repository creation, it should match
branch creation UI better (meaning, be part of git push, not part of
git init), and it should be something that the hosted providers can
all hook into so we can keep our non-git state management current.

-- 
Shawn.
