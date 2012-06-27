From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Allow help.htmlpath to be an http: URL
Date: Wed, 27 Jun 2012 14:32:49 -0700
Message-ID: <7vbok4785a.fsf@alter.siamese.dyndns.org>
References: <8d3c71d21710c66e4d5560cec958552b69a22338.1340830514.git.chris@arachsys.com>
 <233b27a14d16a2a1cb38b9f3e07a3a79b09a3256.1340830514.git.chris@arachsys.com>
 <20120627210502.GB2292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Webb <chris@arachsys.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:32:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjzr7-0000Im-54
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab2F0Vcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:32:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756462Ab2F0Vcw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:32:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C688176;
	Wed, 27 Jun 2012 17:32:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PqN/Zl3uppy02AG9vKsLetFY6zc=; b=W0LN/9
	UNZuxv9r3W1F+MwLhH0GyFHj3j4Y4jo/ZQLoVfsqFEzoLDc/Gh+MIHrNgBo1urkL
	J9aDbllMU1Pc1Mvc2diCiLU5v2SVlRs+zuUVu9KHWBYQAvsBufOsEa4csIXXxLt6
	aARTzm/wtD+ZbL7tKiZYzqDmODXfre2pFA91w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EsY+X/9SigBO8KiP4QYPwUKu62s6i30o
	1Kd50sJ5OcZVYDO9a3o6gHggUw1sxWdLRsIGJa3daL89yEfmRuHNPEc8VBPcL5ae
	23LNKsTA1eCcdiO4UO0c7wnHJ9+9tjEFJfQHnxLBN4PMgScL5h6bGQ017hOSNy+q
	5KmCjPtWz7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27C8C8175;
	Wed, 27 Jun 2012 17:32:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A86628174; Wed, 27 Jun 2012
 17:32:50 -0400 (EDT)
In-Reply-To: <20120627210502.GB2292@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 27 Jun 2012 17:05:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5835AA2-C09F-11E1-BA26-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200759>

Jeff King <peff@peff.net> writes:

> On Wed, Jun 27, 2012 at 09:55:13PM +0100, Chris Webb wrote:
>
>> Setting this to a URL prefix instead of a path to a local directory allows
>> git-help --web to work even when HTML docs aren't locally installed, by
>> pointing the browser at a copy accessible on the web. For example,
>> 
>>     [help]
>>       format = html
>>       htmlpath = http://git-scm.com/docs
>> 
>> will use the publicly available documentation on the git homepage.
>
> Nice.
>
>>  	/* Check that we have a git documentation directory. */
>> -	if (stat(mkpath("%s/git.html", html_path), &st)
>> -	    || !S_ISREG(st.st_mode))
>> -		die(_("'%s': not a documentation directory."), html_path);
>> +	if (prefixcmp(html_path, "http:")) {
>> +		if (stat(mkpath("%s/git.html", html_path), &st)
>> +				|| !S_ISREG(st.st_mode))
>> +			die("'%s': not a documentation directory.", html_path);
>> +	}
>
> I'd rather not tie this directly to http. Is there any reason not to
> allow https, for example? Can we maybe just look for strstr("://")
> instead? That's the same magic we use to differentiate URLs from paths
> when looking for repositories.

One part of me says "any non-standard html-path should be sent to
the browser".  Another part of me says "what if network is
unavailable?  Wouldn't it be nice to fall back to use the local
copy?"

And a small voice in me responds to the latter with "If you have a
local copy anyway, why would you want to go to the network even if
you could?"

Which leads me to conclude that it is the right thing to do if
html_path came from the configuration, not from the compiled-in
default, to always ask browser to do its thing, and let it fail if
it has to fail---it is not Git's problem anymore at that point.

It also is the simplest.
