From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/4] git-cherry-pick: add allow-empty option
Date: Tue, 10 Apr 2012 14:09:17 -0700
Message-ID: <7v4nsrpa4i.fsf@alter.siamese.dyndns.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-1-git-send-email-nhorman@tuxdriver.com>
 <1334072868-9435-2-git-send-email-nhorman@tuxdriver.com>
 <7v62d7qzu9.fsf@alter.siamese.dyndns.org>
 <20120410181317.GA17776@hmsreliant.think-freely.org>
 <7vfwcbpem5.fsf@alter.siamese.dyndns.org>
 <20120410200019.GC17776@hmsreliant.think-freely.org>
 <7v8vi3pbtf.fsf@alter.siamese.dyndns.org>
 <20120410203944.GA12139@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 23:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHiJa-0004Pd-UA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 23:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab2DJVJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 17:09:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967Ab2DJVJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 17:09:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C516C7663;
	Tue, 10 Apr 2012 17:09:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f1KqDhk3tWAkZZ2Dqkm9QyszZPA=; b=E5YPfx
	gns9MnT7fv3WSW6V+6TbzKt6AVGTOfA6vOFs6kVR+dSQdnBavoYpv70gJjNm05CJ
	C50RTSvkX354LTuV6YjlhnWTGjw/jwsWabZNUaO3UWL9AjUQAmp3cZXppXtoO61v
	dIMIH9z4nTVyD1gs1uvsQvN67GS+Wu7mk+Xeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lo+UFKZkpXVGrNG5198LZu2HxNkR/PAl
	jgJ00qeXLMvw1luT43B9xiU/wVlagPjR0DzyMdzkZCbWcHySDb/pNzoLUGVZ3/EU
	SFtVsXI6ibaAljuvInN40+V4n2hXHwaL4/mkIL1plpGnLX9SjdO4fdwOoXLA6zgQ
	M/JCsBgBMiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC2467662;
	Tue, 10 Apr 2012 17:09:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F0AF7661; Tue, 10 Apr 2012
 17:09:19 -0400 (EDT)
In-Reply-To: <20120410203944.GA12139@hmsreliant.think-freely.org> (Neil
 Horman's message of "Tue, 10 Apr 2012 16:39:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 700D8702-8351-11E1-BCA0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195129>

Neil Horman <nhorman@tuxdriver.com> writes:

> ...  What do you say to my proposal regarding the splitting of the device
> dependent on how we were executed?  It seems we can't use a single advice string
> in this case, as no matter which we choose there is a use case in which it fails
> to make sense.

When your cherry-pick got --allow-empty, it should pass --allow-empty to
its inner invocation of commit if it is picking an originally empty
commit, and this advice will not trigger because commit will happily
commit the no-change change.

When your cherry-pick got --allow-empty but not --keep-unnecessary-commit,
its inner invocation of commit must not pass --allow-empty if it is _not_
picking an originally empty commit.  Then the inner commit will fail if it
auto resolves to no change, and the user sees the advice.  The current
advice text is appropriate for this case.

When your cherry-pick did not get either of these flags, its inner
invocation of commit must not pass --allow-empty.  The user sees the
advice when the auto resolved result matches HEAD from the commit invoked
by cherry-pick.  The current advice text is fine for this case, as we say
"possibly", not "we definitely know it was due to conflict resolution".

Or your cherry-pick may have failed due to a conflict, regardless of the
options like --allow-empty or --keep-unnecessary-commit given to it, and
the user may have run commit after resolving the conflict.  The current
advice text is fine for this case, too, as we say "possibly", and it
indeed is what just happened.

So I do not think you need to change anything with respect to the advice
message.

Am I missing some other cases?
