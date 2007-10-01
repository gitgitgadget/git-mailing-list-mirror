From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/5] Change git_connect() to return a struct child_process
 instead of a pid_t.
Date: Mon, 01 Oct 2007 09:23:19 +0200
Message-ID: <4700A067.3010004@viscovery.net>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at>	<1191183001-5368-2-git-send-email-johannes.sixt@telecom.at> <7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 09:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcFco-0000t5-If
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 09:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbXJAHXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 03:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbXJAHXX
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 03:23:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:24816 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbXJAHXW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 03:23:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IcFcd-0000XV-Kw; Mon, 01 Oct 2007 09:23:19 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BABCA546; Mon,  1 Oct 2007 09:23:19 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vbqbjg9zz.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59583>

Junio C Hamano schrieb:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
>> This prepares the API of git_connect() and finish_connect() to operate on
>> a struct child_process. Currently, we just use that object as a placeholder
>> for the pid that we used to return. A follow-up patch will change the
>> implementation of git_connect() and finish_connect() to make full use
>> of the object.
> 
> Good description, except removal of checks for negative return
> of the calling sites raised my eyebrow and had me spend a few
> more minutes to review than necessary (see below).

I've thought about this issue a bit more.

Letting git_connect() die on error unconditionally is poison for any 
libification efforts. So here's a plan:

1. Let git_connect() return a struct child_process even for the
    non-forking case. This way a return value of NULL can uniquely
    identify a failure.

2. Keep the error checks in the callers (adjust to test for NULL).

3. Change the die() calls to return failure.

4. Note that the int fd[2] parameter to git_connect() is really an
    output: Remove it and use .in and .out of the returned struct
    child_process instead.

And maybe:

5. Reuse somehow the struct child_process that git_proxy_connect()
    already fills in.

Since my patch doesn't do (1), it can't do (2), i.e. keep the error checks - 
they must be removed because no unique failure value exists. So I could 
complete (1) in a new version of this patch, in order to also do (2). What 
is your preference?

-- Hannes

PS: I've postponed the completion of this plan - in favor of the MinGW port 
integration - because it only helps libification.
