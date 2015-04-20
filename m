From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Mon, 20 Apr 2015 15:51:02 -0700
Message-ID: <xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>
	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>
	<CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:51:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkKX1-0004Bl-LY
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 00:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbbDTWvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 18:51:07 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750872AbbDTWvF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 18:51:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ACB4C4949C;
	Mon, 20 Apr 2015 18:51:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xa4nj9L6XIhlx8FBwZGZ2yhAmec=; b=criLcQ
	HNWvUqJ1GcbcljQswOE8Z1ki33b01V79KK34Wvf/+qFG2wrk0/rw0qicmlRSc6DN
	jcqKXPjagFEMyIaX3fMVAclDlCxjPjBr5rTc5VbkPmqC6QdoCOQR/wkwh1cR7xa9
	7uC5FTi+l5yXs7OJmCZLboccmrpvUwG0yj8sA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZcY/JtQ+MOaFzuH61qdDQbGEQr+dteFC
	ewAF3CjInJ9sRJujKhIKjRdOXkV3tgmXXV81xUEtikcl+5qA4rB9roplDexjSBL/
	ojU83YfylSo8jk/3sCUat69DAuhBllrQ/bxt4vTTRQ7A6ZGgR/x0djrGwBybS8do
	ddfQkPbgBKc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A4DDE49499;
	Mon, 20 Apr 2015 18:51:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2708649497;
	Mon, 20 Apr 2015 18:51:03 -0400 (EDT)
In-Reply-To: <CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com>
	(Stefan Beller's message of "Mon, 20 Apr 2015 15:26:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B8AEBB00-E7AF-11E4-896D-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267509>

Stefan Beller <sbeller@google.com> writes:

> The problem comes from guessing the number of fds we're allowed to use.
> At first I thought it was a fundamental issue with the code being broken, but
> it turns out we just need a larger offset as we apparently have 9 files open
> already, before the transaction even starts.
> I did not expect the number to be that high, which is why I came up with the
> arbitrary number of 8 (3 for stdin/out/err, maybe packed refs and reflog so I
> guessed, 8 would do fine).
>
> I am not sure if the 9 is a constant or if it scales to some unknown
> property yet.
> So to make the series work, all we need is:
>
> - int remaining_fds = get_max_fd_limit() - 8;
> + int remaining_fds = get_max_fd_limit() - 9;
>
> I am going to try to understand where the 9 comes from and resend the patches.

I have a suspicion that the above is an indication that the approach
is fundamentally not sound.  9 may be OK in your test repository,
but that may fail in a repository with different resource usage
patterns.

On the core management side, xmalloc() and friends retry upon
failure, after attempting to free the resource.  I wonder if your
codepath can do something similar to that, perhaps?

On the other hand, it may be that this "let's keep it open as long
as possible, as creat-close-open-write-close is more expensive" may
not be worth the complexity.  I wonder if it might not be a bad idea
to start with a simpler rule, e.g. "use creat-write-close for ref
updates outside transactions, and creat-close-open-write-close for
inside transactions, as that is likely to be multi-ref updates" or
something stupid and simple like that?

Michael?
