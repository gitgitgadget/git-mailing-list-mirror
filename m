From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 14/25] setup.c: convert is_git_directory() to use strbuf
Date: Thu, 20 Feb 2014 11:06:46 -0800
Message-ID: <xmqqwqgp61tl.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-15-git-send-email-pclouds@gmail.com>
	<xmqqppmi97s3.fsf@gitster.dls.corp.google.com>
	<CACsJy8Ab0OVQw4ATgv6E7rv-B3OwbhyrJBbXiXjYiUvtMknMrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 20:08:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGYyb-0007ZW-Ge
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 20:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388AbaBTTIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 14:08:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754799AbaBTTH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 14:07:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A9C56C43F;
	Thu, 20 Feb 2014 14:07:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LvvebUIlOM0uwisJdiVHi9FpSgo=; b=Zp7lMo
	WDXkItp7FIO/Wsek79QnPdXZxsVbLfZbvamkgQ0EmxzkqEvbbKRy6TpCf+85iEV7
	8GM7TbpqRBA7KLaK9xRCA8oXKJ3EKi8/Jtax66wj0i43HwthZ156ggvWBEu9Y+KN
	NG5gy/HfPLXm7DJaBqtIqgmrtZJJpjTiz6UyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oDYdgV3Oowbz4ckQeeWGT8JeWeXoytD/
	XlPKQcdnJd1UVwXwpy0W+Gq1yelzASrqMxj5RyfmISLk7g2SOzBxqP7h4XwJtYKJ
	CpZUTQ7AEEAcN3BrES99e3r1i2BJqrZYf1P7idUmEiP8UsTeDtA+Wl/SUk8XOHOf
	xrIooTjZPHY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 673A56C43D;
	Thu, 20 Feb 2014 14:07:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 58CFB6C3A3;
	Thu, 20 Feb 2014 14:06:50 -0500 (EST)
In-Reply-To: <CACsJy8Ab0OVQw4ATgv6E7rv-B3OwbhyrJBbXiXjYiUvtMknMrg@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 20 Feb 2014 20:04:31 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 270AE3CC-9A62-11E3-ADE7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242441>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Feb 20, 2014 at 3:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> +     strbuf_setlen(sb, len);
>>> +     strbuf_add(sb, s, strlen(s));
>>
>> I am not sure addstr_at() gives us a good abstraction, or at least
>> the name conveys what it does well not to confuse readers.
>>
>> At first after only seeing its name, I would have expected that it
>> would splice the given string into an existing strbuf at the
>> location, not chopping the existing strbuf at the location and
>> appending.
>
> I think I invented a few new strbuf_* in this series and this is one
> of them. We have about ~14 other places in current code that do
> similar pattern: set length back, then add something on top.

Yes, and you can count getline/getwholeline as a special case to
chomp to empty at the beginning.  I am not opposed to a helper to
give us an easy access to this common pattern.

It was just the name "addstr-at" did not sound, at least to me, what
it does, i.e. "replace with s from the pos to the end", which I
think is the same thing as a single-liner:

    strbuf_splice(sb, pos, sb->len - pos, s, strlen(s))
