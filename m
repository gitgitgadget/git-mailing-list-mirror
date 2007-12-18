From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix segfault in diff-delta.c when FLEX_ARRAY is 1
Date: Tue, 18 Dec 2007 01:07:01 -0800
Message-ID: <7vwsrc1idm.fsf@gitster.siamese.dyndns.org>
References: <1197941997-11421-1-git-send-email-madcoder@debian.org>
	<20071218014455.GB14981@artemis.madism.org>
	<alpine.LFD.0.9999.0712172032090.21557@woody.linux-foundation.org>
	<alpine.LFD.0.9999.0712172146070.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, spearce@spearce.org,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 10:07:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4YQP-00029C-Nk
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 10:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbXLRJHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 04:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbXLRJHS
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 04:07:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbXLRJHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 04:07:16 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 455FE4111;
	Tue, 18 Dec 2007 04:07:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 745884110;
	Tue, 18 Dec 2007 04:07:03 -0500 (EST)
In-Reply-To: <alpine.LFD.0.9999.0712172146070.21557@woody.linux-foundation.org>
	(Linus Torvalds's message of "Mon, 17 Dec 2007 22:12:03 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68711>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But there's a few that aren't obviously allocations (this is a list done 
> with grep and sparse, I didn't look at whether the values used are then 
> all allocation-related):
>
>  - builtin-blame.c:128     memset(o, 0, sizeof(*o));

This is harmless and in fact unnecessary clearing, immediately before
calling free(3).

>  - diff-delta.c:250        memsize = sizeof(*index)

I haven't studied this codepath.

>  - object-refs.c:23        size_t size = sizeof(*refs) + count*sizeof(struct object *);

Overallocation to have at least "count" pointers to "struct object".

>  - object-refs.c:61        size_t size = sizeof(*refs) + j*sizeof(struct object *);

Ditto for "j" pointers.

>  - attr.c:220              sizeof(*res) +

Overallocation to have at least "num_attr" instances of "struct
attr_state" (plus name string if needed, which is stored using location
past state[num_attr]).

>  - remote.c:467            memset(ret, 0, sizeof(struct ref) + namelen);

Clearing an arena that was overallocated to have at least namelen
elements of char[] on the line immediately before this, with matching
size.  All callers pass namelen = strlen(name) + 1 so we are Ok even
when FLEX_ARRAY gives no extra space.

>  - remote.c:474            memcpy(ret, ref, sizeof(struct ref) + strlen(ref->name) + 1);

Ditto.

>  - transport.c:491         memset(ref, 0, sizeof(struct ref));

A line above overallocates to have enough room for strlen(ref_name) plus
terminating NUL, and after this lines clears the non-flex part, name is
copied.  So this overclears a bit, but is harmless.

> diff --git a/unpack-trees.c b/unpack-trees.c
> index e9eb795..aa2513e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -590,7 +590,7 @@ static int merged_entry(struct cache_entry *merge, struct cache_entry *old,
>  		 * a match.
>  		 */
>  		if (same(old, merge)) {
> -			*merge = *old;
> +			memcpy(merge, old, offsetof(struct cache_entry, name));
>  		} else {
>  			verify_uptodate(old, o);
>  			invalidate_ce_path(old);

Portability of offsetof() is slightly worrisome, but giving a
compatibility macro is trivial if this turns out to be problematic for
some people.
