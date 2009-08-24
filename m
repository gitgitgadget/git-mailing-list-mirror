From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix simple deepening of a repo
Date: Sun, 23 Aug 2009 21:49:16 -0700
Message-ID: <7vocq5q0j7.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
 <alpine.LFD.2.00.0908232320410.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 06:50:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfRVX-0001ZL-BM
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 06:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbZHXEt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 00:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbZHXEt1
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 00:49:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbZHXEt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 00:49:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A98D4342F0;
	Mon, 24 Aug 2009 00:49:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=VIsPXJ2TOsehssvNkheGlIqc9Nk=; b=IZNtikT9sHjzB4EDAMKY26R
	LxEBBYEvow1qkwFJGXtpsgvAumY9wafUWUptVgH6RbWFehqELG/Dp4AqszgT5r+a
	7WfAPPBYa1UsWiOYI+GoirRj+xxiogVT0h8QE24kPGe6boa2I4yPvjcXILLGu82l
	RPPUfwnY2T6cHKt3aHAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ZKSL+dXn+bXiVhhbZBlDGRP+O/XriulHuYnsKTlu6/ZRhmTZ5
	O3GYR61+GGVIvAOjPBKu3Og2nJ3lZYrq3c99lhFMcZbXOfNyFmAgXEL7P0+6+l6M
	qhBf7dQ+QtaFRlohX4i8f/ooCXcLCNwFl+MwDfR405jKBmP1H0uk/QeimQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 73D7D342EE;
	Mon, 24 Aug 2009 00:49:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AEE73342ED; Mon, 24 Aug 2009
 00:49:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7EFEF49A-9069-11DE-9061-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126904>

Nicolas Pitre <nico@cam.org> writes:

> If all refs sent by the remote repo during a fetch are reachable 
> locally, then no further conversation is performed with the remote. This 
> check is skipped when the --depth argument is provided to allow the 
> deepening of a shallow clone which corresponding remote repo has no 
> changed.
>
> However, some additional filtering was added in commit c29727d5 to 
> remove those refs which are equal on both sides.  If the remote repo has 
> not changed, then the list of refs to give the remote process becomes 
> empty and simply attempting to deepen a shallow repo always fails.
>
> Let's stop being smart in that case and simply send the whole list over
> when that condition is met.  The remote will do the right thing anyways.
>
> Test cases for this issue are also provided.
>
> Signed-off-by: Nicolas Pitre <nico@cam.org>
> ---

Thanks.  The fix looks correct (as usual with patches from you).

But it makes me wonder if this logic to filter refs is buying us anything.

>  	for (rm = refs; rm; rm = rm->next) {
> +		nr_refs++;
>  		if (rm->peer_ref &&
>  		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
>  			continue;
		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
		heads[nr_heads++] = rm;
	}

What is the point of not asking for the refs that we know are the same?

In other words, what breaks (not necessarily in the correctness sense, but
also in the performance sense) if we get rid of this filtering altogether?

Over a native protocol, we will tell the other end what we have and the
remote end will notice that we are asking for the same thing, so it won't
include unnecessary objects in the pack anyway.  When calling out to a
walker, we will also notice that the ref matches what we have already and
will not fetch anything from the remote.  Because the commit at the tip of
the ref that is already up-to-date is marked as COMPLETE, we will not even
locally have to walk the object chain to make sure things are connected.

I think the only thing that this possibly gains is if _everything_ is up
to date.  Then we won't need to make a call to transport->fetch() and it
would save a new connection.

But that optimization is already done long ago by the caller's
quickfetch() in the normal case.

Which makes me suspect that the real fix should be something a lot
simpler, like this (untested) patch.

diff --git a/transport.c b/transport.c
index f231b35..14dab81 100644
--- a/transport.c
+++ b/transport.c
@@ -1053,18 +1053,16 @@ const struct ref *transport_get_remote_refs(struct transport *transport)
 int transport_fetch_refs(struct transport *transport, const struct ref *refs)
 {
 	int rc;
-	int nr_heads = 0, nr_alloc = 0;
+	int nr_heads = 0;
 	const struct ref **heads = NULL;
 	const struct ref *rm;
 
-	for (rm = refs; rm; rm = rm->next) {
-		if (rm->peer_ref &&
-		    !hashcmp(rm->peer_ref->old_sha1, rm->old_sha1))
-			continue;
-		ALLOC_GROW(heads, nr_heads + 1, nr_alloc);
+	for (rm = refs; rm; rm = rm->next)
+		nr_heads++;
+	heads = xmalloc(nr_heads * sizeof(*heads));
+	nr_heads = 0;
+	for (rm = refs; rm; rm = rm->next)
 		heads[nr_heads++] = rm;
-	}
-
 	rc = transport->fetch(transport, nr_heads, heads);
 	free(heads);
 	return rc;
