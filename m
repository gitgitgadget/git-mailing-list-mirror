From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] commit: provide a function to find a header in a buffer
Date: Wed, 27 Aug 2014 10:30:22 -0700
Message-ID: <xmqqioldet75.fsf@gitster.dls.corp.google.com>
References: <20140827075503.GA19521@peff.net>
	<20140827075600.GA26384@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:30:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMh3O-0005fW-A3
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 19:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935356AbaH0Rad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 13:30:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60969 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934674AbaH0Rac (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 13:30:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BA00331B3;
	Wed, 27 Aug 2014 13:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KSV+ramg7BZ+jcUJVkiyhVPkEfU=; b=KUFj1u
	y7xmRv3RQHIqrcnINKRHaZdAEGdfwKfDoEDD+CY1RugKSXOX+XOwpRfKfOCilFCG
	Ivhxj9M9bn6O/6gYsox1/t22rGy36JBSsyr9edkfajh7iIXDRI1vMovnEdlACfdO
	RJvLV3SoXKyOqc/XDIWKnwY+Lyle5djU3z8WA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XQpMcgUo/7sMThc83827a+/vI61boC6N
	Q8FlSPLjsTzdXCgunGu1eFkLFJgv5tET7I6XI6md55Tp9nYeB5EdHsK+geaSBqy7
	sL7NnIxc1SL92poSIp2t0fV0P5iZy+do36QumFSfrPmCrNQd/be37lw1f9Egks0z
	W88rCF/vFmY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91F81331B2;
	Wed, 27 Aug 2014 13:30:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BF463331AE;
	Wed, 27 Aug 2014 13:30:23 -0400 (EDT)
In-Reply-To: <20140827075600.GA26384@peff.net> (Jeff King's message of "Wed,
	27 Aug 2014 03:56:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D3A189A6-2E0F-11E4-93A6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256014>

Jeff King <peff@peff.net> writes:

> +const char *find_commit_header(const char *msg, const char *key, size_t *out_len)
> +{
> +	int key_len = strlen(key);
> +	const char *line = msg;
> +
> +	while (line) {
> +		const char *eol = strchrnul(line, '\n');
> +
> +		if (line == eol)
> +			return NULL;
> +
> +		if (eol - line > key_len &&
> +		    !strncmp(line, key, key_len) &&
> +		    line[key_len] == ' ') {
> +			*out_len = eol - line - key_len - 1;
> +			return line + key_len + 1;

Hmph.  Does this have to worry about continuation lines in the
header part e.g. mergetag?  If the original in pretty.c was only
about the encoding, it may not have mattered, but now because it is
made public, it may matter more.
