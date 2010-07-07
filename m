From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fatal: internal error in diff-resolve-rename-copy
Date: Wed, 7 Jul 2010 10:13:44 +0200
Message-ID: <AANLkTimoNMYgP8-Wv0xZG0Ge7LpDZHblKSop8bozdfjY@mail.gmail.com>
References: <4C31CA75.9010709@drmicha.warpmail.net>
	<AANLkTimyZnvIs9XCwxKLxisum5KllXwrPygkCidC1CnH@mail.gmail.com>
	<4C3341EA.7070901@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jul 07 10:14:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWPld-0001hM-Ro
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 10:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab0GGINr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 04:13:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37874 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab0GGINp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 04:13:45 -0400
Received: by ewy23 with SMTP id 23so2036766ewy.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=IXO1yxXHcMxCNfOIBT4DOn3taXAh5X23oOnXTYPsGO4=;
        b=I37cbHVHo+Gc7TzzlI29gZgvY/olaMhYUctKPYMHzatXoCluc3GIzK8YKXkzMdKk1A
         760ORoaLJI5LS5BABpuqZ62SsO1M40UrML86OzbfGLA+fFvD+irSEzlAwH60gRVjrYsI
         1Rftj7gy+IOgzJEEmcEB17XlgbDjkynNB1JjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RZ3PvpfUJsIfJJ2oNwe0JyAHZf7qhxgRaHlCAToh6K6Oe2kmdsYwaOdTlnbDh6VCQb
         uKTdsjbWJT9H2CRo8217FoVBYlPOVqFSgyDYrY/E6ZDOe/twFrtH8r1hrhKrXWratWMk
         nOmKuJqSrEpZZjgYZiRklt1LCB4xmMcJQSbUc=
Received: by 10.213.13.80 with SMTP id b16mr5104926eba.89.1278490424249; Wed, 
	07 Jul 2010 01:13:44 -0700 (PDT)
Received: by 10.213.112.208 with HTTP; Wed, 7 Jul 2010 01:13:44 -0700 (PDT)
In-Reply-To: <4C3341EA.7070901@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150458>

On Tue, Jul 6, 2010 at 16:47, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Alex Riesen venit, vidit, dixit 05.07.2010 20:20:
>> On Mon, Jul 5, 2010 at 14:05, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>>> can someone help me with understanding or debugging the following? With
>>> "log -p --stat" I get that strange fatal error. (With GIT_FLUSH=0 it
>>> appears upfront.)
>>>
>>> Without "-p --stat" the log is displayed without a fatal error (same 3
>>> commits), but with "-p" or "--stat" (or both) it's fatal.
>>
>> Could you run the case under valgrind? (I suspect a corruption of diff
>> data structures)
>
> I have zero experience with valgrind. Running the reported command with
> the same suppressions as the test suite does, but with full leak check,
> I get the following report on stderr. Do you see anything suspicious in
> there? Should I run valgrind with -v?

No, I afraid it wont help. Memory access errors are always reported and these
("use of uninitialized value", in particular) were what I hoped to see here.

In this case something left the diff_filepair unset after allocation (hence the
"internal error". Should have been "Oops, we have a bug"): value 0 (as
seen in the check_pair_status, where the message comes from) is just
what the structure gets initialized by allocation.

Unless the repository is private (otherwise I'd like to take a look at it),
I'd suggest to put a breakpoint at the message point and try to figure
out how come the diff_filepair->status was left unset or why the diff
code is interested in its value (maybe it shouldn't be, in this case).
