From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/15] read-cache: Improve readability
Date: Sun, 22 Mar 2015 12:26:02 -0700
Message-ID: <xmqq619sdeb9.fsf@gitster.dls.corp.google.com>
References: <1426897692-18322-1-git-send-email-sbeller@google.com>
	<1426897692-18322-3-git-send-email-sbeller@google.com>
	<xmqqbnjnaso7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaLJgC6rWdRSeVVQSBYn0soJuzqnrK_bNtgAPWimPYE8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:26:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZlVi-0006TZ-O7
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 20:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbbCVT0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 15:26:06 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751826AbbCVT0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 15:26:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6921641DC9;
	Sun, 22 Mar 2015 15:26:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jxBcf01w5ckP+dLFkaHcU0mCHRQ=; b=dPyL5s
	0HO0e4KPeGaJ6YqFxMNl9Ppz/A1JWkudYGrES7HeuvaDeh+ENEjWiJH0GxAgFng6
	Wblr9618YfJ6FjL3avat8AXCEB/7e1QhXKOFyqyVwVg2LweVE9PTSYA+JEIkIUe7
	CGQ2NjVE9EnDq5JNLpS5P4HsTn9zA4X7p388I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X1Hv4yibDNbhLPsO6mhShC6/Z9h/Vz5U
	VJWSuJQx2zmnJn/tYB9gQYaoyBP9QVXECmvzExGrN2znvtOexX5rFSWOZnRPhqnG
	36o+syZozgzu18lc8I/J2EEq+lLRZNqJxoYX5f7Ha+tcUySLpOat8z+B0JV03lne
	2vA8KuHTC2c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6139041DC8;
	Sun, 22 Mar 2015 15:26:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D762B41DC6;
	Sun, 22 Mar 2015 15:26:03 -0400 (EDT)
In-Reply-To: <CAGZ79kaLJgC6rWdRSeVVQSBYn0soJuzqnrK_bNtgAPWimPYE8w@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 Mar 2015 22:11:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 47C45230-D0C9-11E4-ACF0-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266085>

Stefan Beller <sbeller@google.com> writes:

> Maybe I have read too much of the refs code lately as there we
> have these long chains which combine precondition with error
> checking.

Of course, things are not so black-and-white in the real world.  

You can also take an extreme stance and view

	if (!pretend && do_it_and_report_error())
        	error(...);

differently.  I would explain that what the whole thing is trying to
achieve as "'do it' part is the primary thing we want to do, but it
only can be done when we are not pretending, and we show an error
when the 'do it' part fails." and would suggest structuring it more
like this:

	if (pretend)
        	; /* nothing */
	else if (do_it_and_report_error())
        	error(...);

or

	if (!pretend) {
        	if (do_it_and_report_error())
                	error(...);
	}

But you could say "The final objective of the whole thing is to show
an error message, but if we are pretending or if our attempt to 'do
it' succeeds, we do not have to show the error", and such a view may
make sense depending on what that 'do it' is.  The original may be
justified under such an interpretation.

We may be tempted to write (note: each boolean term may be a call
with many complex arguments)

    if (A && B && C && D && E)
	...

when it is in fact logically is more like this:

    /* does not make sense to attempt C when A && B does not hold */
    if (A && B) {
    	if (C && D && E)
        	...
    }

But it becomes a judgement call if splitting that into nested two if
statements is better for overall readability when the top-level if
statement has an else clause.  You cannot turn it into

    /* does not make sense to attempt C when A && B does not hold */
    if (A && B) {
    	if (C && D && E)
        	...
    } else {
        ... /* this cannot be what the original's else clause did */
    }

blindly.  It would need further restructuring.  I think the code
inside the refs.c is a result of making such judgement calls.

>> By the way, aren't we leaking ce when we are merely pretending?
>
> Yes we are, that's how I found this spot. (coverity pointed out ce was
> leaking, so I was refactoring to actually make it easier to fix it, and then
> heavily reordered the patch series afterwards. That spot was forgotten
> apparently.

I dropped 2/15 and expect the real fix in the future; no rush,
though.
