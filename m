From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable clone
Date: Sat, 05 Mar 2016 10:40:01 -0800
Message-ID: <xmqqk2lgvke6.fsf@gitster.mtv.corp.google.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	<xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 19:40:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acH7c-0003t4-95
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 19:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbcCESkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 13:40:08 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65204 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750717AbcCESkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 13:40:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 813F54A11D;
	Sat,  5 Mar 2016 13:40:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DjXRKdgmTlnqq4/p4eW6Ur0qq5A=; b=BDvSZC
	HKTINmC7jB5TiFv73LOX0DkI5n9Gap88aj4QTbzaWeknlTKj9Kyf8muUkPoN7lig
	Wdmr1wM317MZ3H1JoOAekQHmz8v7C8Z+XDDkZ5lw0d4r9jDfKZujH8Wqz3Tf/kiS
	dE1lL6NQfMY1gXn3lkdLjxGgN5jTe7RIKUyO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s3M9KY27FLUULCfSj3yJCdcy8iNI8V1H
	IPfmSqznMh6JGpOa3ZfPpN1LL6iCtQCFSZQUS5zJ9BU4eCgj0lhsRznF/wCxyFQ0
	ky7nJ67RYB9dfgUhGOrZih+68CBgVYSt8gNYXYpAPTEMgLgaaWaMy61o7BfK7z85
	9m5yVk8j5YQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7788C4A11C;
	Sat,  5 Mar 2016 13:40:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 778074A11A;
	Sat,  5 Mar 2016 13:40:03 -0500 (EST)
In-Reply-To: <xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 05 Mar 2016 10:31:50 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC9DBFCA-E301-11E5-A68D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288318>

Junio C Hamano <gitster@pobox.com> writes:

> So what remains?  Here is a rough and still slushy outline:
>
>  - A new method, prime_clone(), in "struct transport" for "git
>    clone" client to first call to learn the location of the
>    "alternate resource" from the server.
>
>    ...
>    - The format of the returned "answer" needs to be designed.  It
>      must be able to express:
>
>      - the location of the resource, i.e. a URL;
>
>      - the type of resource, if we want this to be extensible.  I
>        think we should initially limit it to "a single full history
>        .pack", so from that point of view this may not be absolutely
>        necessary, but we already know that we may want to say "go
>        there and you will find an old-style bundle file" to support
>        the kernel.org CDN, and we may also want to support Jeff's
>        "split bundle" or Shawn's ".info" file.  A resource poor
>        (read: personal) machine that hosts a personal of a popular

Sorry for a typo: s/of a/fork &/;

>        project might want to name a "git clone" URL for that popular
>        project it forked from (e.g. "Clone Linus's repository from
>        kernel.org and then come back here for incremental fetch").
