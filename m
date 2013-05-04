From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] fast-export: don't parse all the commits
Date: Sat, 04 May 2013 12:22:27 -0700
Message-ID: <7vli7uwnws.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-4-git-send-email-felipe.contreras@gmail.com>
	<7vd2t7ybin.fsf@alter.siamese.dyndns.org>
	<CAMP44s09KqFuXPf=3qG42jzChnNBoiXdStME6Ga7EzY7uwF88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 21:22:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYi2g-0002bM-9r
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 21:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab3EDTWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 15:22:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188Ab3EDTWa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 15:22:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF37E1CF20;
	Sat,  4 May 2013 19:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DN+fvt3r81Jw+NWxvcvIjmKov7M=; b=iPLdW4
	K/mt1Gz4S7fACBzoYsPufOQA5NG7x1w6OTUbpigA32Bggy/ExRXCvFvBw1zIIEuE
	aELNOYFIZ7O0vLCwMSxGl1tIUSja40PaXPWEIkonL5VPO987JHfG27Du8HbPTARl
	w1zuVk3cfrCAe0gPM14Vi/iC74nomIisksyn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QxNcuMbRgjku4Av4Z++rcOaSNRnDrWA0
	8Fv5844UnOIU3qpRlb2WJpKnCb4qV4uRe6nQmbdX6kZ8AzftMjdWo3MofGZZ48cx
	ceEYX1bx8DXahdPa15GlUuyln/XKWRosnIxAGcCFLwTPwWh1INY9lDOhVp/Fjmtu
	5L7VCRRS0Tw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A69FC1CF1E;
	Sat,  4 May 2013 19:22:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 289411CF1D;
	Sat,  4 May 2013 19:22:29 +0000 (UTC)
In-Reply-To: <CAMP44s09KqFuXPf=3qG42jzChnNBoiXdStME6Ga7EzY7uwF88Q@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 3 May 2013 19:06:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5FDE12E-B4EF-11E2-86DD-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223372>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> This updates the parse_object() moved by the previous patch. At this
>> point in the codeflow, unlike the original, we already _know_ the
>> object must be a commit; wouldn't an equivalent of:
>>
>>         object = &(lookup_commit(sha1)->object)
>>
>> be more correct here?
>
> Maybe, if we want to run some extra code we don't care about.
>
> The only actual difference is that object->type will be OBJ_COMMIT,
> ...

The reason to prefer lookup_commit() over lookup_unknown_object() is
primarily that we allocate the storage for known type, not union,
out of the allocation pool (alloc.c) for the known type.  Also we
mark the result with the type so that we can catch mistakes in data
when later code somehow expects an object with the same object name
to be of different type; while the latter is a good safety measure,
I do not think it matters that much in this codepath. The former is
more important in general.
