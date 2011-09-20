From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to remove unreachable objects?
Date: Mon, 19 Sep 2011 17:40:03 -0700
Message-ID: <7vfwjs82sc.fsf@alter.siamese.dyndns.org>
References: <20110919110831.ewq03vnqos4w8cs8@webmail.edis.at>
 <20110919195335.GA31930@sigill.intra.peff.net>
 <20110919201804.GB31930@sigill.intra.peff.net>
 <7vsjns8b6m.fsf@alter.siamese.dyndns.org>
 <20110919225219.GD4056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dieter@schoen.or.at, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 20 02:40:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5oNk-0005Xy-Bs
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 02:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987Ab1ITAkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 20:40:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751626Ab1ITAkI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 20:40:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7324955ED;
	Mon, 19 Sep 2011 20:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oFfLKCax6aNzAT71Jg0YwL/uxLQ=; b=Kmuy+s
	I+wAHfitDTvsU057ZSm+Mjx+YxlHzm7BnO68TmN4XwjKaGBgZx9qcZNZ0hSFxg04
	6EZyud5bbVzlolzJfiSA1v7Reaa0xwRSvr/zsTlWbHyn7dja2788UsHdxWyQfVzT
	chHMo/3zheBLqMgPcFpSYrZEwWMvPWpoZSrrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FkNpzGb6gsnjM0jUZ1M1Cw3HialY5iy7
	F2mM2y7dQJxZ7xG6gJrN35k77jJ3kDhbTEIFI/ideuoCTs+aUC6bLM4xA43Ohwmy
	ulLUPbKiJiaNc60ZsF9vR/nS5fB6s9Ko6NqwOFoW+g2jLQFEDuayCBVfn/hi1ggU
	wQUP4Msywfc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69EDF55EC;
	Mon, 19 Sep 2011 20:40:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EAB8855EA; Mon, 19 Sep 2011
 20:40:04 -0400 (EDT)
In-Reply-To: <20110919225219.GD4056@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Sep 2011 18:52:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 152BB0FA-E321-11E0-BEEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181723>

Jeff King <peff@peff.net> writes:

>> One possible use case might be when your repository is corrupt, and does
>> not pass "git fsck" (without any argument).  In such a case, if you are
>> lucky and your disk corrupted objects only reachable from a recent topic
>> branch, you might find that this command:
>> 
>> 	$ git fsck master next ...list other topics here...
>> 
>> still succeeds, so that you can figure out which topic makes such a
>> limited fsck fail when it is listed on the command line, judge its
>> importance and resurrect what you can from there, before nuking it to
>> bring the repository back in health so that you can recreate the topic.
>
> Does that work? I had the impression from the documentation that the
> arguments are purely about the reachability analysis, and that the
> actual corruption/correctness checks actually look through the object db
> directly, making sure each object is well-formed. Skimming cmd_fsck
> seems to confirm that.

You are right that you may see "corrupt object" for unreachable from the
tips in the object store, but I was talking more about verifying
everything that is needed for reachability analysis from the given tips
can be read, iow, "missing object" errors, lack of which would mean you
can salvage everything reachable from the refs involved in the traversal.
