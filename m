From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Mon, 01 Oct 2007 01:39:21 -0700
Message-ID: <7vtzpbrzye.fsf@gitster.siamese.dyndns.org>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
	<1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
	<7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>
	<4700A067.3010004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 01 10:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcGoT-0004mY-PY
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 10:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbXJAIj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 04:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbXJAIj3
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 04:39:29 -0400
Received: from rune.pobox.com ([208.210.124.79]:42869 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbXJAIj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 04:39:28 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id B9D0F13F638;
	Mon,  1 Oct 2007 04:39:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1589F13F5E5;
	Mon,  1 Oct 2007 04:39:44 -0400 (EDT)
In-Reply-To: <4700A067.3010004@viscovery.net> (Johannes Sixt's message of
	"Mon, 01 Oct 2007 09:23:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59589>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
>> Johannes Sixt <johannes.sixt@telecom.at> writes:
>>
>>> This prepares the API of git_connect() and finish_connect() to operate on
>>> a struct child_process. Currently, we just use that object as a placeholder
>>> for the pid that we used to return. A follow-up patch will change the
>>> implementation of git_connect() and finish_connect() to make full use
>>> of the object.
>>
>> Good description, except removal of checks for negative return
>> of the calling sites raised my eyebrow and had me spend a few
>> more minutes to review than necessary (see below).
>
> I've thought about this issue a bit more.
>
> Letting git_connect() die on error unconditionally is poison for any
> libification efforts. So here's a plan:
>
> 1. Let git_connect() return a struct child_process even for the
>    non-forking case. This way a return value of NULL can uniquely
>    identify a failure.
> ...
> Since my patch doesn't do (1), it can't do (2), i.e. keep the error
> checks -
> they must be removed because no unique failure value exists. So I
> could complete (1) in a new version of this patch, in order to also do
> (2). What is your preference?

In any case, I'd rather first have one that hides fork/exec
behind child_process first without changing the call to die() in
git_connect() in this round.  I am still in "post feature
release clean-up" mood ;-)

As to error indication, it somehow does not feel right to return
something called "child _process_" structure when we want to
tell the caller that there is no process to wait for in the
no-error case, although the fact that we can use .in/.out fd in
the structure when we _do_ have child process is attractive.

As an alternative, we could keep the "NULL return means there
was no need to fork" semantics of git_connect(), and instead add
"int *status_ret" parameter for the caller to check.
