From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] fetch/push: allow refs/*:refs/*
Date: Wed, 22 Aug 2012 04:28:47 -0700
Message-ID: <7v7gsrb1xs.fsf@alter.siamese.dyndns.org>
References: <1345484397-10958-1-git-send-email-gitster@pobox.com>
 <1345484397-10958-2-git-send-email-gitster@pobox.com>
 <50332E2D.2070602@alum.mit.edu> <7vpq6kdu31.fsf@alter.siamese.dyndns.org>
 <50348C97.4040606@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 22 13:28:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T497J-0008NT-Lv
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 13:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311Ab2HVL2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 07:28:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab2HVL2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 07:28:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB0168026;
	Wed, 22 Aug 2012 07:28:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DBCQZg8PNHpWVzPPpnxybBlmpI4=; b=jdqYnJ
	sKFGe+pgT0QEnzge4JPT1UE7E/Kuj6jd+9LiscmmZWV3BVqRJEpNP5OArL2Ix/by
	YU10q7msbGyCmJDguK+W52QRLuSy3Y5u9WClzLDxWK51lohKhziXA4Oj1qDXQQU0
	UFTJWq1DGd4GDzijIXd+ZLVjP1xlo03VxwPC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ICj3YFiZH5w63sF5iwz1Q9KGAvJX9FoO
	9lWUP1HEDwgkxVR8IbcRaS8LCNUmxI3XWf+kgRGUwagcCCIoHAp/w86HI1lqYjM1
	e1BYl9jc/iFENJ/zFVCOlkCXncrtbjqo1UGBizytM0OcGKrA1rTaq/frMe+Wy6IM
	707C99A88Ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C84C98025;
	Wed, 22 Aug 2012 07:28:49 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C3418024; Wed, 22 Aug 2012
 07:28:49 -0400 (EDT)
In-Reply-To: <50348C97.4040606@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 22 Aug 2012 09:39:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B059DE2-EC4C-11E1-81D7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204012>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> The remote side can also throw phony "I have this object, too, but
>> not at a particular ref---this entry is only to let you know I have
>> it, so that we can negotiate minimal transfer better" entries that
>> are labelled with strings that do not begin with "refs/" and do not
>> pass check_refname_format() (and because they are not refs, they do
>> not have to pass the test) at us, and we do not want to filter them
>> out in this function.  But we do not want anything that is malformed
>> under "refs/".
>
> Thanks for the explanation.  I'm trying to dig some more into this so
> that I can add some documentation, because this area of the code is
> rather obscure.
>
> Here is the loop being discussed, in full (from builtin/fetch-pack.c,
> filter_refs()):
> ...
> Empirically (determined by instrumenting the code and running the git
> test suite):
>
> * The first branch of the if statement is only executed for ref->name of
> the form "refs/tags/foo^{}" for various "foo".

We do not want "fetch --mirror" and "refs/*:refs/*" to add a tag
whose name is "foo^{}" to us.

> * The second branch of the if is *never* executed.

I am not familiar with (nor particularly interested in) the "args.depth"
code, so I have no comment on this part offhand.

> * The third branch is invoked for various reference names under "refs/"
> (including oddballs like "refs/for/refs/heads/master", "refs/stash",
> "refs/replace/<SHA1>"), and also for "HEAD".
>
> This doesn't quite agree with your explanation, because the phony refs
> (at least in this dataset) *do* start with "refs/" and they *are* trashed.

Try fetching from a repository that has an alternate, and you would
see those ".have" phoney refs.

But yes, they are trashed as well, as they are not likely to match,
so you are right; the ".have" entries are red-herring (they have
already been used before the caller calls this function for their
sole purpose of marking the other side has).
