From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] bulk-checkin: replace fast-import based
 implementation
Date: Thu, 01 Dec 2011 07:46:59 -0800
Message-ID: <7v39d4pa4s.fsf@alter.siamese.dyndns.org>
References: <1322699263-14475-1-git-send-email-gitster@pobox.com>
 <1322699263-14475-6-git-send-email-gitster@pobox.com>
 <CACsJy8D5BqqkXCa7kczcNBxjt=G2d2ZXUToncR2pBGRuZ3gPKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 16:47:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RW8qs-0007CM-AU
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 16:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755032Ab1LAPrF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Dec 2011 10:47:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754976Ab1LAPrD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 10:47:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3666CEB;
	Thu,  1 Dec 2011 10:47:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Fn7YRba778Qy
	BSq820+x3jHyqTI=; b=rzQQg3adjkgPN82sJIEohWMLsgfBO8M9kJOQ1l4LeFFF
	UftYzW2CruzIK1nHVH9su4v3FVUAodAqXp0vI5fCNzL0tvwpvXhsU/9mKyrvPhnP
	445gdj1t3j8BRcS/YDUEUBQJXBaVL+EtWZwlsMwD57PwEK2QZBX9B/clctIVwcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NVfgXI
	Z6mEIhlyh8Ua467Mh/vYIoo0s0vyr/OzJcltEH4f8/6dtll5/UGc6bHxVnFv6Jlj
	RpaX4ajJfEytTQymu4uf/SNqTGVxwjiH2/62RmEszIP7Ydr/fZ7s2bNNvopO6xMk
	Nqud6+9qyjpHFrD3WmcPo6ung9I9YLFKzQbhs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EEE866CEA;
	Thu,  1 Dec 2011 10:47:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5344D6CE8; Thu,  1 Dec 2011
 10:47:01 -0500 (EST)
In-Reply-To: <CACsJy8D5BqqkXCa7kczcNBxjt=G2d2ZXUToncR2pBGRuZ3gPKg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 1 Dec 2011 15:05:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B59A3DB8-1C33-11E1-9707-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186172>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Dec 1, 2011 at 7:27 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
>> @@ -458,11 +459,15 @@ int cmd_add(int argc, const char **argv, const=
 char *prefix)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(seen);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> + =C2=A0 =C2=A0 =C2=A0 plug_bulk_checkin();
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_status |=3D add_files_to_cache(prefi=
x, pathspec, flags);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (add_new_files)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit_status |=
=3D add_files(&dir, flags);
>>
>> + =C2=A0 =C2=A0 =C2=A0 unplug_bulk_checkin();
>> +
>> =C2=A0finish:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (active_cache_changed) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write_cac=
he(newfd, active_cache, active_nr) ||
>
> Also do the same for git-commit, except as-is commit case, for
> updating large files?
>
> update-index should also learn about this,...

I didn't do any of the above in this series and that was on purpose.

Getting plug/unplug (and all the machinery that they are related to) to=
 do
the right thing when they are called is far more important at this stag=
e
than figuring out when it is appropriate to plug and unplug in various
random programs, it is sufficient to have one canonical and simplest
callsite pair as an example in the primary interface to add new objects
(i.e. "git add") for that purpose, and it is not too cumbersome for ear=
ly
adopters to remember using "git add" when adding oddball large blobs
instead of using "commit -a".

In short, I wanted to keep the patch to the minimum to avoid distractin=
g
capable reviewers (which is in short supply these days).

I wouldn't stop you or anybody from preparing a patch series that adds
plug/unplug pairs before the machinery is perfected, so that such an
effort can expose a corner case where the machinery and the API present=
ed
in this series is inadequate and can use improvements. Once the machine=
ry
gets perfected, submit such a patch series to add users that are well
tested.

Thanks.
