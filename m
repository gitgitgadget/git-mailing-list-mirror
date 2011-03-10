From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/9] --left/right-only and --cherry-mark
Date: Thu, 10 Mar 2011 10:22:56 -0800
Message-ID: <7v4o7a6dj3.fsf@alter.siamese.dyndns.org>
References: <cover.1299499429.git.git@drmicha.warpmail.net>
 <7vtyfc7ymk.fsf@alter.siamese.dyndns.org>
 <4D7886FD.60109@drmicha.warpmail.net>
 <7vd3lz5me5.fsf@alter.siamese.dyndns.org>
 <4D78AC8B.7010308@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:23:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxkW0-0001yQ-Bf
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 19:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121Ab1CJSXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 13:23:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56566 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1CJSXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 13:23:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8F814CA8;
	Thu, 10 Mar 2011 13:24:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/5JrgiSXCZsa/Y24SVp5IFTe4Ok=; b=lzMymx
	1SicKw/ebPIj9oKIAC9HFQol/tkRKD2eekKPRv+HEJzHdUZkvaEy/rgooA89tVAM
	635RdaEqP+xWjRWxsFlwGNReN21ltGiPryzwjLCQgW+R3Qf3TMdk8rQB6K9MgD4G
	5oK/dVPGp7m7dMUxEVhu+0hiIk1Efw7VQSqTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=myJtdJIUB2ce1tMAkuIEuULVO5vdMSip
	yX2FjjSgyR1MWRg7RGBurbwTWaOTZ02lMhjg0KnddD1vBARpF7+HiznS9svisgkv
	MFQ9L5Mie2I6mmFT7y4dYI3cw7lfer0AkBcJCKeC6cqOp4Y/C2nrXlSX1StH6ceu
	Sk6Lgg761MQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A0DB14CA6;
	Thu, 10 Mar 2011 13:24:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 92C7A4CA5; Thu, 10 Mar 2011
 13:24:26 -0500 (EST)
In-Reply-To: <4D78AC8B.7010308@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 10 Mar 2011 11:48:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A34BD872-4B43-11E0-AA03-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168841>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> ...
> Additionally, since parse_revision_opt (which calls handle_revision_opt)
> is called from other sites for individual args we would need to do the
> handling in the Y case (set pick when marking) right in
> handle_revision_opt, not just in setup_revisions. It's a matter of a few
> more if's and or's, but still.
>
> Taking these together, I wonder whether we shouldn't leave it as in v2.

The primary downside of keeping cherry_pick and cherry_mark as independent
I see is what would happen to the "if (cherry_pick || cherry_mark)" when
somebody comes up with the next bright idea to use the change equivalence
computed in cherry_pick_list(). With the approach in v2, the natural way
of enhancing this would be to add another "|| cherry_xyzzy" there, and the
next bright idea would add another "|| cherry_frotz".

My gut feeling was that it would be a more maintainable implementation to
have an internal bit that does not have to be exposed to the UI and that
tells the revision machinery that we need to compute the equivalence, and
an enum (if the three modes of using the equivalence are incompatible with
each other) or a one-bit-per-feature bitset (if the three features that
use the equivalence can be used at the same time) that tells the machinery
what to do with the equivalence information. From the UI level, the user
only asks for the feature(s) that use(s) the equivalence information, and
asking for any of them would set the internal "need equivalence" bit.

The above is modeled after the way how revs.limited bit is used. That bit
corresponds to the "internal bit" that is flipped by many features that
can be triggered from the UI level that depends on having the history
graph before they do their work.

Counting the number of "if (limited)" and tricky codepaths around it, and
contrasting that with the number of ways we flip the "limited = 1" bit
(which grew over time), I think you can understand where my fear of
potential future complexity against "if (cherry_pick || cherry_mark)"
comes from.

As I said earlier, this was only a minor thing that nagged me. Considering
that currently there is only one place that checks if we are doing any of
the operation that requires us to have change equivalence information to
change the behaviour depending on the result, I wouldn't be too unhappy if
this feature is done in the way you did in your v2 patch.

Thanks.
