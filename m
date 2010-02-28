From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: fix segfault caused by invalid index access
Date: Sun, 28 Feb 2010 10:13:22 -0800
Message-ID: <7vocj9cjp9.fsf@alter.siamese.dyndns.org>
References: <vpq7hpxl4cp.fsf@bauges.imag.fr>
 <1267375122-13039-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Feb 28 19:14:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlneF-00038o-Fu
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 19:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab0B1SNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 13:13:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:32849 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab0B1SNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 13:13:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DF5679E89B;
	Sun, 28 Feb 2010 13:13:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HUFUaHP5jUjoK7gYLI1UeeTfOs4=; b=L/6Khn
	O4XrHjFwNwzu8QXTswGEtTmw/XNet9A20xw7hVwZeDOpRbz4sGjMznpt97VrHUx+
	IftkgLFw8J6XfezledZzzitXREE0xxE6e61osOsElF2R/XWi5cQZ8b9CpTGpmUYZ
	+sasU4NT7CCf6HKPc6dxCOBRVFyPuqWuRpZcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pYI75S9x8+4Rt6xKEP4OfxuuyZjSjYbB
	NVZf/7jc+UR40qs4PPOsBIvnGBXwZbPvgGT9XE0QLw73lDpughnCY2kCLEOfFN8I
	3BAL7xexVlUmwS8/AITuEE4BbLvAX1bpoBbGuL+CzeZdhk7WRF9/4MdoXkNMle+p
	1RmVvMtQMNw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB2339E89A;
	Sun, 28 Feb 2010 13:13:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14C139E899; Sun, 28 Feb
 2010 13:13:24 -0500 (EST)
In-Reply-To: <1267375122-13039-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Sun\, 28 Feb 2010 17\:38\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F7E7E55A-2494-11DF-BD9B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141258>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> -	if (pos < 0)
> -		pos = -pos - 1;
> -	ce = active_cache[pos];
> -	if (ce_namelen(ce) == namelen &&
> -	    !memcmp(ce->name, filename, namelen))
> +	if (pos >= 0) {
> +		ce = active_cache[pos];

A positive return value of cache_name_pos() is "I found a merged entry
with that name at this index" while a negative is "I would insert at this
index if you give me a merged entry with that name".

The latter is what the name comparison logic is about.  The caller asked
for filename, and the return value may point at an existing entry (in
which case you do not even need to memcmp(), but it doesn't hurt and
simplifies the code).  The nagative one with compensation could be
pointing at an unrelated entry, or an unmerged entry with filename you
asked, which sorts higher than a merged entry with the same name.
