From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] pathspec: allow escaped query values
Date: Thu, 02 Jun 2016 16:01:33 -0700
Message-ID: <xmqq60trry9e.fsf@gitster.mtv.corp.google.com>
References: <20160602213015.21712-1-sbeller@google.com>
	<xmqqr3cfs1dp.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYL_47ptjK1S++Z=JUBOQtG1MJS=h0i=9f3fzRmbZDf-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 01:01:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bcS-0006u6-UL
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbcFBXBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:01:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64589 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932166AbcFBXBg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:01:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47BA020690;
	Thu,  2 Jun 2016 19:01:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m8s260ltjodFoYRICfzEpPKuNzU=; b=ZFG6rK
	05/AOw0WOpl41rdCYXFPpQ91GtnuKcYaIM7JwYfLwT6qmXA2W7B1MbpAXV/e2P/S
	w0r7tCfF8DLm9wvWw8K0DRhEklZn1hAN3xfcEZBt/EpiXLvMbMzH3l2HPOufJVkr
	O2izyj8W/C9aP5c71Rinh8Dltwh1VIZkmLgVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eE8azX6hxTQ0MXG8JFoDSUsTWId5cY3X
	Hz/R5DGcAHH3wM+G7YC7uGPq5ZdTHA+dVwCunjCxai9fxmxjQMzj2m7JE3FkKvEn
	T7Iaxrz69T6IVfZ8R7Rz84hbkFgOhrW715XoGNbLueXO7gFaNqO3vuPUi58K7yrE
	fA/epDHyLKY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 40D212068F;
	Thu,  2 Jun 2016 19:01:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C385A2068B;
	Thu,  2 Jun 2016 19:01:34 -0400 (EDT)
In-Reply-To: <CAGZ79kYL_47ptjK1S++Z=JUBOQtG1MJS=h0i=9f3fzRmbZDf-g@mail.gmail.com>
	(Stefan Beller's message of "Thu, 2 Jun 2016 15:53:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F41F5EA8-2915-11E6-ABDD-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296253>

Stefan Beller <sbeller@google.com> writes:

> Thinking about efficiency, I have the believe that memmove can be faster
> than a `*src=*dst` thing we do ourselves as it may have access to specialized
> assembly instructions to move larger chunks of memory or such.

> So I think ideally we would do a block copy between the escape characters
> (sketched as:)
>
>     last = input
>     while input not ended:
>         current = find next escape character in input
>         memcpy from input value in the range of last to current
>         last = current + 1
>     copy remaining parts if no further escape is found

That would be true _only_ when "find next escape and copy up to that
byte" aka "scanning once with optimized strchr(), and copying once
with optimized memmove()" is faster than "scanning once and copying"
loop.

I was merely reacting to your use of memmove() in a very different
loop, where if you unescape "a\b\c\defghijk", your memmove() would
move "efghijk" many times.

>>         ret = xmalloc(strlen(value));
>
> xmallocz at least?

Yes.  Also the handling of the terminating NUL may need to be
updated.  That is why I did not say "replace yours with this", but
merely "along the lines of this" ;-)
