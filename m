From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] use child_process_init() to initialize struct child_process variables
Date: Fri, 31 Oct 2014 14:48:17 -0700
Message-ID: <xmqqvbmzsyfy.fsf@gitster.dls.corp.google.com>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
	<xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
	<20141030213523.GA21017@peff.net>
	<FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Jeff King" <peff@peff.net>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:48:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XkK3U-0001hy-7P
	for gcvg-git-2@plane.gmane.org; Fri, 31 Oct 2014 22:48:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbaJaVsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2014 17:48:20 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751933AbaJaVsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2014 17:48:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00B8E18CC4;
	Fri, 31 Oct 2014 17:48:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3HMSJw0s5xfr+TfGKOX5rL3vDuo=; b=mW4Rpk
	Ch9I4CMwnFwCRAdDgDPwiCPQjEkTNJ4YVCNC4qm/ANEuR5HaPEWQuMmWxF3OFSBn
	GagMoV0Rl4OIKk+WbQTAdOH8QE5OidqStfnR3fCTBTriIr/Ao0Htj0i2DwVfbikt
	9oXWzIy6TLfC1+/ZZp26j6pAIk3vMQQetjgOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oa/QhaAC6gSPjBib9Qkp7UM6FFxBBkPm
	ryhz/9zjEmlsZQI6pqsaWIn6tgjcLqKkwmVwP8grHo/fWgKC1TJOQdeH42t+1H4E
	2dGsQ114dF/CCijYPkYh1zLlxcIUF1kjLusgLktzIP9auhlDOSSBBYsTwYETqnTs
	C36qb9VFKc4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB0E118CC2;
	Fri, 31 Oct 2014 17:48:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6EE8418CC1;
	Fri, 31 Oct 2014 17:48:18 -0400 (EDT)
In-Reply-To: <FEC7DC4C920D4F97B5F165B10BC564D2@PhilipOakley> (Philip Oakley's
	message of "Fri, 31 Oct 2014 00:19:20 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A01ABA10-6147-11E4-B3AC-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> As a side project (slow time) I've been looking at the loss of the
> HEAD symbolic ref when multiple heads are bundled that point at the
> same rev. That is, when the HEAD detection heuristic fails.

It think you are talking about the logic used by the "clone", where

 - if there is only one branch ref that matches the value of HEAD,
   that is the branch;

 - if there are more than one refs that match the value of HEAD,
   and if one of them is 'master', then that is the branch;

 - if there are more than one refs that match the value of HEAD,
   and if none of them is 'master', then pick the earliest one.

So you would be in trouble _if_ you have two refs pointing at the
same commit, one of them being 'master', and the current branch is
the other ref.  All other cases you shouldn't have to change the
file format and have older client understand which branch is the
current one.

Programs that read a pack data stream unpack-objects were originally
designed to ignore cruft after the pack data stream ends, and
because the bundle file format ends with pack data stream, you
should have been able to append extra information at the end without
breaking older clients.  Alas, this principle is still true for
unpack-objects, but index-pack broke it fairly early on, and we use
the latter to deal with bundles, so we cannot just tuck extra info
at the end of an existing bundle.  You'd instead need a new option
to create a bundle that cannot be read by existing clients X-<.
