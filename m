From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is only temporary
Date: Thu, 16 Oct 2014 12:27:49 -0700
Message-ID: <xmqqegu7u85m.fsf@gitster.dls.corp.google.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
	<543E85FA.6050404@xiplink.com>
	<xmqqwq81w8az.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 21:27:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeqiM-0000AG-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 21:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbaJPT1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 15:27:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751874AbaJPT1w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 15:27:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C894917995;
	Thu, 16 Oct 2014 15:27:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U7EckjbOGrrUJXgSzkBxn0XzdhE=; b=DodD5x
	gQoYWqGZX8kF1hQiJuhzNty3762mQcVaCGSrym2TUA/Jb8QfLx8g1nbgxNYiFWUm
	Av8l3KDHcG73IsxPro0yBmZq1fsGOUlcTtSewV7++tqJngJ4fIXDoxAzgw/fnifP
	zYRAgvi8ZyHuqkmR4YpDfmZv6j+Qoyc1/BC+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wd0L7OULB6Evb4IEvuDJbdtTyalfxGJJ
	ajBPqJl3zGx3YWir0Nto4IIJn5pAofi/MPe8NuQKofMMSevDpnsB5cJcrHrhyPDL
	6HYTmRTq2BMt4iGGGwsPVed6GSK1m8X0a89jhkTqPcYa96D12XX2WEFqC7w6RRzP
	SO0gSCcY+7k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF1EE17994;
	Thu, 16 Oct 2014 15:27:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3F47A17993;
	Thu, 16 Oct 2014 15:27:50 -0400 (EDT)
In-Reply-To: <xmqqwq81w8az.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 15 Oct 2014 10:29:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 844FF676-556A-11E4-9CBD-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> I think things would be more understandable if the option was "--dissociate
>> <repository>" and was an explicit alternative to --reference:
>> 	[[--reference | --dissociate] <repository>]
>>
>> I'm still not liking the name "--dissociate" though.  The original suggestion
>> of "--borrow" is better.  Perhaps "--library" or "--local-cache"?  I dunno...
>
> I was not thinking when I originally started the topic with
> "--borrow", until I realized that it would not make much sense,
> primarily because we allow multiple references.
>
> What should this command line do, and how would you implement such a
> behaviour?
>
>     $ git clone \
>         --reference=/local/pool/linux.git \
>         --borrow=../my/neighbour/linux-hack.git \
>         git://git.kernel.org/...../linux.git
>
> With "do the usual --reference thing, but then dissociate the result
> from referents" option, there is no ambiguity and that is why I did
> not go with the "--borrow" option suggested in the original thread.

Another approach we could take is to add --borrow and then forbid
mixing --reference and --borrow on the same command line, until
somebody comes up with an implementation to allow us dissociate from
borrowed repositories while still depending on referenced ones, at
which time we can lift that limitation.

But if that future extension is not going to happen, there is not
much difference.  The end result will be either

 - the one that is very clear to the users that they cannot
   selectively dissociate because there is no such option documented
   (i.e. --reference, --dissociate and no --borrow); and

 - the other one that gives a slight hope to the users that the
   combination might work (i.e. with --reference, --borrow and no
   --dissociate) but refuses to do so when it actually is run.

Between the two, the former might actually be easier to the users to
understand, as it keeps their expectation in line with the reality.

So I dunno.

I certainly am *not* going to do the selective dissociation change
myself.  Do we have a volunteer (hint: this probably does not fall
into "low-hanging fruit" category)?
