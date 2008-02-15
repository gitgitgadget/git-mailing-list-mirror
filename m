From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Automatically close stderr pipes created by
 run_command
Date: Fri, 15 Feb 2008 09:11:36 -0800
Message-ID: <7vfxvui1pz.fsf@gitster.siamese.dyndns.org>
References: <20080214062229.GB30516@spearce.org>
 <47B3F51C.3060002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 15 18:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ47F-0008Tb-LS
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 18:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbYBORME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 12:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbYBORMB
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 12:12:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbYBORMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 12:12:00 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC28234E;
	Fri, 15 Feb 2008 12:11:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 C5C42234C; Fri, 15 Feb 2008 12:11:48 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73961>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Shawn O. Pearce schrieb:
>> Like the out pipe and in pipe, we now automatically close the err
>> pipe if it was requested by the caller and it hasn't been closed
>> by the caller.  This simplifies anyone who wants to get a pipe to
>> the stderr stream for another process.
>
> IMHO, this is backwards.
>
> The .in, .out, .err members of struct child_process serve two different
> purposes:
>
> 1. Caller sets them to some fd > 0. This means:
>    "Here is a readable (.in) or writable (.out, .err) fd; use it."
>
> 2. Caller sets them to -1: This means:
>    "Create a pipe and give me the writable (.in) or readable (.out,
>    .err) end of it back."
>
> Notice that in a clean implementation:
>
> - case 1. would imply that the fd is "given away", i.e.
>   start_command/finish_command take ownership and close it;
>
> - case 2. would imply that the caller takes ownership of the returned
>   fd and has to close it.

I am puzzled.  In a clean implementation perhaps the fds belong
to the caller in both cases.  Or belong to the callee in both
cases.  Or perhaps sometimes belong to the caller and someimes
to the callee as you wrote above, but that seems arbitrary.

I suspect from the caller's point of view, if we can always make
them owned by the caller, that would be the most consistent and
convenient.  "Here is a fd --- I lend it to you so use it but do
not close --- I may have other uses for it later".

In any case, I agree with you that the current code lacks
consistency either way and we need an order there.
