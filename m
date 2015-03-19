From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Wed, 18 Mar 2015 23:41:14 -0700
Message-ID: <xmqqoanpjxpx.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
	<20150319052620.GA30645@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 07:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYU8v-0005rl-R4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 07:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbbCSGlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 02:41:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750799AbbCSGlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 02:41:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D45F43A806;
	Thu, 19 Mar 2015 02:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k8t26sQS9hkuH+HQ3Ui3s+LuwfA=; b=nlDeSI
	MHt3b19MwMJ8zk52ZtHWWLJ++idpmKCgBlAIEJxLmFDNeFbDtxJMbhJvfA6B8FsQ
	9ZsgPKokgPETbSgTy42iZ6BromlCDiIg4XEsMoLvmMjjTayY5FOM0cijKHGlAwLO
	TZ9UzwoROFyJyPpfgd4547gf7n402h1QLToGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PpBeYRMfmFM4qymksjte46QAuwlx5UXz
	GsmhTZ17DElVV6KZv/Y8sYu9NVCDWcgeU+Lleogk2VxPI98M1OmXDUwdPv9FF9dG
	JH5LSEXc9x0jopsQfViqSTj8j++SZnc3ztfwFu1+D9kKnNqHWRMRXiHndkIewa/O
	cNRooLaN0Hs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC1303A804;
	Thu, 19 Mar 2015 02:41:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 456C83A801;
	Thu, 19 Mar 2015 02:41:15 -0400 (EDT)
In-Reply-To: <20150319052620.GA30645@peff.net> (Jeff King's message of "Thu,
	19 Mar 2015 01:26:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0CA8B70-CE02-11E4-B258-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265791>

Jeff King <peff@peff.net> writes:

> I wondered if we could do away with the radix entirely. Wouldn't we be
> asking for base 10 most of the time? Of course, your first few patches
> show octal parsing, but I wonder if we should actually have a separate
> parse_mode() for that, since that seems to be the general reason for
> doing octal parsing. 100000644 does not overflow an int, but it is
> hardly a reasonable mode.

True.

> I also wondered if we could get rid of NUM_SIGN in favor of just having
> the type imply it (e.g., convert_l would always allow negative numbers,
> whereas convert_ul would not). But I suppose there are times when we end
> up using an "int" to store an unsigned value for a good reason (e.g.,
> "-1" is a sentinel value, but we expect only positive values from the
> user). So that might be a bad idea.

Yeah, there is a reason why ssize_t exists.

> IMHO most of the tightening happening here is a good thing, and means we
> are more likely to notice mistakes rather than silently doing something
> stupid.

I do like the general idea of making sure we avoid use of bare
atoi() and unchecked use of strtol() and such, and have a set of
well defined helper functions to perform the common checks, exactly
for the reason you said.
