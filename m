From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 20/27] update-ref --stdin: Reimplement using reference transactions
Date: Thu, 03 Apr 2014 08:57:30 -0700
Message-ID: <xmqq61mqs8wl.fsf@gitster.dls.corp.google.com>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>
	<1395683820-17304-21-git-send-email-mhagger@alum.mit.edu>
	<xmqqppl0zvcs.fsf@gitster.dls.corp.google.com>
	<533B9A26.8050303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 17:57:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVk1Q-0003Uu-8V
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 17:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788AbaDCP5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 11:57:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566AbaDCP5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 11:57:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6D60794E6;
	Thu,  3 Apr 2014 11:57:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WAzqKWg1THRszbZUsNd5bZQTo84=; b=m0xbDj
	uFStBgwDCdFSM14XpNOduKYM7boqRAbIBd5HNh6i6Egrkyj7hrQJ+/WGxzANN1XB
	LvSLjByPJBfkMbOhQF3+gttdH5aqc6cOogiIGQM3soOE35YNPV3IetiOuOVMMW3/
	Mfi2h+RgGaWTlHb9cD0pBFuE/l8CnnnvvhG78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UjplJQFYoHqcK9rvywqgktaVNzismM14
	6KR+8Uq9B/896xe0u43EYuLSySE3FuVXuIXGaJSBehYl5vrbgEVwAP3npFR/JE1l
	W3+tRzNqS/GAiLqULo151NkMO6b+qnS8AC79jzNEGWmgjuI0NzwKbeh0RSxaPZeV
	v47W+wrCxcY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4E43794E5;
	Thu,  3 Apr 2014 11:57:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC4B5794E2;
	Thu,  3 Apr 2014 11:57:31 -0400 (EDT)
In-Reply-To: <533B9A26.8050303@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 02 Apr 2014 07:03:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA2E7D70-BB48-11E3-8CDC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245741>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I assumed that rolling back a non-consummated transaction in the case of
> early program death should be the responsibility of the library, not of
> the caller.  If I'm correct, the caller(s) won't have to be modified
> when the atexit facility is added, so I don't see a reason to add it
> before it is needed by a concrete backend.
>
> But you suggest that the caller should be involved.

I didn't say "should".  If the library can automatically rollback
without being called upon die() anywhere in the system, that is
better.  The suggestion was because I didn't think you were shooting
for such a completeness in the library part, and a possible way out
is for the caller to help.
