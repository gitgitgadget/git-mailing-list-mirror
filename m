From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] receive-pack: Add receive.denyObjectLimit to refuse
 push with too many objects
Date: Fri, 13 May 2011 20:20:29 +0200
Message-ID: <4DCD766D.2080801@kdbg.org>
References: <201105131854.31540.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri May 13 20:20:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKwyd-0002Yn-2j
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 20:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756612Ab1EMSUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 14:20:34 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:35179 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751665Ab1EMSUd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 14:20:33 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id D07E92C4004;
	Fri, 13 May 2011 20:20:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id CA99419F3B3;
	Fri, 13 May 2011 20:20:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <201105131854.31540.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173557>

Am 13.05.2011 18:54, schrieb Johan Herland:
> There's something weird going on here: The included test case works as
> intended, but when I try to test this in "real-world" conditions,
> I don't get the expected error message in the output:
> 
>   # From inside my git.git repo:
>   $ git init --bare foo.git
>   $ (cd foo.git && git config receive.denyObjectLimit 100000)
>   $ git push foo.git/ master
>   Pushing to foo.git/
>   Counting objects: 112383, done.
>   Delta compression using up to 8 threads.
>   Compressing objects: 100% (27658/27658), done.
>   error: pack-objects died of signal 13
>   error: failed to push some refs to 'foo.git/'
>   $
> 
> So the pack-objects on the local side dies of a broken pipe (as
> expected), but the error message from the remote side:
> 
>   error: unpack failed: received pack exceeds configured receive.denyObjectLimit
> 
> is never printed, so the user gets no clue as to why the push failed.

The error message is printed by receive_status(), called around line 350
in builtin/send-pack.c. But when pack-object fails, then the
pack_objects() call around line 340 signals an error and an early-exit
branch is taken, and receive_status() is never called.

In the test case, only a small amount of data is produced by
pack-objects, so that it can exit successfully and quickly enough
because the data fits into the pipe buffer. If the pack-objects process
were scheduled differently, there is a chance that it dies from SIGPIPE
as well. So, you are just being lucky that the test case succeeds.

-- Hannes
