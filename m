From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] upload-pack: support subtree packing
Date: Tue, 27 Jul 2010 07:46:05 -0700
Message-ID: <20100727144605.GA25268@spearce.org>
References: <1280187370-23675-1-git-send-email-pclouds@gmail.com> <1280187370-23675-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 16:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdlQ8-0004XR-Jt
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 16:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab0G0OqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 10:46:10 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61897 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088Ab0G0OqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 10:46:09 -0400
Received: by pwi5 with SMTP id 5so467371pwi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 07:46:08 -0700 (PDT)
Received: by 10.142.144.16 with SMTP id r16mr10474826wfd.34.1280241968530;
        Tue, 27 Jul 2010 07:46:08 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 33sm5741562wfg.21.2010.07.27.07.46.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 07:46:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280187370-23675-2-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151945>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> wrote:
> This patch adds a new capability "subtree", which supports two new
> requests "subtree" and "commit-subtree".
>=20
> "subtree" asks upload-pack to create a pack that contains only blobs
> from the given tree prefix (and necessary commits/trees to reach
> those blobs).
>=20
> "commit-tree" asks upload-pack to create a pack that contains trees o=
f
> the given prefix (and necessary commits/trees to reach those trees)
>=20
> With "subtree" request, Git client may then rewrite commits to create
> a valid commit tree again, so that users can work on it independently=
=2E
> When users want to push from such a tree, "commit-tree" may then be
> used to re-match what users have and what is in upstream, recreate
> proper push commits.

I disagree with a lot of this... but the idea is quite cool.

I like the "subtree" command, being able to clone down only part of
the repository is a nice feature, and the implementation of subtree
seems simple enough for the server.  It only has to emit some of
the paths, but the entire commit DAG.  This is pretty simple to
implement server side and is very lightweight.


But I disagree with the client rewriting the commits in order to
work with them locally.  Doing so means you can't take a commit
from your team's issue tracker and look it up.  And any commit
you create can't be pushed back to the server without rewriting.
Its messy for the end-user to work with.

I would prefer doing something more like what we do with shallow
on the client side.  Record in a magic file the path(s) that we
did actually obtain.  During fsck, rev-list, or read-tree the
client skips over any paths that don't match that file's listing.
Then we can keep the same commit SHA-1s, but we won't complain that
there are objects missing.

The downside is, a lot of the client code is impacted, and that
is why nobody has done it yet.  Tools like rebase or cherry-pick
start to behave funny.  What does it mean to rebase or cherry-pick
a commit that has deltas outside of the area you don't have cloned?
It probably should abort and refuse to execute.  But `git show`
should still work, which implies you need a way to toggle the
diff code to either skip or fail on deltas outside of the shallow
path space.
=20
--=20
Shawn.
