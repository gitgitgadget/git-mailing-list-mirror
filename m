From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Wed, 7 Mar 2012 06:47:15 -0500
Message-ID: <20120307114714.GA14990@sigill.intra.peff.net>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
 <20120306114914.GB6733@sigill.intra.peff.net>
 <7vlindp17d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michal Privoznik <mprivozn@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 12:47:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5FL5-0007GC-Jz
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 12:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660Ab2CGLrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 06:47:22 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43848
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755716Ab2CGLrV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 06:47:21 -0500
Received: (qmail 23771 invoked by uid 107); 7 Mar 2012 11:47:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Mar 2012 06:47:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Mar 2012 06:47:15 -0500
Content-Disposition: inline
In-Reply-To: <7vlindp17d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192445>

On Tue, Mar 06, 2012 at 06:57:42PM -0800, Junio C Hamano wrote:

> > The idea of turning on patience diff via config makes sense to me, and
> > it is not a problem for plumbing tools to have patience diff on, since
> > patience diffs are syntactically identical to non-patience diffs.
> 
> Even though I do not strongly object to the general conclusion, I
> have to point out that the last line above is a dangerous thought.
> 
> If you change the default diff algorithm, you will invalidate long
> term caches that computed their keys based on the shape of patches
> produced in the past.

I see your point, though I don't think I'd use the word "dangerous" to
describe the invalidation of a cache. In a true cache, we must be ready
for cache misses, so the "danger" is causing extra cache misses. That
might be non-optimal, depending on the cost of a miss, but it's not
going to result in data loss.

[This email ended up long; the "tl;dr" is: "I don't think it's that big a
 deal, but I don't really have a problem limiting this feature to
 just porcelain". Michal, the way to do that would be to move the config
 parsing into git_diff_ui_config instead of git_diff_basic_config.]

> The prime example being the rerere database,

Having said that about caches, I don't know that I'd call rerere a
cache. The "miss" means the user has to resolve the merge. So whether it
is a cache or a database of precious information depends on how much you
value the user's input.

Anyway, would this option actually affect rerere? AFAICT, rerere does
not care about diff generation, but rather about the merge parameters.
And it is smart enough to tell the merge subsystem to use standard
parameters when generating rr-cache entries (e.g., setting
merge.conflictstyle does not affect what is put in the rr-cache).

> but I wouldn't be surprised if somebody has a notes tree to record
> patch ids for existing commits to speed up "git cherry" (hence "git
> rebase").

I do that[1]. However, any cache of patch-ids that does not record
the diff parameters used is wrong[2]. You're unlikely to come up with a
false positive due to the length of the patch-id hash, and a few cache
misses here and there are fine. A cache that invalidates all entries
when its cache parameters change[3] would be rendered useless by two
commands flip-flopping between two different sets of diff parameters.
But that is a quality-of-implementation issue for the cache.

[1] Actually, I don't store it in notes, but rather in the mmap'd
    persistent key value store I developed for the generation number
    cache last summer (which we ended up not using).

[2] Mine doesn't actually do this, and is wrong. Which is part of the
    reason I haven't sent it upstream.

[3] The notes_cache code invalidates like this. Since the only user is
    the textconv cache, that strategy works well. For the generation
    number cache, it maintains multiple cache entries.

> Also kup tool kernel.org folks use to optimize the uploading of
> inter-release diff relies on having a stable output from "git diff
> A..B", so that the uploader can run the command to produce a diff
> locally, GPG sign it, and upload only the signature and have the k.org
> side produce the same diff between two tags, without having to upload
> the huge patchfile over the wire.

That's a cute trick, but I think it is going to be inherently flaky.
Does kup run the "git diff" itself (or, I would hope "git diff-tree")?
If not, then they are at the mercy of the uploader adding custom diff
parameters. I don't know about others, but I sometimes tweak the amount
of context in a diff I send if it makes the diff more readable (e.g., if
two hunks are close by and are more easily read as a single hunk, or if
relevant context is one or two lines outside of a hunk).

But even if the kup client runs a sanitized, well-known, plumbing
version of the diff on both sides, they're still not guaranteed to
produce the same patch. Different versions of git may produce different
results. For example, we stopped defaulting to XDF_NEED_MINIMAL in
582aa00. Git v1.7.1 produces a different diff for some commits than
v1.7.1.1.

> IOW, "syntactically identical so it is OK" is not the right thought
> process.  "It may change the shape of the patch, which is a potential
> problem for various tools, but as long as users understand that, it
> should be allowed." is OK.

I would argue that it is those tools which should be the ones to care.
One of the great things about git is that it uses simple, standard
formats like unified diff, and doesn't care if you used git to generate
them. But the actual algorithm used to generate the diff is outside the
scope of git-apply. So in theory the email you are grabbing with "git
am" could be generated by GNU diff, or even some weird proprietary diff,
and we don't care. Applying a patch-id or anything else that makes
assumptions about the diff algorithm is inherently risky.  For internal
cases where one tool is generating both sides of the diff, it should be
sure to specify vanilla parameters.

> My preference however is to limit this to Porcelains only, though.

I'd be OK with that. The "...it should be sure to specify vanilla
parameters" above can be spelled as "should use the plumbing version".
Though even that is not entirely foolproof (due to differing versions,
as I mentioned above, but also I think we respect things like
$GIT_DIFF_OPTS), it works OK in practice. And given that the main
motivation is for porcelain users, I don't think it is hurting anyone to
be conservative at first.

If "kup" relies on the user to run the diff themselves for the feature
you mentioned, then it may cause breakage there (because most people
will run the porcelain "git diff"). But I think it is already broken by
things like diff.mnemonicprefix, as well as break- and rename-detection
parameters.

-Peff
