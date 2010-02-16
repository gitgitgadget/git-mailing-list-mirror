From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix threaded grep for machines with only one cpu
Date: Mon, 15 Feb 2010 18:32:12 -0800
Message-ID: <7vocjpnc5v.fsf@alter.siamese.dyndns.org>
References: <20100215225001.GA944@book.hvoigt.net>
 <7vwryet2cw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:32:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhDEq-0002np-J5
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 03:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521Ab0BPCcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 21:32:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46339 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932503Ab0BPCcW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 21:32:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DDD4E9A4A3;
	Mon, 15 Feb 2010 21:32:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iC+o8V2swoWe+078tSVXq8KllBk=; b=r01hzx
	S6FhnO6KQ+B3Lk4DAgeqQLOLJvuozxVAIMyCYUrczVw8xwRwTElZOjJcqBvsC6f8
	HdFdgEgj4DonYPh+R6CPzRr1Kjo54L8Zxk5wwKRVHsXyP95oTh50NVHldNnra0S4
	BdqfvHGB2nW5wsFPZxtQCv9NRK2joyDdz+ctE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lcyPOlC0Z4cwRRFvmGSeWOJbZC9CqHJ9
	StmG2thNZ0HLrhdGrd6iw3nD0UU6zmSwcIkAGtF0aigoNpw55ZTPPuE/4uUQUhgr
	Sfn5wi5B0FsEKvL320lDjVMOF9s7KEEKW3FQqmO3vFsqit/sSLJJ6yt13ahIcK1n
	SN1wYKK6Rl0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A85219A49A;
	Mon, 15 Feb 2010 21:32:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C49AC9A497; Mon, 15 Feb
 2010 21:32:13 -0500 (EST)
In-Reply-To: <7vwryet2cw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 15 Feb 2010 17\:07\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8028C8E0-1AA3-11DF-9F2E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140061>

Junio C Hamano <gitster@pobox.com> writes:

> So at least for grep_mutex your patch shouldn't matter.  Please explain
> use of which mutex is broken and how your patch fixes it.

Is this the answer to my question?  With your patch, your single-threaded
program will end up locking and unlocking this mutex needlessly, and the
mutex is left undestroyed after you are done, I think.

 builtin-grep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 26d4deb..5c1545e 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -81,8 +81,8 @@ static pthread_mutex_t read_sha1_mutex;
 
 #define grep_lock() pthread_mutex_lock(&grep_mutex)
 #define grep_unlock() pthread_mutex_unlock(&grep_mutex)
-#define read_sha1_lock() pthread_mutex_lock(&read_sha1_mutex)
-#define read_sha1_unlock() pthread_mutex_unlock(&read_sha1_mutex)
+#define read_sha1_lock() do { if (use_threads) pthread_mutex_lock(&read_sha1_mutex); } while (0)
+#define read_sha1_unlock() do { if (use_threads) pthread_mutex_unlock(&read_sha1_mutex); } while (0)
 
 /* Signalled when a new work_item is added to todo. */
 static pthread_cond_t cond_add;
