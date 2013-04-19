From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: tighten IS_STASH_LIKE logic
Date: Fri, 19 Apr 2013 10:50:32 -0700
Message-ID: <7v38um2yvr.fsf@alter.siamese.dyndns.org>
References: <1366270717-19929-1-git-send-email-artagnon@gmail.com>
	<7vk3nz4h20.fsf@alter.siamese.dyndns.org>
	<CALkWK0m_Nt8SFdjGKWWHtBJ+HVsk095ukjZ0N=KBt5q+or5XFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 19:50:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTFSK-0001mA-JQ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 19:50:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474Ab3DSRug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 13:50:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64179 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab3DSRuf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 13:50:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A10C2174E6;
	Fri, 19 Apr 2013 17:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1tVcJzGQxVts3Mnj3nf6woCKeyk=; b=sqn3MF
	1Eqy8SIp21es001UloeIWKrkrAKJuehBNcEVDKp1zNz74Kv7pCFXjE0np4r8IA4V
	kVlkkkN/aDCGoNY8UThNpval/Wmbv+J0FInJ9xEEV+s+rG4wwZKIclAFxJclh4ow
	dG6vYLyr2FFcvN19YKXTi24Ka3yGDsiMsVdn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CdYBOuG9mO4dnMoG09f0FeFlYEBC8xPp
	8AdTQYx/FpgDD4CGXoxYYggrFqCBSZb/+fEwb5d6VeCbxkzgPN/HWOyXuFQAVa78
	mZ6O2no6H8eBzcHeHup3/cURF+otG7pm8sHf0j9rRDCDmdWxcYIpY8FwB+vjx1wM
	+Z2OQKnnqxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 955A4174E5;
	Fri, 19 Apr 2013 17:50:34 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02407174E2;
	Fri, 19 Apr 2013 17:50:33 +0000 (UTC)
In-Reply-To: <CALkWK0m_Nt8SFdjGKWWHtBJ+HVsk095ukjZ0N=KBt5q+or5XFQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Apr 2013 11:27:04 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A280F57C-A919-11E2-886C-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221785>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> My patch is not solving an end-user problem.  Think of it as a source
> code comment: to answer the question "what kind of commit does stash
> create make?",

There already is sufficient comment that explains how a stash commit
is constructed, isn't it?

I may have forgotten to say this, but we were helped by the logic
that makes sure we can read what we need to carry out the operation
and nothing more in the then-current (which is the same as current)
code that was written before we added --include-untracked.  If the
check were enforcing that a stash-like must be a two parent merge,
which may have seemed reasonable back when the stash-like logic was
written, it would have been more painful to add three parent
possibility while still allowing people to use different vintage of
Git in the same repository.

Insisting on the i-commit and w-commit to have exactly the same
parent would mean that somebody who wants to improve create-stash
has one less option---even when the easiest and/or cleanest way to
improve create-stash for the particular goal were to record these
two commits based on a different parents, the requirement the patch
is trying to add here will prevent her from doing so and force her
to work around the pointless (read: not necessary when the current
code shows or applies the stash) check.

>> Is it worth it?
>
> Is it worth what?  What are we losing?

The risk of actually closing the door for future developers.  That
is a downside of this patch, if we were to apply it.

And having to spend braincycles to worry about what door we may be
unintentionally closing.  That's a downside of even discussing this
patch.
