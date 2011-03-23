From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL svn-fe] vcs-svn: simplifications, error handling
 improvements
Date: Tue, 22 Mar 2011 23:03:15 -0700
Message-ID: <7vbp12gyqk.fsf@alter.siamese.dyndns.org>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300751400-7427-1-git-send-email-david.barr@cordelta.com>
 <20110323003240.GA4949@elie> <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 07:03:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2HAT-0003Zv-9k
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 07:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065Ab1CWGD1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 02:03:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab1CWGD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 02:03:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 581E124FB;
	Wed, 23 Mar 2011 02:05:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DLuR8xmNlqZ96vV73dU0NdfDzyU=; b=dWxktp
	t3HsPZAvHgEsnsbK7LjZxfBw+dJdJquzmOKpdS2s+xCLA8Hup7Soeu4ghOxkmINn
	p6ovHhI04A3VLim195gfym64/l1U1YlazsgD6rOz6DJ6Q99eGTI9Ue/kUq15cpTl
	3/yuBD6y7S3w50n6XKGDWj9y6lEVbbXvbojnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gGvfyUYR349Bzhv2UfSiuLLYeO35NuxE
	seN3N2xZfOFqhTWxILR5BBpKI+nSh+W2jk2hprfL2zHfDkqnXaKG3eKm1yXY7dmv
	AK/5pzqTuUsGLIjfTWAyLsxz9GysbyYg2SpeD9v49Tt+XtybFhAooPdAxzHI0Zf4
	+hegWKekH3A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 245A824FA;
	Wed, 23 Mar 2011 02:05:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5CC7624F9; Wed, 23 Mar 2011
 02:04:57 -0400 (EDT)
In-Reply-To: <7vsjuegzj8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Mar 2011 22:46:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7D9273E6-5513-11E0-A5A9-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169802>

Junio C Hamano <gitster@pobox.com> writes:

> By the way, I've been getting annoyed by these three "sleep 100" getting
> stuck in t0081 and spending their sweet timeout while running my tests
> (prove is on, "make test </dev/null" to forbid it from reading my stdin).
> I see attempts to kill them early with "kill $!" but apparently they are
> not working. Can you take a look at it?

A bit more datapoint.  The first one works just fine, while the second one
gets stuck:

    $ cd t && make T=t0081-line-buffer.sh test
    $ cd t && make T=t0081-line-buffer.sh prove

I notice that [sh] spawned from prove is orphaned.

21643 pts/9    Ss     0:00      \_ bash
17149 pts/9    S+     0:00      |   \_ make T=t0081-line-buffer.sh prove
17155 pts/9    S+     0:00      |       \_ /bin/sh -c echo "*** prove ***"; GIT_CONFIG=.git/
17156 pts/9    S+     0:00      |           \_ /usr/bin/perl /usr/bin/prove --exec /bin/sh t
17157 pts/9    Z+     0:00      |               \_ [sh] <defunct>

Is this a known bug in prove perhaps?

    $ /usr/bin/prove --version
    TAP::Harness v3.17 and Perl v5.10.1
