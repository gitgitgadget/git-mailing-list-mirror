From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] clean: improve performance when removing lots of directories
Date: Fri, 17 Apr 2015 12:13:20 -0700
Message-ID: <xmqqpp72pnzj.fsf@gitster.dls.corp.google.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
	<1428770587-9674-5-git-send-email-erik.elfstrom@gmail.com>
	<xmqqpp75l1gd.fsf@gitster.dls.corp.google.com>
	<CAMpP7NbQ7pmcjT4pDn5dA5yvfgMgirbkoMD6ijjiFp7zmARPbA@mail.gmail.com>
	<20150417190002.GB32578@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: erik =?utf-8?Q?elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:26:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjBuW-0002Yn-MK
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 21:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbbDQT0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 15:26:40 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55243 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754204AbbDQT0j (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 15:26:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A6B547B55;
	Fri, 17 Apr 2015 15:26:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9yiYvmZZc1ZYP2KmPeLsTlS+pkI=; b=fgrYTs
	hYEmXirQsp/XN4ZNQ1vaWDvhORtzvLDxWw4C88rjNmrkpCEavcvLa9iNZi1Hj8dH
	6Q3Xw+JY3548+GtA+EFly3/hxg1Xf3vsNomlb2IGXj6rLCDFdKFrl3Q7HMpukS00
	ONBvuBVNwrII2ODZ9ApkmP0rMC+ffSQoPnafM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FrFiqAaJBoYaB9Y4aLS9750C+/yNgd7o
	Rwe23wrGbQcHDYnSGhdmglLYcQetoaIipXZw5jaLQ7qqN6z6j7GJvkbvScwJniYo
	pZegly+2y6iYWsjnCi2+romvlXyXWKIIhIesZxd1gA4LFviaqzk5OyRkgL9Imw/t
	F9rSKuyNm40=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 920D447B53;
	Fri, 17 Apr 2015 15:26:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E636147405;
	Fri, 17 Apr 2015 15:13:21 -0400 (EDT)
In-Reply-To: <20150417190002.GB32578@peff.net> (Jeff King's message of "Fri,
	17 Apr 2015 15:00:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D05AC5B8-E535-11E4-BFBF-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267380>

Jeff King <peff@peff.net> writes:

>> Option 1:
>>  Plug the hole in my new is_git_repository function. A quick and dirty
>>  fix that passes the above test would be:
>
> I think that makes sense. It would be nice if you could just call
> read_gitfile, but that function is very anxious to die on error. So the
> prerequisite step would probably be to refactor that into a
> read_gitfile_gently that returns an error code.

I agree.

I was looking at the repository discovery loop to see if it makes
sense to update is-git-directory() to take a gitfile, but I do not
think it is a good idea (typically after is-git-directory() says
"yes", we would append paths e.g. "refs/heads/master" after it to
pass the result to system calls like open()).  I agree that adding
read-gitfile-gently and call it before running is-git-directory
would be a good solution for this change.

> PS Thank you for working on this.

That too.

Thanks.
