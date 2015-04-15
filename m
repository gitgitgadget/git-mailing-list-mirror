From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Odd broken "--date=now" behavior in current git
Date: Wed, 15 Apr 2015 10:04:55 -0700
Message-ID: <xmqqzj69l3uw.fsf@gitster.dls.corp.google.com>
References: <CA+55aFxvcN8Dz-t6fi6etycg+AiyR0crXv5AcfCdv8ji-iNBpw@mail.gmail.com>
	<xmqqzj6ayp3p.fsf@gitster.dls.corp.google.com>
	<20150415072223.GA1389@flurp.local>
	<CA+55aFwbEnneEvUDhxGaWw=fSwY2WbtGy6Uc3aQzpiUY6GH1uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 15 19:05:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiQkU-0001ze-6H
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 19:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbbDORFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 13:05:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755851AbbDORFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 13:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 208E646512;
	Wed, 15 Apr 2015 13:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=svbXOCqiEPoc1vGl89hE1Evihio=; b=B+8TWM
	ur16hFin33iSbzAptiAzfb3E5drccsuy3fEt52MqDLFH4pwMhOt+0CkKqpMNpr7J
	9ofBW7St0NI7yQ66toqBHFt5uy704XokOKXLRRlmnLZrua//2BbCsnQn/48zfTVR
	a4bIzA6Ichj4E/PNbupVRorJZdOHaPul7NTQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X9wjmnKgEwwrdSywfA/zGVfDBVMb5PPY
	RXgfCwRciqPVFfSjsooVpBBqJvCBvZwVFzbTN7C92gCdFDf9OVgeXpcrKVO5pceO
	kjZI0uuVFJiH7I6CXDv1Q9+28CB4t0iB8M8u5oYqkroSSfsZdC1U1tc6qMKaxRrV
	c9NynXbrUiU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 187A146511;
	Wed, 15 Apr 2015 13:05:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 599D9464E0;
	Wed, 15 Apr 2015 13:04:56 -0400 (EDT)
In-Reply-To: <CA+55aFwbEnneEvUDhxGaWw=fSwY2WbtGy6Uc3aQzpiUY6GH1uQ@mail.gmail.com>
	(Linus Torvalds's message of "Wed, 15 Apr 2015 09:20:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8AA5BF1E-E391-11E4-93D7-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267221>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Apr 15, 2015 at 12:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> The fix seems to be simply:
>
> Yup, that seems to do it for me. I'm not sure how we get to
> "match_digit()" with the time string "now", though.

The --date=<when> parameter is read by determine_author_info() and
then parse_force_date(), both in builtin/commit.c.  This calls
parse_date(), which first calls (and fails) parse_date_basic() when
it is not a strict timestamp.

"now", "4.days.ago", etc. are then passed to approxidate_careful()
which in turn calls approxidate_str().  Note that the approxidate
formats do not usually spell out the TZ offset.  The result is
turned into "@<numseconds>" by parse_force_date().

The string "@<numseconds>" without TZ offset is re-interpreted by
parse_date() called by fmt_ident(); the last function prepares the
author ident line "Name <email> <numseconds> <offset>".

The --date=<when> does not force committer information, which goes
through the usual codepath of grabbing the "current" time.
