From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 	test_must_fail
Date: Wed, 21 Jul 2010 10:32:12 -0500
Message-ID: <QGT_6Gjw_prM4Z_TThjuP3s9CSH7c4P6hnnNpVLNYxcJL6N_1HxuGQ@cipher.nrlssc.navy.mil>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil> <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil> <AANLkTilY0fYxKlWLYGU4f4ZtJzsMSSnIIi0YnywKU5DU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, avarab@gmail.com, jrnieder@gmail.com,
	jaredhance@gmail.com, drafnel@gmail.com
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 17:32:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObbHS-0006bp-5k
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 17:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544Ab0GUPcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 11:32:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:45885 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab0GUPcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 11:32:16 -0400
Received: by mail.nrlssc.navy.mil id o6LFWD9G014139; Wed, 21 Jul 2010 10:32:13 -0500
In-Reply-To: <AANLkTilY0fYxKlWLYGU4f4ZtJzsMSSnIIi0YnywKU5DU@mail.gmail.com>
X-OriginalArrivalTime: 21 Jul 2010 15:32:13.0314 (UTC) FILETIME=[E4502620:01CB28E9]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151403>

On 07/20/2010 06:19 PM, Erick Mattos wrote:
> 2010/7/20 Brandon Casey <casey@nrlssc.navy.mil>
>> No time to investigate, but here is an example patch and the
>> results of running the affected tests.

> You have made cosmetic changes which do not do the same as the original.

Nope, look closer.  The changes are not cosmetic.

Try this:

   run_it () { "$@"; }; run_it foo= true && echo success || echo failure

You probably get something like this (if you're using bash):

   bash: foo=: command not found

That's because the one-shot variable assignment doesn't work when
used like this.  It also means that the original tests which do:

   test_must_fail PAGER= git ...

are broken.  We ran into this problem a while back and fixed it in
the commit that I referenced (e2007832).  I fixed the new instances
in t2017, t3200, and t3301 in the patch that I sent.

For the tests in t2017 and t3200 that now fail, the originals seem to
expect 'git reflog show' to return non-zero when asked to show the reflog
for a ref which doesn't have a log.  reflog does not currently return
non-zero in this case.  Either the tests should be updated to reflect
the actual behavior of 'reflog show', or 'reflog show' should be updated
to return non-zero when passed a ref without a log.

-brandon

>> --->8---
>> From: Brandon Casey <drafnel@gmail.com>
>>
>> See e2007832552ccea9befed9003580c494f09e666e
>> ---
>>  t/t2017-checkout-orphan.sh |   36 ++++++++++++++++++++++++++++++------
>>  t/t3200-branch.sh          |    6 +++++-
>>  t/t3301-notes.sh           |    6 +++++-
>>  3 files changed, 40 insertions(+), 8 deletions(-)
>>
>> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
>> index be88d4b..81cb393 100755
>> --- a/t/t2017-checkout-orphan.sh
>> +++ b/t/t2017-checkout-orphan.sh

>> @@ -80,17 +84,29 @@ test_expect_success '--orphan does not make reflog when core.logAllRefUpdates =
>>        git config core.logAllRefUpdates false &&
>>        git checkout --orphan epsilon &&
>>        ! test -f .git/logs/refs/heads/epsilon &&
>> -       test_must_fail PAGER= git reflog show epsilon &&
>> +       (
>> +               PAGER= &&
>> +               export PAGER &&
>> +               test_must_fail git reflog show epsilon
>> +       ) &&
>>        git commit -m Epsilon &&
>>        ! test -f .git/logs/refs/heads/epsilon &&
>> -       test_must_fail PAGER= git reflog show epsilon
>> +       (
>> +               PAGER= &&
>> +               export PAGER &&
>> +               test_must_fail git reflog show epsilon
>> +       )
>>  '

>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index 859b99a..bf7747d 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -237,7 +237,11 @@ test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates
>>        git config core.logAllRefUpdates false &&
>>        git checkout -b beta &&
>>        ! test -f .git/logs/refs/heads/beta &&
>> -       test_must_fail PAGER= git reflog show beta
>> +       (
>> +               PAGER= &&
>> +               export PAGER &&
>> +               test_must_fail git reflog show beta
>> +       )
>>  '
