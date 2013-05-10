From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] transport-helper: fix remote helper namespace regression
Date: Fri, 10 May 2013 13:55:29 -0700
Message-ID: <7vli7mzha6.fsf@alter.siamese.dyndns.org>
References: <1368187710-4434-1-git-send-email-felipe.contreras@gmail.com>
	<1368187710-4434-3-git-send-email-felipe.contreras@gmail.com>
	<7vsj1uzijo.fsf@alter.siamese.dyndns.org>
	<CAMP44s2QHd7b2t654hnMw_xca0OJKjUjEgP2yU4PUe-w4z-zBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 22:55:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UauLz-0003aR-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 22:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab3EJUzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 16:55:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42471 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754247Ab3EJUzc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 16:55:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65CC51DC49;
	Fri, 10 May 2013 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YMXoVTRKoEbUPSp1attDm6rW9po=; b=LBJ6kt
	fO7QmomRcEoGLsK7rWrWAAtAoHpetnVWUG4eAmtfomHHEPj76RIIo5q3K/ZeD4Mk
	SBMGAMHAaRCjieWbLWdaa1sHCJHDfoZ1F6D7K4ZV+kBTZbxtON9V7w4Sw1t/NWK9
	z/y8pas5NF69/ktHgOxq1S6Zk+739Ecl9QVtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u3EcVWFmeReVU1PKm0VsUwN1vRlfQwuJ
	gPA96zVDUnsowDQJqUGQTbWxjSEyMCGEqwdyjvX/6Cxb8QCm8k7Q93X8t8p9CN8s
	D/Mcxljba1S4XTHssHbpKryAepLVZFuS35yutfi83ebLLzas0PoihNHCV4FBVjsN
	nwEU9uxtilc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB5C1DC48;
	Fri, 10 May 2013 20:55:31 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D32D81DC47;
	Fri, 10 May 2013 20:55:30 +0000 (UTC)
In-Reply-To: <CAMP44s2QHd7b2t654hnMw_xca0OJKjUjEgP2yU4PUe-w4z-zBg@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 10 May 2013 15:36:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F36B8E66-B9B3-11E2-B592-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223906>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, May 10, 2013 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> +test_expect_success 'push update refs failure' '
>>> +     (cd local &&
>>> +     git checkout update &&
>>> +     echo "update fail" >>file &&
>>> +     git commit -a -m "update fail" &&
>>> +     git rev-parse --verify testgit/origin/heads/update >expect &&
>>> +     GIT_REMOTE_TESTGIT_PUSH_ERROR="non-fast forward" \
>>> +     test_expect_code 1 git push origin update &&
>>
>> This is not portable
>
> Why not? Other parts of this script run commands with environment
> variables like this.

There is a difference between a proper command and a shell function
with respect to the single-shot environment assignment.

	VAR=VAL command args

is fine, but

	VAR=VAL shell_function args

is not.

People often make this mistake and we had to fix it number of times
in t/ directory.
