From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/6] refs.c: remove unlock_ref and commit_ref from write_ref_sha1
Date: Fri, 23 Jan 2015 16:39:24 -0800
Message-ID: <xmqqppa5nhab.fsf@gitster.dls.corp.google.com>
References: <54C0E76D.5070104@alum.mit.edu>
	<1422043442-30676-1-git-send-email-sbeller@google.com>
	<1422043442-30676-6-git-send-email-sbeller@google.com>
	<xmqq61bxoxs8.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYPCFBNNkYV0C_XeCEaqfz=Mh3Zy=L-vAWsmZBFgebqNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Loic Dachary <loic@dachary.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 01:39:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEol9-0000Nn-8W
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 01:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbbAXAj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 19:39:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57591 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750960AbbAXAj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 19:39:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 04E7932A5F;
	Fri, 23 Jan 2015 19:39:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3y2YO1eWzHYwYYwIXqp6uGwUQKQ=; b=UEpyX5
	M31vxPlevbYoTOimX0iqBWCKJjBi0K2rqAWjTF39jX2aebsXCe9CvtNNcKyAPwqw
	KeY0PVJN6IbKqa2xZsnG+Jg7xaI80+mrxxhT1ZjLqYItrR49a1IKk24MGfhYERO4
	o6g4ypcr2mliJwLJIN1qoejbe34V4ycL3EmUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QR1j2wmt4nMZ9YGerXC+kuFmcOO7gSwA
	A5FfpdINJTkLlYl9AQ8cDG13bUTOFcYDtMYEWUCWB0paKrDH1JP6GwSdXpqMlOHd
	JADw/HOfeFgZu4VwyM+c5orS/6g1YzxKkcHlXCUxL3C9VwK2eY81X4P/1HhCyuFr
	u7xNdBS/iaE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEB4032A5E;
	Fri, 23 Jan 2015 19:39:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 61C3932A5D;
	Fri, 23 Jan 2015 19:39:25 -0500 (EST)
In-Reply-To: <CAGZ79kYPCFBNNkYV0C_XeCEaqfz=Mh3Zy=L-vAWsmZBFgebqNQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 23 Jan 2015 16:22:57 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 726C03B0-A361-11E4-812A-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262981>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jan 23, 2015 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> -static int commit_ref(struct ref_lock *lock)
>>> +static int commit_ref(struct ref_lock *lock, const unsigned char *sha1)
>>>  {
>>> +     if (!lock->force_write && !hashcmp(lock->old_sha1, sha1))
>>> +             return 0;
>>>       if (commit_lock_file(lock->lk))
>>>               return -1;
>>>       return 0;
>>> @@ -2879,10 +2882,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>>       }
>>>       lock->force_write = 1;
>>>       hashcpy(lock->old_sha1, orig_sha1);
>>> -     if (write_ref_sha1(lock, orig_sha1, logmsg)) {
>>> +     if (write_ref_sha1(lock, orig_sha1, logmsg)
>>> +         || commit_ref(lock, orig_sha1)) {
>>> +             unlock_ref(lock);
>>
>> This is not a new problem, but the two lines in pre-context of this
>> patch look strange.
>
> Which (not new) problem are you talking about here? Do you have
> a reference?

These two lines in pre-context of the hunk:

>>>       lock->force_write = 1;
>>>       hashcpy(lock->old_sha1, orig_sha1);
