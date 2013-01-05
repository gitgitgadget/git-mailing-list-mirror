From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid
 overwrites
Date: Fri, 04 Jan 2013 20:38:01 -0800
Message-ID: <7vk3rsqm6u.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
 <CACsJy8BeuV8esGTWsQiT_G9pZE28s5KJxH6+dzdhioLgmSiNVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael <fedora.dm0@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 05:38:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrLWa-0004OG-Vp
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 05:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab3AEEiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 23:38:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066Ab3AEEiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 23:38:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72E4AA5E4;
	Fri,  4 Jan 2013 23:38:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F0PbwNipcTVYCn2ApjKd9DjFF78=; b=r3h3PR
	88ZGuKZoJmjA4roMvWJyVB1MR/6uurFyHPOoIdtsC8dxb7b3oIoBuC0emnHOMsMr
	pWQ0xHx29KyuTGSWrwQXGR7Z+6RQAIBXtwE+Fv2GfMQLU561b6/wK0zUf5pwMiUY
	G3xZSbuvb6cAsc/jRpSTLdUL3qfQBlgY75IYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=daAzZkqnQS6Ic0DCUMLFm+e0NEyk3KSq
	+r8bD1Rpcy1ReUdg0VPaBtnOg7vsAHEWTxFnlWiZ11AYLWZ01MsGkC+urkipjfxv
	7SH8N9exp9K7SdClsPADGbcQyFg8T7RIr6MmULyvKdFMysA0YdNO/5wJb3UIxZUQ
	tc4ZN7xJHMo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61EC8A5E3;
	Fri,  4 Jan 2013 23:38:03 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2BF2A5E1; Fri,  4 Jan 2013
 23:38:02 -0500 (EST)
In-Reply-To: <CACsJy8BeuV8esGTWsQiT_G9pZE28s5KJxH6+dzdhioLgmSiNVg@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 5 Jan 2013 09:45:40 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0D9EA40-56F1-11E2-B604-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212662>

Duy Nguyen <pclouds@gmail.com> writes:

> Maybe we could all this into a wrapper? If getenv() here has a
> problem, many other places may have the same problem too. This
> simplifies the change. But one has to check that getenv() must not be
> used in threaded code.

That needs to be done regardless, if we care; POSIX explicitly says
getenv() need not be thread-safe.

I personally do not think a wrapper with limited slots is a healthy
direction to go.  Most places we use getenv() do not let the return
value live across their scope, and those that do should explicitly
copy the value away.  It's between validating that there is _no_ *env()
calls in the codepath between a getenv() call and the use of its
return value, and validating that there is at most 4 such calls there.
The former is much easier to verify and maintain, I think.
