From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/PATCH] setup: Copy an environment variable to avoid
 overwrites
Date: Fri, 04 Jan 2013 22:47:42 -0800
Message-ID: <7va9soqg6p.fsf@alter.siamese.dyndns.org>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
 <CACsJy8BeuV8esGTWsQiT_G9pZE28s5KJxH6+dzdhioLgmSiNVg@mail.gmail.com>
 <7vk3rsqm6u.fsf@alter.siamese.dyndns.org>
 <CACsJy8CZe=qyzmG_1vdLYp07OvkDAU4wYc8MN3et7WBVmMhJOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael <fedora.dm0@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:48:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNY5-00061V-Kv
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092Ab3AEGrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:47:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751021Ab3AEGrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:47:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCC188AFB;
	Sat,  5 Jan 2013 01:47:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uFkhGeoIBo4riycPOIUYx3pldI0=; b=bhYLKi
	R8zUEfToycs0Vqw27A2BOqLQyt1yMylxGHU7sj50cqj3SFPH2WLvq89aR0/QKwXl
	ci8kCfu/Yi3kkQEFuenjOheyz26Fum2bDZF2sCQqXcRL1HDFflChSQvn5Rchmn+f
	gJ13UtyU9l0AaYigcbP1f5abdp61lRJKhaq64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F+9ohmgAgVXwyT945eqenmvELQULnUAc
	1N3lXvDnBAN2wZ9UP75a7EDqCceyrh3j7ejWgnNiaKe3jOUQ449WXq6W03zmVSQG
	adGlexxKdBq6gOB3HRz/InMbCum15f+2kBsgVi5M/F0Ua53HuPueZdB5j8rjGFZ4
	7F9Hx6j8nuk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE4B08AFA;
	Sat,  5 Jan 2013 01:47:44 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 272408AF8; Sat,  5 Jan 2013
 01:47:44 -0500 (EST)
In-Reply-To: <CACsJy8CZe=qyzmG_1vdLYp07OvkDAU4wYc8MN3et7WBVmMhJOQ@mail.gmail.com> (Duy
 Nguyen's message of "Sat, 5 Jan 2013 13:24:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEDD9124-5703-11E2-B691-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212666>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Jan 5, 2013 at 11:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> I personally do not think a wrapper with limited slots is a healthy
>> direction to go.  Most places we use getenv() do not let the return
>> value live across their scope, and those that do should explicitly
>> copy the value away.  It's between validating that there is _no_ *env()
>> calls in the codepath between a getenv() call and the use of its
>> return value, and validating that there is at most 4 such calls there.
>> The former is much easier to verify and maintain, I think.
>
> I did not look carefully and was scared of 143 getenv calls. But with
> about 4 calls, yes it's best to do without the wrapper.

Just to make sure you did not misunderstand, the 4 (four) in my
message is not about "4 calls among 143 are unsafe".

It was referring to the number of rotating slots your patch defined,
which means

	val = getenv("FOO");
        ... random other code ...
        use(val)

is safe only if random other code makes less than 4 getenv() calls.

I didn't verify all of the call sites. It needs to be done with or
without your wrapper patch. Without your wrapper, the validation
needs to make sure "random other code" above does not make any getenv()
call.  With your wrapper, the validation needs to make sure "random
other code" above does not make more than 4 such calls.  My point
was that the effort needed for both are about the same, so your
wrapper does not buy us much.
