From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/5] Change git_connect() to return a struct child_process
 instead of a pid_t.
Date: Mon, 01 Oct 2007 11:08:12 +0200
Message-ID: <4700B8FC.70704@viscovery.net>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>	<1191183001-5368-2-git-send-email-johannes.sixt@telecom.at>	<7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>	<4700A067.3010004@viscovery.net> <7vtzpbrzye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 11:08:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcHGN-0004uC-NY
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 11:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbXJAJIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 05:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbXJAJIR
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 05:08:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:31123 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbXJAJIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 05:08:17 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IcHG8-0003Zi-Ib; Mon, 01 Oct 2007 11:08:12 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B7767546; Mon,  1 Oct 2007 11:08:12 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vtzpbrzye.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59590>

Junio C Hamano schrieb:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> Letting git_connect() die on error unconditionally is poison for any
>> libification efforts. So here's a plan:
>>
>> 1. Let git_connect() return a struct child_process even for the
>>    non-forking case. This way a return value of NULL can uniquely
>>    identify a failure.
>> ...
>> Since my patch doesn't do (1), it can't do (2), i.e. keep the error
>> checks -
>> they must be removed because no unique failure value exists. So I
>> could complete (1) in a new version of this patch, in order to also do
>> (2). What is your preference?
> 
> In any case, I'd rather first have one that hides fork/exec
> behind child_process first without changing the call to die() in
> git_connect() in this round.  I am still in "post feature
> release clean-up" mood ;-)

Sure: The die()s are converted in a later step.

My problem is that if I don't wrap the non-fork connections somehow in this 
first round, I *must* remove the error checks because there is no unique 
failure return value anymore.

> As to error indication, it somehow does not feel right to return
> something called "child _process_" structure when we want to
> tell the caller that there is no process to wait for in the
> no-error case, although the fact that we can use .in/.out fd in
> the structure when we _do_ have child process is attractive.

Did you mean: "even if we don't have a child process"?

How about a typedef if you dislike the name?

> As an alternative, we could keep the "NULL return means there
> was no need to fork" semantics of git_connect(), and instead add
> "int *status_ret" parameter for the caller to check.

Seriously? Add an *out* parameter when we can get rid of one and have a 
return value, too?

-- Hannes
