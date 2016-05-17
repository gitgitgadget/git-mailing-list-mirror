From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD PATCH 0/3] Free all the memory!
Date: Tue, 17 May 2016 11:16:09 -0700
Message-ID: <xmqqinycwnx2.fsf@gitster.mtv.corp.google.com>
References: <20160517032247.25092-1-sbeller@google.com>
	<CAPig+cT9UKEcNXvsQsFDrQycKwMJR5bCter76UL-zpkncniPBw@mail.gmail.com>
	<CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Turner <dturner@twopensource.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 20:16:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jXV-00036E-Se
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbcEQSQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:16:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750790AbcEQSQN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:16:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42F211CBB5;
	Tue, 17 May 2016 14:16:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V98/2Fq4eDBl22levjumk9Iead0=; b=E1GplV
	hra4W0cHGXwnne9bbHPnLJJWQjhps8Ffg0F27pbpYkdLjmo+bh8ae9psTA7bJN5r
	xJg50OokiZHRQNM51naWM2EW4BzW+nS3j/ZWW3UbatyTs/mjScKil/nKpuRpxwt0
	be4OykZa5G97elu9/eHlOlCyyhCYdvP5daWHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U5w2+S7FnoBqgPRAtxKldpwqJ+sfsqmT
	5UszOrtVzfR1vI4NXG9PzpGA5DOzl4MU3dee2Qr0wzfEl9X9FoHPUZC2OvqwRpSK
	VBoX2Uw5w0YbKxWBu52t//1u+Flm1Sfv5C+cCZwltb5cqoaHtOoCz1nHy/Rmtgg/
	kfhGZfb+3IA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 399731CBB4;
	Tue, 17 May 2016 14:16:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A72561CBB3;
	Tue, 17 May 2016 14:16:11 -0400 (EDT)
In-Reply-To: <CAGZ79kaJoAxqtsTuErQSgJiVeD_vdZ1MQXKr-LTtyro-FbscTQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 17 May 2016 10:58:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6F576D12-1C5B-11E6-9534-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294890>

Stefan Beller <sbeller@google.com> writes:

> So as a developer I wish we would close all leaks that are non-concerning.

Valgrind suppression (and if you use other tools, suppression for
them) sounds like the way to go, I would think.

Reducing false positive is a good goal; it helps to highlight the
real problems.  But we need to find a way to do so without hurting
the use by the end users by making them pay the unnecessary cost to
free() at the end and by cluttering the code with #ifdefs that makes
it easier to introduce subtle bugs.

> David writes:
>> AFAIK, nothing in the "definitely lost" category is fixed by your rev-parse patch.
>>
>> I don't think we care that much about "still reachable" memory -- I only care about lost memory.  I could imagine, I guess, something that happens to save a pointer to a bunch of memory that should be freed, but I don't think that's the common case.
>
> As said above I'd want them to be fixed for me as a developer for
> better automated tooling and detection. (The alternative to fix the automated
> tooling is a no-no for me ;)

Does the word "no-no" mean what you seem to think it means?  It
sounds as if you are saying "fixing tools to reduce false positives
is fundamentally wrong, I refuse to go in that direction".
