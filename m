From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] t3404: rebase: interactive: demonstrate short SHA-1 collision
Date: Mon, 12 Aug 2013 03:40:50 -0400
Message-ID: <CAPig+cTYC-EPWFmqTxBO15PE6AuC3jUYNehtQwYk9oADp1AaZw@mail.gmail.com>
References: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
	<1376280459-55188-3-git-send-email-sunshine@sunshineco.com>
	<7vzjsnzagj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:40:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8mkK-0004P0-B2
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527Ab3HLHkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:40:52 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:37478 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab3HLHkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:40:52 -0400
Received: by mail-la0-f52.google.com with SMTP id fq13so4471104lab.11
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UGWb8p1jpMqNtiKC78bMDpQK93kEghvsThkdhQRqwHg=;
        b=YhDvwHrICvXYFjrxcYuxjfhmf0kEa5s5L6kt81s2qRk6kUSY2nVer3ymYKoiaLiiRL
         4W25U2U4uiRP5c2XvgB9MTNQl2f/47b+AQrRMYFfTycP+fDZ3sLYlxO+Pz6kGfo5ppSU
         oXpwZL7XW3Z08MArknEYowKwLzAzhh0g2CzfKkrpRDEN/PyEhGA8M1Pw6df0IGnBcyc1
         CiCMW6TGfUnbzRw9AiK7WgDOCd9y+3aEcVDFjAn1OAJyTbin0BQtHBhMAYeBM7Phhgaq
         dmQPLSZy997Wmyp2U/JcL6I2OW8C4BBkcMUlIFAXCazfXLspvQq+fjr5YQkacIRg7A8T
         j/EQ==
X-Received: by 10.152.1.169 with SMTP id 9mr10580803lan.90.1376293250796; Mon,
 12 Aug 2013 00:40:50 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 12 Aug 2013 00:40:50 -0700 (PDT)
In-Reply-To: <7vzjsnzagj.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: i3IG9Q2-2DDV_1i_kfCnJq4vQYU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232167>

On Mon, Aug 12, 2013 at 2:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> The 'todo' sheet for interactive rebase shows abbreviated SHA-1's and
>> then performs its operations upon those shortened values. This can lead
>> to an abort if the SHA-1 of a reworded or edited commit is no longer
>> unique within the abbreviated SHA-1 space and a subsequent SHA-1 in the
>> todo list has the same abbreviated value.
>>
>> For example:
>>
>>   edit f00dfad first
>>   pick badbeef second
>>
>> If, after editing, the new SHA-1 of "first" is now
>> badbeef5ba78983324dff5265c80c4490d5a809a, then the subsequent 'pick
>> badbeef second' will fail since badbeef is no longer a unique SHA-1
>> abbreviation:
>>
>>   error: short SHA1 badbeef is ambiguous.
>>   fatal: Needed a single revision
>>   Invalid commit name: badbeef
>>
>> Demonstrate this problem with a couple of specially crafted commits
>> which initially have distinct abbreviated SHA-1's, but for which the
>> abbreviated SHA-1's collide after a simple rewording of the first
>> commit's message.
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>> ---
>>  t/t3404-rebase-interactive.sh | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index af141be..e5ebec6 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -977,4 +977,21 @@ test_expect_success 'rebase -i with --strategy and -X' '
>>       test $(cat file1) = Z
>>  '
>>
>> +test_expect_success 'short SHA-1 setup' '
>> +     test_when_finished "git checkout master" &&
>> +     git checkout --orphan collide &&
>> +     git rm -rf . &&
>> +     unset test_tick &&
>
> This will inconvenience tests added later to these two in the
> future.  Oversight, or deliberate act knowing that these two are the
> last tests in this script ;-)?
>
> One bad thing is that "unset" loses information so that such future
> tests cannot resurrect test_tick and continue on from where the last
> test-tick left off.

Oversight. The commits were quite deliberately crafted with very
specific commit times, commit messages, trees, and blobs in order to
achieve a conflicting short SHA-1 ("badbeef") at rebase time, so it
was necessary to have test_tick at a known state.

It shouldn't be too much effort to save its value and restore it at
the end of the test.

>> +     test_commit collide1 collide &&
>> +     test_commit --notick collide2 collide &&
>> +     test_commit --notick "collide3 115158b5" collide collide3 collide3
>> +'
>>
>> +test_expect_failure 'short SHA-1 collide' '
>> +     test_when_finished "reset_rebase && git checkout master" &&
>> +     git checkout collide &&
>> +     FAKE_COMMIT_MESSAGE="collide2 815200e" \
>
> ;-)
>
>> +     FAKE_LINES="reword 1 2" git rebase -i HEAD~2
>> +'
>> +
>>  test_done
