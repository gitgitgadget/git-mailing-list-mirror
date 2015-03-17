From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer parsing
Date: Tue, 17 Mar 2015 11:48:39 -0700
Message-ID: <xmqqk2yfo3y0.fsf@gitster.dls.corp.google.com>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Mar 17 19:48:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXwXr-0002t5-03
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 19:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932345AbbCQSso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 14:48:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932220AbbCQSsl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 14:48:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33C253EE8B;
	Tue, 17 Mar 2015 14:48:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u52OBqAjB6bdnxLLda+2FaL4W38=; b=drMK5n
	E1q3JtZaScLpoT3/ifrGfFqF4M1SYiC4zNi6SQhYna5xN1a0+5AGk3sPzLUVJjHH
	OJCxyoFyifUR1sfw8xczm0AoD38x2k81gU5mJli9VzcDP+ThDcrlxX2RI85BSDt/
	oLuo+feh/vdFA9lgDRiBWJ3pVCqItxiSbqXHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DEpnCdFh3tMlbxZCW2ch3b9HXFgei5m0
	eant6MUCPn6kCFyEwFnqfROeLGYhHlyx95DEa4aZr2dHpidSxeQCMIfryi853yzD
	vxz2E5z5yQJ4wHRXBarATA4RV40y8uxI0+YJVPJGnN7qL9qZ342a0ffLnubI9nk1
	ZtMQ5K8u6hw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2CA0E3EE89;
	Tue, 17 Mar 2015 14:48:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8DD453EE87;
	Tue, 17 Mar 2015 14:48:40 -0400 (EDT)
In-Reply-To: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Tue, 17 Mar 2015 17:00:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3A96E006-CCD6-11E4-B388-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265653>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> When I looked around, I found scores of sites that call atoi(),
> strtoul(), and strtol() carelessly. And it's understandable. Calling
> any of these functions safely is so much work as to be completely
> impractical in day-to-day code.
>
> git-compat-util.h has two functions, strtoul_ui() and strtol_i(), that
> try to make parsing integers a little bit easier.

Exactly.  They were introduced to prevent sloppy callers from
passing NULL to the &end parameter to underlying strtoul(3).  The
first thing that came to my mind while reading your message up to
this point was "why not use them more, tighten them, adding
different variants if necessary, instead of introducing an entirely
new set of functions in a new namespace?"

For example:

> * Am I making callers too strict? In many cases where a positive
>   integer is expected (e.g., "--abbrev=<num>"), I have been replacing
>   code like
>
>       result = strtoul(s, NULL, 10);
>
>   with
>
>       if (convert_i(s, 10, &result))
>               die("...");

I think strictness would be good and those who did "--abbrev='  20'"
deserve what they get from the additional strictness, but 

	if (strtol_i(s, 10, &result))

would have been more familiar.
