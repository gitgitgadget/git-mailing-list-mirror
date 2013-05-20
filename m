From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/17] Remove assumptions about refname lifetimes
Date: Mon, 20 May 2013 11:03:33 -0700
Message-ID: <7vy5b9v896.fsf@alter.siamese.dyndns.org>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
	<CALKQrgfpAqWESDrjE5po+XPvK+xft=PVwDXr3E7BU28jdDRcZA@mail.gmail.com>
	<7vfvxhwqt1.fsf@alter.siamese.dyndns.org>
	<20130520165942.GB27788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 20 20:03:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeUQu-0006Xl-M9
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 20:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab3ETSDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 14:03:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab3ETSDf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 14:03:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DCD720BEC;
	Mon, 20 May 2013 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fQilNzxQeUHk/GArmGBbvvg8ITg=; b=MXaRar
	lfV5qIdgkWOFQBHPqEOP+ia1ityu+JXYo+cr0NseNkTE194FgckCWgzxXD4PNeCU
	CaJPOVj9wwZCSzw264bEBoRtaSBvF+/e3mmMVrlN9Ualk+nuVOUGXEdPIYhUuz9d
	Ct+TlYRtAJ8kGY25muRGmXz/uhUM6jLk4Js8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GsLWgvHRO3hOtH0eVFFJ8YkugaMicq1U
	VFIo3g48HtzXDFAaYxYLHrEAD+ofVT2xRFoZKeUfLIUUTwWHulDbeD6dfZh206w1
	L6YI833YpM1M74TYX39c0wGFpF4t+vdOvbEGZ13ZTb/XCXsU4knUBaijWA6erM8Z
	9j0X8ZZELj0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 150CC20BEB;
	Mon, 20 May 2013 18:03:35 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 652C020BE8;
	Mon, 20 May 2013 18:03:34 +0000 (UTC)
In-Reply-To: <20130520165942.GB27788@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 20 May 2013 12:59:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9677EE04-C177-11E2-A9C1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224970>

Jeff King <peff@peff.net> writes:

> But more importantly, it introduces contention between two unrelated
> refs that are being updated. Even if we reconcile the differences
> automatically (e.g., with a "merge-and-retry" strategy), that is going
> to be a serious performance regression for a busy repository, as we
> repeatedly try to reconcile the serialized updates to the refs/ root
> tree.

I think we are on the same page.

> Any transactional solution needs to have the equivalent of ref-level
> locking (i.e., row-level locking in a relational setting).

Not necessarily if we can exploit assumptions such as deletion is
far rare compared to update and creation which in turn are far rare
compared to lookup.  I've been wondering if we can find a cheap
reader-writer lock mechanism, use a single instance of it to govern
the whole repository, and have everybody but ref deleters and "git
pack-ref" take the read side of the lock.

Then only while ref deletion or ref packing is going on, everybody
need to stall, but otherwise the most common "read or update
recently touched refs (aka loose refs)" will be taking the reader
side of that cheap read-write lock and reading a single loose ref
file.

Perhaps such a "cheap on reader side" reader-write lock is hard to
come by?
