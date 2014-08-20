From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v20 43/48] refs.c: move the check for valid refname to lock_ref_sha1_basic
Date: Wed, 20 Aug 2014 14:24:23 -0700
Message-ID: <xmqqy4uisvlk.fsf@gitster.dls.corp.google.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-44-git-send-email-sahlberg@google.com>
	<53BC07FC.8080601@alum.mit.edu> <20140715180424.GJ12427@google.com>
	<CAL=YDWkYAg-0h3ZwiyZGtUHFEv1KEti_uURTwgbZE9xT_P_XSQ@mail.gmail.com>
	<CAL=YDWmc2gkw=8YavWHyLUAD4du7saPrKzPKT+dsCfdZJz1EiA@mail.gmail.com>
	<53F4B642.7020002@alum.mit.edu>
	<xmqqk363t060.fsf@gitster.dls.corp.google.com>
	<53F500E9.6060900@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:24:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKDN0-0003j8-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 23:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752877AbaHTVYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 17:24:35 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65213 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbaHTVYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 17:24:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 897C8328BC;
	Wed, 20 Aug 2014 17:24:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iGlSAclLM7jbSyrmd4AJY5mgvqo=; b=OI/JOH
	s2JUITe4juiLUd8RX2z8qZv6FWbXm4ZGQLAEQ+HD+Tb7r3kVncEz4yUvsO7+BQyq
	Z1TAkq7DPSWYv7TS+O42lM8+kT/yVh+LmR7my39cnoBIIEXHEmS6aEf4UkIITRxT
	bCP0ALBIdEsJdGPHSSKKh9fO6cL7S6A5FrD2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XuVvuOsIrsmIlWAPjPdRiNUr7VdkvRzw
	UZAtM02Hdf4exyulEfSdu6+o6xkXicEiHBghjOoqOFiEx5eEiZHaBm39o+vEMUFP
	+CK4u0Kk16Yy4+X91mUHOCn8r5e4T8Rk2scNoDQV3T7wG5q9vsK1o6puUwV02gjq
	YYfaYDQxWmE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DEA0328BA;
	Wed, 20 Aug 2014 17:24:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 252E1328B6;
	Wed, 20 Aug 2014 17:24:25 -0400 (EDT)
In-Reply-To: <53F500E9.6060900@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 20 Aug 2014 22:11:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5C0C9B56-28B0-11E4-9740-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255589>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 08/20/2014 09:45 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>>> I think we can get away with not including broken refnames when
>>> iterating.  After all, the main goal of tolerating them is to let them
>>> be deleted, right?
>> 
>> Or read from a ref whose name has retroactively made invalid, in
>> order to create a similar but validly named ref to serve as its
>> replacement?  So at least we need to give the users some way of
>> reading from them, in addition to deleting them, no?
>
> The die() error message would presumably include the name of the invalid
> reference.
>
> If we change the rules for reference names and a bunch of names become
> invalid, then it would admittedly be cumbersome to run git N times to
> find the N invalid names.  But if we change the rules, then *at that
> time* we could always build in iteration over broken reference names.
>
> It's not that I have something against building it iteration over broken
> reference names now, as long as it is clearly segregated from "normal"
> iteration to prevent illegal names from getting loose in the code.

Oh, I don't think it is that important for iterator to show broken
ones.  If refs/heads/foo/$brokenname exists but is skipped from any
and all iterations, nobody will get hurt until the end user wonders
where foo/$brokenname went, at which time rev-parse can be used to
grab the value from it before update-ref -d can be used to remove it.

If refs/heads/foo/$brokenname, which is skipped from iterations,
prevents a valid ref refs/heads/foo from getting created, that would
give a bit of surprise to the user who long forgot foo/$brokenname
existed, but the recovery procedure is exactly the same as the case
where he has a branch foo/$koshername and wants to create foo; first
'branch -D' the D/F-conflicting one and then create foo.

So the primary things I care about are when the user has a string
that is the name of an existing misnamed ref, the value of the ref
can be obtained, and the ref can be removed.

Thanks.
