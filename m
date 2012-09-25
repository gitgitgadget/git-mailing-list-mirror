From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] Revert "completion: fix shell expansion of items"
Date: Wed, 26 Sep 2012 00:37:25 +0200
Message-ID: <20120925223725.GA12658@goldbirke>
References: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
 <20120920014608.GA27782@sigill.intra.peff.net>
 <20120920181152.GA4689@goldbirke>
 <20120925043119.GA6208@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 00:37:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGdlK-00031A-SO
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 00:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab2IYWhk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Sep 2012 18:37:40 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:55433 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2IYWhj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 18:37:39 -0400
Received: from localhost6.localdomain6 (p5B130672.dip0.t-ipconnect.de [91.19.6.114])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MK8g5-1TI1Ka3qLt-001Os2; Wed, 26 Sep 2012 00:37:26 +0200
Content-Disposition: inline
In-Reply-To: <20120925043119.GA6208@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:fHTltzTwclI2Vx33kF96eEpZdsJRMxYcxnUv1UzYOUR
 7/DsSnEIrLlAxD8RE81CsMQ4STGYcdpZIePHs1Uv0fvtbdzI16
 0kCEaAya0lLFWoDmv4cYrB41cvfPyjP7B9qzcSs8GJYxizmb8X
 CsPOvT7CwstNhyr/ep9v0QBcnL+DxhOxPbJ/CHGIob7dg8JPV/
 IPHziJTPBf2qrYGHmhb7DZN6dNR5pk5RP8LlNn2CxxUR/8uGbQ
 nYY6Ua8r3aAK5nE0liVGWQvEl/Vm6IFuJfPfue/QjkbzaK85dr
 pyMwlk8PVuUKxHzuUeUwMhfyOwNXlCZGQheemrKqZp4LfQFj8W
 qjjPKYB9x9uWseE+OIyA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206380>

On Tue, Sep 25, 2012 at 12:31:19AM -0400, Jeff King wrote:
> Yeah, doing "git checkout jk/<tab>" is not working at all, and I noti=
ced
> the buggy commit is on the maint track, but has not yet been released=
=2E
> I'm not sure of the solution, but I think we should do this in the
> meantime:
>=20
> -- >8 --
> Subject: Revert "completion: fix shell expansion of items"

I agree with the revert, too.

I looked into this issue, but quickly got lost in quoting-escaping
hell.  Ideally we could do some quoting in __gitcomp_nl(), so it would
work for all kinds of input, but I couldn't come up with anything
working.  Alternatively, we could modify __gitcomp_nl()'s callers, or
rather the helper functions supplying input to __gitcomp_nl() to do
the quoting or escaping themselves.  Actually, that's quite easy for
local refs, at least, because for-each-ref's builtin quoting support
does the trick:

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index c48cd19f..3dc1ec8c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -313,7 +313,7 @@ __git_refs ()
 			refs=3D"refs/tags refs/heads refs/remotes"
 			;;
 		esac
-		git --git-dir=3D"$dir" for-each-ref --format=3D"%($format)" \
+		git --git-dir=3D"$dir" for-each-ref --shell --format=3D"%($format)" =
\
 			$refs
 		if [ -n "$track" ]; then
 			# employ the heuristic used by git checkout

With this change completion of local refs works well, even in the
presence of branches ${foo.bar} and foo'bar.

Unfortunately, there are many callsites for __gitcomp_nl(), and it is
invoked with refs from remote repos, heads, tags, refspecs, remotes,
config variables, symbols from ctags, or output from stash or
ls-tree...  although some of these are OK as they are now (remotes,
config variables).


Best,
G=E1bor
