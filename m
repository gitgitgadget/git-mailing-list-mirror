From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] checkout: honor advice.detachedHead when reattaching to
 a branch
Date: Tue, 24 May 2011 10:11:43 -0700
Message-ID: <7vzkmc6n1s.fsf@alter.siamese.dyndns.org>
References: <7vei4bzhwm.fsf@alter.siamese.dyndns.org>
 <20110506223847.GC17848@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 24 19:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOv9D-00033Q-1I
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 19:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab1EXRLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2011 13:11:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42986 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab1EXRLv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2011 13:11:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CC7C5CE3;
	Tue, 24 May 2011 13:13:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UTxmjg/zRhYVMUAABkUFmmdqYrM=; b=ZovsPK
	Q0t2839USBPlKJctuui1udrSqlwBY7acJPVrZicYBm4GA4XozhklIOBtbbBo+4Dv
	5Xxl89Zycqb1oTjJpvqa7richFISs7fTLcFY8ADhJ5d+PNF0vh2TxOwq3yCX/3jX
	MRQXnMVZ3WnjqoPkKTwxGmY0kqADBaBOEZ0YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Pyl5k6nOQ371GvPoBM/7BqWD5+WcH5md
	UVI4h0P1t8lLtP9ymg3tBosdk80V5q/eDbNEV1B+5RopuqjkbDPzuhzji6Z6Mfnu
	LVI1nX1XL8KVKs1v6giAyKSlx7/zk/P6JNtylA5QdAh/NlU6PO/uoTs79yUeavQx
	scep1U9neLw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D63D55CDE;
	Tue, 24 May 2011 13:13:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C90485CDD; Tue, 24 May 2011
 13:13:53 -0400 (EDT)
In-Reply-To: <20110506223847.GC17848@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 6 May 2011 18:38:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 355971D2-8629-11E0-AADB-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174333>

Jeff King <peff@peff.net> writes:

> Hopefully the above made sense, but to be clear, what I think we should
> do is:
>
>   1. Suppress the "If you want to keep it..." advice on exit with the
>      existing advice.detachedhead.
>
>   2. Optionally, if anybody cares (and I don't), introduce
>      advice.detachedOrphanCheck to suppress the check entirely.
>
>   3. Optionally remove "Previous HEAD position" in the non-orphan case.
>      I think it's superfluous, but it's so short that I don't really
>      care either way.

I think the above makes sense (sorry for replying a three-week old thread,
but I am trying to rid as many topics as I can from the Stalled category),
except that #3. might be useful after manually bisecting the existing
history.  You may not be losing any commit (all are connected), but you
would be losing the point you have spent efforts to locate by switching
out.

I also think #2 would not be necessary; scripts that know what they are
doing should be using -q to suppress output from checkout anyway, and the
check is disabled in that case.

So on top of 8e2dc6a (commit: give final warning when reattaching HEAD to
leave commits behind, 2011-02-18), here is a re-roll.

-- >8 --
Subject: checkout: make advice when reattaching the HEAD less loud

When switching away from a detached HEAD with "git checkout", we give a
listing of the commits about to be lost, and then tell how to resurrect
them since 8e2dc6a (commit: give final warning when reattaching HEAD to
leave commits behind, 2011-02-18).

This is a good safety measure for people who are not comfortable with the
detached HEAD state, but the advice on how to keep the state you just left
was given even to those who set advice.detachedHead to false.

Keep the warning and informational commit listing, but honor the setting
of advice.detachedHead to squelch the advice.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e44364c..feaf29f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -634,14 +634,17 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 		"Warning: you are leaving %d commit%s behind, "
 		"not connected to\n"
 		"any of your branches:\n\n"
-		"%s\n"
-		"If you want to keep them by creating a new branch, "
-		"this may be a good time\nto do so with:\n\n"
-		" git branch new_branch_name %s\n\n",
+		"%s\n",
 		lost, ((1 < lost) ? "s" : ""),
-		sb.buf,
-		sha1_to_hex(commit->object.sha1));
+		sb.buf);
 	strbuf_release(&sb);
+
+	if (advice_detached_head)
+		fprintf(stderr,
+			"If you want to keep them by creating a new branch, "
+			"this may be a good time\nto do so with:\n\n"
+			" git branch new_branch_name %s\n\n",
+			sha1_to_hex(commit->object.sha1));
 }
 
 /*
@@ -668,8 +671,6 @@ static void orphaned_commit_warning(struct commit *commit)
 		die("internal error in revision walk");
 	if (!(commit->object.flags & UNINTERESTING))
 		suggest_reattach(commit, &revs);
-	else
-		describe_detached_head("Previous HEAD position was", commit);
 }
 
 static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
