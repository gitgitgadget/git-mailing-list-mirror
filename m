From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] Make sure fsck_commit_buffer() does not run out of the buffer
Date: Thu, 11 Sep 2014 09:49:02 -0700
Message-ID: <xmqqegvif6gx.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<cover.1410356761.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1409101552560.990@s15462909.onlinehome-server.info>
	<xmqqlhprgylt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1409111352130.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 18:49:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS7YX-0007yM-6x
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 18:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974AbaIKQtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 12:49:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61464 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755066AbaIKQtH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 12:49:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BC77139B24;
	Thu, 11 Sep 2014 12:49:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWgrZ4w6UqXITjEQHZfRA2DhMn0=; b=t+m3xt
	CZbmQL+j05hAYFkfwkIBXP52CqZ0wcaitsLObRuGGdbI5JJztnf5qSkdGRTWkdg8
	XoZril/aDHkDp1/p4CgU6qX/UEX/LOafOYTMUhE6VZR6lNuafXV8ClNBHwKDXrfP
	HHVXlLJmAw8lZbqg0WSEqV6Cw/VyBNSe+drjw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=D1T2FN7cuPUvXM94gnGW+4ssNb6XTlGB
	ZRNaqKIDkHP1AA7G7gf5vkSbCOYZCPgDPNdWfZbLcjlYxdG4vEFCH3VPcUkQBQwq
	enywisSqw2SWQYeVlp/ktECpkNf71YfkMETrPFGhLHoV44uM9GFa2dHffZ0XW65E
	AJtJCEYfULM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B1D2039B22;
	Thu, 11 Sep 2014 12:49:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2FEFF39B20;
	Thu, 11 Sep 2014 12:49:05 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.1409111352130.990@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 11 Sep 2014 13:59:00 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8A798B3C-39D3-11E4-90A7-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256850>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +	for (i = 0; i < size; i++) {
>> > +		switch (buffer[i]) {
>> > +		case '\0':
>> > +			return error_func(obj, FSCK_ERROR,
>> > +				"invalid message: NUL at offset %d", i);
>> 
>> Isn't this "invalid header"?  After all we haven't escaped this loop
>> and haven't seen the message part of the commit object (and it is
>> the same if you are going to later reuse this for tag objects).
>
> My reasoning for keeping it saying "message" was that a message consists
> of a header and a body. I will change it to "unterminated header" instead,
> also in the error message when no NUL was found.

Because end users think of a "message" in the context of discussing
either a commit or a tag as what they give as the value to the "-m"
option, the object payload consists of a header and a body the
latter of which *is* the message to them.  Choosing a word that is
not "message" is a good way to avoid potential confusion here.
