From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 14/25] setup.c: convert is_git_directory() to use strbuf
Date: Thu, 20 Feb 2014 11:36:57 -0800
Message-ID: <xmqqob2160fa.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-15-git-send-email-pclouds@gmail.com>
	<xmqqppmi97s3.fsf@gitster.dls.corp.google.com>
	<CACsJy8Ab0OVQw4ATgv6E7rv-B3OwbhyrJBbXiXjYiUvtMknMrg@mail.gmail.com>
	<xmqqwqgp61tl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 20:37:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGZQp-0003hA-RO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 20:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbaBTThJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 14:37:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbaBTThH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 14:37:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD96D6E319;
	Thu, 20 Feb 2014 14:37:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zqVTqXzaJGapYtjfAlG91PwEPmI=; b=H61Cht
	dXdBg5U3+bwO+cydDriX4VpeO/Dohxv6/+b7rjnD8q3EL8appBIGEdT2ETKDT6lB
	JkekhUXr0TVs/FIdn/J6+DjewNi6lWwLPQm+Ug749PsCWVYAdTh/bNkrVPW2WaNe
	30tlp/8wfDSeKcMpgb/Yw5ByCR2zu/CCyWmTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TeazgGZE/3RU0fccghDYbur/dF2XZtuE
	dfZ3TzdThIbnPCmX5Jekz+ojwm3w5raCkk3NNW5U0TEoaXl+bepSlYZ7G2jibKGX
	61GSQ2LFRANRaBYVCxntRLiPEdKMJorVNacPaFDty2i5mRkvulp51aTnINbm0vON
	UfkYUbogfts=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7F936E300;
	Thu, 20 Feb 2014 14:37:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4565D6E2F8;
	Thu, 20 Feb 2014 14:37:01 -0500 (EST)
In-Reply-To: <xmqqwqgp61tl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 20 Feb 2014 11:06:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5E6F4F20-9A66-11E3-9CE4-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242443>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Feb 20, 2014 at 3:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> +     strbuf_setlen(sb, len);
>>>> +     strbuf_add(sb, s, strlen(s));
>>>
>>> I am not sure addstr_at() gives us a good abstraction, or at least
>>> the name conveys what it does well not to confuse readers.
>>>
>>> At first after only seeing its name, I would have expected that it
>>> would splice the given string into an existing strbuf at the
>>> location, not chopping the existing strbuf at the location and
>>> appending.
>>
>> I think I invented a few new strbuf_* in this series and this is one
>> of them. We have about ~14 other places in current code that do
>> similar pattern: set length back, then add something on top.
>
> Yes, and you can count getline/getwholeline as a special case to
> chomp to empty at the beginning.  I am not opposed to a helper to
> give us an easy access to this common pattern.
>
> It was just the name "addstr-at" did not sound, at least to me, what
> it does, i.e. "replace with s from the pos to the end", which I
> think is the same thing as a single-liner:
>
>     strbuf_splice(sb, pos, sb->len - pos, s, strlen(s))

Oh, and as to other strbuf_* helpers, I am finding myself getting
very fond of strbuf_git_path() as I read the series along; it gives
us the same convenience as git_path() [*1*] while giving us tighter
control on the lifetime rules of the path buffer.

[Footnote]

*1* And the new git_path() updated in this series has to be a lot
 more than catenate($GIT_DIR, "/", $path) but needs the smart of
 adjust_git_path(), the convenience matters.
