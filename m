From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Thu, 19 Mar 2015 10:41:50 -0700
Message-ID: <xmqqfv90khpd.fsf@gitster.dls.corp.google.com>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
	<20150316011343.GA928@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYeSF-00088l-JU
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 18:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653AbbCSRly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 13:41:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753180AbbCSRlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 13:41:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4702841E87;
	Thu, 19 Mar 2015 13:41:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kk9Y6bjDtIUL+6nyj+g59pKrbf4=; b=yTu7X4
	IaHYArVOhzQsmeGPDqJ2toCQzrnbl7lk22oLp47ZcftXtccYv62BuzHdC0Hy2kDw
	TnjElqQRzPai6sWzR8LyFzpIztUluLRuimG4qORnVTwoE6JlinNfcHCr8yAp40su
	ke3O3qAA1sFmPm1qHDZOGwZZGBZUkay0S/B3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nit4d7YN1IMRjThrw8BDQhyZ7Gmy0Dpu
	osmClY+ycalKK1MMb15Qi1HJrDJmC4UJbFcwiZnwmnq28QueokzV4VFdMrr7XfFv
	SCETnLYMl4HFeyi/Py9bmcXFpdc0IlWBIcEJ0wX61HAzCUihuSR0uQmBPkwiNA29
	3AwoD1w/Vu4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40DF741E86;
	Thu, 19 Mar 2015 13:41:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AEA0341E83;
	Thu, 19 Mar 2015 13:41:51 -0400 (EDT)
In-Reply-To: <20150316011343.GA928@peff.net> (Jeff King's message of "Sun, 15
	Mar 2015 21:13:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 39F10A98-CE5F-11E4-8EC6-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265812>

Jeff King <peff@peff.net> writes:

> ...
> And there we stop. We don't pass the "refs" list out of that function
> (which, as an aside, is probably a leak). Instead, we depend on the list
> of heads we already knew in the "to_fetch" array. That comes from
> processing the earlier list of refs returned from get_refs_via_connect.
> ...
> That doesn't mean there isn't an additional bug lurking. That is,
> _should_ somebody be caring about that value? I don't think so. The
> old/new pairs in a "struct ref" are meaningful as "I proposed to update
> to X, and we are at Y". But this list of refs does not have anything to
> do with the update of local refs. It is only "what is the value of the
> ref on the other side". The local refs are taken care of in a separate
> list.

Correct.  When we want to insert some function to allow users/hooks
to tweak the result of update, we might want to make sure that we
are passing the final list of refs to that function, but the purpose
of this function is not to make such a modification.

Just to make sure we do not keep this hanging forever and eventually
forget it, I'm planning to queue this.

Thanks.

-- >8 --
From: Jeff King <peff@peff.next>
Date: Sun, 15 Mar 2015 21:13:43 -0400
Subject: [PATCH] fetch-pack: remove dead assignment to ref->new_sha1

In everything_local(), we used to assign the current ref's value
found in ref->old_sha1 to ref->new_sha1 when we already have all the
necessary objects to complete the history leading to that commit.
This copying was broken at 49bb805e (Do not ask for objects known to
be complete., 2005-10-19) and ever since we instead stuffed a random
bytes in ref->new_sha1 here.  No code complained or failed due to this
breakage.

It turns out that no codepath that comes after this assignment even
looks at ref->new_sha1 at all.

 - The only caller of everything_local(), do_fetch_pack(), returns
   this list of ref, whose element has bogus new_sha1 values, to its
   caller.  It does not look at the elements and acts on them.

 - The only caller of do_fetch_pack(), fetch_pack(), returns this
   list to its caller.  It does not look at the elements and acts on
   them.

 - One of the two callers of fetch_pack() is cmd_fetch_pack(), the
   top-level that implements "git fetch-pack".  The only thing it
   looks at in the elements of the returned ref list is the old_sha1
   and name fields.

 - The other caller of fetch_pack() is fetch_refs_via_pack() in the
   transport layer, which is a helper that implements "git fetch".
   It only cares about whether the returned list is empty (i.e.
   failed to fetch anything).

Just drop the bogus assignment, that is not even necessary.  The
remote-tracking refs are updated based on a different list and not
using the ref list being manipulated by this codepath; the caller
do_fetch_pack() created a copy of that real ref list and passed the
copy down to this function, and modifying the elements here does not
affect anything.

Noticed-by: Kyle J. McKay <mackyle@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fetch-pack.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 655ee64..6f0c0e1 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -625,7 +625,6 @@ static int everything_local(struct fetch_pack_args *args,
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
-		unsigned char local[20];
 		struct object *o;
 
 		o = lookup_object(remote);
@@ -638,8 +637,6 @@ static int everything_local(struct fetch_pack_args *args,
 				ref->name);
 			continue;
 		}
-
-		hashcpy(ref->new_sha1, local);
 		if (!args->verbose)
 			continue;
 		fprintf(stderr,
-- 
2.3.3-377-gdf43604
