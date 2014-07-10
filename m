From: Fabian Ruch <bafain@gmail.com>
Subject: Re: [PATCH RFC v2 06/19] rebase -i: Stop on root commits with empty
 log messages
Date: Thu, 10 Jul 2014 11:29:49 +0200
Message-ID: <53BE5D0D.8090308@gmail.com>
References: <53A258D2.7080806@gmail.com>	<cover.1404323078.git.bafain@gmail.com>	<00ca9dc0d1750301aa22c2bb78976b141233cef3.1404323078.git.bafain@gmail.com> <xmqq8uo38p28.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:30:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5Ag2-0003mg-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 11:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaGJJ37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 05:29:59 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:46004 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752807AbaGJJ3x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 05:29:53 -0400
Received: by mail-we0-f170.google.com with SMTP id w61so8706783wes.1
        for <git@vger.kernel.org>; Thu, 10 Jul 2014 02:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=tAhsnFUq29Xwjuxtlf0mDlV+Ifrt47IiyJyGB1WBX/M=;
        b=jajpM+DgmFlhBx/YMHn2VTZHYCtnzC1URTZVTzHcG0vEB9YjzGqqNpJvqC4zn7/RDl
         agrS27gBJTVQmwRHkXgI0m2rfDLf27Pyl2uXGJK6iRqHi2EtCXm2K8mTo90dcdRZVbfu
         I/aKhwhazhq+rdxt542SlkNaVvynyizc5j6nI8PMZkyrBflb8s7pX3A6S1T+lokjbtfv
         DsigDFFe3iOI7psozJkc2TVckYLS8NWEMM0L4UEkQKKfJR6nYBq0QTzUzQhTGVjpyDcI
         8Rc2B/HIZs1W1V9cbYG3jgRea+w76F48Sa7LKb1juWpvRX2Y6hhYxIOMIbr1IqXd4Ycj
         Kpxg==
X-Received: by 10.180.91.81 with SMTP id cc17mr17467927wib.17.1404984591745;
        Thu, 10 Jul 2014 02:29:51 -0700 (PDT)
Received: from client.googlemail.com (nat-wh-nan.rz.uni-karlsruhe.de. [141.70.81.135])
        by mx.google.com with ESMTPSA id l8sm109146064wje.15.2014.07.10.02.29.49
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Jul 2014 02:29:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqq8uo38p28.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253179>

Hi Junio,

Junio C Hamano writes:
> Fabian Ruch <bafain@gmail.com> writes:
>> The command line used to recreate root commits specifies the
>> erroneous option `--allow-empty-message`. If the root commit has an
>> empty log message, the replay of this commit should fail and the
>> rebase should be interrupted like for any other commit that is on the
>> to-do list and has an empty commit message. Remove the option.
>>
>> The option might have been introduced by copy-and-paste of the first
>> part of the command line which initializes the authorship of the
>> sentinel commit. Indeed, the sentinel commit has an empty log message
>> and this should not trigger a failure, which is why the option
>> `--allow-empty-message` is correctly specified here.
> 
> The first "commit --amend" uses -C "$1" to give the amended result
> not just the authorship but also the log message taken from "$1".
> If we are allowing a commit without any message to be used as "$1",
> I think --allow-empty-message needs to be there.  If "$1" requires
> the option here, why doesn't the second one, that records the
> updated tree with the metainformation taken from the same commit
> "$1" can successfully commit without the option?

(I realize now that the emptiness of the sentinel log message is
irrelevant to the success of the first "commit --amend" since we are
amending using -C. I'll rewrite the second paragraph of the patch
description.)

The first "commit --amend" requires --allow-empty-message because we do
not want to fail without the authorship or log message of $1 being in
place. It's not a matter of allowing or disallowing empty log messages yet.

git-rebase--interactive can come across an empty log message in three
different ways, which are, depicted as to-do list tasks, the following.

 1) pick --ff $1
 2) pick --no-ff $1
 3) reword $1

This patch is concerned with consistency in the second case.
git-rebase--root does not handle the first case yet and the third case
is handled somewhere else in the script independent of the first two.

The --root option handling was added to the script as a special case
later in the revision history. It's that option handling which
introduced the inconsistency that non-fast-forwards of commits with
empty log messages succeed if they are root commits but have always
failed otherwise.

Your reply suggests that git-rebase--interactive was wrong from the
beginning and that the replay of commits without any message should be
allowed. This would reconcile the first case with the second. In fact,
since neither of them alters the changes introduced by $1 or its log
message, it might be incorrect to complain about a missing message in
the first place.

Do you want me to replace this patch with a patch

    rebase -i: Always allow picking of commits with empty log messages

that makes git-rebase--interactive cherry-pick commits using
--allow-empty-message? The script would still abort an empty reword with
the new patch and the user could then still force the empty log message
with "git commit --amend --allow-empty-message".

   Fabian

> Puzzled...
> 
>> Add test.
>>
>> Signed-off-by: Fabian Ruch <bafain@gmail.com>
>> ---
>>  git-rebase--interactive.sh |  2 +-
>>  t/t3412-rebase-root.sh     | 39 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
>> index 4c875d5..0af96f2 100644
>> --- a/git-rebase--interactive.sh
>> +++ b/git-rebase--interactive.sh
>> @@ -510,7 +510,7 @@ do_pick () {
>>  		git commit --allow-empty --allow-empty-message --amend \
>>  			   --no-post-rewrite -n -q -C $1 &&
>>  			pick_one -n $1 &&
>> -			git commit --allow-empty --allow-empty-message \
>> +			git commit --allow-empty \
>>  				   --amend --no-post-rewrite -n -q -C $1 \
>>  				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
>>  			die_with_patch $1 "Could not apply $1... $2"
