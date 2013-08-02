From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] sha1_file: introduce close_one_pack() to close packs on fd pressure
Date: Fri, 02 Aug 2013 09:26:47 -0700
Message-ID: <7v38qsqcs8.fsf@alter.siamese.dyndns.org>
References: <CA+sFfMdJgQaEBx_FsYPz1rC3--jknnb4Zwr+FOaL+9gNe4xwyw@mail.gmail.com>
	<1375421793-32224-1-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, spearce@spearce.org,
	sunshine@sunshineco.com, bcasey@nvidia.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 02 18:27:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5ICL-00034S-7F
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 18:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab3HBQ0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 12:26:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab3HBQ0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 12:26:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A1243411F;
	Fri,  2 Aug 2013 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f5/Q7osfa3Anu8YQD1KOmab2h5Y=; b=o+w4aQ
	ul4EBkEhfS7H0rofC30t0cd+N0fq+GSfpbJCu2lr9MvUGGr1owYPI8zbRX4/w6wj
	MrPASnFA/D2JGsGtYBTCyRL0Htn/v6EfHBUhwSi2fVQZ51Py+DhmRLMISIc/JvQb
	V6AgBA4YoXWhTwZ93aqgY+nBhznUF9j2POj7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XEjehBbziGoiUgH0P72NmOVGPuIElMiv
	tWEI/yuDbwfFU4Z2KSb5XTwpuiD68bGyhLi1unVbAHHDgNUgcU0ZDCHa7k58ey4+
	ypfFU4nQ6tP1LABO7FR0sMytnaw/waU/KKqAiG810EdTTWObsuJePiPGkYLxCema
	gppju+XCLOI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F07383411E;
	Fri,  2 Aug 2013 16:26:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C99423411C;
	Fri,  2 Aug 2013 16:26:48 +0000 (UTC)
In-Reply-To: <1375421793-32224-1-git-send-email-drafnel@gmail.com> (Brandon
	Casey's message of "Thu, 1 Aug 2013 22:36:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54A31384-FB90-11E2-93F4-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231528>

Brandon Casey <drafnel@gmail.com> writes:

> +/*
> + * The LRU pack is the one with the oldest MRU window, preferring packs
> + * with no used windows, or the oldest mtime if it has no windows allocated.
> + */
> +static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struct pack_window **mru_w, int *accept_windows_inuse)
> +{
> +	struct pack_window *w, *this_mru_w;
> +	int has_windows_inuse = 0;
> +
> +	/*
> +	 * Reject this pack if it has windows and the previously selected
> +	 * one does not.  If this pack does not have windows, reject
> +	 * it if the pack file is newer than the previously selected one.
> +	 */
> +	if (*lru_p && !*mru_w && (p->windows || p->mtime > (*lru_p)->mtime))
> +		return;
> +
> +	for (w = this_mru_w = p->windows; w; w = w->next) {
> +		/*
> +		 * Reject this pack if any of its windows are in use,
> +		 * but the previously selected pack did not have any
> +		 * inuse windows.  Otherwise, record that this pack
> +		 * has windows in use.
> +		 */
> +		if (w->inuse_cnt) {
> +			if (*accept_windows_inuse)
> +				has_windows_inuse = 1;
> +			else
> +				return;
> +		}
> +
> +		if (w->last_used > this_mru_w->last_used)
> +			this_mru_w = w;
> +
> +		/*
> +		 * Reject this pack if it has windows that have been
> +		 * used more recently than the previously selected pack.
> +		 * If the previously selected pack had windows inuse and
> +		 * we have not encountered a window in this pack that is
> +		 * inuse, skip this check since we prefer a pack with no
> +		 * inuse windows to one that has inuse windows.
> +		 */
> +		if (*mru_w && *accept_windows_inuse == has_windows_inuse &&
> +		    this_mru_w->last_used > (*mru_w)->last_used)
> +			return;

The "*accept_windows_inuse == has_windows_inuse" part is hard to
grok, together with the fact that this statement is evaluated for
each and every "w", even though it is about this_mru_w and that
variable is not updated in every iteration of the loop.  Can you
clarify/simplify this part of the code a bit more?

For example, would the above be equivalent to this?

		if (w->last_used < this_mru_w->last_used)
			continue;

		this_mru_w = w;
                if (has_windows_inuse && *mru_w &&
                    w->last_used > (*mru_w)->last_used)
			return;

That is, if we already know a more recently used window in this
pack, we do not have to do anything to maintain mru_w.  Otherwise,
remember that this window is the most recently used one in this
pack, and if it is newer than the newest one from the pack we are
going to pick, we refrain from picking this pack.

But we do not reject ourselves if we haven't seen a window that is
in use (yet).

> +	}
> +
> +	/*
> +	 * Select this pack.
> +	 */
> +	*mru_w = this_mru_w;
> +	*lru_p = p;
> +	*accept_windows_inuse = has_windows_inuse;
> +}
> +
> +static int close_one_pack(void)
> +{
> +	struct packed_git *p, *lru_p = NULL;
> +	struct pack_window *mru_w = NULL;
> +	int accept_windows_inuse = 1;
> +
> +	for (p = packed_git; p; p = p->next) {
> +		if (p->pack_fd == -1)
> +			continue;
> +		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
> +	}
> +
> +	if (lru_p) {
> +		close(lru_p->pack_fd);
> +		pack_open_fds--;
> +		lru_p->pack_fd = -1;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
>  void unuse_pack(struct pack_window **w_cursor)
>  {
>  	struct pack_window *w = *w_cursor;
> @@ -768,7 +845,7 @@ static int open_packed_git_1(struct packed_git *p)
>  			pack_max_fds = 1;
>  	}
>  
> -	while (pack_max_fds <= pack_open_fds && unuse_one_window(NULL, -1))
> +	while (pack_max_fds <= pack_open_fds && close_one_pack())
>  		; /* nothing */
>  
>  	p->pack_fd = git_open_noatime(p->pack_name);
