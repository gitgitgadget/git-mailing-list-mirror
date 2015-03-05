From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Retry if fdopen() fails due to ENOMEM
Date: Thu, 05 Mar 2015 11:19:36 -0800
Message-ID: <xmqqy4nb2qwn.fsf@gitster.dls.corp.google.com>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 05 20:19:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTbJB-0000ov-Lp
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 20:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757966AbbCETTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 14:19:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51292 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757220AbbCETTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 14:19:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 450EE3D2BD;
	Thu,  5 Mar 2015 14:19:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sw+AY7QYANUVP5h0ufiFR8uVQxs=; b=BAeHIx
	lkcKUtbXuu6yEi9iDNxqeGu4uATnt31HX453DXjpvgkWH8bhGyI/1oa3FdkMH2aE
	rfSSzJSsIAggjdul+jn1a4TUZAkiB4Hl6ukfNeurXaERmKOQKVd42tsMf5RKU+au
	j7ZTgSQ6ti/l2s7nytSB3kCVE8OMoObVj39v0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EgMApIP+12RgY3FtKhTJWHsEeP+XP2Gc
	VDiRn6IB9zer0xchFoEDSHk2JxdocvwMMupPav1gsx8yniF4jZovHyb0KgwxVVFy
	g+nS/l3zBTpBB1UI53O53tpIY3QuJCXoTyy32mV5bGUUX8m3fA2C9ZKNUMW4e+9f
	i2FB1itO6nE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C8593D2BC;
	Thu,  5 Mar 2015 14:19:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B84983D2BB;
	Thu,  5 Mar 2015 14:19:37 -0500 (EST)
In-Reply-To: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 5 Mar 2015 17:07:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9097B0DE-C36C-11E4-90EE-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264861>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> One likely reason for fdopen() to fail is the lack of memory for
> allocating a FILE structure. When that happens, try freeing some
> memory and calling fdopen() again in the hope that it will work the
> second time.

In codepaths where we are likely under memory pressure, the above
might help, but I have to wonder

    (1) if update-server-info and daemon fall into that category; and

    (2) if Git continues to work under such a memory pressure to
        cause even fdopen() to fail.

In other words, I do not see a reason not to do this change, but I
am not sure how much it would help us in practice.

We call fopen() from a lot more places than we call fdopen().  Do we
want to do the same, or is there a good reason why this does not
matter to callers of fopen(), and if so why doesn't the same reason
apply to callers of fdopen()?

> Michael Haggerty (5):
>   xfdopen(): if first attempt fails, free memory and try again
>   fdopen_lock_file(): use fdopen_with_retry()
>   copy_to_log(): use fdopen_with_retry()
>   update_info_file(): use fdopen_with_retry()
>   buffer_fdinit(): use fdopen_with_retry()
>
>  daemon.c              |  4 ++--
>  git-compat-util.h     | 11 +++++++++++
>  lockfile.c            |  2 +-
>  server-info.c         |  2 +-
>  vcs-svn/line_buffer.c |  2 +-
>  wrapper.c             | 28 +++++++++++++++++++++++++---
>  6 files changed, 41 insertions(+), 8 deletions(-)
