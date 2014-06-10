From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/15] use get_commit_buffer everywhere
Date: Tue, 10 Jun 2014 09:06:35 -0700
Message-ID: <xmqqioo8agvo.fsf@gitster.dls.corp.google.com>
References: <20140609180236.GA24644@sigill.intra.peff.net>
	<20140609181323.GL20315@sigill.intra.peff.net>
	<xmqqbnu1emfa.fsf@gitster.dls.corp.google.com>
	<20140610000223.GA20644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 18:06:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuOZU-0006ly-LD
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 18:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbaFJQGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 12:06:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56972 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751541AbaFJQGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 12:06:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E51B01DAE6;
	Tue, 10 Jun 2014 12:06:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d3DqQm3eLV5YJEUbgP0/da0qE0U=; b=uKE1IB
	y7kr1kWWFZtU6rmRioWtfA+S700wA4OuyWTP9q9qcB9BZBq/MgTpGiahgzXokHyi
	DfJnknMDPbh8BsP0C+2UkzfSLmDDyzqHZtC6PRZ8/lrjWcWiHp5bWCCrCaExSPHt
	Pgz+s7GSGepbTl3ON7ANeQCs50HVj26/uaEc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pqRm9PtYICXRToNvfSpDbWsvHU2qP0Du
	wVBnlG3c18fa9XBTolz16Frlo/LPXKZNy2wP7N6i4QFxwaUS5oFqIISnUzPeoznS
	mWM2noydxya4JXHSelldAXJQwMdhoot7nSeunT/msUkeL5xrPrO/+9bxpr/mibtq
	rTuukozrGLs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8F551DAE5;
	Tue, 10 Jun 2014 12:06:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 60A931DADF;
	Tue, 10 Jun 2014 12:06:37 -0400 (EDT)
In-Reply-To: <20140610000223.GA20644@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 9 Jun 2014 20:02:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 337D9976-F0B9-11E3-8CD0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251202>

Jeff King <peff@peff.net> writes:

> I agree it's not right, though. I think the original is questionable,
> too. It takes a pointer into the middle of partial_commit->buffer and
> attaches it to a strbuf. That's wrong because:
>
>   1. It's pointing into the middle of an allocated buffer, not the
>      beginning.
>
>   2. We do not own partial_commit->buffer in the first place.
>
> So any call to strbuf_detach on the result would be disastrous.

You are right.  Where did this original crap come from X-<...

> ... and it
> doesn't cause a bug in practice because the only use of the strbuf is to
> pass it as a const to create_notes_commit.
>
> I feel like the most elegant solution is for create_notes_commit to take
> a buf/len pair rather than a strbuf, but it unfortunately is just
> feeding that to commit_tree. Adjusting that code path would affect quite
> a few other spots.
>
> The other obvious option is actually populating the strbuf, but it feels
> ugly to have to make a copy just to satisfy the function interface.
>
> Maybe a cast and a warning comment are the least evil thing, as below? I
> dunno, it feels pretty wrong.

Yeah, it does feel wrong wrong wrong.  Perhaps this big comment
would serve as a marker for a low-hanging fruit for somebody else to
fix it, e.g. by using strbuf-add to make a copy, which would be the
easiest and safest workaround?

> diff --git a/notes-merge.c b/notes-merge.c
> index 94a1a8a..1f3b309 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -671,7 +671,7 @@ int notes_merge_commit(struct notes_merge_options *o,
>  	DIR *dir;
>  	struct dirent *e;
>  	struct strbuf path = STRBUF_INIT;
> -	char *msg = strstr(partial_commit->buffer, "\n\n");
> +	const char *msg = strstr(partial_commit->buffer, "\n\n");
>  	struct strbuf sb_msg = STRBUF_INIT;
>  	int baselen;
>  
> @@ -719,7 +719,15 @@ int notes_merge_commit(struct notes_merge_options *o,
>  		strbuf_setlen(&path, baselen);
>  	}
>  
> -	strbuf_attach(&sb_msg, msg, strlen(msg), strlen(msg) + 1);
> +	/*
> +	 * This is a bit tricky. We should not be attaching msg, which
> +	 * is not owned by us and is not even the start of a heap buffer, to a
> +	 * strbuf. But the create_notes_commit interface really wants
> +	 * a strbuf, even though it will only ever use it as a buf/len pair and
> +	 * never modify it. So this is tentatively safe as long as nobody ever
> +	 * modifies, detaches, or releases the strbuf.
> +	 */
> +	strbuf_attach(&sb_msg, (char *)msg, strlen(msg), strlen(msg) + 1);
>  	create_notes_commit(partial_tree, partial_commit->parents, &sb_msg,
>  			    result_sha1);
>  	if (o->verbosity >= 4)
>
> I'm still confused and disturbed that my gcc is not noticing this
> obvious const violation. Hmm, shutting off ccache seems to make it work.
> Doubly disturbing.
>
> -Peff
