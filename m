From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git chokes on large file
Date: Wed, 28 May 2014 10:10:58 -0700
Message-ID: <xmqqbnuhesm5.fsf@gitster.dls.corp.google.com>
References: <201405271647.s4RGlDJc024596@hobgoblin.ariadne.com>
	<CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 19:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WphNe-0007os-Jv
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 19:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbaE1RLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 13:11:06 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54924 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbaE1RLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 13:11:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D9C019E4F;
	Wed, 28 May 2014 13:11:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gleDzLxVO+iGyceaxSUnDs4V3Jo=; b=igpRN8
	ySOhcheRzPDKqBwgl+kvmz8JtiwUkDgaDBDf9zTThhReTBDqituT1NAIZl+V5qAh
	Q+BzdYlcrv3sIY7ivQje0nJBSu2vthawYeQvTZL5xIyHKVGt94DHTQdt4m3hXnZx
	7hR6xym7mpsLpI6Rnln3vezwXKepiKht0JE8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmLUnGYMUaavVK06rvXbr8Rcz3/LSMoR
	W8RwXP/xrsOh8NfVcE/Ay/yA/ebQD9AQDXG9ehVUIAPEfC3CxP+vDIgcu69gagPE
	932ouutfli+/+buVKhC0Yu9Ugv/J4tDydmxbxtwXUg40LbsKKdIipYlCeuon9ZZU
	eiYfQ2eAxHg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6309619E4E;
	Wed, 28 May 2014 13:11:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0873A19E47;
	Wed, 28 May 2014 13:10:59 -0400 (EDT)
In-Reply-To: <CACsJy8BM1f1pJPzGPf--a-kUim6wyX+Mr1AfMupY3mpREY+8DA@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 28 May 2014 20:32:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A651DD0-E68B-11E3-84B6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250296>

Duy Nguyen <pclouds@gmail.com> writes:

>>     $ git fsck --full --strict
>>     notice: HEAD points to an unborn branch (master)
>>     Checking object directories: 100% (256/256), done.
>>     fatal: Out of memory, malloc failed (tried to allocate 21474836481 bytes)
>
> Back trace for this one
> ...
> Not easy to fix. I started working on converting fsck to use
> index-pack code for pack verification. index-pack supports large files
> well, so in the end it might fix this (as well as speeding up fsck).
> But that work has stalled for a long time.

You need to have enough memory (virtual is fine if you have enough
time) to do fsck.  Some part of index-pack could be refactored into
a common helper function that could be called from fsck, but I think
it would be a lot of work.

>>     $ git commit -m Test.
>>     [master (root-commit) 3df3655] Test.
>>     fatal: Out of memory, malloc failed (tried to allocate 21474836481 bytes)

I suspect that this one is only because you are letting the status
which involves diff to kick in (and for that you would need to have
enough memory).  As you suggested, it might be a good idea to take
bigfilethreshold account when deciding if we would want to run diff.
