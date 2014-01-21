From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] builtin/blame.c: struct blame_entry does not need a prev link
Date: Tue, 21 Jan 2014 13:54:58 -0800
Message-ID: <xmqqlhy9t2z1.fsf@gitster.dls.corp.google.com>
References: <1390157870-29795-1-git-send-email-dak@gnu.org>
	<1390157870-29795-2-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 21 22:55:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5jHs-0005Ky-4D
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 22:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbaAUVzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jan 2014 16:55:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085AbaAUVzF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jan 2014 16:55:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8570636BA;
	Tue, 21 Jan 2014 16:55:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H8jY6RvdL1XPwyPjfaXZCfN3UIY=; b=tuRMQu
	eptAovexJ7VCT3sD6J79lPy1W6r0IRXF8lpe1jxHYiWfOR5DzkvwD+I5tImHrqP2
	zqGGk4xV6V0ECLs0jGh6j+mDgF7g7Mt8uIfi1qfOXmJc6NWRp01tYTALdPNqbF2A
	MWAIaZxR+ml4MVWlrbhRMdFLs43ZgQ4Wx2qy0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJqtW8b3MDIk3ct7hUJOfGhLwO+GqTo8
	AQ8aTDePvnvDOewv+fqGyDoNV+LOxEUFXII0BMXwEtmuZSntzZUbZye+ZFtxBvls
	9LcBaOklTQRFamGtfBnSkyI1tYMKr8rfGyfEaIcWo3MPdxNq0zvbbb1xGqgjwDI1
	+fwwXgkhRdk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1945636B9;
	Tue, 21 Jan 2014 16:55:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7203B636B2;
	Tue, 21 Jan 2014 16:55:02 -0500 (EST)
In-Reply-To: <1390157870-29795-2-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Sun, 19 Jan 2014 19:57:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AE0505B2-82E6-11E3-A7CE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240779>

David Kastrup <dak@gnu.org> writes:

> ---

Thanks.  At some point during its development I must have thought
that having it as a dual-linked list may make it easier when we have
to split a block into pieces, but it seems that split_overlap() does
not need to look at this information.

Needs sign-off.


>  builtin/blame.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e44a6bb..2195595 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -197,7 +197,6 @@ static void drop_origin_blob(struct origin *o)
>   * scoreboard structure, sorted by the target line number.
>   */
>  struct blame_entry {
> -	struct blame_entry *prev;
>  	struct blame_entry *next;
>  
>  	/* the first line of this group in the final image;
> @@ -282,8 +281,6 @@ static void coalesce(struct scoreboard *sb)
>  		    ent->s_lno + ent->num_lines == next->s_lno) {
>  			ent->num_lines += next->num_lines;
>  			ent->next = next->next;
> -			if (ent->next)
> -				ent->next->prev = ent;
>  			origin_decref(next->suspect);
>  			free(next);
>  			ent->score = 0;
> @@ -534,7 +531,7 @@ static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
>  		prev = ent;
>  
>  	/* prev, if not NULL, is the last one that is below e */
> -	e->prev = prev;
> +
>  	if (prev) {
>  		e->next = prev->next;
>  		prev->next = e;
> @@ -543,8 +540,6 @@ static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
>  		e->next = sb->ent;
>  		sb->ent = e;
>  	}
> -	if (e->next)
> -		e->next->prev = e;
>  }
>  
>  /*
> @@ -555,14 +550,12 @@ static void add_blame_entry(struct scoreboard *sb, struct blame_entry *e)
>   */
>  static void dup_entry(struct blame_entry *dst, struct blame_entry *src)
>  {
> -	struct blame_entry *p, *n;
> +	struct blame_entry *n;
>  
> -	p = dst->prev;
>  	n = dst->next;
>  	origin_incref(src->suspect);
>  	origin_decref(dst->suspect);
>  	memcpy(dst, src, sizeof(*src));
> -	dst->prev = p;
>  	dst->next = n;
>  	dst->score = 0;
>  }
> @@ -2502,8 +2495,6 @@ parse_done:
>  		ent->suspect = o;
>  		ent->s_lno = bottom;
>  		ent->next = next;
> -		if (next)
> -			next->prev = ent;
>  		origin_incref(o);
>  	}
>  	origin_decref(o);
