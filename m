From: Junio C Hamano <gitster@pobox.com>
Subject: Re: move detection doesnt take filename into account
Date: Tue, 01 Jul 2014 10:08:15 -0700
Message-ID: <xmqq61jhxb0g.fsf@gitster.dls.corp.google.com>
References: <53B105DA.30004@gmail.com>
	<287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
	<xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
	<53B2CE4A.9060509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Elliot Wolk <elliot.wolk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:08:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X21Xl-0003tL-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 19:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758663AbaGARI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 13:08:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53351 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758658AbaGARIY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 13:08:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C167223FD1;
	Tue,  1 Jul 2014 13:08:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xD2bKvODHbrNP1CjQo1eOY0Qnmo=; b=ib7OMT
	Mc06Ro7gtSRgVgHHMbonKmYXpbe1fg18Cum7Uum6jjiz+jP7DHYxYLxjQejoG0Ga
	sFYQCV2cLzbcNCZSXSUFqlabJYqk1MYpz/NZHU9klDtoxni/SzUz7dt0bp2+vJtT
	BlKRwCQiwf+UuexMZgI6wUtFnRLIJKAVRRylE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qrdoKDxaXbEWto3b8IF0ubBWPMMA8hmJ
	R08j4lj781VfSE9YsvvkixVbu3ErnH3tuGwxPbgEHosE/CfBD/lL6LLbecUTMZPD
	s6RscOcLRmBSj1BiPr7AZhlutlE64+siACBXLZopyHrA57gwKNQwNEm0QLWdqAQL
	gPijr/A9pP8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B840223FD0;
	Tue,  1 Jul 2014 13:08:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2BBBB23FC0;
	Tue,  1 Jul 2014 13:08:06 -0400 (EDT)
In-Reply-To: <53B2CE4A.9060509@gmail.com> (Elliot Wolk's message of "Tue, 01
	Jul 2014 11:05:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44CFDFB0-0142-11E4-8684-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252726>

Elliot Wolk <elliot.wolk@gmail.com> writes:

> On 07/01/2014 10:57 AM, Junio C Hamano wrote:
>> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>>
>>> I think it does, but based on filename suffix. E.g. here is a rename of
>>> three empty files with a suffix.
>>>
>>>   3 files changed, 0 insertions(+), 0 deletions(-)
>>>   rename 1.a => 2.a (100%)
>>>   rename 1.b => 2.b (100%)
>>>   rename 1.c => 2.c (100%)
>> This is not more than a chance.
>>
>> We tie-break rename source candidates that have the same content
>> similarity score to a rename destination using "name similarity",
>> whose implementation has been diffcore-rename.c::basename_same(),
>> which scores 1 if `basename $src` and `basename $dst` are the same
>> and 0 otherwise, i.e. from 1.a to a/1.a is judged to be a better
>> rename than from 1.a to a/2.a but otherwise there is nothing that
>> favors rename from 1.a to 2.a over 1.a to 2.b.
>
> thanks for the info!
> then i suppose my bug is a petition to have name similarity instead
> use a different statistical matching algorithm.

[administrivia: please do not top-post on this list]

I didn't think it through but my gut feeling is that we could change
the name similarity score to be the length of the tail part that
matches (e.g. 1.a to a/2.a that has the same two bytes at the tail
is a better match than to a/2.b that does not share any tail, and to
a/1.a that shares the three bytes at the tail is an even better
match).

Oh, and rename basename_same() to something else; currently it is
only used as the "name similarity", and after such a change, it will
stay to be "name similarity" but will not be asking "are basenames
the same?" anymore.

Hint, hint...
