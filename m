From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Fix default pull not to do an unintended Octopus.
Date: Tue, 27 Sep 2005 16:35:12 +0200
Message-ID: <200509271635.12907.Josef.Weidendorfer@gmx.de>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <200509271152.42963.Josef.Weidendorfer@gmx.de> <20050927125434.GF30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 27 16:38:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKGYI-0007uk-QL
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 16:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbVI0OfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 10:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964948AbVI0OfY
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 10:35:24 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:12716 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S964927AbVI0OfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 10:35:23 -0400
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 12F9626E0
	for <git@vger.kernel.org>; Tue, 27 Sep 2005 16:35:22 +0200 (MEST)
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <20050927125434.GF30889@pasky.or.cz>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9396>

On Tuesday 27 September 2005 14:54, you wrote:
> Yes. I'm actually inclined to keep this setup, simply because it is
>
>   * easy
>   * simple
>   * sufficient in most of the cases

I would almost say: sufficient for all cases.
The .git/remotes stuff is about providing a shortcut for remote
repositories and about defaults for this repository.
I am not really sure this is needed, and this second use of a name
(additionally to head names) can be confusing.

> > Perhaps we should have extended the branches file to allow different
> > remote reps and heads depending on the command (fetch/pull/merge/push).
> > A "URL:" is not needed, as you probably like to have different repos for
> > pull and push. And in contrast to the remotes stuff above, a "Merge:"
> > line makes quite sense here: When on "mybranch", a merge should default
> > to merging the heads specified on the Merge line in branches/mybranch.
>
> No. If you are in the branches/ playground, please keep it strictly
> one-to-one mapping. That's what makes it easy and simple and that's what
> makes it good.

Ah, no. Any line in a branches/ file is a pure attribute for the given
head, and does not change its 1:1 relationship.

E.g. a branches/master file with

	Push: git:/.../git.git#public-master
	Merge: origin

would specify:
- If the current head is master, a cg-merge will merge with
head origin
- If the current head is master, a cg-push will publish the
local master to the given remote URL

The branches/master does nothing say about the origin branch/head.

> > When cloning a remote head, Cogito creates a local "origin" head and
> > corresponding mapping in branches/origin. Afterwards, it automatically
> > generates a new local branch "master", which branches of at the
> > origin. Further "cg-updates" (=git fetch+merge) fetch origin, and merge
> > origin into master.
> > I assume that this currently is hardcoded in scripts?
>
> Yes.
>
> > Shouldn't there be created a branches/master, specifying that a default
> > merge should happen with "origin"? This way, an "cg-update" would look
> > into "branches/master" on the "Merge:" line. It sees that "origin" is
> > bound to a remote head, and thus, does a fetch before merging.
>
> If ever doing that, this should be done at some other place than
> branches/.

Hmm, perhaps. We could go with .git/push-defaults and .git/merge-defaults.
But then, IMHO .git/branches should be renamed to .git/fetch-defaults,
as it holds the remote URL needed for fetching changes.

By creating the needed defaults on a cg-clone, you can get rid of the
above mentioned hardcoded things.

> And I'm sceptical about it anyway. Really, introducing some 
> new configuration mechanism just to tell Cogito what default branch name
> should it pick up when you call fetch/update/merge without a parameter?

It is about storing pull/push remote URLs for a given head.
Ok, in the case "merge", it is about defaults (useful to
get rid of the hardcoding of merging origin into master on a cg-update).

I really think that the "push" URL currently is missing in Cogito.
Pushing the master by using the origin URL works, but I would like to
see this working for arbitrary heads.

By the way, am I correct than cogito currently misses a command to
switch the branch? cg-seek is only for temporal switching. What are
the prefered options? A "cg-seek -f", a "cg-jump" or "cg-switch"?

Josef
