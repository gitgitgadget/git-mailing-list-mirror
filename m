From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/15] read-cache: free cache entry in add_to_index in case of early return
Date: Sun, 22 Mar 2015 12:11:19 -0700
Message-ID: <xmqqa8z4dezs.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-4-git-send-email-sbeller@google.com>
	<xmqq1tkjc9g6.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYVWUofm+Hc2tWv8vLBxc01HqCGM=efYyb0jdGB-64zBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:11:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZlHS-00011c-Q1
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 20:11:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbCVTLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 15:11:22 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61402 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751893AbbCVTLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 15:11:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 08E0041A7C;
	Sun, 22 Mar 2015 15:11:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+HHHUM0lLWs3eCJH0f5eB1kBt7E=; b=d/T/WW
	tY8OJp4wr/GihK3VCys3l9q3HMYD1PVxdz8qOOfq3bg9QCaQWgLwam/mGfClWy44
	1Na4qYqIv3sbCXUAEUFWF2Ui37dsDqqJo3FXfdoIThg0HcLp/qLWHfNB+UkjnUK6
	b3yr/mwuq44jIIvB9WRCq6QlXFdiaDbkBvw7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c5BbEKXr/V5419uPA0boytsIerhlHDAs
	zAg0qOlUCaa7gjWOG0hoLuv+RksKUPYtxzeCiBZlDio49OyuhxhZH4dCB+ofvEFI
	AfuSDXP3wqP8eJuV53T2pSGuR7aWQI7Em2MHA3eELO30FKY0w+3xAefHdnoWiL0H
	r2/aJsjU/V4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0080441A7A;
	Sun, 22 Mar 2015 15:11:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DCD841A79;
	Sun, 22 Mar 2015 15:11:20 -0400 (EDT)
In-Reply-To: <CAGZ79kYVWUofm+Hc2tWv8vLBxc01HqCGM=efYyb0jdGB-64zBg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 Mar 2015 22:10:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 393BF3E6-D0C7-11E4-B843-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266083>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Mar 20, 2015 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> This frees `ce` would be leaking in the error path.
>>
>> At this point ce is not yet added to the index, so it is clear it is
>> safe to free it---otherwise we will leak it.  Good.
>>
>>> Additionally a free is moved towards the return.
>>
>> I am on the fence on this one between two schools and do not have a
>> strong preference.  One school is to free as soon as you know you do
>> not need it, which is a valid stance to take.  Another is, as you
>> did, not to care about the minimum necessary lifetime of the storage
>> and free them all at the end, which is also valid.  Technically, the
>> former could be more performant while the latter is easier on the
>> eyes.
>
> I only recall to have seen the latter school so far, which is why I
> made the change in the first place assuming the school of freeing
> ASAP has no strong supporters inside the git community.
>
> I can resend the patch dropping the reordering, if you prefer.

I already said that I do not have a preference ;-)

Will queue 3/15 as-is, drop 2/15 and wait on 1/15.
