From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Fix path prefixing in grep_object
Date: Mon, 26 Aug 2013 10:26:17 -0700
Message-ID: <xmqqbo4kicsm.fsf@gitster.dls.corp.google.com>
References: <1377394558-371-1-git-send-email-hordp@cisco.com>
	<CABURp0qG7Nnjpp17MAO7Ltwf51EsswZ3GcT-qyt14Vs1tc9pGw@mail.gmail.com>
	<xmqqa9k6moif.fsf@gitster.dls.corp.google.com>
	<20130825042314.GE2882@elie.Belkin>
	<xmqqk3jal4t7.fsf@gitster.dls.corp.google.com>
	<xmqqfvtwkjp8.fsf@gitster.dls.corp.google.com>
	<CABURp0oGMTEgX3TKKEMAOxe6T0=uij+bAyc+5u0x_UHwEPo3CQ@mail.gmail.com>
	<xmqqr4dgifp5.fsf@gitster.dls.corp.google.com>
	<CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0Yc-000516-MW
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043Ab3HZR0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:26:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43428 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902Ab3HZR0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:26:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 022803BF0E;
	Mon, 26 Aug 2013 17:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6DNL8eF+ainc5n86N3CKvQv97Jg=; b=bL1QWG
	6bksA3CDZRdLf2aAsPOBpGa8tdxnJ5fQnb3wJHPS1LfsCx4mALgtMNHPBTqS816c
	l2JpwTRGgJxZUQOXNdKGBa7gtBKvxLhzpoJHjIm3Y6NO4TMgzrS6W/POCpzWQYQK
	haASd4rKnPKyCuGDIylRvVO2uvOE8lDk6sQKI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XHGw6MqRs4T6avbsQEf91dlK60yMmaCK
	HkhB9IlVB/EEKwgNNDlN1fw0ydEdNR+VT8tUnR8G+LNkmQC7BWf2Q7f6R6lXSQH5
	d/p36e01PIGYJdzfFQVPNVgOauOEsZrRrOVcxaxGUzKFxhbMtVjY5WyCqrN8yXuY
	i1OsUD6XAZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA29B3BF0D;
	Mon, 26 Aug 2013 17:26:19 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5589F3BF02;
	Mon, 26 Aug 2013 17:26:19 +0000 (UTC)
In-Reply-To: <CABURp0odEGgZO1yWFgXS+akPb4wJHiTLoQcmqBd00oYnPZ77vA@mail.gmail.com>
	(Phil Hord's message of "Mon, 26 Aug 2013 12:49:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9EC0008E-0E74-11E3-92EE-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233008>

Phil Hord <phil.hord@gmail.com> writes:

>> If your justification were "above says 'there may be a readon why
>> the user wanted to ask it in that way', i.e. 'find in this tree
>> object HEAD:some/path and report where hits appear', but the reason
>> can only be from laziness and/or broken script and the user always
>> wants the answer from within the top-level tree-ish", then that
>> argument may make some sense. You need to justify why it is OK to
>> lose information in the answer by rewriting the colon that separates
>> the question ("in this tree object") and the answer ("at this path
>> relative to the tree object given").
>>
>> Whether you rewrite the input or the output is not important; you
>> are trying to give an answer to a different question, which is what
>> I find questionable.
>
> Ok, so if I can summarize what I am inferring from your objection:
>
>  1. The (tree-path, found-path) pair is useful information to get back
> from git-grep.

At least that was the intent. I can be persuaded that your change
will not break anybody if you successfully argue that it is not a
useful information, though.

>  2. A colon is used to delimit these pieces of information, just as a
> colon is used to delimit the filename from the matched-line results.
>
>  3. The fact that the colon is also the separator used in object refs
> is mere coincidence; the colon was _not_ chosen because it
> conveniently turns the results list into valid object references.  A
> comma could have been instead, or even a \t.

Not necessarily.  If the user is asking the question in a more
natural way (I want to see where in 'next' branch's tip commit hits
appear, by the way, I know I am only interested in builtin/ so I'd
give pathspec as well when I am asking this question), the output
does give <commit> <colon> <path>, so it is more than coincidence.

I do not think it is worth doing only for this particular use case,
but it might be a good change to allow A:B:C to be parsed as a
proper extended SHA-1 expression and make it yield

	git rev-parse $(git rev-parse $(git rev-parse A):B):C

Right now, "B:C" is used as a path inside tree-ish "A", but I think
we can safely fall back, when path B:C does not appear in tree-ish
A, to see if path B appears in it and is a tree, and then turn it
into a look-up of path C in that tree A:B.
