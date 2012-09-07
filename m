From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Prevent git-config from storing section keys that are
 too long
Date: Thu, 06 Sep 2012 18:33:20 -0700
Message-ID: <7vpq5yzkf3.fsf@alter.siamese.dyndns.org>
References: <1346978829-4486-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Sep 07 03:34:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9nSM-0004bx-CM
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 03:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab2IGBd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 21:33:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab2IGBdX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2012 21:33:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B03909EF6;
	Thu,  6 Sep 2012 21:33:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JTp5DHhToDKHIRP/62Adca0ooLk=; b=PHBPdz
	WiCZyIiBrSQvNN7dTw55wWLOAiSNzJqNwFyRSZtI2EA9TCaEgv1QbwF0Udo6n+bh
	ZcFhKnwB/Nq4bEzTlPcZpbFrjPBA9o1IqKRR+hWk61rv1gDRAvFupE6DCmJp1zxt
	rptAigYQ6LCb4qBVlQxmAHu1fqcK7mb+1VwcU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J2WMwlpfiezULzoDKLxL5O86mwNeAgQT
	MHaAY0XO2Hqi8KOBFSShZqTatO1cihXvlL7dIAQr0e+saTqwPewjv5GFRVUw0FX+
	b56n2E5CAFpxFQDmMMKG3fC5cem0os4cDE3wmk5aGXuAJuZhj/25+8MhPh/jx4MF
	M1YVcsRrtro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E4589EF5;
	Thu,  6 Sep 2012 21:33:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 04AF49EF3; Thu,  6 Sep 2012
 21:33:21 -0400 (EDT)
In-Reply-To: <1346978829-4486-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Thu, 6 Sep 2012 20:47:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 029531F6-F88C-11E1-B16F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204943>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> Key names have a length limit defined by MAXNAME in config.c.  When
> reading the config file, we reserve half of this limit for the section
> identifier and the other half for the key name within that section.
>
> For example, if setting a key named url.foo.insteadOf, url.foo may use
> at most half of MANXNAME.
>
> The parser will throw an error if this condition is violated.
>
> This patch ensures that git-config enforces the same restriction
> during the creation of a section identifier so that it doesn't allow
> the generate a configuration file that cannot be re-read later.
>
> This patch also adds a test to t1303-wacky-config to catch any future
> issues with this check.
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
> ---
>
> Hi All,
>
> I happened to notice this while running the test suite in a deeply
> nested directory...
>
> The check for baselen exceeding half of MAXNAME could be done earlier
> in the function but doing it late allowed the error message to be
> clearer without extra hassle.
>
> I also wonder if MAXNAME should be increased somewhat.  Section
> identifiers generated from keys like:
>
> url./some/really/long/path.insteadOf
>
> could overrun the current limit.  It's not a common case, of course,
> or this issue would have been found sooner.  Would doubling the
> current limit be out of the question?

Is there a reason to have _any_ limitation?  It is not like we store
configuration data by allocating one file per item (in which case we
may be limited by the filesystem limit for direntry size), so if it
is not too much trouble, I think the right thing to do is to lift
the limitation altogether, possibly using strbuf instead of a
statically sized array of characters.

Of course, once you write a very long entry using a newer version of
Git, the resulting configuration file may end up unusable by older
version of Git, so a patch to implement such a change may need to be
based on older maintenance release (say maint-1.7.9) and then merged
upwards, but otherwise I do not offhand see a compatibility downside
of such a change.
