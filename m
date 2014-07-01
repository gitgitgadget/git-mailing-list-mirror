From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] string-list: add pos to iterator callback
Date: Tue, 01 Jul 2014 10:45:19 -0700
Message-ID: <xmqq1tu5x9ao.fsf@gitster.dls.corp.google.com>
References: <20140625233429.GA20457@sigill.intra.peff.net>
	<20140625234252.GE23146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:45:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X227f-0001oE-Hw
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 19:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758068AbaGARp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 13:45:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56368 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755607AbaGARp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 13:45:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B383824D2B;
	Tue,  1 Jul 2014 13:45:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AmQvP2anez7HsONbla5fEztQ014=; b=ipmf/V
	YpMeSnZff2T+b4L9N9Ybz59FjPvNu5H8nLK6GP6Jr9hDraYUqTEU+J5UAt+bSJkf
	SbBlbR5VgrTQdg8tDm8CycwX5yA0pRHSqk7TQjWpD3XEqJh053ga2FnSJvaB5yql
	6ZpVwMOg3Ff8VerwjA22TWQg/NF//XlfOuGRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MZ03SbGWYsFGjCRCHx9T2JziUm+8ZCyJ
	ikUQ1anX5EEw2BPssq/5ZvqynQjrO1LLmSSPcqQ92C4FWveaP/kCmIT2vmCKhRY1
	KJS86FNOENwdFYTldWZdieFtqF/sE/fK4oQpS5ylLeao6xWkWFOID3OYVJA5bKgl
	chH0CW3NVbw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A9AFF24D2A;
	Tue,  1 Jul 2014 13:45:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E1A8324D21;
	Tue,  1 Jul 2014 13:45:09 -0400 (EDT)
In-Reply-To: <20140625234252.GE23146@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Jun 2014 19:42:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 72443A04-0147-11E4-B297-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252731>

Jeff King <peff@peff.net> writes:

> When we are running a string-list foreach or filter, the
> callback function sees only the string_list_item, along with
> a void* data pointer provided by the caller. This is
> sufficient for most purposes.
>
> However, it can also be useful to know the position of the
> item within the string (for example, if the data pointer

s/the string/&-list/ (or s/&/&_list/).

> points to a secondary array in which each element
> corresponds to part of the string list). We can help this
> use case by providing the position to each callback.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The diff here is noisy, and I expect in the long run that the one caller
> I add to builtin/tag.c later in the series will eventually stop using
> string_list entirely (in favor of a custom struct), which may leave us
> with no callers that actually use the new field.
>
> I do think the logic above is sound, though, and it's a potentially
> useful thing. There may be other sites that avoid the for_each wrapper
> in favor of iterating themselves simply _because_ they needed to know
> the position (I would just do the same here, except that my new caller
> wants to use filter_string_list, which is a little more complicated).

While I can buy that some callers would want to learn the pos in the
list, I am not sure if this is a good direction to go.  Primarily, I
am having trouble sifting between "want" and "need".

How often do callers want to do this?  If only narrow specialized
callers want this, is it unreasonable to ask them to add a "int ctr"
in their cb_data and use "pos = ((struct theirs *)cb_data)->ctr++"
in their callback instead?
