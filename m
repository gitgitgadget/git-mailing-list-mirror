From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] check_refname_component: Optimize
Date: Thu, 29 May 2014 09:36:33 -0700
Message-ID: <xmqqfvjsbkz2.fsf@gitster.dls.corp.google.com>
References: <1401311055-480-1-git-send-email-dturner@twitter.com>
	<1401311055-480-2-git-send-email-dturner@twitter.com>
	<538658C0.8050001@alum.mit.edu> <1401320968.18134.98.camel@stross>
	<CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 18:36:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq3Jw-0006qN-BR
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 18:36:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989AbaE2Qgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 12:36:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56646 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757532AbaE2Qgj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 12:36:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 57A931A5CB;
	Thu, 29 May 2014 12:36:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5bi2K8Kc4Y5dFNhJ9zmCdeSO3Yg=; b=tOquH4
	1vSpUmElSZ+O8wT3mIyJV3pMD0H/7zE0TqAQTCGwDCNw8jx2JiHbNp0q3IyV0W06
	tEy4SmGThCkzBLQqs9BDPRTTZJr2+5oqKi0+tGnVjoxA/yGmm3KupsLt4ciC0g9i
	XKEScIITI68jcDgSXg+2u4zc6ifR2/G3dEPms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jnAumO+bArl7OKIjGkxEQmxPR5uyn3g0
	wLh8WW9pHAg3SGl3hha1l1AKn+xjwjiMNx7d8OZMYfOLEEdSjQ5UKAl/3av29i7C
	MrHOC0Gg3zGl+xoZRDk84tU49X8DBpAEdHNYMgRx3iHm5WlFg6wgtH0jzgPlGew0
	RiTP1jvSWCA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4D66B1A5CA;
	Thu, 29 May 2014 12:36:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C54FA1A5C6;
	Thu, 29 May 2014 12:36:34 -0400 (EDT)
In-Reply-To: <CACsJy8BcBmuC3KMu+5dhGiOXX=u7WtHWQzQuT=ZPTbSCduJdbw@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 29 May 2014 20:41:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65D5F7B0-E74F-11E3-92F4-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250393>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, May 29, 2014 at 6:49 AM, David Turner <dturner@twopensource.com> wrote:
>>> I assume that most of the time spent in check_refname_component() is
>>> while reading the packed-refs file, right?
>>
>> Yes.
>
> I wonder if we can get away without SSE code by saving stat info of
> the packed-refs version that we have verified. When we read pack-refs,
> if stat info matches, skip check_refname_component(). Assuming that
> pack-refs does not change often, of course.

Can you elaborate a bit more?

Regardless, I think I would prefer to see this patch done as at
least a two step series, one that does only the look-up table thing,
and then the other with arch-specific tweaks as a follow-up on top.
