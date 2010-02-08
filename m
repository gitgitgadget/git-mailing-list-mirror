From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Mon, 08 Feb 2010 14:21:26 -0800
Message-ID: <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org> <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org> <7vtytrih7b.fsf@alter.siamese.dyndns.org> <7vvde7h1mn.fsf@alter.siamese.dyndns.org> <20100208213256.GA470@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 23:21:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NebzE-0002BG-0k
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 23:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab0BHWVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 17:21:41 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab0BHWVj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 17:21:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDB4E98A37;
	Mon,  8 Feb 2010 17:21:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=991uYK7UwdCi6afOZt2VLK58lNk=; b=DDXLt4
	Tf7pbypstfXfmXKyUwZcDK9kE1vWSBwF+RKrw6fixP1T3wi05AFw0JFs+oiEy4Jl
	A52tN2EXqLYLz6WiNLjeVM9izHFij38ghJ5mOMYqHW6SsOolkuSvS3AkKtY0cGtZ
	u2WfT/rW8CwZufXxk6QXIwdVlXEWXvYqF2EMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wXotaZBVUujBffBjS1Tddag9uvYTZI/+
	3PlmXvdfG3fFk9QWJFsYWjfVqDGE2Wy7qjEvDJKld1GoDRPflf75rg2wKWOylARW
	VwGrPTbyCTc+tuOAPzXuiARujgGKRwOToNQWdAyp0Wp7LuEA7TeJxP9+NXrpnHqX
	vH3qf/BTAxk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A849A98A31;
	Mon,  8 Feb 2010 17:21:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4064D98A0D; Mon,  8 Feb
 2010 17:21:28 -0500 (EST)
In-Reply-To: <20100208213256.GA470@coredump.intra.peff.net> (Jeff King's
 message of "Mon\, 8 Feb 2010 16\:32\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 50589AA8-1500-11DF-990E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139326>

Jeff King <peff@peff.net> writes:

> ... Which means that the original porcelain
> format was perhaps not very well thought-out.
> ...
> now whether to fix it and break compatibility, or leave it broken...

I think the purpose of the patches that started this thread was to admit
that 1965ff7 (add --porcelain option to git-push, 2009-06-22) was not well
thought out, and to break compatibility to fix it.

Having said that, I would say that what 1965ff7 specified was only these
two:

    = TAB refs/heads/master:refs/heads/master TAB [up to date]
    - TAB :refs/heads/foobar TAB [deleted]

so everything else that do not match this pattern is a fair game, most
importantly, the line that begins with "To" would not be mistaken with
this pattern, I think.

>> @@ -1071,7 +1071,8 @@ int transport_push(struct transport *transport,
>>  		}
>>  
>>  		if (!quiet && !ret && !refs_pushed(remote_refs))
>> -			fprintf(stderr, "Everything up-to-date\n");
>> +			fprintf(porcelain ? stdout : stderr,
>> +				"Everything up-to-date\n");
>>  		return ret;
>>  	}
>
> This one, on the other hand, seems to me to be just noise. What does a
> --porcelain caller learn by seeing "Everything up-to-date" that it did
> not already know from seeing the list of refs?

I do not care too much about this hunk either way.  We could leave it as
is, as we will be giving some other stuff to the standard error stream
without squelching anyway, even with the three-patch series.  We could
squelch only this message, but it is dubious what it is buying us.  If you
forced me to decide, I would probably say "let's just drop this hunk and
keep the code as-is".

As to the exit status, do you have any thoughts, by the way?

I am not convinced that it would be necessary nor even a good idea to make
it behave inconsistently between the normal case and Porcelain case, only
to make it easier to special case the "remote side would reject due to
non-fast-forward" failure mode (iow, even if the calling script knows that
it would fail due to non-fast-forward but otherwise everything else would
be fine, what good would it do?)
