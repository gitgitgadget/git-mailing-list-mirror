From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2012, #01; Tue, 2)
Date: Wed, 03 Oct 2012 11:17:37 -0700
Message-ID: <7vbogj5sji.fsf@alter.siamese.dyndns.org>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
 <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 20:18:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJTW7-0003U1-HF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 20:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab2JCSRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 14:17:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524Ab2JCSRk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 14:17:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7EB78961;
	Wed,  3 Oct 2012 14:17:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ituELCHAb63BY9YCbBwXK5iKjU=; b=xIVIu/
	A5/oh189tCU1W+LWTT1fD0Xca5r7nMXHx72GI2vW76LX245By4gihDK/sHtQI5S0
	9cQMifcGeQ1rF+2sGni9TkyYXTA25NbxK/CREeR631YuTzOF8hqY1ZOI1VZZXcbF
	6Ex3DP7IzCjmL08AePGULvf/3RILopVsb3FA0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWgEhq3wBXUmEB0AyyOs6gsdCK9YZWaW
	vDEU6mPboubqFGgya8k1TMXchTi5JayomaCdh3RXM9q+EqNYUDV+urNJFqxssSY5
	cQiHmFcrZpOHwucsHbLTZGZ20cx2d7+1Vr2krIMJ0yDp+DB4ghZdXb1tPo7/EaT+
	zwdUyOKJqkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A55608960;
	Wed,  3 Oct 2012 14:17:39 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 132D8895F; Wed,  3 Oct 2012
 14:17:38 -0400 (EDT)
In-Reply-To: <CACsJy8BGuoW6K_9vEgGrb2XC2bNtR=0jNRU3JQhsv7_diGQpbA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 3 Oct 2012 22:23:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D54425E-0D86-11E2-96C3-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206918>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> There's an interesting case: "**foo". According to our rules, that
> pattern does not contain slashes therefore is basename match. But some
> might find that confusing because "**" can match slashes,...

By "our rules", if you mean "if a pattern has slash, it is anchored",
that obviously need to be updated with this series, if "**" is meant
to match multiple hierarchies.
> I think the latter makes more sense. When users put "**" they expect
> to match some slashes. But that may call for a refactoring in
> path_matches() in attr.c. Putting strstr(pattern, "**") in that
> matching function may increase overhead unnecessarily.
>
> The third option is just die() and let users decide either "*foo",
> "**/foo" or "/**foo", never "**foo".

For the double-star at the beginning, you should just turn it into "**/"
if it is not followed by a slash internally, I think.

What is the semantics of ** in the first place?  Is it described to
a reasonable level of detail in the documentation updates?  For
example does "**foo" match "afoo", "a/b/foo", "a/bfoo", "a/foo/b",
"a/bfoo/c"?  Does "x**y" match "xy", "xay", "xa/by", "x/a/y"?

I am guessing that the only sensible definition is that "**"
requires anything that comes before it (if exists) is at a proper
hierarchy boundary, and anything matches it is also at a proper
hierarchy boundary, so "x**y" matches "x/a/y" and not "xy", "xay",
nor "xa/by" in the above example.  If "x**y" can match "xy" or "xay"
(or "**foo" can match "afoo"), it would be unreasonable to say it
implies the pattern is anchored at any level, no?
