From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] Change git_connect() to return a struct child_process instead of a pid_t.
Date: Tue, 02 Oct 2007 10:54:11 -0700
Message-ID: <7v641pmmgs.fsf@gitster.siamese.dyndns.org>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>
	<1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>
	<7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>
	<4700A067.3010004@viscovery.net>
	<7vtzpbrzye.fsf@gitster.siamese.dyndns.org>
	<4700B8FC.70704@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 19:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iclwy-0003SS-C1
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 19:54:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbXJBRyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 13:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753110AbXJBRyS
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 13:54:18 -0400
Received: from rune.pobox.com ([208.210.124.79]:51885 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037AbXJBRyS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 13:54:18 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id E932D13F6B4;
	Tue,  2 Oct 2007 13:54:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 4116513FBC9;
	Tue,  2 Oct 2007 13:54:35 -0400 (EDT)
In-Reply-To: <4700B8FC.70704@viscovery.net> (Johannes Sixt's message of "Mon,
	01 Oct 2007 11:08:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59704>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Junio C Hamano schrieb:
> ...
>> As to error indication, it somehow does not feel right to return
>> something called "child _process_" structure when we want to
>> tell the caller that there is no process to wait for in the
>> no-error case, although the fact that we can use .in/.out fd in
>> the structure when we _do_ have child process is attractive.
>
> Did you mean: "even if we don't have a child process"?
>
> How about a typedef if you dislike the name?
>
>> As an alternative, we could keep the "NULL return means there
>> was no need to fork" semantics of git_connect(), and instead add
>> "int *status_ret" parameter for the caller to check.
>
> Seriously? Add an *out* parameter when we can get rid of one and have
> a return value, too?

Ah, I somehow got confused and thought that the caller decides
not to do the waitpid business at the end of the connection, but
as everybody calls finish_connect() with what it got from
git_connect(), as long as the fake "child_process" structure
records something to let finish_connect() know that it should
not waitpid() on the process, all is well.

It might make sense to teach finish_command() that a magic value
of (cmd->pid == 0) means there is no process to wait for and
this "child_process" structure is only about the in/out stream
to the other side.
