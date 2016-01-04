From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] avoid shifting signed integers 31 bits
Date: Mon, 04 Jan 2016 09:52:10 -0800
Message-ID: <xmqqh9itp705.fsf@gitster.mtv.corp.google.com>
References: <20151229063449.GA28755@sigill.intra.peff.net>
	<20151229063545.GA30340@sigill.intra.peff.net>
	<CACsJy8CAAqZFQCfadUov7DFhSgh=dtGfE-onbXZQXO-0Y2652g@mail.gmail.com>
	<20151231052029.GA10238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 04 18:52:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aG9In-0004nt-FP
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 18:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbcADRwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 12:52:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751390AbcADRwM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 12:52:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B38693418D;
	Mon,  4 Jan 2016 12:52:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ktmf3hfF4DYGErzfwoZunDxRKM=; b=ZrfRn0
	gHhUYmHDk/ueNzrNBuESp0gux3wOTkKdk1mFWJJbzXtY3c/w+gyg/zi6344zMdxI
	RvI/4SI6aovgdulh2EMEoyzfNWQTOcla1I+GYPPdDEIY3ivc4YWwGE75DsQSx9+4
	dDRXDSHdeD69oJvH5zeJCvp+dzr/bSiSRk87Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hnzsxp8qzPrEnjBMM1UJiWn/wigmjHDg
	3AuWaaTOhn0CWFm1Nnh5aJkezjr+fIDG5J5T895TMB31E31rc+Tj1FhHNpX3sn7O
	SZoszVTCGCFKhDwyeeyCK6oiwFF6wnl5SwiKvZSdrgP0EVM/aXyjKMSGZV+ItTcz
	Jo6yh4bMRl0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9AD03418C;
	Mon,  4 Jan 2016 12:52:11 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 296663418B;
	Mon,  4 Jan 2016 12:52:11 -0500 (EST)
In-Reply-To: <20151231052029.GA10238@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 31 Dec 2015 00:20:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E15FBF22-B30B-11E5-9E29-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283310>

Jeff King <peff@peff.net> writes:

> On Thu, Dec 31, 2015 at 12:10:33PM +0700, Duy Nguyen wrote:
>
>> On Tue, Dec 29, 2015 at 1:35 PM, Jeff King <peff@peff.net> wrote:
>> > We sometimes use 32-bit unsigned integers as bit-fields.
>> > It's fine to access the MSB, because it's unsigned. However,
>> > doing so as "1 << 31" is wrong, because the constant "1" is
>> > a signed int, and we shift into the sign bit, causing
>> > undefined behavior.
>> >
>> > We can fix this by using "1U" as the constant.
>> 
>> We have this in cache.h, should it be fixed as well?
>> 
>> /* CE_EXTENDED2 is for future extension */
>> #define CE_EXTENDED2         (1 << 31)
>
> Sort of. We don't actually use it, and since it's a macro, that means it
> never even hits the compiler proper itself. So it's not a bug, but it's
> a bug waiting to happen. :)
>
> -Peff

Let's squash an obvious change for that in to 1/2, then, before I
merge the series to 'next'.

Thanks.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Tue, 29 Dec 2015 01:35:46 -0500
Subject: [PATCH] avoid shifting signed integers 31 bits

We sometimes use 32-bit unsigned integers as bit-fields.
It's fine to access the MSB, because it's unsigned. However,
doing so as "1 << 31" is wrong, because the constant "1" is
a signed int, and we shift into the sign bit, causing
undefined behavior.

We can fix this by using "1U" as the constant.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/receive-pack.c | 2 +-
 cache.h                | 2 +-
 diff.h                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e6b93d0..e35ed40 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1597,7 +1597,7 @@ static void prepare_shallow_update(struct command *commands,
 				continue;
 			si->need_reachability_test[i]++;
 			for (k = 0; k < 32; k++)
-				if (si->used_shallow[i][j] & (1 << k))
+				if (si->used_shallow[i][j] & (1U << k))
 					si->shallow_ref[j * 32 + k]++;
 		}
 
diff --git a/cache.h b/cache.h
index 6f53962..9088843 100644
--- a/cache.h
+++ b/cache.h
@@ -214,7 +214,7 @@ struct cache_entry {
 #define CE_INTENT_TO_ADD     (1 << 29)
 #define CE_SKIP_WORKTREE     (1 << 30)
 /* CE_EXTENDED2 is for future extension */
-#define CE_EXTENDED2         (1 << 31)
+#define CE_EXTENDED2         (1U << 31)
 
 #define CE_EXTENDED_FLAGS (CE_INTENT_TO_ADD | CE_SKIP_WORKTREE)
 
diff --git a/diff.h b/diff.h
index f7208ad..893f446 100644
--- a/diff.h
+++ b/diff.h
@@ -91,7 +91,7 @@ typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data)
 #define DIFF_OPT_DIRSTAT_BY_LINE     (1 << 28)
 #define DIFF_OPT_FUNCCONTEXT         (1 << 29)
 #define DIFF_OPT_PICKAXE_IGNORE_CASE (1 << 30)
-#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1 << 31)
+#define DIFF_OPT_DEFAULT_FOLLOW_RENAMES (1U << 31)
 
 #define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
 #define DIFF_OPT_TOUCHED(opts, flag)    ((opts)->touched_flags & DIFF_OPT_##flag)
-- 
2.7.0-rc3-132-g73ad441
