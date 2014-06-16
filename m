From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] commit: Add commit.verbose configuration
Date: Mon, 16 Jun 2014 15:25:22 -0700
Message-ID: <xmqq38f4pk4t.fsf@gitster.dls.corp.google.com>
References: <1402601942-45553-1-git-send-email-caleb@calebthompson.io>
	<1402603225-46240-1-git-send-email-caleb@calebthompson.io>
	<xmqqppic3dko.fsf@gitster.dls.corp.google.com>
	<20140616195057.GB28126@sirius.local>
	<xmqqzjhcpqju.fsf@gitster.dls.corp.google.com>
	<20140616201037.GA37953@sirius.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Caleb Thompson <caleb@calebthompson.io>
X-From: git-owner@vger.kernel.org Tue Jun 17 00:25:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwfLK-000705-8B
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 00:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbaFPWZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 18:25:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64451 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932396AbaFPWZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 18:25:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B5AF021386;
	Mon, 16 Jun 2014 18:25:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SbcWlVlaVZe13IXxzonV/3EHFz0=; b=VFA/is
	EG4b57uGYvfiqFdQTrjjQ2mJHLQ8SrFPO8lZbmnI5wLywQAZ9OgqfHxY6biQbIUR
	/RcxnfxVotFo2s/LIPtcNb59P337FOMqP/B4YITOIBasBzxPLaIXf/bRUE0rrt8d
	sQj/ro1e9fHi2Bl/v7+UpYegNw/baTF9JZ2Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FMT3zrgZiiU3XKbjWT5UmH564aWEiLB9
	J1VVMnShZLe7+y8V1GSCEX2GDGqwY3sHWBPOQ2EiRTtBN0xMyQk4yaE4VEMIHUib
	iOAzpRlDzF0Win94kWjiaX4F17OaCvHfOrJpqdXRQH+4c+/Tr+uaOunmf+5/a73/
	D26p+AZjx58=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2B45221385;
	Mon, 16 Jun 2014 18:25:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8273321382;
	Mon, 16 Jun 2014 18:25:21 -0400 (EDT)
In-Reply-To: <20140616201037.GA37953@sirius.local> (Caleb Thompson's message
	of "Mon, 16 Jun 2014 15:10:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1A92058C-F5A5-11E3-AE41-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251827>

Caleb Thompson <caleb@calebthompson.io> writes:

>> Again, what are we testing, exactly?
>>
>> We do not want to see "^diff --git" in the output file, in other
>> words, we want to make sure "^diff --git" does not appear in the
>> output.
>>
>> So
>>
>>         write_script check-for-no-diff <<-\EOF
>>         ! grep '^diff --git' "$@"
>>	EOF
>>
>> should be the most natural way to express what we are testing, no?
>
> I did consider that. The reason I didn't propose that is that it doesn't catch
> the unlikely case that the $1 only contains a "diff --git" line or that $1 is
> empty.
>
> Those are rather unreasonable concerns, so I'm happy to use the much more
> readable version as you propose.

If it only has "diff --git", then the grep will find a hit, exits
with success, the script yields the opposite and "git commit" will
fail, which is what we want, so that is OK.  "$1 is empty" may or
may not be an error, depending on your settings, I guess (i.e. can't
we squelch the "# helpful instruction" lines altogether?)?

If the editor input is expected to be very stable, we could even do
something like:

	write_script check-editor-input <<-\EOF
	diff expect "$1" >&2
        EOF

and then catch any deviation from the norm with something like:

	cat >expect <<-\EOF &&
        ... expected editor input comes here ...
        EOF
        test_set_editor "$PWD/check-editor-input &&
	git commit --amend

but if the editor input may easily be affected by volatile things
like blob object names given in the diff output by "commit -v" or
untracked cruft in the working tree listed in the status output,
then it would add unnecessary maintenance burden (every time earlier
parts of the test scripts are updated, the expected output may have
to change to adjust to these non-essential details), so it is a
judgment call.

Thanks.
