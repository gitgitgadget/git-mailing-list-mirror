From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] replace: add --graft option
Date: Mon, 09 Jun 2014 09:43:07 -0700
Message-ID: <xmqq61kaf2zo.fsf@gitster.dls.corp.google.com>
References: <20140604194118.23903.3019.chriscool@tuxfamily.org>
	<20140604194353.23903.89933.chriscool@tuxfamily.org>
	<xmqqfvjjrpq9.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3k98_6Uh+noJgt4xqEooATVMAEf58FFkuy6rHBnP10zw@mail.gmail.com>
	<CAP8UFD2u-DReCv2ZXhAzH_UMW5P--+a=AKS-N88xE6zmdWBLqQ@mail.gmail.com>
	<CAP8UFD344NFECqtO-uK-2wHA7XEko3XMJWuhW9+KGBdaiqGq+w@mail.gmail.com>
	<20140608112333.GA9691@sigill.intra.peff.net>
	<20140608120439.GA21827@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:43:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu2fH-0006m4-5z
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 18:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933617AbaFIQnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 12:43:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57358 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbaFIQnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 12:43:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B57A31C983;
	Mon,  9 Jun 2014 12:43:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUrjHDQ8WrZwkA0cf4xz9aza17Q=; b=rJymDt
	PZO5c8yj+swFuPbOO0eWOz9p4nkZ5zwmEnSDrEDGCHHy5FIlUy/04y5+6S2CFnKL
	n+n5zDzhoD3O6TXxIEyx5tUk2qO+xLj7yYuMBVwzY0EzmAsGFdn199MF9VbKZk91
	Lewwop7OWlq/Ihm4GgOm6oEXuimU8cjHw3jdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rrtOJkxRzFDtG1vCWeBarwj2DnuZQFU5
	tBGCx624xoYdL+15ZMia9rijfqYoSuIMJX01wKUBjfF7ytHZZjRb1FxSmPG73DXV
	rOVyeYijV0XMJEiZzz3vA1HyLsuhDva4F9iH5B05zep65WGrwUpV+CVAfEp8dQAD
	7ppQi7YHdck=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A072A1C982;
	Mon,  9 Jun 2014 12:43:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 65B2A1C97D;
	Mon,  9 Jun 2014 12:43:09 -0400 (EDT)
In-Reply-To: <20140608120439.GA21827@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 8 Jun 2014 08:04:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 23960198-EFF5-11E3-8008-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251083>

Jeff King <peff@peff.net> writes:

> I think it would make sense to actually take this one step further,
> though, and move commit->buffer into the slab, as well. That has two
> advantages:
>
>   1. It further decreases the size of "struct commit" for callers who do
>      not use save_commit_buffer.
>
>   2. It ensures that no new callers crop up who set "commit->buffer" but
>      to not save the size in the slab (you can see in the patch below
>      that I had to modify builtin/blame.c, which (ab)uses
>      commit->buffer).
>
> It would be more disruptive to existing callers, but I think the end
> result would be pretty clean. The API would be something like:
>
>   /* attach buffer to commit */
>   set_commit_buffer(struct commit *, void *buf, unsigned long size);
>
>   /* get buffer, either from slab cache or by calling read_sha1_file */
>   void *get_commit_buffer(struct commit *, unsigned long *size);
>
>   /* free() an allocated buffer from above, noop for cached buffer */
>   void unused_commit_buffer(struct commit *, void *buf);
>
>   /* drop saved commit buffer to free memory */
>   void free_commit_buffer(struct commit *);
>
> The "get" function would serve the existing callers in pretty.c, as well
> as the one I'm adding elsewhere in show_signature. And it should work as
> a drop-in read_sha1_file/free replacement for you here.

This solution has the kind of niceness to make everybody (certainly
including me) who has been involved in the code path should say "why
didn't I think of that!" ;-)
