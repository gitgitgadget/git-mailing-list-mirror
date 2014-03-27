From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 03/12] Move lower case functions into wrapper.c
Date: Thu, 27 Mar 2014 15:16:48 -0700
Message-ID: <xmqqlhvvcmnj.fsf@gitster.dls.corp.google.com>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<20140326221531.11352.86408.chriscool@tuxfamily.org>
	<xmqqppl8ftjd.fsf@gitster.dls.corp.google.com>
	<20140327.084745.2069840957131666658.chriscool@tuxfamily.org>
	<xmqq4n2jfva5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:17:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTIbc-00058z-Fa
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 23:17:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169AbaC0WQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 18:16:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40034 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487AbaC0WQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 18:16:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F7B9784CC;
	Thu, 27 Mar 2014 18:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vcb1HRvXvaWatQ1KS1FoMkmTj94=; b=IV7ej+
	qtRzVurB7YeWrD/Baxgwc4BjgF45N5fgIfMm8N5lzZSE7piZtJI1sv1PKJArJTxK
	s12Hhnm8AHOdQnlBYQfBMZ2p5IyUOTMWvwr11j16pBt2KabjpRtflpPT8xzaXQiF
	dHQ+pUFJ+l6y/A7NcEZeb2AMYWsDcPiT0AhZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PuouyAlUm3j8+/LYtgzsrhxzqnGaWPh5
	/MXapW9I7OtTmXKfg94mlH6VpBd1d1zSsRSyJ16Qpe6PuHjcJpZUFWm9gBgWflL/
	A5ce6Nsj7Jb8aavLzwOGfudh/2Jb6wBDvU1u+8DWYD4Ned1Z4XtI6fBZqHyTOQ7V
	Gzmj90/pOx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BD46784CA;
	Thu, 27 Mar 2014 18:16:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5D694784C7;
	Thu, 27 Mar 2014 18:16:51 -0400 (EDT)
In-Reply-To: <xmqq4n2jfva5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 27 Mar 2014 09:42:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7F1448B8-B5FD-11E3-99E1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245329>

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Yeah, but it seems a bit wasteful to allocate memory for a new string,
>> then downcase it, then compare it with strcmp() and then free it,
>> instead of just using strcasecmp() on the original string.
>
> I wasn't looking at the caller (and I haven't).  I agree that, if
> you have to compare case-insensitive user input against known set of
> tokens, using strcasecmp() would be saner than making a downcased
> copy and the set of known tokens.  I do not know however you want to
> compare in a case-insensitive way in your application, though.

It appears that one place this "lowercase" is used is to allow
rAnDOm casing in the configuration file, e.g.

	[trailer "Signed-off-by"]
		where = AfTEr

which I find is totally unnecessary.  Do we churn code to accept
such a nonsense input in other places?
