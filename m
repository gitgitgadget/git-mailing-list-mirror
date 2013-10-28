From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/19] pack-bitmap: add support for bitmap indexes
Date: Mon, 28 Oct 2013 08:22:07 -0700
Message-ID: <xmqqiowhh140.fsf@gitster.dls.corp.google.com>
References: <20131025055521.GD11810@sigill.intra.peff.net>
	<20131025060345.GH23098@sigill.intra.peff.net>
	<xmqqk3h1hrx0.fsf@gitster.dls.corp.google.com>
	<20131026002629.GA18324@sigill.intra.peff.net>
	<20131026062507.GA23963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 28 16:22:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vaoe0-0003vn-A0
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 16:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756950Ab3J1PWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 11:22:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62867 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab3J1PWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 11:22:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B12A44E08F;
	Mon, 28 Oct 2013 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=60japk2dKhA7C6nl+iaTzNWv3Ys=; b=M0jmP/
	5aa70uxD1OJLJXFpwKdjFnEuJFAm71eDX70gkD18XfUUuopVcePWt1/C4cD9mtAk
	7kJ8sjlhetxxcHMqVBhVW1ZXwdR1aP6KqC/dDvoxc7yx5cVOXAlrV5C1jxk11Zb/
	V/SjqdyB+QNpo+KDtFhH3ClNK0QMZkg+yrfmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lMqsqllsRfMPxWUOF4Lz/fXej8a4vKHC
	CRKF8eYRQor3jRib7IIoy+9xOiqq7GYtSkt+MKdRJSAn3kr0Hn08mG1wTxh/jJ46
	dswFSDOXoCFwyn2KajTJzG/YXohdbzAzluMy9akPfvqG0ouuBaqXFby7Wq9/yPMg
	eyfXGu3cXzY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2CB44E08E;
	Mon, 28 Oct 2013 15:22:09 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 053124E08D;
	Mon, 28 Oct 2013 15:22:08 +0000 (UTC)
In-Reply-To: <20131026062507.GA23963@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 26 Oct 2013 02:25:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B607ECE2-3FE4-11E3-8CB9-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236833>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 25, 2013 at 08:26:29PM -0400, Jeff King wrote:
>
>> On Fri, Oct 25, 2013 at 04:06:19PM -0700, Junio C Hamano wrote:
>> 
>> > Jeff King <peff@peff.net> writes:
>> > 
>> > > diff --git a/pack-bitmap.c b/pack-bitmap.c
>> > > new file mode 100644
>> > > index 0000000..73c52fd
>> > > --- /dev/null
>> > > +++ b/pack-bitmap.c
>> > > @@ -0,0 +1,965 @@
>> > > +#include <stdlib.h>
>> > > +
>> > > +#include "cache.h"
>> > 
>> > You among all people already know why this is bad, no?
>> 
>> Yes, I am well aware of why we do not want it. I thought I removed that,
>> but it appears I missed one. Sorry.
>
> In addition to that one, there are a few other system header includes:
>
>   - the ewah/*.c files include the necessary standard headers, and do
>     not include git-compat-util.h at all. I do not really consider these
>     "git code", but rather a black box we have imported into the tree
>     to ease the dependency chain. So in that sense, they operate like
>     xdiff/*.c or compat/regex/*.c, which also compile on
>     their own (and can get away with it because they are mostly standard
>     C and do not do "system" things.

Right; I didn't comment on the bare inclusions of system headers in
these files exactly because I shared that reasoning.

>     However, the code in the ewah/ directory has been hacked up a bit
>     from its original, and ewah_io.c _does_ include "git-compat-util.h".
>     So it may make sense to consider our copy a fork and git-ify it
>     more.

Yeah, sounds very sensible.
