From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for commit attributes
Date: Thu, 10 Apr 2014 10:22:38 -0700
Message-ID: <xmqqk3axxfoh.fsf@gitster.dls.corp.google.com>
References: <1397072295-7670-1-git-send-email-diego.lago.gonzalez@gmail.com>
	<CACsJy8BJw3+=vSHzfBYigoK6ejt-DNHJPTcOWS3Nv=zxpF1f7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Diego Lago <diego.lago.gonzalez@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 19:22:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYIgZ-00067f-5s
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 19:22:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758586AbaDJRWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 13:22:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61724 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753322AbaDJRWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 13:22:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D7DC7A4D4;
	Thu, 10 Apr 2014 13:22:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jGJm7AZW0hKso5xXvFuwmJ33oBo=; b=nxFWSa
	mMi14sh+Yn3316jWG8lZBes3O2gFtmLjokZ4BGqS9aRg209xvOyt4OIiPbHTHl42
	R7FPIxkeoVJa6YkBEjsHZnvfJZIl/qOCdWuTb6QNmxdO4Jtf9X8mnEkt1GoV3way
	YG4/Q99OcvzOydI5KPLgwtQG7+A1kOgRDSOcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u2GL/f+cPko9HZTiQ0oIsXk/ZKNToz26
	oe8+RvqBMVkc3y7wKevIVPv0PX3tkynKMMOEGY3CCaUXluYCIQxtKuoaY+b/uH4r
	THCty1O9tALcI4/sAv4cBhbwqqFennRu4oW2MBnOUchMe6KaZ+Gy6avTDNquFZ9l
	wMkzWO6SCuI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8BF1C7A4CF;
	Thu, 10 Apr 2014 13:22:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A3467A4CE;
	Thu, 10 Apr 2014 13:22:40 -0400 (EDT)
In-Reply-To: <CACsJy8BJw3+=vSHzfBYigoK6ejt-DNHJPTcOWS3Nv=zxpF1f7g@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 10 Apr 2014 11:25:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B7EACC66-C0D4-11E3-84E3-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246019>

Duy Nguyen <pclouds@gmail.com> writes:

> If the problem is polluting human eyes, wouldn't it be better to make
> git-log to filter it out? For example, we could tell git that all
> fields (in the message body) that start with X- are "rubbish", so
> instead of showing "X-something: base64 stuff...", it shows
> "X-something: <filtered out>" instead? At least people will see that
> this commit carries human-unreadable stuff.

We had lengthy discussions in early 2010 [*1*].  The whole thread,
at least the whole sub-thread that contains the focused message, is
a required reading to understand where we stand with respect to
"extra headers in commit objects".

"Any additional information about the commit can be added" this
patch implements is exactly the kind of thing we want to avoid,
which made Linus say in an even older discussion [*2*]:

    No "this random field could be used this random way" crud, please.

Even worse, the "--attr" pretends to be opaque by not defining what
each "attribute" really means, but the patch hardcodes arbitrary
rules like "an attribute is unconditionally copied during amends"
and "an attribute cannot be multi-valued", if I read it correctly.

I actually think this "recording information about commits" is
exactly the use-case notes were invented to address, and if it is
found cumbersome to use, the reason why it is cumbersome needs to be
discovered and use of notes needs to be improved.  Hooks and/or a
wrapper around "git commit" to implement their custom workflow may
be involved as part of the solution and "git notes" may need to
learn a new trick or two along the way.

I am not interested in hearing "let's add random crud to commit
object header" before "let's improve notes so that it can be more
smoothly used" is fully explored.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/138848/focus=138892

*2* http://thread.gmane.org/gmane.comp.version-control.git/19126/focus=19149
