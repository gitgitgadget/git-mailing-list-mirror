From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: save heap memory. allocate only the required amount
Date: Mon, 25 Aug 2014 14:36:02 -0700
Message-ID: <xmqq8umcl0al.fsf@gitster.dls.corp.google.com>
References: <1408889844-5407-1-git-send-email-arjun024@gmail.com>
	<53FA0054.5060808@gmail.com>
	<CAPc5daWheSH8E-PycSUq2Coqp19t_+_6TuBEOKhK4QwsEtzkkA@mail.gmail.com>
	<20140825130732.GD17288@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@gmail.com>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 23:36:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM1w4-0006Js-Uf
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933578AbaHYVgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 17:36:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60796 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933551AbaHYVgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 17:36:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C3B343529A;
	Mon, 25 Aug 2014 17:36:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n8zwMqjVaYdSZ0IvDdHoK1fSCUg=; b=oJexck
	Znui7d1GkDekXPlbJjgfASctA76l/NX3MgUdbM0yN/20DFZtVtrzzXr5sv6vC3CZ
	9GLjyGa4eI20qjg7N2EZrtKfol0MFD8uLGkcT5pp2c7G6JupUDD6KKXgc32v+oiT
	v4kfGkNDX5HAiHGctjKFHsR5/IqKHC4ZZSErg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VzYLEe/oJzsGivEr9DIwyk7LNfKcrizD
	rBWPF9vYE4cv05wC70zKmhp/yldMyQ9Ik7aCkvFs8E307ZR+F4qs4zeS4L6JGgzV
	ssxTy7tvYtkjyxFjojnFHCil2H3YRwVNtNjjQzIPB9TaiAYaoR954AySX1Wm5zb9
	2z2X78hNPZE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B905735299;
	Mon, 25 Aug 2014 17:36:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D6B635287;
	Mon, 25 Aug 2014 17:36:03 -0400 (EDT)
In-Reply-To: <20140825130732.GD17288@peff.net> (Jeff King's message of "Mon,
	25 Aug 2014 09:07:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D073396C-2C9F-11E4-B56F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255872>

Jeff King <peff@peff.net> writes:

>> The string will always be "dist=" followed by decimal representation of
>> a count that fits in "int" anyway, so I actually think use of strbuf is way
>> overkill (and formatting it twice also is); the patch as posted should be
>> just fine.
>
> I think you are right, and the patch is the right direction (assuming we
> want to do this; I question whether there are enough elements in the
> list for us to care about the size, and if there are, we are probably
> better off storing the int and formatting the strings on the fly).

;-)

> It would be nice if there was some way to abstract the idea of
> formatting a buffer directly into a flex-array. That would involve the
> double-format you mention, but we could use it in lots of places to make
> the code nicer....
> ...
>   struct name_decoration *r = fmt_flex_array(sizeof(*r),
>                                              offsetof(*r, name),
> 					     "dist=%d", x);
>
> which is a little less nice. You could make it nicer with a macro, but
> we don't assume variadic macros. <sigh>

At first I thought "Yuck.  A helper only to format into the flex
member that holds a string?", and I tried to change my mind, but I
couldn't quite convince myself.  At least not yet.

Among the flex arrays we use, some are arrays of bools, some others
are arrays of object names, and there are many arrays of even more
esoteric types.  Only a small number of them are "We want a struct
with a constant string, and we do not want to do two allocations and
to pay an extra dereference cost by using 'const char *'".

For them, by the time we allocate a struct, by definition we should
have sufficient information to compute how large to make that
structure and a printf-format plus its args would be the preferred
form of that "sufficient information", I would think.

The name "fmt_flex_array()", which stresses too much on the
"formatting" side without implying that it is the way to allocate
the thing, may be horrible, and I agree with you that without
variadic macros the end result may not read very well.  Unless we
have great many number of places we can use the helper to make the
code to create these objects look nicer, I am afraid that the
pros-and-cons may not be very favourable.

Thanks for an interesting tangent.
