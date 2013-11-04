From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/remote: remove postfixcmp() and use suffixcmp() instead
Date: Mon, 04 Nov 2013 14:37:13 -0800
Message-ID: <xmqqtxfraj52.fsf@gitster.dls.corp.google.com>
References: <20131103201303.14446.7508.chriscool@tuxfamily.org>
	<xmqqbo20ynxs.fsf@gitster.dls.corp.google.com>
	<xmqq7gcnzznt.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1311042316520.1191@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Avery Pennarun <apenwarr@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 04 23:37:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdSm0-0007Q3-JE
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 23:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab3KDWhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 17:37:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201Ab3KDWhT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 17:37:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F189A4F049;
	Mon,  4 Nov 2013 17:37:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0cD6XskgMsOXx+tmZz+HGd+JFqc=; b=Tzihdk
	IT7jFKbICvrS+++459DmSIRxAVpNYV3wPL4vf6S3PiAKxhaAch+UhVYFwEd1iOFm
	daj4pMvM9fzMSeDAc3tucWNyI4pR4AkOtNk8x7iW+tVTeomzh24YWcK0F7OCzI/T
	V1MUQhqGukRxicqyuwAuIiFU4Sh6ECRxMzOz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E0+jQYkRsnxQ3phNM068m00QU5eBlQXF
	xQ5R5mZt2b8Llt7c5gdQaTvO+aQ8o3BF7RckGxPcxEo49IyPe12n4udPz4TPNJPw
	JSFmvEgCAd5oMNPhLKS+FhB6vhUAhoB23PNS25xN2AZSTvakFlp3QL7pzplF/GLO
	bSCd7eV21lY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E51AE4F048;
	Mon,  4 Nov 2013 17:37:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 400A94F042;
	Mon,  4 Nov 2013 17:37:18 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1311042316520.1191@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 4 Nov 2013 23:17:27 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A93E09AC-45A1-11E3-AF47-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237310>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Mon, 4 Nov 2013, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > I do not think anybody sane uses prefixcmp() or suffixcmp() for
>> > anything but checking with zero; in other words, I suspect that all
>> > uses of Xcmp() can be replaced with !!Xcmp(), so as a separate
>> > clean-up patch, we may at least want to make it clear that the
>> > callers should not expect anything but "does str have sfx as its
>> > suffix, yes or no?" by doing something like this:
>> >
>> >  int suffixcmp(const char *str, const char *suffix)
>> >  {
>> >  	int len = strlen(str), suflen = strlen(suffix);
>> >  	if (len < suflen)
>> >  		return -1;
>> >  	else
>> > -		return strcmp(str + len - suflen, suffix);
>> > +		return !!strcmp(str + len - suflen, suffix);
>> >  }
>> >
>> > I am not absolutely sure about doing the same to prefixcmp(),
>> > though. It could be used for ordering, even though no existing code
>> > seems to do so.
>> 
>> I just realized why this suggestion is incomplete; if we were to go
>> this route, we should rename the function to has_suffix() or
>> something. anything-cmp() ought to be usable as an ordering
>> comparison function, but suffixcmp() clearly isn't.
>
> I have to admit that I do not understand why a change in suffixcmp()'s
> behavior is needed.

I made the suggestion only because I do not understand why the
function should order "f" and ".txt" in the

	"f" < ".txt"

order. Even worse, the other function postfixcmp() orders them the
other way around.

If -1 returned from the function were an indication of error "The
string does not even have that suffix", then I would have been a bit
more sympathetic, and its current behaviour in that case could be
argued as a special case of the broader return value "non-zero (from
the ordinary strcmp() return codeflow) means the string does not
have that suffix and zero means the string ends with the suffix".

But then, a function that pretends to be for ordering comparison,
with a name that ends with cmp(), and then declaring that "no, this
is not for ordering; the sign of the result does not matter--what
only matters is if it returns zero or non-zero", feels quite
schizophrenic, at least to me.

And my earlier suggestion to change the return value *is* not a
right change.  It still keeps the pretense of comparison for
ordering (i.e. ...cmp() name), while returning a value that cannot
possibly be used for ordering.

So I think the right patch should make the function like this:

	int has_suffix(const char *str, const char *suffix)
        {
        	int len = strlen(str);
                int suffix_len = strlen(suffix);
                if (len < suffix_len)
                	return 0;
		return !strcmp(str + len - suffix_len, suffix);
	}
