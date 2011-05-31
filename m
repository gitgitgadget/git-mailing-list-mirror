From: Junio C Hamano <gitster@pobox.com>
Subject: Re* diff: --quiet does not imply --exit-code if --diff-filter is
 present
Date: Tue, 31 May 2011 10:06:44 -0700
Message-ID: <7vd3iykdej.fsf_-_@alter.siamese.dyndns.org>
References: <87wrh7jgzk.wl@dns1.atmark-techno.com>
 <20110531153356.GB2594@sigill.intra.peff.net>
 <7vvcwqkh4a.fsf@alter.siamese.dyndns.org>
 <20110531162546.GA11321@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 31 19:07:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRSPF-0002Th-Fi
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 19:07:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728Ab1EaRG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2011 13:06:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59818 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018Ab1EaRGy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2011 13:06:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 35C444ECB;
	Tue, 31 May 2011 13:09:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1VQqBRtDThJRNxlsDP5kXVjayVA=; b=vdhAH9
	kRRo8Ae3QPZmS/QhJO22bAwi1Rxt6KvjPqkUwZzZFO/HiCznwWtxY5UNjt2XioGZ
	YDFPt6iz09/ttPwrwXp0pZF6qzOAr9r+t+a8I5YFpfh8YRCMSDOrzmOIPJ+eO6Vs
	5CNm8wRXwDiLDcLnnISm3kMhKhgM1l4QLILh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cEQ2/mWvf/3qRzqroGYyM0ppnDf0Fx45
	bbFpa4GhMRssarKwM3jmzoT8O7Ng61yJQHvw9M2N4xoBpCpgB42+/u/Rl4LtBTbn
	Fr/svzIi8h6NXJDECRToDkVJHD33yUX6/l+P/03Feg0rng76f8zh/Wiuhsi/vt2n
	xEUiIBaHDfk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EFD814ECA;
	Tue, 31 May 2011 13:08:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 87F0C4EC9; Tue, 31 May 2011
 13:08:55 -0400 (EDT)
In-Reply-To: <20110531162546.GA11321@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 31 May 2011 12:25:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD44C776-8BA8-11E0-9070-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174813>

Jeff King <peff@peff.net> writes:

>> Thanks; a natural question is if we need the same for diff-index, then.
>
> No, it calls straight into unpack_trees. So I think the question is
> "should unpack_trees respect the QUICK optimization". I suspect it
> didn't happen simply because unpack_trees is so complex, and there are
> probably corner cases with merging.

Yeah, a somewhat hacky version would look like this.

-- >8 --
diff-index --quiet: learn the "stop feeding the backend early" logic

A negative return from the unpack callback function usually means unpack
failed for the entry and signals the unpack_trees() machinery to fail the
entire merge operation, immediately and there is no other way for the
callback to tell the machinery to exit early without reporting an error.

This is what we usually want to make a merge all-or-nothing operation, but
the machinery is also used for diff-index codepath by using a custom
unpack callback function. And we do sometimes want to exit early without
failing, namely when we are under --quiet and can short-cut the diff upon
finding the first difference.

Add "exiting_early" field to unpack_trees_options structure, to signal the
unpack_trees() machinery that the negative return value is not signaling
an error but an early return from the unpack_trees() machinery. As this by
definition hasn't unpacked everything, discard the resulting index just
like the failure codepath.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-lib.c     |    7 ++++++-
 unpack-trees.c |    4 +++-
 unpack-trees.h |    1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index 9c29293..2e09500 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -433,8 +433,13 @@ static int oneway_diff(struct cache_entry **src, struct unpack_trees_options *o)
 	if (tree == o->df_conflict_entry)
 		tree = NULL;
 
-	if (ce_path_match(idx ? idx : tree, &revs->prune_data))
+	if (ce_path_match(idx ? idx : tree, &revs->prune_data)) {
 		do_oneway_diff(o, idx, tree);
+		if (diff_can_quit_early(&revs->diffopt)) {
+			o->exiting_early = 1;
+			return -1;
+		}
+	}
 
 	return 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 07f8364..3a61d82 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -593,7 +593,7 @@ static int unpack_nondirectories(int n, unsigned long mask,
 static int unpack_failed(struct unpack_trees_options *o, const char *message)
 {
 	discard_index(&o->result);
-	if (!o->gently) {
+	if (!o->gently && !o->exiting_early) {
 		if (message)
 			return error("%s", message);
 		return -1;
@@ -1133,6 +1133,8 @@ return_failed:
 		display_error_msgs(o);
 	mark_all_ce_unused(o->src_index);
 	ret = unpack_failed(o, NULL);
+	if (o->exiting_early)
+		ret = 0;
 	goto done;
 }
 
diff --git a/unpack-trees.h b/unpack-trees.h
index 64f02cb..4b07683 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -47,6 +47,7 @@ struct unpack_trees_options {
 		     skip_sparse_checkout,
 		     gently,
 		     show_all_errors,
+		     exiting_early,
 		     dry_run;
 	const char *prefix;
 	int cache_bottom;
