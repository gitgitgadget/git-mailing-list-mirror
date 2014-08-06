From: Sergey Organov <sorganov@gmail.com>
Subject: Re: rebase flattens history when it shouldn't?
Date: Wed, 06 Aug 2014 15:36:19 +0400
Message-ID: <87ppgdu9xo.fsf@osv.gnss.ru>
References: <87k374xkpq.fsf@osv.gnss.ru> <20140723175218.GB12427@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 13:36:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEzW7-0007Zu-GK
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 13:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbaHFLgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 07:36:24 -0400
Received: from mail.javad.com ([54.86.164.124]:57991 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754118AbaHFLgX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 07:36:23 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id CAAC76184E;
	Wed,  6 Aug 2014 11:36:21 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1XEzVz-0001g1-UM; Wed, 06 Aug 2014 15:36:20 +0400
In-Reply-To: <20140723175218.GB12427@google.com> (Jonathan Nieder's message of
	"Wed, 23 Jul 2014 10:52:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254852>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hi Sergei,
>
> Sergei Organov wrote:
>
>>      --C--
>>     /     \
>>    /   ----M topic,HEAD
>>   /   /
>>  A---B master
>>
>> shouldn't
>>
>> $ git rebase master
>>
>> be a no-op here?
> [...]
>> I'd expect --force-rebase to be required for this to happen:
>>
>> -f, --force-rebase
>>     Force the rebase even if the current branch is a descendant of the
>>     commit you are rebasing onto. Normally non-interactive rebase will
>>     exit with the message "Current branch is up to date" in such a
>>     situation.
> [...]
>> Do you think it's worth fixing?
>
> Thanks for a clear report.
>
> After a successful 'git rebase master', the current branch is always a
> linear string of patches on top of 'master'.

Is this documented? Except implicitly by the: 

-p, --preserve-merges
           Instead of ignoring merges, try to recreate them.

??

Anyway, why such a requirement, and is it actually enforced by tests?

> The "already up to date" behavior when -f is not passed is in a
> certain sense an optimization --- it is about git noticing that 'git
> rebase' wouldn't have anything to do (except for touching timestamps)
> and therefore doing nothing.

Maybe, but I'd argue it's rather sane behavior to do no rebase when new
rebase point is the same as original in general. I.e., when "current
branch is a descendant of the commit you are rebasing onto", as
documentation says.

> So I don't think requiring -f for this case would be an improvement.

I still do, as it will match documentation, that in turn looks
reasonable.

> I do agree that the documentation is misleading.

If the problem is in documentation, it's not only misleading, it's
formally wrong.

> Any ideas for wording that could make it clearer?

Well, if it's indeed documentation, how about this:

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 2a93c64..62dac31 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -316,10 +316,9 @@ which makes little sense.
 
 -f::
 --force-rebase::
-	Force the rebase even if the current branch is a descendant
-	of the commit you are rebasing onto.  Normally non-interactive rebase will
-	exit with the message "Current branch is up to date" in such a
-	situation.
+	Force the rebase even if the result will only change commit
+	timestamps. Normally non-interactive rebase will exit with the
+	message "Current branch is up to date" in such a situation.
 	Incompatible with the --interactive option.
 +
 You may find this (or --no-ff with an interactive rebase) helpful after

BTW, why "Incompatible with the --interactive option."? Isn't "force"
assumed by --interactive, functionally?

-- 
Sergey.
