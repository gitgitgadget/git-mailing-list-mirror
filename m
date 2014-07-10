From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/10] replace: add --graft option
Date: Thu, 10 Jul 2014 09:51:20 -0700
Message-ID: <xmqqr41t88dz.fsf@gitster.dls.corp.google.com>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.51047.chriscool@tuxfamily.org>
	<xmqqsima7f3r.fsf@gitster.dls.corp.google.com>
	<CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 18:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5HZG-0000qW-4C
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 18:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaGJQva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 12:51:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55647 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791AbaGJQv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 12:51:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8E9C426551;
	Thu, 10 Jul 2014 12:51:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lUNUJ1kiH7dSSBxUBxaWrPLpXNc=; b=Pg4a5A
	Kilh7rlR+p/k30gTQzrusZrzCIFTeKPnSvCmcXmhzFuViobUesWMsa73IzcLfB5E
	mzScMLNtnpSP6JPPpW9w/LvGdZc+iWUcz51uBSw6RmMWfEiD+IclqVP7JK0zN1An
	DOJlPmY9F48uOritYuK2BI8LOuSDrdKZxO55U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZbjaFqe2ycV5vrHdTQUdIJKA8IQcDtUD
	9RNX+8OJ3EkL9RAUiYAH8TH80AKg98vWANUbSvR/vxpY+NOcEKJnuzoi26baoTCe
	5Zx4PKd8/j6D48pMX05gpunF0tdy27ivWiYW0z5d7SQ/RWTj47/rVYhU9nYGAVtD
	TxPrH6aM8IE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D25026550;
	Thu, 10 Jul 2014 12:51:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8493926546;
	Thu, 10 Jul 2014 12:51:07 -0400 (EDT)
In-Reply-To: <CAP8UFD2X7j2TGEQfX3h8CfiZypJ5tVPqaZ2bNE0k1-jbeJj=Zw@mail.gmail.com>
	(Christian Couder's message of "Thu, 10 Jul 2014 11:30:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 636A4A98-0852-11E4-9833-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253190>

Christian Couder <christian.couder@gmail.com> writes:

>> Is this really an error?  It may be a warning-worthy situation for a
>> user or a script to end up doing a no-op graft, e.g.
>>
>>         git replace --graft HEAD HEAD^
>>
>> but I wonder if it is more convenient to signal an error (like this
>> patch does) or just ignore the request and return without adding the
>> replace ref.
>
> As the user might expect that a new replace ref was created on success
> (0 exit code), and as we should at least warn if we would create a
> commit that is the same as an existing one,...

Why is it an event that needs a warning?  I do not buy that "as we
should at least" at all.

If you say "make sure A's parent is B" and then you asked the same
thing again when there already is a replacement in place, that
should be a no-op.  "Making sure A's parent is B" would be an
idempotent operation, no?  Why not just make sure A's parent is
already B and report "Your wish has been granted" to the user?

Why would it be simpler for the user to get an error, inspect the
situation and realize that his wish has been granted after all?
