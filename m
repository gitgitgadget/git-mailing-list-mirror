From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf)
Date: Fri, 05 Dec 2014 10:00:05 -0800
Message-ID: <xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
References: <20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203051344.GM6527@google.com>
	<xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
	<20141204030133.GA16345@google.com>
	<xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
	<20141204234147.GF16345@google.com> <20141204234432.GA29953@peff.net>
	<CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
	<20141205000128.GA30048@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 05 19:00:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwxAw-0003Xu-G1
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 19:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbaLESAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 13:00:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55889 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751373AbaLESAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 13:00:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CED8920FF2;
	Fri,  5 Dec 2014 13:00:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pn+IS2DoCHtxR00ZsQQxqGZIhJc=; b=B53ho5
	uzbUPtv1O651n6ee3ogFpgKi/VTAaVBA8TSWE3WjFMuctnFn1YtGO4vuPiJOZrHO
	uYaGk2aObgSiKXPVC27fcdZjMpLet91AYzMBeShmdvBFOr7TWwkT5O1U7O6awFAT
	49su0JI2rzlFZR5+5JjIZzasqi90KxKWz13mE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZE+XnUKWaHG4se1ldgbilCVtyyAmh612
	tzcWWYHx1OgQ809W3Ao/K4EsmnpPWGxXoWGeqyZ/5q6OQmtcolWqFeU1YbuwOadd
	6QmwbIQfZHx7lnNVxRW3OJ4bnfeAF676erqJno6mNZB1mYplEGXK9InPptEwtoBW
	87Hvx/AWFw4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF66F20FF1;
	Fri,  5 Dec 2014 13:00:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2C64220FEF;
	Fri,  5 Dec 2014 13:00:09 -0500 (EST)
In-Reply-To: <20141205000128.GA30048@peff.net> (Jeff King's message of "Thu, 4
	Dec 2014 19:01:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D22F018-7CA8-11E4-B12D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260878>

Jeff King <peff@peff.net> writes:

> The only downside I can think of is that we may truncate the message in
> exceptional circumstances. But is it really any less helpful to say:
>
>   error: unable to open file: some-incredibly-long-filename-aaaaaa...
>
> than printing out an extra 100 lines of "a"? And I mean the "..."
> literally. I think mkerror() should indicate the truncation with a
> "...", just so that it is clear to the user. It should almost never
> happen, but when it does, it can be helpful to show the user that yes,
> we know we are truncating the message, and it is not that git truncated
> your filename during the operation.
>
> Is this truncation really a concern, and/or is there some other downside
> I'm not thinking of?

I am more worried about variable length part pushing the information
that is given later out to the right, e.g. "error: missing file '%s'
prevents us from doing X".  Chomping to [1024] is not a good
strategy for that kind of message; abbreviating %s to /path/name/...
(again, with literally "...") would be.
