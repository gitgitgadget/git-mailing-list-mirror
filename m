From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Mon, 06 Jun 2011 13:31:54 -0700
Message-ID: <7vipsi8zwl.fsf@alter.siamese.dyndns.org>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 22:32:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTgTA-0003JQ-Bt
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 22:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965Ab1FFUcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 16:32:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44443 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab1FFUcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 16:32:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 533865032;
	Mon,  6 Jun 2011 16:34:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfM3/LilYPx1r3SfsoUCTjP79cM=; b=YfNhoo
	0IgNFOHI9vgXwBiQVPEIQoaSlphWlG3bLY2GRXyyj/i9W98E62q4+mpUAa9T4nZ/
	pgBisuwf0/xdll7VzG0UR2lPvlj19vlz5NoBabIFmOpHkbxPCv1YryE0k5+QbL8k
	zGPLDYjd988TO14LFkb+7SZDptWsCXQDeMAJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c75vU+Sx7F+guPiLonL9KDqQlh8ebSmK
	wLPqqEpLmIB5icytJGtneQOC+PUDVZ+9024JQPT0qgUiTZ16ki8rrY1CNsU4vN3Z
	iyBmqX8jgEFVsMAaX8amjvNr/FDmiuqwQPxd9t+8wrRxM0kEYpuHiVu/VH2ySnlY
	6CbgD1ononE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F06FF502D;
	Mon,  6 Jun 2011 16:34:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 51B9B5026; Mon,  6 Jun 2011
 16:34:06 -0400 (EDT)
In-Reply-To: <20110603051805.GC1008@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Jun 2011 01:18:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56DF8A82-907C-11E0-828D-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175161>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index f579794..a99f1c8 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -343,8 +343,9 @@ static void remove_junk_on_signal(int signo)
>  static struct ref *wanted_peer_refs(const struct ref *refs,
>  		struct refspec *refspec)
>  {
> -	struct ref *local_refs = NULL;
> -	struct ref **tail = &local_refs;
> +	struct ref *head = get_remote_ref(refs, "HEAD");

The rest of the patch looked quite sane but I wonder if this should be
using get_remote_ref() that calls find_ref_by_name_abbrev() which in turn
would hit "refs/heads/HEAD" if the remote side didn't give you "HEAD".
Shouldn't it be using find_ref_by_name() directly?

> @@ -357,8 +358,11 @@ static void write_remote_refs(const struct ref *local_refs)
>  {
>  	const struct ref *r;
>  
> -	for (r = local_refs; r; r = r->next)
> +	for (r = local_refs; r; r = r->next) {
> +		if (!r->peer_ref)
> +			continue;

As this is part of this patch, I presume this test reliably catch "HEAD"
and only "HEAD", but what is it that gives us this guarantee?  Is it that
in all three possible configurations (i.e. traditional no-separate remote
layout, separate remote layout, or mirrored layout), we never map anything
outside refs/heads/* and refs/tags/* namespace, hence things like HEAD
will never have peer_ref defined?

This is not a complaint but is an honest question. I am wondering how
future possible enhancements to "clone" (like the rumored "track only this
branch") will affect codepaths around this area.
