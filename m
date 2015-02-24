From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] diffcore-rename with duplicate tree entries can segfault
Date: Tue, 24 Feb 2015 15:11:00 -0800
Message-ID: <xmqqd24yq517.fsf@gitster.dls.corp.google.com>
References: <20150224214311.GA8622@peff.net>
	<xmqqh9uborrx.fsf@gitster.dls.corp.google.com>
	<20150224224918.GA24749@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 00:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQOdC-0007Ds-9H
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 00:11:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbbBXXLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 18:11:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752284AbbBXXLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 18:11:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 45D403B869;
	Tue, 24 Feb 2015 18:11:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iZR42hgNZa7BizagBRZB+l6Qtu0=; b=Dcj9nl
	A3kPrLWI5URk1ovefq/ci/klc64kth0G5Yzs2s2mzTExOy7Rggu4CXfkb8oMj/Gx
	zrmHOZXW+GYZZ6FFZs//aBcgTbEPfGOpW+JwtIQmpNBz0AutKhv9wEJlcfa/SQSf
	LVaGh2+ci/7Nw8PR1vyBS3iuprLiLouK9XWHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sU7KdnPpa8kyyoD6hnMgNtdqad7+tA1t
	+mMsQ3hiupyg8UavNOY5PimJoX7yx9toJaxLFwB1+swIKObqDRvGA3wc2NrZg1Hh
	vgc/f6NVVXo6wHqkfY45HlJegrhVzSPo9YmbUXcBbaOvTZlljKR26X5m5HT80i/c
	0Hvt2KmvRXg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AF793B868;
	Tue, 24 Feb 2015 18:11:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A7213B867;
	Tue, 24 Feb 2015 18:11:01 -0500 (EST)
In-Reply-To: <20150224224918.GA24749@peff.net> (Jeff King's message of "Tue,
	24 Feb 2015 17:49:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 664462D0-BC7A-11E4-BDD2-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264359>

Jeff King <peff@peff.net> writes:

> I'm assuming there _is_ a sane sort order. We have two halves of a
> filepair, but I think before any of the rename or break detection kicks
> in, each pair should either:
>
>   1. Have a name in pair->one, and an invalid filespec in pair->two
>      (i.e., a deletion).
>
>   2. The opposite (name in pair->two, /dev/null in pair->one). An
>      addition.
>
>   3. The same name in pair->one and pair->two.

I think creation and deletion are expressed with mode=0 and not with
/dev/null.
