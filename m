From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: RFC: git send-email and error handling
Date: Thu, 14 Apr 2011 16:10:12 -0400
Message-ID: <4DA754A4.3090709@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 22:10:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QASrx-00072A-V8
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 22:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779Ab1DNUKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 16:10:15 -0400
Received: from mail.windriver.com ([147.11.1.11]:33065 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab1DNUKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 16:10:14 -0400
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p3EKADOg023072
	for <git@vger.kernel.org>; Thu, 14 Apr 2011 13:10:13 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 Apr 2011 13:10:13 -0700
Received: from [128.224.146.65] ([128.224.146.65]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 14 Apr 2011 13:10:13 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Thunderbird/3.1.9
X-OriginalArrivalTime: 14 Apr 2011 20:10:13.0347 (UTC) FILETIME=[F6AE7330:01CBFADF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171544>

I came across a situation today where the behaviour of git send-email
kind of surprised me -- in that it seemed definitely less than ideal
for the use case I had.

For stable linux kernel releases, it is very common to send
hundreds of patches at once, to people you've never contacted before,
simply because the are called out in CC: or SOB: lines of a patch
that has been cherry picked.  So it is highly likely that you may
hit full inboxes, expired accounts and so on.

The command line (git 1.7.4.4) is typically something like:

git send-email --to stable@kernel.org --to linux-kernel@vger.kernel.org \
   --cc stable-review@kernel.org   some_patch_dir

So, let me get to what happened today:  After sending 113 out of 209
patches, it came to the 114th patch, and gave me this:

(mbox) Adding cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> from line 'From: Dmitry Torokhov <dmitry.torokhov@gmail.com>'
(body) Adding cc: Dmitry Torokhov <dtor@mail.ru> from line 'Signed-off-by: Dmitry Torokhov <dtor@mail.ru>'
(body) Adding cc: Paul Gortmaker <paul.gortmaker@windriver.com> from line 'Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>'
5.2.1 <dtor@mail.ru>... Mailbox disabled for this recipient

Then, taking that as a hard error, it simply exited,
leaving me scrambling to figure out how to quickly fix the
offending patch and continue with the unsent queue.

 From my point of view, the right thing to do here would have
been to ignore the error on the harvested mail address, and continue
on through the rest of the queue.  Or even interactively ask me what
to do when it saw the 5.2.1 failure.  But maybe that wouldn't be
right for everyone.  I didn't see anything in the GSE man page
that would let me configure this behaviour either.

Anyway, I thought I'd mention it and see where the discussion went.

Thanks,
Paul.
