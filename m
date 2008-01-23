From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Tue, 22 Jan 2008 19:34:33 -0800
Message-ID: <7vir1lp646.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
	<7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
	<7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
	<7vprvv1wnu.fsf@gitster.siamese.dyndns.org>
	<7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
	<7vhch71vvb.fsf@gitster.siamese.dyndns.org>
	<7v8x2j1sul.fsf@gitster.siamese.dyndns.org>
	<7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801211104590.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801211120350.2957@woody.linux-foundation.org>
	<7vabmyykvg.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801211242330.2957@woody.linux-foundation.org>
	<alpine.LFD.1.00.0801221355110.1741@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 04:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHWOo-0004kT-9l
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 04:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879AbYAWDex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 22:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752969AbYAWDex
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 22:34:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602AbYAWDew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 22:34:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D124A7B60;
	Tue, 22 Jan 2008 22:34:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D4FE7B3E;
	Tue, 22 Jan 2008 22:34:41 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801221355110.1741@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 22 Jan 2008 14:00:25 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71507>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Ok, having looked a bit more, I found another two cases that my grep had 
> missed. They were regular if-statements, just more complex than my stupid 
> grep pattern had taken into account.
>
> Both are in read-cache.c:
>
> read-cache.c:                   if (stage || istate->cache[pos]->ce_mode) {
> read-cache.c:                   if (ce_stage(p) == stage && (stage || p->ce_mode))
>
> and I'd send a patch, except my tree right now is in pretty bad shape 
> because I'm also trying to see if I can add a name hash to the index.

-- >8 --
read-cache.c: fix a couple more CE_REMOVE conversion

It is a D/F conflict if you want to add "foo/bar" to the index
when "foo" already exists.  Also it is a conflict if you want to
add a file "foo" when "foo/bar" exists.

An exception is when the existing entry is there only to mark "I
used to be here but I am being removed".  This is needed for
operations such as "git read-tree -m -u" that update the index
and then reflect the result to the work tree --- we need to
remember what to remove somewhere, and we use the index for
that.  In such a case, an existing file "foo" is being removed
and we can create "foo/" directory and hang "bar" underneath it
without any conflict.

We used to use (ce->ce_mode == 0) to mark an entry that is being
removed, but (CE_REMOVE & ce->ce_flags) is used for that purpose
these days.  An earlier commit forgot to convert the logic in
the code that checks D/F conflict condition.

The old code knew that "to be removed" entries cannot be at
higher stage and actively checked that condition, but it was an
unnecessary check.  This patch removes the extra check as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8ba8f0f..8f5d02a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -615,7 +615,7 @@ static int has_dir_name(struct index_state *istate,
 			 * it is Ok to have a directory at the same
 			 * path.
 			 */
-			if (stage || istate->cache[pos]->ce_mode) {
+			if (!(istate->cache[pos]->ce_flags & CE_REMOVE)) {
 				retval = -1;
 				if (!ok_to_replace)
 					break;
@@ -637,8 +637,9 @@ static int has_dir_name(struct index_state *istate,
 			    (p->name[len] != '/') ||
 			    memcmp(p->name, name, len))
 				break; /* not our subdirectory */
-			if (ce_stage(p) == stage && (stage || p->ce_mode))
-				/* p is at the same stage as our entry, and
+			if (ce_stage(p) == stage && !(p->ce_flags & CE_REMOVE))
+				/*
+				 * p is at the same stage as our entry, and
 				 * is a subdirectory of what we are looking
 				 * at, so we cannot have conflicts at our
 				 * level or anything shorter.
