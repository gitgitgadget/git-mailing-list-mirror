From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] Add support for matching full refs in hideRefs
Date: Wed, 04 Nov 2015 11:09:10 -0800
Message-ID: <xmqqy4eda8fd.fsf@gitster.mtv.corp.google.com>
References: <1446537497-13921-1-git-send-email-lfleischer@lfos.de>
	<1446537497-13921-4-git-send-email-lfleischer@lfos.de>
	<xmqqd1vqdc7c.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:09:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zu3Qt-0007aj-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 20:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbbKDTJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 14:09:15 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755937AbbKDTJN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2015 14:09:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCEA6248C1;
	Wed,  4 Nov 2015 14:09:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ImNIbtikGCi7j7ufHSzs5jS9n10=; b=ZTb+tz
	XTCVNXhSaxkIB1NtOTyuGsz3siUJfPIgUWANSE6p5D66/zer/oD3GPSinXfo2CsJ
	T3vzd701+B9J8TPNY6zZ4UijC0U5TDp4VUWTVwFQoLmCeyZRpEkjzpbiJT3iLM3j
	Io2EIn7NkoWeT/37SRycv35vwS91A9CBy3t3k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=huMABoLGaQVSjFNNyvHKenrHr8Y5mKWn
	ITNXQcrmvzJsy3qAjhPsoXbHcA7vh1HWm2CcaZmW63s87dEs9rsAt0dxNMXIZHIc
	+eG3rwbBhVFzQ/9fQw5SJZDi/kBB3vHcjkvKBuRsZmiNoJAk2bBU+h55J+Y0w27I
	ITTZQIphoB4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B2876248C0;
	Wed,  4 Nov 2015 14:09:12 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 32C48248BE;
	Wed,  4 Nov 2015 14:09:12 -0500 (EST)
In-Reply-To: <xmqqd1vqdc7c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 03 Nov 2015 13:07:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8887CF98-8327-11E5-82D4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280865>

Junio C Hamano <gitster@pobox.com> writes:

> The semantics of "hideRefs" used to be that "refs can be hidden from
> ls-remote" (i.e. prevents fetching, avoids contaminating "--mirror")
> and "refs can be hidden from 'push'", but the objects being known
> tips of histories that are complete, they still participate in
> common ancestor discovery.  
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 3da97a1..91ed6a5 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2690,7 +2690,8 @@ the prefix `refs/heads/master` is specified in `transfer.hideRefs` and the
>>  current namespace is `foo`, then `refs/namespaces/foo/refs/heads/master` is
>>  omitted from the advertisements but `refs/heads/master` and
>>  `refs/namespaces/bar/refs/heads/master` are still advertised as so-called
>> -"have" lines.
>> +"have" lines. In order to match refs before stripping, add a `^` in front of
>> +the ref name. If you combine `!` and `^`, `!` must be specified first.
>
> I think the changes in the above two hunks prevent the hidden refs
> from participating in common ancestor discovery (which is probably a
> good thing), making the above description stale.

Ah, I was confused.  The description only says "refs from outer
namespaces are not advertised, but still participate the common
ancestor discovery in the form of .have lines", and moving the
location where ref-is-hidden is called in this patch does not affect
that fact at all.

So this looks good as-is.

Thanks.
