From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] On watchman support
Date: Tue, 18 Nov 2014 13:26:56 -0800
Message-ID: <xmqqwq6std27.fsf@gitster.dls.corp.google.com>
References: <20141111124901.GA6011@lanh> <1416270336.13653.23.camel@leckie>
	<CACsJy8BfxP7KF1XF29BOgC6XhO8iAy-ycEoLkDG5rn6TYH_DrA@mail.gmail.com>
	<1416334360.27401.10.camel@leckie>
	<xmqqioicut32.fsf@gitster.dls.corp.google.com>
	<1416345123.27401.11.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:27:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqqIi-0000Nc-3X
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:27:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbaKRV07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:26:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932074AbaKRV07 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:26:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA9421FC02;
	Tue, 18 Nov 2014 16:26:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oKGcp8NSfi5sn0AfA/+3YGKzSpA=; b=Wi4m3M
	xHR8aIsEVKbJUnbwUKm5Ip3AQ0dgEiNi9Co2/9FqFC8l5GwpQq0hPuwRB2lWLb+w
	8xVlZlfauf6YtGnTM+J+f21wBitGMysp/fJKhnFOG/u6Q9dUzAza5aQ2ZZJdgRbQ
	ckrVQxw1ONgEzc3+5MywZ5hczWIjwlnE8bn88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G0JwWzV+EhqpeII0kjK4EW59mqdFxSuL
	gUGxYzboxIuNBVc/8bDjGpwAcbGBuAiiyZaZFhdNLUkM9NSg72zwpVWV6XoAelXB
	qxM0j6RRTUU4U2xucI0M1Q3eb9jzvT+cghjY1lkmNkZge/So6w5FCte/tXsy+pS9
	WQntfm7K92c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D14BA1FC01;
	Tue, 18 Nov 2014 16:26:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D8EE1FBFE;
	Tue, 18 Nov 2014 16:26:59 -0500 (EST)
In-Reply-To: <1416345123.27401.11.camel@leckie> (David Turner's message of
	"Tue, 18 Nov 2014 16:12:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A114197C-6F69-11E4-9C20-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twopensource.com> writes:

> On Tue, 2014-11-18 at 12:55 -0800, Junio C Hamano wrote:
>> I vaguely recall that the reason why we dropped it was because it
>> was too much code churn in an area that was being worked on in
>> parallel, but you may need to go back to the list archive for
>> details.
>
> OK, in that case I'll try to remember to reroll it once the rest of the
> refs stuff lands.

Sure.  But I would much prefer to see us explore an arch independent
optimisation of the caller before starting to micro-optimize a leaf
function.  

It is not check_refname_format() that is the real problem. It's the
fact that we do O(# of refs) work whenever we have to access the
packed-refs file. check_refname_format() is part of that, surely,
but so is reading the file, creating all of the refname structs in
memory, etc. (credit to peff@).
