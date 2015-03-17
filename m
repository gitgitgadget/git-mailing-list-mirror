From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] not making corruption worse
Date: Tue, 17 Mar 2015 15:54:02 -0700
Message-ID: <xmqqh9tjme0l.fsf@gitster.dls.corp.google.com>
References: <20150317072750.GA22155@peff.net>
	<20150317073730.GA25267@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 17 23:54:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YY0NH-0001jS-GY
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 23:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932538AbbCQWyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 18:54:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750958AbbCQWyF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 18:54:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB8213F571;
	Tue, 17 Mar 2015 18:54:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fR3AVYtdm3MYZiUDegvotAcqpXI=; b=mmALl9
	SibLLUwc1CKUDIQeXF3tCKg5ME2RUIPOiJf0df5xy3oEJ6ySLZ8JtEr+0GD/2LNE
	iCuQTXHot2JpEREaDSJdVOSfz6O2yriMGXS+PTil0DqTaS6tshBXBwcqThfJ+f0b
	rIgbEm6PMLjz/0WrtaG0eVdfLqXZsmjSGo9+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uuzGB+VI6LzriGcusmm6TINi9vQD1fOE
	0fqub7igZ2O2nvN1ujZxgg64QnBsvsYStStKIRIBrNU6DvIOxJwFctzvaowCm7tr
	NFEcxGFPy4UXy1UXjm3035dsBAzIm6V2ubk9t6ZhYTpR30Acm1RxrMBuwqLvVIMD
	zhgrJ4HpeLs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3CCE3F570;
	Tue, 17 Mar 2015 18:54:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31D963F56F;
	Tue, 17 Mar 2015 18:54:04 -0400 (EDT)
In-Reply-To: <20150317073730.GA25267@peff.net> (Jeff King's message of "Tue,
	17 Mar 2015 03:37:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 828CB0A8-CCF8-11E4-896C-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265674>

Jeff King <peff@peff.net> writes:

> But it strikes me as weird that we consider the _tips_ of history to be
> special for ignoring breakage. If the tip of "bar" is broken, we omit
> it. But if the tip is fine, and there's breakage three commits down in
> the history, then doing a clone is going to fail horribly, as
> pack-objects realizes it can't generate the pack. So in practice, I'm
> not sure how much you're buying with the "don't mention broken refs"
> code.

I think this is a trade-off between strictness and convenience.  Is
it preferrable that every time you try to clone a repository you get
reminded that one of its refs point at a bogus object and you
instead have to do "git fetch $there" with a refspec that excludes
the broken one, or is it OK to allow clones and fetches silently
succeed as if nothing is broken?

If the breakage in the reachability chain is somewhere that affects
a branch that is actively in use by the project, with or without
hiding a broken tip, you will be hit by object transfer failure and
you need to really go in there and fix things anyway.  If it is just
a no-longer-used experimental branch that lost necessary objects,
it may be more convenient if the system automatically ignored it.

In some parts of the system there is a movement to make this trade
off tweakable (hint: what happened to the knobs to fsck that allow
certain kinds of broken objects in the object store?  did the topic
go anywhere?). This one so far lacked such a knob to tweak, and I
view your paranoia bit as such a knob.
