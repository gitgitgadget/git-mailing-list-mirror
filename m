From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Symbolic refs break ref advertisement on 1.8.4.3+
Date: Mon, 18 Nov 2013 10:16:32 -0800
Message-ID: <xmqqr4adbmnz.fsf@gitster.dls.corp.google.com>
References: <CAGyf7-EX2QXKyAwoxv2Ux5cjSp71m-dR+Vq4C3pevJrYaGu42g@mail.gmail.com>
	<20131117100251.GB22166@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 18 19:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViTNI-0008Vq-6y
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 19:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab3KRSQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 13:16:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab3KRSQf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 13:16:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCB1551273;
	Mon, 18 Nov 2013 13:16:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2j1TmAmM1FUhhLj0Hu/CqVOBKso=; b=TLLMPX
	X1+TVZzRZBhqawRZsELKTmg/lKAQuhASFy3zKh6ZXkd0sK5iTd7bRSdiakG4fjy/
	eBZsjZt6hYDqPRmqho+FneIxfz/kAxAukeU/CmJR/MTBeyJzb5IXmU4eUxmGMCTl
	nESHAyFUYs7Pu2u84GwJRBIY2XXJituo22/nk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dWiIp1BptYHbv0JF0tIOh5leCHdRQ3o3
	2JAK0YFOCBNNPMyRyz6LZJqrFvczWb1igevwsGJjtWIWaZPVDNiVcFVmKSU0oSxT
	ky35Y3U2IGvVLtuxcu7fWrTj2SPnT3ZpvisIpAp/z1ob+peWuGZIPcZxfxtFTuRp
	hsKKM/FtZPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB6A951272;
	Mon, 18 Nov 2013 13:16:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1762751271;
	Mon, 18 Nov 2013 13:16:34 -0500 (EST)
In-Reply-To: <20131117100251.GB22166@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 17 Nov 2013 05:02:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8E605784-507D-11E3-A247-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238003>

Jeff King <peff@peff.net> writes:

> On Sun, Nov 17, 2013 at 01:39:52AM +1100, Bryan Turner wrote:
>
>> Aphrael:example bturner$ for ((i=1;i<21;i++)); do git symbolic-ref
>> refs/heads/syms/$i refs/heads/master; done
>> Aphrael:example bturner$ git ls-remote .
>> fatal: protocol error: impossibly long line
>> fatal: Could not read from remote repository.
>> 
>> A symref= entry is written into the first packet of the ref
>> advertisement, right after the capabilities, for each symbolic ref in
>> the repository. Unfortunately, no splitting is done on that value and
>> so once you have 15-20 symbolic refs (more or less depending on path
>> lengths), you blow the 996 byte limit in format_packet (pkt-line.c)
>> and all further clone/fetch operations fail.
>
> Ick, yeah. I don't think there is a way around that with the way the
> information is shoe-horned into the protocol.  We should probably just
> revert 5e7dcad (upload-pack: send non-HEAD symbolic refs, 2013-09-17),
> and assume the HEAD branch name is short enough to fit.
>
> Another option would be to cap the number of non-HEAD symrefs we'd send
> (by counting up the bytes and keeping below the limit). That at least
> makes the "easy" cases work, but it's a bit too flaky for my taste.

Thanks Bryan for an easy reproduction, and thanks Peff for a
suggestion.  Let's revert that one for now.
