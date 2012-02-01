From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't search files with an unset "grep" attribute
Date: Wed, 01 Feb 2012 00:01:41 -0800
Message-ID: <7vhazb3rtm.fsf@alter.siamese.dyndns.org>
References: <7vy5sy8e0y.fsf@alter.siamese.dyndns.org>
 <1327359555-29457-1-git-send-email-conrad.irwin@gmail.com>
 <7vaa5d4mce.fsf@alter.siamese.dyndns.org>
 <20120125214625.GA4666@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 01 09:01:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsV8Y-00026l-GK
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 09:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab2BAIBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 03:01:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40233 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753558Ab2BAIBo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 03:01:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 73C7B3071;
	Wed,  1 Feb 2012 03:01:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DKVTCvZHspKvPrtaWJ0rY4f1XUU=; b=V1/f1G
	4NS7afWYJns1Gg5TXIgmKNAJu+2+b1ifLAt+szCkRL+mHyM/6JTXHNe5Zm4iYcVU
	Q6nzViHfZcl5/9xmD7pJpcE9vJc4hcky4zls6uBcmoyn1ZRsaJJgnP/onN6wO2vD
	7qS8CmxLepqlgT+MsWadOmsVtAFSom/n7Fe2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K5e3TvUYS+/5mlxOgBky2q5N6gqyYV3Y
	p2ATOQ25/kFhgU3X9lmenO3AVyBImNVDpkFDXAay54O7dfcsusBuoHEOdX1SsK+e
	uAHGMKNl7t1iP2wbSMB4QoF3I0F+plfKUeUWYE3BPrx70JWl0X3s4EqgSFcZiNQU
	sP7hBrMwb7k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B49D3070;
	Wed,  1 Feb 2012 03:01:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC7C2306F; Wed,  1 Feb 2012
 03:01:42 -0500 (EST)
In-Reply-To: <20120125214625.GA4666@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 25 Jan 2012 16:46:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FA8750D0-4CAA-11E1-9EF3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189501>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 23, 2012 at 10:59:45PM -0800, Junio C Hamano wrote:
>
>> Conrad Irwin <conrad.irwin@gmail.com> writes:
>> > I used to use this approach, hooking into the "diff" attribute directly to mark
>> > a file as binary, however that was clearly a hack.
>> 
>> After thinking about this a bit more, I have to say I disagree that it is
>> a hack.
>
> I kind of agree.
>
> The biggest problem is that the name is wrong.  The "diff.*.command"
> option really is about generating a diff between two blobs of a certain
> type. But "diff.*.textconv" and "diff.*.binary" are really just
> attributes of the file, and may or may not have to do with generating a
> diff. Ditto for diff.*.funcname, I think.
>
> You argue, and I agree, that if we are talking about attributes of the
> files and not diff-specific things, then other parts of git can and
> should make use of that information.
>
> So if this was all spelled:
>
>   $ cat .gitattributes
>   *.pdf filetype=pdf
>   $ cat .git/config
>   [filetype "pdf"]
>           binary = true
>           textconv = pdf2txt
>
> I think it would be a no-brainer that those type attributes should apply
> to "git grep".

I think this discussion has, instead of forking into two equally
interesting subthreads, veered to a more intellectually stimulating
tangent and we ended up losing focus.

Regardless of what to do with "I do not want to grep in these types of
files" and "I want textconv applied when grepping in these types", which
would be new attributes to implement two new features, I would like to see
us first concentrate on fixing the "binary" issue.  When somebody tells us
"Your autodetection may screw it up, but this file is binary; just show
'Binary files differ.' when comparing." with "-diff" (or "binary"), we
should honor that when "git grep" decides if it should take the 'Binary
file matches' codepath.  We currently do not, and it clearly is a bug.

This is especially made somewhat urgent because I do not want a half-baked
"two pathspecs" approach that only "git grep" knows about when we add the
support for "git grep --exclude-path=...".

We should have to teach the underlying machinery that matches pathspec
about negative pathspec entries only once. After we have done so, all the
callers, not just "git grep", should be able to take advantage of the
change by just learning to place negative pathspec entries in the "struct
pathspec" they pass to the machinery.  Doing anything else will lead to
madness of adding ad-hoc "here we should further filter with the other
negative 'struct pathspec'" in each and every application.

But I suspect that it would not materialize anytime soon.  And I also
suspect that the correct handling of 'Binary file matches', which is a
pure bugfix, should solve the original issue started these threads 90% in
practice.
