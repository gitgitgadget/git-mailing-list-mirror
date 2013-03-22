From: Jeff King <peff@peff.net>
Subject: Re: git merge heuristic
Date: Fri, 22 Mar 2013 18:33:30 -0400
Message-ID: <20130322223330.GB13207@sigill.intra.peff.net>
References: <ECEA5ACFB4B2BC4A81A93F032519ABCAD47F79@minsk.us.stoke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Senthil Natarajan <snatarajan@stoke.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 23:34:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJAXG-0008Ac-VU
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 23:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423427Ab3CVWdj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 18:33:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36199 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422924Ab3CVWdj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 18:33:39 -0400
Received: (qmail 6153 invoked by uid 107); 22 Mar 2013 22:35:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 18:35:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 18:33:30 -0400
Content-Disposition: inline
In-Reply-To: <ECEA5ACFB4B2BC4A81A93F032519ABCAD47F79@minsk.us.stoke.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218861>

On Fri, Mar 22, 2013 at 11:53:04AM -0700, Senthil Natarajan wrote:

> I want to learn about how Git compares patches while doing a merge.=C2=
=A0
> For example, if a patch has been cherry-picked from branch A to branc=
h
> B, and then downstream we do a "git merge" from A to B, how does Git
> know to skip the cherry-picked patch?

It doesn't. Git's 3-way merge only looks at three things: where each
side of the merge ended, and what their common ancestor looked like.

So when you cherry-pick a commit, as long as the content in the file
ended up the same, there is no conflict. And it doesn't matter if it
happened by cherry-picking, or if you just happened to make a sequence
of commits that ended in the same state.

However, we do perform such detection during a rebase, in which we try
to skip patches that have already been applied upstream.

>=C2=A0It would have a different SHA-1, so what is the comparison
> algorithm/heuristic?=C2=A0 What happens if the comment is different, =
but the
> actual patch is identical?

Yes, the commit will have a different sha1. For that, we use the
"patch-id", which is basically a sha of the contents of the diff of the
commit against its parent. See the manual for git-patch-id, git-cherry,
and the --cherry-* options of "git log".

It will not find all duplicate commits (e.g., it will miss ones where
there was a conflict during cherry-pick, or even where the context is
slightly different). However, in many cases, rebase can also realize
while applying a patch that it has already been applied, and skip it
then.

-Peff
