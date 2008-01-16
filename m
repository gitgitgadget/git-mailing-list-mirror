From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 15:19:34 -0800
Message-ID: <7vtzldmk8p.fsf@gitster.siamese.dyndns.org>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.44.0801152006260.944-100000@demand>
	<7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
	<7vodblo6c9.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:21:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHZC-0005mV-Nf
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757123AbYAPXUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 18:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757105AbYAPXUF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:20:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106AbYAPXUB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:20:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D5B7710C2;
	Wed, 16 Jan 2008 18:19:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F1EA410C1;
	Wed, 16 Jan 2008 18:19:50 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>
	(Brandon Casey's message of "Wed, 16 Jan 2008 14:46:23 -0600 (CST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70772>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> My patch does this, though I understand it may take some time to review.
>
> I left the lk->fd unmodified when close() failed in case the caller
> would like to include it in an error message.

But that would bring us back to the same double-close issue,
wouldn't it?

	if (close_lock_file(lock))
		die("Oops, failed to close fd %d", lock->fd);

is not enough.  You need to do:

	if (close_lock_file(lock)) {
        	int fd = lock->fd;
                lock->fd = -1;
		die("Oops, failed to close fd %d", fd);
	}

to avoid atexit handler closing the lock->fd.

Worse yet, a careless caller may do:

	close_lock_file(lock);

	... do something that opens a new fd, perhaps for
        ... mmaping a packfile in

	rollback_lock_file(lock);

	... Oops, we cannot mmap the packfile.
