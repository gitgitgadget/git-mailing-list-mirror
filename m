From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/10] setup_git_env: use git_pathdup instead of xmalloc + sprintf
Date: Wed, 25 Jun 2014 12:54:38 -0700
Message-ID: <xmqqtx789341.fsf@gitster.dls.corp.google.com>
References: <20140619211659.GA32412@sigill.intra.peff.net>
	<20140619212800.GF28474@sigill.intra.peff.net>
	<CACsJy8B-zQUH++U_RKq16_M+6FF5bmHXA100xM3uO42TUj3kJg@mail.gmail.com>
	<20140624205815.GA28724@sigill.intra.peff.net>
	<xmqqmwd0aotu.fsf@gitster.dls.corp.google.com>
	<20140625172237.GA15294@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 25 21:54:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WztHP-0002wm-D2
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 21:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743AbaFYTyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 15:54:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52472 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754550AbaFYTyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 15:54:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DD97422559;
	Wed, 25 Jun 2014 15:54:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fo5gM+kIo4cIuWsgbdgXyBZge8Y=; b=IYEbg8
	yn9toPhP8QKbRA+VkKhh7BxBd6RiepWd+U+GSk8dVTfPe298b08sK1Q0KK1jiv07
	X8Sw+LAle2gmJ0Zpb1WWRjuc9HgX57XbExxmvye8mPXE3QeG0QVeyy+/lwm1gCGr
	EVuT3vmMTNe759MAc+CyEtTSbxYdZose2caMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKkaNWvAQB+f0bBR6AlyqDoO2y5x2yrN
	GRlHhMk1+bo8F16K/Idc9nmK6WoC04gvilvmkCGMRhw8CBEscBBapx8eYr8RbiF3
	of7HbJZdEUnhl+fFLPVVsLk485qCwYlqt2NOA7rAKlUMs2Ft1KG240RmuS6pAb45
	tE5s0tLm/WI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEF1C22558;
	Wed, 25 Jun 2014 15:54:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BEDB022554;
	Wed, 25 Jun 2014 15:54:33 -0400 (EDT)
In-Reply-To: <20140625172237.GA15294@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 25 Jun 2014 13:22:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87689E4C-FCA2-11E3-9780-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252455>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 25, 2014 at 10:20:13AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Here's a replacement patch that handles this (and just drops the ugly
>> > mallocs as a side effect).
>> >
>> > -- >8 --
>> > Subject: [PATCH] setup_git_env: copy getenv return value
>> >
>> > The return value of getenv is not guaranteed to survive
>> > across further invocations of setenv or even getenv. When we
>> > are assigning it to globals that last the lifetime of the
>> > program, we should make our own copy.
>> >
>> > Signed-off-by: Jeff King <peff@peff.net>
>> > ---
>> 
>> Sigh. This mail unfortunately crossed with 64f25581 (Merge branch 'jk/xstrfmt'
>> into next, 2014-06-23) with about 20 hours of lag.
>
> Ah, sorry. I had checked yesterday that jk/xstrfmt hadn't been merged
> yet, but I didn't check when responding to Duy.

Sorry to have sighed --- crossing e-mails happen all the time.  No
need to feel sorry.

>> I'd make it relative like the attached on top of the series.  Note
>> that I tweaked the args to git_pathdup() to avoid the "are you sure
>> you want to give a variable format string to git_pathdup() which you
>> said is like printf(3)?" warning from the compiler.
>
> Both changes look good to me. Thanks for taking care of it.

Thanks.
