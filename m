From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/5] verify-commit: verify commit signatures
Date: Mon, 23 Jun 2014 10:52:38 -0700
Message-ID: <xmqq61jrcy3d.fsf@gitster.dls.corp.google.com>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
	<cover.1403506792.git.git@drmicha.warpmail.net>
	<20140623172805.GD4838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:52:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz8QE-0001f1-Ma
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186AbaFWRwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:52:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53526 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbaFWRwq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:52:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D8D121266;
	Mon, 23 Jun 2014 13:52:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lj6Cfth5sZcFXfdPZSJE387G4zU=; b=pCtvf3
	r1fuYo9DrrFovxjJ7a2dZp3kJsIusTsq/T6iHf2InS5JGuN2XT/XYR1uMFCR27qC
	3slunukLRrpPPr4gNzTj5YnEETmFWWU+OHc9YHU299CtZVSVgZDEhe2S3ShU531B
	WBrEdrPpDJzhvhpZJGqV/w3FFdgjjsVwvZffM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cyhzbaZqYppb8OG2aKA2cJrfT6/PdJk/
	Hxpp+2mOgaODm4XagpZcKSLE6J3foFTMrEtoyP6+szObfdP0xbOWCOBtsjZAe8O4
	7KOw0TMiYS1rfHyFxXFUORgIAQUNq1YFBUroU1CcxHzQbKaiJj4jVtEnx+ui7LS3
	5NC/jehqdhY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 73F4921264;
	Mon, 23 Jun 2014 13:52:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 477E621259;
	Mon, 23 Jun 2014 13:52:36 -0400 (EDT)
In-Reply-To: <20140623172805.GD4838@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 23 Jun 2014 13:28:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2904F318-FAFF-11E3-B4BF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252362>

Jeff King <peff@peff.net> writes:

> On Mon, Jun 23, 2014 at 09:05:46AM +0200, Michael J Gruber wrote:
>
>> This incorporates all remarks about the test coding guidelines and
>> rearranging the series.
>> 
>> Open questions:
>> - There was some debate about (optionally) verifying more than what
>> git-verify-{commit,tag} currently do, or going for a generic git-verify command.
>> The former would require both to be changed (in order to treat similar cases similarly),
>> the latter would need a deprecation for git-verify-tag.
>
> I think that a potential "git verify" doesn't need to block this series,
> per the logic I gave elsewhere.
>
> The one thing that does give me pause is that we do not seem to have any
> way of accessing mergetag signatures. We should perhaps stop and think
> for a second about how we might expose those (and whether it would fit
> into the "git-verify-{commit,tag}" paradigm). I am tempted to say that
> "git verify-tag" on a commit should verify the mergetag (right now it
> would simply be an error). But I haven't though that hard on it.

I agree that "verify-commit" that lives next to "verify-tag" is fine
and does not have to wait for a unified "verify" that may not even
be a good idea, but if we were to verify the mergetags in one of
these "verify-$OBJECTTYPE" commands, I would think "verify-commit"
should be the one to check them, for the simple reason that they
appear in "commit" objects, not in "tag" objects.

I would imagine that I would not mind too much if "verify-tag"
delegated the verification to "verify-commit" automatically when it
is given a commit object, but for a command fairly low-level to be
useful for scripting, such a DWIMmage may be too unexpected and make
them unnecessarily unreliable.  Using scripts that want strictness
(and who in the right mind that wants to verify things do not want
strictness?) would need to "cat-file -t" upfront to switch on the
object type.
