From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ideas to speed up repacking
Date: Mon, 02 Dec 2013 23:17:24 -0800
Message-ID: <xmqqli02pfnf.fsf@gitster.dls.corp.google.com>
References: <201312021630.45767.mfick@codeaurora.org>
	<xmqqpppepxuu.fsf@gitster.dls.corp.google.com>
	<CACsJy8DJU2YTE1iNdb=fvo0fVOgLUK2mKXUhjcoJh8Ac0wW_EA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Fick <mfick@codeaurora.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 08:17:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnkEe-0004En-RK
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 08:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab3LCHR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 02:17:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61315 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995Ab3LCHR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 02:17:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D1884B556;
	Tue,  3 Dec 2013 02:17:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ng+RFp1+alQm0aKrA//QJLpdx7E=; b=PyOhei
	0AeB5R+3zn2doUHI/9hzawmxMTS/Wnl0L8QgDoOldZ8xQzx2RUe9EEDzMhI621Dr
	e36QbCrB6mQl+vn+uWZY5T9z4bDbgwlJHFdAcJrSk5krV6OrFDqvpNF2q3p662OZ
	O9cFDFvzaPPvoXG5hiqlhgYki1gVPM1Oq+4rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KjqEuGg0nInUjDl88rODwnAkrTSiDs4q
	N6VjWXWYQH71eX2Ns8I3aChyAuLBIzmzhHUChBo/f15IH17Y7F7FYld+5M2O8l4x
	4F0Fd7DE8KOGrGZjf9iAvHbs2p4y7yrXlvz2GRzzKvOnXwzteMJylm5J7T7/lWGa
	YG5NZEIbp+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BD3E4B555;
	Tue,  3 Dec 2013 02:17:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA9294B552;
	Tue,  3 Dec 2013 02:17:25 -0500 (EST)
In-Reply-To: <CACsJy8DJU2YTE1iNdb=fvo0fVOgLUK2mKXUhjcoJh8Ac0wW_EA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 3 Dec 2013 10:27:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F5EE68C8-5BEA-11E3-B243-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238674>

Duy Nguyen <pclouds@gmail.com> writes:

>> If nothing else has happened in the repository, perhaps, but I
>> suspect that the real problem is how you would prove it.  For
>> example, I am guessing that your Scenario 4 could be something like:
>>
>>     : setup #1
>>     $ git repack -a -d -f
>>     $ git prune
>>
>>     : scenario #4
>>     $ git commit --allow-empty -m 'new commit'
>>
>> which would add a single loose object to the repository, advancing
>> the current branch ref by one commit, fast-forwarding relative to
>> the state you were in after setup #1.
>>
>> But how would you efficiently prove that it was the only thing that
>> happened?
>
> Shawn mentioned elsewhere that we could generate bundle header in and
> keep it in pack-XXX.bh file at pack creation time. With that
> information we could verify if a ref has been reset, just fast
> forwarded or even deleted.

With what information? If you keep the back-then-current information
and nothing else, how would you differentiate between the simple
scenario #4 above vs 'lost and new' two commit versions of the
scenario?  The endpoints should both show that one ref (and only one
ref) advanced by one commit, but one has cruft in the object
database while the other does not.

>> Also with Scenario #2, how would you prove that the new pack does
>> not contain any cruft that is not reachable?  When receiving a pack
>> and updating our refs, we only prove that we have all the objects
>> needed to complete updated refs---we do not reject packs with crufts
>> that are not necessary.
>
> We trust the pack producer to do it correctly, I guess. If a pack
> producer guarantees not to store any cruft, it could mark the pack
> somehow.

That is not an answer.  Since when do we design to blindly trust
anybody on the other end of the wire?
