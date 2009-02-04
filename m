From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [wishlist] git-archive -L
Date: Thu, 05 Feb 2009 00:00:18 +0100
Message-ID: <498A1E02.6020707@lsrfire.ath.cx>
References: <20090202143425.GA30667@artemis.corp> <4987FC03.60607@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:02:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqki-0006sS-LB
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbZBDXA0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 18:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbZBDXA0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:00:26 -0500
Received: from india601.server4you.de ([85.25.151.105]:43641 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbZBDXA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:00:26 -0500
Received: from [10.0.1.101] (p57B7F3CC.dip.t-dialin.net [87.183.243.204])
	by india601.server4you.de (Postfix) with ESMTPSA id 689362F8056;
	Thu,  5 Feb 2009 00:00:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <4987FC03.60607@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108453>

Ren=E9 Scharfe schrieb:
> Anyway, I'll try to resurrect my old, incomplete symlink following co=
de,
> but I don't have much time, either. :-/

After a second and a third look I don't see any salvageable parts in th=
e
old code any more.  It was a just prototype that taught me something I
should have been able to find out by thinking alone: that to follow
links within tracked content we can't simply jump to the target, but we
have to walk the whole path step by step.

E.g., consider a repository with these four entries:

	Type	Name	Target
	-------	-------	------
	file	a/f
	symlink	a/x	f
	symlink a/y	../b/f
	symlink	b	a

Let's say our goal is to follow symlinks pointing to tracked content.

We can easily follow "a/x" to get to its target "f" by concatenating th=
e
directory part of the symlink's path ("a/") with the target ("f"), i.e.
we only need to do a simple string operation.

If we do the same for "a/y", we'd arrive at "b/f", which is not a
tracked file by itself, though.  We need to look up each path element
one by one and follow symlinks at each step.  That can't be done with
our existing tree walkers, AFAICS, so we'd need to write a new one.

The decision to follow a link can be made by the callback and passed to
read_tree_recursive() as a return value, with, e.g., READ_TREE_FOLLOW
and READ_TREE_FOLLOW_NON_MATCHES meaning to follow all internal symlink=
s
and to follow only those whose target doesn't match the specified paths=
,
respectively.

Ren=E9
