From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for handling packname
Date: Thu, 27 Feb 2014 11:39:54 -0800
Message-ID: <xmqq8uswz6np.fsf@gitster.dls.corp.google.com>
References: <1393509601-31312-1-git-send-email-sunheehnus@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Sun He <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 20:40:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ6oO-0001bS-0F
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 20:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbaB0Tj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 14:39:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742AbaB0Tj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 14:39:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1BDD707AB;
	Thu, 27 Feb 2014 14:39:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=suXWTTMRxUYcvILo8cNpYvjz3MA=; b=sWJNxr
	YLgOgMSSZa+w+1cu1EmcL82nEgYrbxKYq0JXE7Jt5K95AWoMMTcIGFX/jyC9EpTJ
	8gp+oIRKjHNSL3LvCUjT1ANKU3TwBSNNJaqIbxBm9iES6Ox1FC6WY5ZL/rAOW4ZL
	TwaMW/bhXBO4iPchSbog24PsMWsz6tVxovzEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B63sQCv2nSe/IM5Jtw2b9SIx+Lo2lr3I
	6LPVXCsjsHXB9hKSMtu46ZMkYkc/b2kYtYpNRip0HjFUiYP9N0pQiewuiKRHV7zu
	/B8+tfnXU8nnCdroQ8kWnWgzr1CPaMp8hysFd534amQRavNhTyD3sAd/CYSPX/00
	Lbhry3jFCHQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8146707AA;
	Thu, 27 Feb 2014 14:39:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEB0E707A8;
	Thu, 27 Feb 2014 14:39:56 -0500 (EST)
In-Reply-To: <1393509601-31312-1-git-send-email-sunheehnus@gmail.com> (Sun
	He's message of "Thu, 27 Feb 2014 22:00:01 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F00C5574-9FE6-11E3-9230-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242843>

Sun He <sunheehnus@gmail.com> writes:

> Signed-off-by: Sun He <sunheehnus@gmail.com>
> ---
>  bulk-checkin.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 118c625..8c47d71 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -23,7 +23,8 @@ static struct bulk_checkin_state {
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
>  	unsigned char sha1[20];
> -	char packname[PATH_MAX];
> +	char *packname;
> +    struct strbuf sb;

Funny indentation.

>  	int i;
>  
>  	if (!state->f)
> @@ -43,6 +44,10 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  		close(fd);
>  	}
>  
> +    /* 64-1 is more than the sum of len(sha1_to_hex(sha1)) and len(".pack") */
> +    strbuf_init(&sb,strlen(get_object_directory())+64);
> +    packname = sb.buf;
> +
>  	sprintf(packname, "%s/pack/pack-", get_object_directory());

If you are using strbuf why not use strbuf_addf() instead?  Then you
do not have to worry about "Is 64-1 enough?" and things like that.

>  	finish_tmp_packfile(packname, state->pack_tmp_name,
>  			    state->written, state->nr_written,
> @@ -54,6 +59,9 @@ clear_exit:
>  	free(state->written);
>  	memset(state, 0, sizeof(*state));
>  
> +    /* release sb space */
> +    strbuf_release(&sb);

The function name is more than enough to explain what it does.  Drop
that comment.

>  	/* Make objects we just wrote available to ourselves */
>  	reprepare_packed_git();
>  }
