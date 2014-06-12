From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Thu, 12 Jun 2014 12:47:30 -0700
Message-ID: <xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:47:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvAyL-00079M-5F
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbaFLTrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:47:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62064 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbaFLTrg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 15:47:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8986B1EBDC;
	Thu, 12 Jun 2014 15:47:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yGPjui8tlc/7TSdsvewC90xa+bo=; b=c2RNas
	WnqcewEWG8JdxRfOoSWTc+veTAHPUZcTW4Qro3fxtLV8fw6Y+je/6Twvb6RpH6Qy
	ACX1FQt7BidkJmoEoP8NHCh5Ic4ukxXBdAKWlyAwc4KiZsxiNpRTo0gm6nl3zTEe
	VNyBgKuAEivkv++GQgjHpAdlAElgsRM2X/vsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b1HArNscA+tTKtgH2sy0O7CkyMHCwP1V
	aMS1inKVfiG+bMpSmTh92dFQQclySkgUi6T1zgkSuC26mZHMWXsHt4goG6CH6cq2
	STDFasLvI4YEbJGG7s80lSMOolIW2gj/PA8YWWCq/fYm1pO8TVX0WXBz90KZMz9I
	KW0RhOEJwPY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7E7581EBDB;
	Thu, 12 Jun 2014 15:47:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 744951EBD5;
	Thu, 12 Jun 2014 15:47:31 -0400 (EDT)
In-Reply-To: <1402525838-31975-1-git-send-email-dturner@twitter.com> (David
	Turner's message of "Wed, 11 Jun 2014 18:30:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 64533B34-F26A-11E3-B2F6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251490>

David Turner <dturner@twopensource.com> writes:

> This issue bit us again recently.
>
> In talking with some colleagues, I realized that the previous version
> of this patch, in addition to being potentially slow, was incomplete.
> Specifically, it didn't handle the case of refs/heads/case/one vs
> refs/heads/CASE/two; these are case clones even though they strcasecmp
> different.

Good catch to realize that two refs that share leading paths that
are the same except for cases are also problematic, but that makes
this feature even less about "case clones", doesn't it?

Also it somehow feels that the patch attempts to solve the issue at
a wrong level.  On a platform that cannot represent two refs like
these (e.g. trying to create "FOO" when "foo" already exists, or
trying to create "a/c" when "A/b" already exists---ending up with
"A/c" instead, which is not what the user wanted to create), would
it be more sensible to fail the ref creation without touching the
users of ref API such as receive-pack?  That way, you would also
catch other uses of refs that are not supported on your system,
e.g. "git branch a/c" when there already is a branch called "A/b",
no?

CC'ing those who are more active in the ref API area recently than I
am for their inputs.
