From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: don't resolve refs when core.warnambiguousrefs is false
Date: Tue, 07 Jan 2014 11:38:15 -0800
Message-ID: <xmqqppo3d1lk.fsf@gitster.dls.corp.google.com>
References: <1389065521-46331-1-git-send-email-brodie@sf.io>
	<CAEfQM484kqLSVeyjhYtg7GfXOQkQNjaO1FV2_U3uAqO=Nargdg@mail.gmail.com>
	<20140107171307.GA19482@sigill.intra.peff.net>
	<xmqqzjn7el4k.fsf@gitster.dls.corp.google.com>
	<20140107175241.GA20415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brodie Rao <brodie@sf.io>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 20:38:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0cTw-000875-JX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 20:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbaAGTi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 14:38:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248AbaAGTi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 14:38:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACFCC5F191;
	Tue,  7 Jan 2014 14:38:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iA9gZSD9uXTi9pZUhggfjPh4he8=; b=O59mQF
	R6HoaDoE2g3BI2BnPY7DXAxS9Sz1hb5Lbu/oePeR7ExOolFYYbqxu0Kon/gBs52t
	aIMkTVw1SZts2uf5sS6/9HGq0anrd6n9emt4E3RZINBPRa81+ZYoRlyVUnUBsOIZ
	YCjTyJrhMyPO/ooYkxrrm9RWBo70vatxlpfiM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gOu++vgo/mBXffDK8OZyv+kRaq894tO/
	RNgyLk6J1h0QEiiMW2xWQQ8NjbuVS2AVv1web3qHHMHtViFMpkGVi99euLzXrxv5
	oL21SwqmqHJGgT52IIglVyI9F+mHU6Hkdpv49RUmrlpod509UrA/xZ0KdYV10AYX
	iXLWZmLvW8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D55C5F18C;
	Tue,  7 Jan 2014 14:38:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DCBE25F182;
	Tue,  7 Jan 2014 14:38:19 -0500 (EST)
In-Reply-To: <20140107175241.GA20415@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 12:52:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 431EEDC6-77D3-11E3-8616-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240135>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 07, 2014 at 09:51:07AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > Alternatively, I guess "cat-file
>> > --batch" could just turn off warn_ambiguous_refs itself.
>> 
>> Sounds like a sensible way to go, perhaps on top of this change?
>
> The downside is that we would not warn about ambiguous refs anymore,
> even if the user was expecting it to. I don't know if that matters much.

That is true already with or without Brodie's change, isn't it?
With warn_on_object_refname_ambiguity, "cat-file --batch" makes us
ignore core.warnambigousrefs setting.  If we redo 25fba78d
(cat-file: disable object/refname ambiguity check for batch mode,
2013-07-12) to unconditionally disable warn_ambiguous_refs in
"cat-file --batch" and get rid of warn_on_object_refname_ambiguity,
the end result would be the same, no?

> I kind of feel in the --batch situation that it is somewhat useless (I
> wonder if "rev-list --stdin" should turn it off, too).

I think doing the same as "cat-file --batch" in "rev-list --stdin"
makes sense.  Both interfaces are designed to grok extended SHA-1s,
and full 40-hex object names could be ambiguous and we are missing
the warning for them.

Or are you wondering if we should revert 25fba78d, apply Brodie's
change to skip the ref resolution whose result is never used, and
tell people who want to use "cat-file --batch" (or "rev-list
--stdin") to disable the ambiguity warning themselves?
