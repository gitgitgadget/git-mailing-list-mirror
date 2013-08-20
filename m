From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 04/24] read-cache: clear version in discard_index()
Date: Tue, 20 Aug 2013 12:34:50 -0700
Message-ID: <xmqqmwoc5f6t.fsf@gitster.dls.corp.google.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com>
	<1376854933-31241-5-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:34:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrhh-0000kK-PL
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab3HTTey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:34:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52117 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751188Ab3HTTex (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:34:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D330B3A979;
	Tue, 20 Aug 2013 19:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slZKoDiJFKo8HvbByEtVpb+5B/U=; b=dFF1bV
	5xLQgkKZzeLNj5QoOUVL2CJ6gNLWK0YSoUSq7S358vQNHXyqCiG2PDnL7oDlc6uN
	LJNuyVjvZ7bcqlRmrONNmbq2o+Ce/9nT8kfnA3dh/r0ZyN/k7uEDMYt3ghhPrXH0
	g8mRJEU9/bIe3yjhxBdFv5ke2A97IA9xNcB3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=au4N+8qvpxTFHmlFcQRmWXdBiezxl8Ef
	Bpn0eNDfnL+WCtdJl+Osws3iuWeRYzQhoJle9iFoNt8nRj28gcLDUXMQXyVHS2hr
	ubWsi4ifQm3oE6x49EUdxxJfJB/x4gT5hwBg/2EjwXDJA67sss8r/gG91Q1ErdE0
	PdGbCK8V/eg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6AB03A978;
	Tue, 20 Aug 2013 19:34:52 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 086BF3A973;
	Tue, 20 Aug 2013 19:34:52 +0000 (UTC)
In-Reply-To: <1376854933-31241-5-git-send-email-t.gummerer@gmail.com> (Thomas
	Gummerer's message of "Sun, 18 Aug 2013 21:41:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 957095EC-09CF-11E3-9B79-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232637>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> All fields except index_state->version are reset in discard_index.
> Reset the version too.

What is the practical consequence of not clearing this field?  I
somehow have a feeling that this was done deliberately, so that we
can stick to the version of the index file format better, once the
user said "update-index --index-version $N" to set it up.  I suspect
that the patch would affect a codepath that does read_cache(), calls
discard_index(), populates the index and then does write_cache().
We stick to the version the user specified earlier in our current
code, while the patched code will revert to whatever default built
into your Git binary, no?

>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>  read-cache.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index de0bbcd..1e22f6f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1558,6 +1558,7 @@ int discard_index(struct index_state *istate)
>  	for (i = 0; i < istate->cache_nr; i++)
>  		free(istate->cache[i]);
>  	resolve_undo_clear_index(istate);
> +	istate->version = 0;
>  	istate->cache_nr = 0;
>  	istate->cache_changed = 0;
>  	istate->timestamp.sec = 0;
