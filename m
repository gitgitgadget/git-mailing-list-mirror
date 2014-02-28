From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC GSoC idea: new "git config" features
Date: Fri, 28 Feb 2014 12:00:48 -0800
Message-ID: <xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
References: <53108650.2020708@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 21:01:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJTcH-0004uT-LT
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 21:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708AbaB1UAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 15:00:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751576AbaB1UAx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 15:00:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53D9E707FC;
	Fri, 28 Feb 2014 15:00:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x44XkeOiq/yTomgmNeVYKNAGp/Y=; b=anDBNr
	ORevV4vU7REy79hlOrKr0XAxov8wtBPtiQSqAOFEe84NdmSnHl65YiOMPeB9m+C5
	yQdxJIvZOM9h6tddXY0d+d6+huHSl5AhDin23pyvzwDuew6VDpdGJcRb8HsvhjVb
	X8vpAnpvJMRjXMEcJy2UjNI8Vmsi4Cp/uCOMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jTEyo2JkNdITsBy6Qeh4UZioG4Cb5TgS
	+AWJC4OeMnHBh5E3BhdFe/+kCJtmvwaOuMKN6t+AaYcsquxkISmzssDt/7JDtHql
	1qICbN83dGEMv1h99kndA8z163pfwSk4pMDId17VAxW4GyYc4rlNhqOGgUvCfafu
	axgN/OCmaqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 40469707FA;
	Fri, 28 Feb 2014 15:00:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D628707F7;
	Fri, 28 Feb 2014 15:00:50 -0500 (EST)
In-Reply-To: <53108650.2020708@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 28 Feb 2014 13:51:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 05B44BD0-A0B3-11E3-9E0B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243011>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I just wrote up another double-idea that has been stewing in my head for
> a while:
>
> * Allow configuration values to be unset via a config file
> * Fix "git config --unset" to clean up detritus from sections that are
> left empty.

The former is *way* too large for a GSoC project.  Most
configuration variables are meant to be read sequencially and affect
in-core variables directly, like

        /* file-scope global */
	static int frotz = -1;  /* unset */

        static int parse_config_frotz(const char *key, const char *value, void *cb)
	{
        	if (!strcmp(key, "core.frotz"))
                	frotz = git_config_int(value);
		return 0;
	}

	... and somewhere ...
        	git_config(parse_config_frotz, NULL);

The config parsers are distributed and there is no single registry
that knows how in-core variables owned by each subsystem represent
an "unset" value.  In the above example, -1 is such a sentinel
value, but in some other contexts, the subsystem may choose to use
INT_MAX.  The only way to allow "resetting to previous" is to

 (1) come up with a way to pass "this key is being reset to
     'unspecified'" to existing git_config() callback functions
     (like parse_config_frotz() in the above illustration), which
     may or may not involve changing the function signature of the
     callbacks;

 (2) go through all the git_config() callback functions and make
     them understand the new "reset to 'unspecified'" convention.

which may not sound too bad at the first glance (especially, the
first one is almost trivial).

But the side effects these callbacks may cause are not limited to
setting a simple scaler variable (like 'frotz' in the illustration)
but would include things that are hard to undo once done
(e.g. calling a set-up function with a lot of side effects).

The latter, on the other hand, should be a change that is of a
fairly limited scope, and would be a good fit for a GSoC project
(incidentally, it has been one of the items on my leftover-bits list
http://git-blame.blogspot.com/p/leftover-bits.html for quite some
time).

Thanks.
