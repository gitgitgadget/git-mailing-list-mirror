From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote: make prune work for mixed mirror/non-mirror repos
Date: Thu, 20 Jun 2013 16:30:58 -0700
Message-ID: <7vhagspdfx.fsf@alter.siamese.dyndns.org>
References: <1371763424.17896.32.camel@localhost>
	<1371766304-4601-1-git-send-email-dennis@kaarsemaker.net>
	<7vppvgpfib.fsf@alter.siamese.dyndns.org>
	<1371769636.17896.44.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 01:31:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpoJp-0007hd-9W
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 01:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965401Ab3FTXbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 19:31:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965307Ab3FTXbD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 19:31:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2CF829E52;
	Thu, 20 Jun 2013 23:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HAePenqsBfjTMVCUOuqKvCmQVos=; b=P0qg+m
	PU6TAmcxCKGawui8SL9+X9jd0B6mtiQxKheXaT/APCgP0EFwbnrXl//DBuOxXY3p
	OV+DZ6rYt+OLEAFL41VGjaqgcrh5GAOkioAYfFDNu/NBWOTdJVw2JpxgqOjcjPJ/
	b0o9n17wpWxOMz5DZYrJouF5FK4C19rJD+JQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DYOAtoXsmdI0nFE8kMdaFHDjreZTMng1
	O5m+lDStOMDH5G8Z7ULO+0yKRN7P5ahW4Nlr6brISen/cDJKs6B2LNF/8JXNdEBb
	Jp+Z8/degFa6ck2Lyc5gYd8B8jlE/5vlO60C2AZdZII/S14IyCA5Gc4Vk1e0XQvO
	3qZeku7t/Qg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8780E29E4F;
	Thu, 20 Jun 2013 23:31:01 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0470829E49;
	Thu, 20 Jun 2013 23:30:59 +0000 (UTC)
In-Reply-To: <1371769636.17896.44.camel@localhost> (Dennis Kaarsemaker's
	message of "Fri, 21 Jun 2013 01:07:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 77004D6C-DA01-11E2-AAC8-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228559>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

>> Going back to your original example:
>> 
>>     [remote "origin"]
>>             url = git://github.com/git/git.git
>>             fetch = +refs/*:refs/*
>>             mirror = true
>>     [remote "peff"]
>>             url = git://github.com/peff/git.git
>>             fetch = +refs/heads/*:refs/remotes/peff/*
>> 
>> Wouldn't you obtain "refs/remotes/github/html" from your "origin"
>> via "git pull origin"?  What happens to your local copy of that ref,
>> when it goes away from the origin and then you try to "fetch --prune
>> origin" the next time with this patch (and without this patch)?
>
> git pull origin gives me refs/html in this case.

Maybe there is a miscommunication.

	$ git ls-remote git://github.com/git/git.git | grep remotes/

shows that that repository, your origin, has refs/remotes/github/html

And you have remote.origin.fetch = +refs/*:refs/* in your local
repository.  So that ref will come to your local repository under
the same name, i.e. refs/remotes/github/html, no?  Not as refs/html.

So this answer

>> What if you had this instead of the above version of remote.peff.*?
>> 
>>     [remote "peff"]
>>             url = git://github.com/peff/git.git
>>             fetch = +refs/heads/*:refs/remotes/github/*
>
> That doesn't change anything.

cannot be correct.  You fetch from your origin and then its
refs/remotes/github/html *will* want to come to your local
repository and be stored there.  If Peff has html branch in that
hypothetical configuration, you fetch from him and his html branch
(i.e. refs/heads/html from his point of view) will want to replace
your local refs/remotes/github/html.  Or Peff may not have html
branch.  The point is that you cannot tell by only looking at your
local ref namespace and what "origin" has.

> Yeah, I'm starting to think this is not such a good idea. How about plan
> B: issuing a warning when adding a remote with a refspec that also
> matches another remote's refspec?

Surely that will make things safer.

> Or plan C: add a per-remote pruneIgnore setting that in this case I
> could set to refs/tags/* refs/remotes/* as I know it's correct? Could
> even be combined with plan B.

As I already said "I dunno", I am not sure if it is worth the effort
to support overlapping RHSs of fetch refspecs, so between B and C, I
would vote for B.
