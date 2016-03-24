From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-apply does not work in a sub-directory of a Git repository
Date: Thu, 24 Mar 2016 09:29:54 -0700
Message-ID: <xmqqd1qjalfh.fsf@gitster.mtv.corp.google.com>
References: <CA+DCAeQQQH59Lb43Y4Bi1xktPNoODV11KkUBbKNG1OZ7mDb-UQ@mail.gmail.com>
	<CAGZ79kYmoKX1w5X8jE5_yGb3VKricHEwxAianTyt4VUd71qH-A@mail.gmail.com>
	<CACsJy8DCk5YintK3PoO1BWdNmsiSLpAcGL4pU7QgNEG6S41CsQ@mail.gmail.com>
	<xmqqbn65dxtl.fsf@gitster.mtv.corp.google.com>
	<xmqqlh59cexj.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Mehul Jain <mehul.jain2029@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:30:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj895-0001yx-0B
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283AbcCXQ37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 12:29:59 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64364 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751834AbcCXQ35 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 12:29:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B10FC4B457;
	Thu, 24 Mar 2016 12:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4xI5HcJ5sKZeLst+MZ6tNk1bBaY=; b=JklCv9
	budqseoRWxBwOBaWEgVyBxVVaGBZbtCC0Q8G4kQfROY7JUs82RFoN+Y4HdcYyLkt
	1210T8tuFOn/SORvpEU0wIe5GGKXQe00XRqO4GdikCSwHSj0Yz9lMMl9Rpp5ofKl
	we/G5dQdt48x38pQRozLrI70ITiMcoaOJjH9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r4InJwYJAnhXt9J4tJAeft8fyJOCF5uh
	AfeP1Kjj6wwbNrdIefEvrUNKWagrvsYWY5A3llW26EYa2t4jCTut+1Jnt1qa2HG4
	0Exh00eWD2FdN3UHmfuWsaq4FQPLnMrPvDybvyYYn5Oj/sPOudNGgqvkxdxnxJLG
	lKAQM+ero04=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A7F064B456;
	Thu, 24 Mar 2016 12:29:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 07C8D4B453;
	Thu, 24 Mar 2016 12:29:55 -0400 (EDT)
In-Reply-To: <CACsJy8CTix-ZwN04MwYTB+JEtDCV27QVf7_0vWmhUSVCwU29Jg@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 24 Mar 2016 17:49:05 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A4D98996-F1DD-11E5-BD26-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289759>

Duy Nguyen <pclouds@gmail.com> writes:

>> The include/exclude mechanism does use wildmatch() but does not use
>> the pathspec mechanism (it predates the pathspec machinery that was
>> made reusable in places like this).  We should be able to
>>
>>     $ cd d/e/e/p/d/i/r
>>     $ git apply --include=:/ ../../../../../../../patch
>>
>> to lift this limitation.  IOW, we can think of the use_patch() to
>> include only the paths in the subdirectory we are in by default, but
>> we can make it allow --include/--exclude command line option to
>> override that default.
>
> Interesting. Disabling that comment block seems to work ok. So
> git-apply works more like git-grep, automatically narrowing to current
> subdir, rather than full-tree like git-status.

We used to have one argument when choosing between "limit to cwd" vs
"work on full-tree" defaults, i.e. "a full-tree thing can easily be
limited to cwd by passing '.' as a pathspec, but limited-to-cwd thing
cannot be widened" before we introduced the magic "full-tree" pathspec.

This "limit to cwd" behaviour of "git apply" predates that by
several years.

> git-apply.txt should
> probably mention about this because (at least to me) it sounds more
> naturally that if I give a patch, git-apply should apply the whole
> patch.

Yes, documentation update is necessary.

> We probably should show a warning if everything file is filtered out
> too because silence usually means "good" from a typical unix command.

We should give an informational message if _anything_ is filtered
out, I would say.
