From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/6] Automatically close stderr pipes created by run_command
Date: Thu, 14 Feb 2008 09:00:28 +0100
Message-ID: <47B3F51C.3060002@viscovery.net>
References: <20080214062229.GB30516@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 09:01:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPZ1m-0000MA-RD
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 09:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760190AbYBNIAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 03:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760069AbYBNIAb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 03:00:31 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:27265 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760157AbYBNIAb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 03:00:31 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JPZ0l-0003eJ-O9; Thu, 14 Feb 2008 09:00:03 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A0BAFA33B; Thu, 14 Feb 2008 09:00:28 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080214062229.GB30516@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73864>

Shawn O. Pearce schrieb:
> Like the out pipe and in pipe, we now automatically close the err
> pipe if it was requested by the caller and it hasn't been closed
> by the caller.  This simplifies anyone who wants to get a pipe to
> the stderr stream for another process.

IMHO, this is backwards.

The .in, .out, .err members of struct child_process serve two different
purposes:

1. Caller sets them to some fd > 0. This means:
   "Here is a readable (.in) or writable (.out, .err) fd; use it."

2. Caller sets them to -1: This means:
   "Create a pipe and give me the writable (.in) or readable (.out,
   .err) end of it back."

Notice that in a clean implementation:

- case 1. would imply that the fd is "given away", i.e.
  start_command/finish_command take ownership and close it;

- case 2. would imply that the caller takes ownership of the returned
  fd and has to close it.

The current implementation of start_command/finish_command as well as its
callers don't follow these rules (because they are not documented
anywhere). As a nasty side-effect we have double-closes in many places
because some callers close fds even though they are not supposed to do it.
(That's the reason why the close() calls in finish_command cannot check
for errors!)

I've a patch cooking that cleans up this mess. IMHO, your patch makes
things messier.

-- Hannes
