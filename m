From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/21] tree_entry_interesting(): fix depth limit with
 overlapping pathspecs
Date: Thu, 16 Dec 2010 15:31:39 -0800
Message-ID: <7vmxo5l2g4.fsf@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 00:31:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTNIh-0000u0-2X
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 00:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab0LPXbt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Dec 2010 18:31:49 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885Ab0LPXbs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 18:31:48 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A796433EA;
	Thu, 16 Dec 2010 18:32:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oP3d54Y2DJfB
	495cE/cIyuamv5Y=; b=JGMM/Q167pfn8i+ijRKKiQZhJTsxlwEij4U/pwAWhcMJ
	WjYEJ5n3YtL2EfJpeE8wYvi/PHhZOEtHPyZHY8vVpjR2BlLmv2MhFoNizmlg2WPY
	Vy0/oe+bFThuigHVphZ3cjJV2Fq9uD6wxy/Zw3R+FFbT0zPjLZlpS0I//mdN6rg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JHaE/r
	SnW34NvAzybiwtrSzf0fUmMVfl1X9cHovUBeKBB8KF/RgynnW1aTmmEkvqvEAIX9
	ADiChVqeOKrkbC64LPnRlE5NZtU4KmG+JAW4/PgNX9je6LbT9ICUXo6yKAWX38WF
	0gRAo7B5/keUOEoVmH1Z5Um36vMdIedrOvkMM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7EC0E33E7;
	Thu, 16 Dec 2010 18:32:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C2F333E2; Thu, 16 Dec 2010
 18:32:07 -0500 (EST)
In-Reply-To: <1292425376-14550-11-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 15 Dec
 2010 22\:02\:45 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B428BBB0-096C-11E0-9661-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163840>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Suppose we have two pathspecs 'a' and 'a/b' (both are dirs) and depth
> limit 1. In current code, pathspecs are checked in input order. When
> 'a/b' is checked against pathspec 'a', it fails depth limit and
> therefore is excluded, although it should match 'a/b' pathspec.
>
> This patch reorders all pathspecs alphabetically, then teaches
> tree_entry_interesting() to check against the deepest pathspec first,
> so depth limit of a shallower pathspec won't affect a deeper one.

I am quite happy to see where this new round of this series is going so
far.  I however doubt this patch is a right approach for the problem yo=
u
are solving, especially because your longer-term (i.e. toward the rest =
of
the series to patch 21) plan is to allow wildcards [*1*].

One thing I am not clear is what it means to limit the recursion level
when you have wildcards.

One possible definition of interaction between limit and wildcard may b=
e
to count the number of slashes in the part of the path that matches the
wildcarded part of the pathspec, add the number of path components
appended due to the leading directory match, and then subtract the numb=
er
of literal slashes in the wildcarded part of the pattern from the above=
,
and declare that a match is found if the difference is less than the
limit.

E.g. a pathspec element "a/*/x" would match "a/b/c/x", "a/b/c/d/e/x",
"a/b/x/y" and "a/b/x/y/z" without limit, and with the limit of 1:

    a/b/c/x        matches ('*' expands to "b/c")
    a/b/c/d/e/x    no ('*' has to expand to "c/d/e" and needs 2 levels)
    a/b/x/y        matches ('*' expands to "b" costing zero, "/y" needs=
 1)
    a/b/x/y/z      does not match

Another definition could be to count _only_ the part that is appended b=
y
recursion (i.e. we do not count how many slashes has to match '*' in th=
e
above examples), and as the option is called --depth, it might make mor=
e
sense.

In either case, I am not sure if "if it matches the longest pathspec, w=
e
have the answer without looking at shorter ones" would be a good rule t=
o
use.


[Footnote]

*1* In addition, perhaps you may later want to introduce some "negative=
"
match operators to pathspecs; while I am not particularly fond of that
direction at this moment, I would like to leave the door open for that
possibility, in case it turns out to be a good thing to have.
