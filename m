From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [GSoC][MICRO] Forbid "log --graph --no-walk"
Date: Fri, 06 Mar 2015 10:51:09 -0800
Message-ID: <xmqqioeeyn6q.fsf@gitster.dls.corp.google.com>
References: <1425632110-31863-1-git-send-email-dongcan.jiang@gmail.com>
	<CAPig+cQDAurk2WeTNZPVTnQ8GJSQOpWyDxHNCK_ww25ZdLtFwQ@mail.gmail.com>
	<CABwkPcoBG61YY0N4b33gdMq2cC1oQ_wFV7KaGGu3wYfuY9inGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git List <git@vger.kernel.org>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 06 19:51:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTxLB-0003XH-HT
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 19:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbbCFSvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 13:51:13 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753444AbbCFSvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 13:51:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75F3F3D3C2;
	Fri,  6 Mar 2015 13:51:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kjk5AyIqhSjJSXgJmwIAtt2ddvc=; b=FMWHBs
	twabROb4rh3UMoZfVhxCzpDX2SAa5VRKen6ZK/+Ehp9iaYGEJUzd6T4TWcfKQjZO
	RNr7TDXHaFaMXKTQDbOmM5doWWWg/wGDsKaNI3/au+mCk8n81w4/Lo/xFnX8UIQt
	TSSYv/SEJrVdYNz+LazE2D+6lkj6FOhgYgzCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JrykBJxui40QPuepDm9KPDJXq51QpazL
	noheWu3Z+BcjHckByM2+lsn2iyPAFp08CfoSCglfh/7e9QVoYpR2O1yihO0KUtY4
	DM+yYRvgFgF7sJby7zfAlVi3VPNDWgIYaeZw7wTzRmSyFyrm/88JFtZOm0nnzNS6
	P0UTnHzO6VU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B1E23D3C1;
	Fri,  6 Mar 2015 13:51:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D594E3D3BD;
	Fri,  6 Mar 2015 13:51:10 -0500 (EST)
In-Reply-To: <CABwkPcoBG61YY0N4b33gdMq2cC1oQ_wFV7KaGGu3wYfuY9inGw@mail.gmail.com>
	(Dongcan Jiang's message of "Fri, 6 Mar 2015 21:13:26 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1A04BDA-C431-11E4-933B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264950>

Dongcan Jiang <dongcan.jiang@gmail.com> writes:

> At first, I also tried to only judge the value of "revs->no_walk &&
> revs->graph", but unfortunately, it failed to pass all cases in
> t4052-stat-output.sh.
> e.g. command "git show --stat --graph" failed to get the correct result.
>
> Finally, this is because that "revs->no_walk" gets set when it comes
> to "git show --stat".

When "git show" is given a range, it turns no-walk off and becomes a
command about a connected history.  Otherwise, it is a command about
discrete point(s).

Because "git show --graph A B C" and "git log --graph --no-walk A B
C" are moral equivalents, if we are forbidding the latter, we should
forbid the former.

"git show A" (and no other revs, just a single point), however,
could be thought of as an equivalent for "git log -1 A", even though
that interpretation is based on a wrong world view (because "show
one and stop" is not the reason why the result "git show A" gives
has only A and nothing else).  And it makes sort of sense to allow
"git show --graph A" that is an equivalent to "git log -1 --graph A"
under that interpretation.

I was tempted to say the existing test is wrong to expect that
"--graph" does anything meaningful for "git show" that is run for a
non-range.  But doing the "use of both is wrong for log" change
without special casing "show" (and instead "fixing" t4052) would be
a change in behaviour, which we try to avoid in general.

I'd prefer a solution that does not waste a new bit in revision
structure in general, but if we were to waste one bit to special
case "show", it shouldn't be "fail only for the log command".  It
should be "allow this stupidity only for the show command for
backward compatibility" bit instead, I think.
