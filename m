From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically update it
Date: Fri, 11 Apr 2014 13:43:47 -0700
Message-ID: <xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
	<xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
	<CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
	<xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 22:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYiIs-0007c4-R2
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 22:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755274AbaDKUnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 16:43:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57202 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754192AbaDKUnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 16:43:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34AAC7A009;
	Fri, 11 Apr 2014 16:43:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gDnd1XtOwa7LBfr6BGnwJHb/cZo=; b=dOKAas
	bwnVvhbXuz7uvZJ1XYIJln4ZfQUetmIQ9dL20E71PL9DTQla8/tj+T5LyNolsiIl
	NTRPhs8NvMHf/5H1oJX/sJDuuFiF1liBhEDoPFT3KSsjWpIe4i9BqS/cUbQBGKr2
	OSdYc729wVjZdD9/RkSDWb47vsUYqC4pDyEnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UlEfYeD6men4wFUANnEEcU1ChON2jFTv
	o7gLSw5r3qilSKF3xRBiQ8ffqOJgz7F+VJIG+7LbU7c6CMPsUfX44UzhH9JAsrqj
	UMYtwXkpenSjVphtfQmN4Iif+iOhj7lQdX7NW+/x0lDsuhXUEjxbiKDCZva99OF3
	UvNyYrKLPo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F0997A008;
	Fri, 11 Apr 2014 16:43:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E67997A007;
	Fri, 11 Apr 2014 16:43:48 -0400 (EDT)
In-Reply-To: <xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 11 Apr 2014 12:24:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FBD93E86-C1B9-11E3-821B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246148>

Junio C Hamano <gitster@pobox.com> writes:

> Yeah, I was hoping that the real write codepath (as opposed to "this
> is read only and we read the index without holding a lock---now we
> noticed that the index needs refreshing, and we know how the
> resulting refreshed index should look like, perhaps we can write it
> to save cycles for other processes" codepath where we cannot and
> should not take a lock early) would take the lock and then read, but
> because that is not the way they work, the need the same protection,
> I would think.

Having said that, nobody sane would be running two simultaneous
operations that are clearly write-oriented competing with each other
against the same index file.  So in that sense that can be done as a
less urgent follow-up for this topic.
