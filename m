From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix start_command() pipe bug when stdin is closed.
Date: Mon, 25 Aug 2008 12:44:08 +0200
Message-ID: <48B28CF8.2060306@viscovery.net>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karl Chen <quarl@cs.berkeley.edu>
X-From: git-owner@vger.kernel.org Mon Aug 25 12:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXZZW-0007Ui-6w
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 12:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYHYKoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 06:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753046AbYHYKoP
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 06:44:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4031 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbYHYKoO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 06:44:14 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KXZYP-0002BN-RV; Mon, 25 Aug 2008 12:44:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 910514FB; Mon, 25 Aug 2008 12:44:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93610>

Karl Chen schrieb:
> I ran into what I think is a bug:
>     sh$ git fetch 0<&-
> 
> (i.e. run git-fetch with stdin closed.)
> It aborts with:
>     fatal: read error (Bad file descriptor)

When I try these instructions I don't get an error; instead the command
runs successfully.

> I think the problem arises from the use of dup2+close in
> start_command().  It wants to rename a pipe file descriptor to 0,
> so it does
>     dup2(from, to);
>     close(from);
> 
> ... but in this case from == to == 0, so 
>     dup2(0, 0);
>     close(0);
> just ends up closing the pipe.

While I do see that there is a problem, it is only half of the story, and
your patch addresses only this half.

What if stdout is closed, too? Then the ends of the first allocated pipe
would go to fds 0 and  1, and then the pipe end at 1 would be closed by a
subsequent dup2(xxx, 1).

Junio, what's your take on this?

-- Hannes
