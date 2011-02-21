From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] revlist.c: introduce --cherry for unsymmetric
 picking
Date: Mon, 21 Feb 2011 11:49:58 -0800
Message-ID: <7vmxlpi2vt.fsf@alter.siamese.dyndns.org>
References: <15a90a6606cff7d823fe4afbedd580aadf7b1d1e.1298032360.git.git@drmicha.warpmail.net> <7vzkptnn7x.fsf@alter.siamese.dyndns.org> <4D625972.4090500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 21 20:50:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prblu-000442-83
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 20:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab1BUTuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 14:50:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1BUTuG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 14:50:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 258AC44A8;
	Mon, 21 Feb 2011 14:51:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cF6t80QMeXp2a6WiM80xSJ5RAYg=; b=ttIfsl
	7raCCN0h+Cgi5du5u77KBzroytaJQ2nVm7KimX+H4sYiFBzSHF8x2VWdhtYyNWgs
	HELLXhCBA51bktt3cDSQ9gp7oRSMcCxqOadqOMYzxc30BTSrdeBRwOpFpcci++tZ
	bfZl8KOW4HFBiDqZocNtZ75ZBuljqgkDjJUC8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iYpkNfxMTrTc99aVIo3smS7uG7zycWNO
	xdkogSBEY4/+Bm9NtuhKXmzHyzHDNvdWus9Ne1OR1Hf1sbv1VIf51nybZTYCFYZr
	0sK/PrzO1oX7K7sFVLVuFeCe+hrc27Y/wjYraPF3YEcguGqEEs0VjerlJuFvWb77
	L70CnW4CT18=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 02D6E44A7;
	Mon, 21 Feb 2011 14:51:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CA2EF44A4; Mon, 21 Feb 2011
 14:51:11 -0500 (EST)
In-Reply-To: <4D625972.4090500@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 21 Feb 2011 13\:24\:18 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F0EEE072-3DF3-11E0-9981-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167503>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>> At the plumbing level (which 'git-cherry' was designed to be),
>> we should be able to ask for either (or both).  Adding a "we are only
>> interested in the right hand side" as a rev-list option is somewhat
>> distasteful and short-sighted.
>
> I don't understand this remark - isn't that exactly what you suggest
> below ("--right-only")? Then what is distasteful and short-sighted?

It does not give people an option to ask for only left side if you give
only "--cherry" and nothing else.  Don't you find that a bad taste?

Compare that with being explicit and supporting both --right/left-only.
The point is to avoid making the internal implementation and plumbing
interface needlessly limited to one use case, and instead keeping them
flexible.

> Could you explain in what way the current implementation is not done
> "properly"?

Your "cherry" implementation limits its utility unnecessarily by assuming
a few things it does not have to assume:

 - It only needs to discard left hand side, but not right hand side.
 - It only needs to work when patch-id equivalence filtering is on.

The former is easy to rectify, I think.

Right now, there is only one thing (cherry-pick) that works on a symmetric
difference set and filter, so it may _appear_ that the latter does not
matter, but by not tying the two unrelated concepts together and keeping
the "right-side-only output" logic and "filter the symmetric difference
set" logic orthogonal, you will leave the door open for others to add
different filtering mode easier.

> So I think the plan is:
>
> - use a "right-only" flag rather than "cherry"

And perhaps left-only for symmetry.

> - make "--cherry" do "--cherry-pick --right-only" (with or without
> ".."->"...")

Yes.

> - simplify cmd_format_patch

As long as the internal machinery to run the right/left-only filtering of
the result of cherry-pick filtering is done (i.e. step 1) and then the
syntactic sugar --cherry synonym is implemented in terms of it (step 2),
cmd_format_patch simplification would come as a natural consequence, I
think.

The simplification does not have to be done as part of this series,
though.  I only mentioned it as a reason why we would want to get the
internal for this topic (step 1) right, not tied too strongly to step 2.

Thanks.
