From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Fri, 11 Feb 2011 11:32:03 -0800
Message-ID: <7v4o8a1i6k.fsf@alter.siamese.dyndns.org>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
 <AANLkTikrVPCr92XHirn1u=73eM--T190V-7nbE6fo8ng@mail.gmail.com>
 <201102111240.29746.johan@herland.net>
 <20110211190326.GB29203@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, skillzero@gmail.com,
	git@vger.kernel.org, John Wiegley <johnw@boostpro.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 11 20:32:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnyjO-0000Ei-0m
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 20:32:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005Ab1BKTcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 14:32:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758000Ab1BKTcT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 14:32:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABA10323C;
	Fri, 11 Feb 2011 14:33:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+rtnw4wKpgXEUfU7+10tDmJgz1o=; b=aD6kEs
	hbn1mi1Cg2owdaEc5G1D6WmqfEew81xI6hXC2oVklfeI015S0sYNvmCuT0VEvmND
	Nay1GeJtld9wEpZngXtvr066sGuqmMq5E3qLbMPpKs2YRsUf+I3zpDUW7pIUFnPA
	NcpjYVPGBYx+8B4lQ0nVMMEnEmHFoRQqMbzKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HHTfLbhgWX2uXPSErAm1mO2Up5XLrN5c
	wiPO1u3IUV0a/KVR2MecQUvpsN7NPCuslCe/XwWotSwlLM7cwA/zqGIAjnl3w/um
	nguZ0JB+QeJMfD3oR11d6i9OYzYjgoqn/eeV+NGGDOqMvMOkSCOVKLV46ZDb/ixs
	BYUFe3lKsr4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 517EA3238;
	Fri, 11 Feb 2011 14:33:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B7FB93236; Fri, 11 Feb 2011
 14:33:07 -0500 (EST)
In-Reply-To: <20110211190326.GB29203@sigill.intra.peff.net> (Jeff King's
 message of "Fri\, 11 Feb 2011 14\:03\:26 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C4AAB62A-3615-11E0-A223-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166570>

Jeff King <peff@peff.net> writes:

> Exactly. One other possible solution to this problem would be to somehow
> make patch-ids handle fuzzy situations better. I doubt it is possible to
> do that without introducing a lot of false positives, though.

We need to remember that we would want to tolerate _no_ false positive.

We try hard to err on the safer side and leave the hard case to the users
for a reason.  A tool that records correct results 99.9% of the time but
produces wrong results for the rest of the time _silently_ is a tool that
cannot be trusted, and forces the user to inspect its output carefully to
make sure it is correct, not just for the 0.1% cases but for all of them.

Among the many automation support facilities we have gained over time, the
three-way merge, recursive merge to come up with a synthetic merge base
tree, detecting change similarity with patch-id, and detecting renames by
content inspection all proved themselves to be reasonably trustworthy
without false positives, even though they sometimes fail with false
negatives and they do so rather loudly by failing.  I find the heuristics
in rerere is trustable most of the time but I still do not completely
trust it myself.

Patching with fuzz and a user declaration that "this change came from
that", especially if the user can declare the correspondence even when
conflict resolution is involved during the porting of changes from totally
different context, fall into a different, a lot less trustworthy, basket.
It needs to start from totally trivial cases and punt _loudly_ when there
is any doubt.
