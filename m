From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] Add support for matching full refs in hideRefs
Date: Tue, 03 Nov 2015 13:07:03 -0800
Message-ID: <xmqqd1vqdc7c.fsf@gitster.mtv.corp.google.com>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
	<1446537497-13921-4-git-send-email-lfleischer@lfos.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:07:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtinS-0007Gw-Di
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbbKCVHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:07:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55164 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750753AbbKCVHH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:07:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D04E29892;
	Tue,  3 Nov 2015 16:07:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TaMzdcKdJcmkHRzWQVv6yvMRamY=; b=qIrt3v
	pHjMZmq/1sbKr/vfPV0uLA4sGwBluSzFMh8pGnZ1LzD3hvVOiKe4jyKgKnXu5mkl
	Z/LQ5vIGErWkSbF0c4xW1rVkwG1qlkrz8U1+00O+lFLACOQOaQtdokitcRNpkya1
	hy+/axSwek/dOu3vZzEdL9zoqSheu3UUvPcb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oj59YjHsZtWTQZxn6bPyjaKKeJaywhmo
	3uhOIjq3DcwHghhAOLVgEoUktITidD141EBm1GvckvakbyO6GRVWK8ik1NTUFI5t
	q8Zcgg+BtR0kAAUZq86+NVbWYz0BPNKaOrkT0xHsA9ik+f73UWqPTZmUe/IwWUtr
	xPaElHSL0vg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54FEE29891;
	Tue,  3 Nov 2015 16:07:05 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6DB5429890;
	Tue,  3 Nov 2015 16:07:04 -0500 (EST)
In-Reply-To: <1446537497-13921-4-git-send-email-lfleischer@lfos.de> (Lukas
	Fleischer's message of "Tue, 3 Nov 2015 08:58:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D5805554-826E-11E5-9F5B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280817>

Lukas Fleischer <lfleischer@lfos.de> writes:

>  static void show_ref(const char *path, const unsigned char *sha1)
>  {
> -	if (ref_is_hidden(path))
> -		return;
> -
>  	if (sent_capabilities) {
>  		packet_write(1, "%s %s\n", sha1_to_hex(sha1), path);
>  	} else {
> @@ -219,9 +216,14 @@ static void show_ref(const char *path, const unsigned char *sha1)
>  	}
>  }
>  
> -static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
> +static int show_ref_cb(const char *path_full, const struct object_id *oid,
> +		       int flag, void *unused)
>  {
> -	path = strip_namespace(path);
> +	const char *path = strip_namespace(path_full);
> +
> +	if (ref_is_hidden(path, path_full))
> +		return 1;
> +

These two hunks are doing a bit more than the primary topic of this
step, aren't they?

The semantics of "hideRefs" used to be that "refs can be hidden from
ls-remote" (i.e. prevents fetching, avoids contaminating "--mirror")
and "refs can be hidden from 'push'", but the objects being known
tips of histories that are complete, they still participate in
common ancestor discovery.  

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 3da97a1..91ed6a5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2690,7 +2690,8 @@ the prefix `refs/heads/master` is specified in `transfer.hideRefs` and the
>  current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master` is
>  omitted from the advertisements but `refs/heads/master` and
>  `refs/namespaces/bar/refs/heads/master` are still advertised as so-called
> -"have" lines.
> +"have" lines. In order to match refs before stripping, add a `^` in front of
> +the ref name. If you combine `!` and `^`, `!` must be specified first.

I think the changes in the above two hunks prevent the hidden refs
from participating in common ancestor discovery (which is probably a
good thing), making the above description stale.
