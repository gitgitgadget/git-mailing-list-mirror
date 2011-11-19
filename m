From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] MSVC: Do not close stdout to prevent a crash
Date: Sat, 19 Nov 2011 11:11:54 -0800
Message-ID: <7v39dkj5ad.fsf@alter.siamese.dyndns.org>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
 <m2sjlkcgyl.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git@vger.kernel.org,
	msysgit@googlegroups.com, gitster@pobox.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 20:12:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRqKZ-0001YE-LW
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 20:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab1KSTL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 14:11:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab1KSTL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 14:11:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B52487C;
	Sat, 19 Nov 2011 14:11:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zSh7XMOwPiorA1FUqlG/AtAeIz4=; b=lGXvIW
	UM04yp3GzNyJdSX9iHE5tVO4iU7C7KleQPVxpnvhg6nmaPouOgJZ1nvX0ekIXu/0
	qdSAP4n/TJD9htet6TSWKbue1FIHzBL4H+wIZrZxd3awjpavq1upjzSUV/GFBs80
	G2oBtKpIss1bRsxE1qObcO50nF8azAF03cj2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BR14ejXczbq3BIHNgrKe2x6UIfn8BJZx
	CZQGUZpvDUoGr6kMJomO48VW8NjlIukPMe8ZBEGaTI57F7gVvRm20iShgUAM3/M8
	sVlRM5FTmN5L+us5ENN7yNXB8Ffw8NxLQCBMxgjhZp0/wMQ035b9ZF9Kzdo3tHvJ
	16PU6glQ1Hg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF29D487B;
	Sat, 19 Nov 2011 14:11:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4BE19487A; Sat, 19 Nov 2011
 14:11:56 -0500 (EST)
In-Reply-To: <m2sjlkcgyl.fsf@igel.home> (Andreas Schwab's message of "Sat, 19
 Nov 2011 15:41:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 591258B4-12E2-11E1-BAEC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185697>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Vincent van Ravesteijn <vfr@lyx.org> writes:
>
>> When compiled with MSVC, git crashes on Windows when calling
>> fstat(stdout) when stdout is closed. fstat is being called at the end of
>
> ITYM fileno(stdout).
> 
>> run_builtin and this will thus be a problem for builtin command that close
>> stdout. This happens for 'format-patch' which closes stdout after a call to
>> freopen which directs stdout to the format patch file.
>
> It shouldn't do that in the first place.  This is an error on any
> platform.

Correct. The clean-up codepath is for built-in command implementations
that write out their result and return 0 to signal success. If we let the
crt0 to run its usual clean-ups like closing the standard output stream,
we wouldn't be able to catch errors from there.

For built-ins that perform their own clean-ups, it is their responsibility
to be careful, hence we skip this part of the code.

We have relied on fstat(-1, &st) to correctly error out, and if MSVC build
crashes, it is a bug in its fstat() emulation, I would think.

We could do something like the following patch to be extra defensive,
though.

 git.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index 8e34903..64c28e4 100644
--- a/git.c
+++ b/git.c
@@ -309,8 +309,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	if (status)
 		return status;
 
-	/* Somebody closed stdout? */
-	if (fstat(fileno(stdout), &st))
+	if (fileno(stdout) < 0 || /* Somebody closed stdout? */
+	    fstat(fileno(stdout), &st))
 		return 0;
 	/* Ignore write errors for pipes and sockets.. */
 	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
