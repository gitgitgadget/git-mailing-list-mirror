From: Jeff King <peff@peff.net>
Subject: Re: Misterious warning about file system boundaries [It's a bug,
 not a mystery.]
Date: Sat, 12 Jun 2010 00:24:10 -0400
Message-ID: <20100612042410.GA20535@coredump.intra.peff.net>
References: <4C0FF7B9.8040007@drmicha.warpmail.net>
 <4C109C4F.1030809@op5.se>
 <4C10AAC4.90405@drmicha.warpmail.net>
 <AANLkTimwhDGNTMiOaW8_AGGd4PvFtyILEikePdC4zGDo@mail.gmail.com>
 <4C10C02E.50502@drmicha.warpmail.net>
 <AANLkTikle0gxLvKkhr-APkt_6QCB0hVu7bIGm0sRcjVK@mail.gmail.com>
 <20100610110258.GA17290@coredump.intra.peff.net>
 <7v39wvndl0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	kusmabite@gmail.com, Erik Faye-Lund <kusmabite@googlemail.com>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 06:25:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONIHf-0004GQ-M3
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 06:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab0FLEYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 00:24:14 -0400
Received: from peff.net ([208.65.91.99]:38194 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047Ab0FLEYN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 00:24:13 -0400
Received: (qmail 17714 invoked by uid 107); 12 Jun 2010 04:24:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 12 Jun 2010 00:24:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Jun 2010 00:24:10 -0400
Content-Disposition: inline
In-Reply-To: <7v39wvndl0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148986>

On Thu, Jun 10, 2010 at 07:53:47AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Since the early-warning suggestion is generating false positives, and I
> > don't think there is a portable and reliable way around it, dropping it
> > makes sense to me.
> 
> Makes sense.  Let's make it so (I won't have time to do that myself until
> late this evening, though).
> 
> Thanks.

Here it is with a nice commit message (though since it is only in next,
I guess you can just merge the early part and both 52b98a and my revert
will be dropped). It's on top of ld/discovery-limit-to-fs, of course.

Note that it would be possible to do a warning in some instances. We
just can't trust the on-disk index ce_dev information, so if you
actually refreshed two cross-filesystem entries we could detect that.
That is such a minority case that I doubt it is worth caring about,
though.

-- >8 --
Subject: [PATCH] Revert "write-index: check and warn when worktree crosses a filesystem boundary"

This reverts commit 52b98a7d2f12b5d0dd076221d40f8fa93598e11a.

The goal of that commit was to warn users early when their
worktree crossed filesystem boundaries. It worked by
comparing the st_dev stat information in the index, and
warning when we had more than one device.

However, the stat information may come from multiple runs,
and the st_dev field is not necessarily stable. In
particular, st_dev will change on Linux across reboots.
Index entries from the previous reboot will appear to come
from a different device, triggering a false positive.

Since this message is really only an early warning for
people who will be bit by the new
GIT_DISCOVERY_ACROSS_FILESYSTEM behavior, and because they
will get an actual error later on (when we can't find their
cross-filesystem .git directory), we can just scrap the
early warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 read-cache.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index e381ea5..f1f789b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1550,8 +1550,6 @@ int write_index(struct index_state *istate, int newfd)
 	struct cache_entry **cache = istate->cache;
 	int entries = istate->cache_nr;
 	struct stat st;
-	int first_valid_ent = -1;
-	int more_than_one_dev;
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
@@ -1574,7 +1572,6 @@ int write_index(struct index_state *istate, int newfd)
 	if (ce_write(&c, newfd, &hdr, sizeof(hdr)) < 0)
 		return -1;
 
-	more_than_one_dev = 0;
 	for (i = 0; i < entries; i++) {
 		struct cache_entry *ce = cache[i];
 		if (ce->ce_flags & CE_REMOVE)
@@ -1583,19 +1580,8 @@ int write_index(struct index_state *istate, int newfd)
 			ce_smudge_racily_clean_entry(ce);
 		if (ce_write_entry(&c, newfd, ce) < 0)
 			return -1;
-		if (ce_uptodate(ce)) {
-			if (first_valid_ent < 0)
-				first_valid_ent = i;
-			else if (ce->ce_dev != cache[first_valid_ent]->ce_dev)
-				more_than_one_dev = 1;
-		}
 	}
 
-	if (more_than_one_dev &&
-	    !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0))
-		warning("working tree spans across filesystems but "
-			"GIT_DISCOVERY_ACROSS_FILESYSTEM is not set.");
-
 	/* Write extension data here */
 	if (istate->cache_tree) {
 		struct strbuf sb = STRBUF_INIT;
-- 
1.7.1.516.gd5539.dirty
