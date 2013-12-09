From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2] diff: don't read index when --no-index is given
Date: Mon, 09 Dec 2013 22:17:03 +0100
Message-ID: <87mwk9n2r4.fsf@gmail.com>
References: <20131209192000.GS29959@google.com> <1386621634-25444-1-git-send-email-t.gummerer@gmail.com> <CAPig+cT_TXEAV-Jb_1N8vhKyenpEJLpw+7J45bsQ6aycdO3ftg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Tim Henigan <tim.henigan@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Alexey Borzenkov <snaury@gmail.com>,
	Bobby Powers <bobbypowers@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 22:17:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq8CS-0005Cb-FU
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 22:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761530Ab3LIVRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 16:17:05 -0500
Received: from mail-yh0-f50.google.com ([209.85.213.50]:35238 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab3LIVRC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 16:17:02 -0500
Received: by mail-yh0-f50.google.com with SMTP id b6so3211701yha.9
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=dgN25Bpo8USm3N3ZG7gg/g7DGz8nDnzOixyeVLYmEwM=;
        b=TfQ1kzHRHu8GeZ0lpC1coBFaOHB6sk4rXQkDF9HhPRxbqdxSZlpW4iOY48m6STMzez
         0VydcwET9rFEOZGTI6x8eNww8ZdCovn2nmwLED3c5Ox8gTdA9JnuTP1RnFZTJtGddYFM
         +ZlXSuiN194jgKo6d4sgLtFJIgEiz1ao6+9YagixSE7VQH8PyFr2uWVWeFZ38l0FDDWd
         1TfiJgCQt1IeO4lZWa8MPEsvKEMiqUiqQyF6v+znIgwS7KWYdRyVBxQomOHyaXNzy2Ao
         Gmz+FVEneHf3OylnojlcDVsZhPTycUzXvMEZvz5AMQ51qz6roSZlwDGwOv7ZBX4gQSSo
         WrfA==
X-Received: by 10.236.143.131 with SMTP id l3mr4660362yhj.95.1386623821766;
        Mon, 09 Dec 2013 13:17:01 -0800 (PST)
Received: from localhost ([2001:5c0:1400:a::e57])
        by mx.google.com with ESMTPSA id 48sm18758122yhq.11.2013.12.09.13.16.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2013 13:17:00 -0800 (PST)
In-Reply-To: <CAPig+cT_TXEAV-Jb_1N8vhKyenpEJLpw+7J45bsQ6aycdO3ftg@mail.gmail.com>
User-Agent: Notmuch/0.17~rc1+8~g4a09c1a (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239105>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Dec 9, 2013 at 3:40 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> git diff --no-index ... currently reads the index, during setup, when
>> calling gitmodules_config().  This results in worse performance when
>> the index is not actually needed.  This patch avoids calling
>> gitmodules_config() when the --no-index option is given.  The times for
>> executing "git diff --no-index" in the WebKit repository are improved as
>> follows:
>>
>> Test                      HEAD~3            HEAD
>> ------------------------------------------------------------------
>> 4001.1: diff --no-index   0.24(0.15+0.09)   0.01(0.00+0.00) -95.8%
>>
>> An additional improvement of this patch is that "git diff --no-index" no
>> longer breaks when the index file is corrupt, which makes it possible to
>> use it for investigating the broken repository.
>>
>> To improve the possible usage as investigation tool for broken
>> repositories, setup_git_directory_gently() is also not called when the
>> --no-index option is given.
>>
>> Also add a test to guard against future breakages, and a performance
>> test to show the improvements.
>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
>> index 979e983..d3dbf6b 100755
>> --- a/t/t4053-diff-no-index.sh
>> +++ b/t/t4053-diff-no-index.sh
>> @@ -29,4 +29,10 @@ test_expect_success 'git diff --no-index relative path outside repo' '
>>         )
>>  '
>>
>> +test_expect_success 'git diff --no-index with broken index' '
>> +       cd repo &&
>> +       echo broken >.git/index &&
>> +       git diff --no-index a ../non/git/a &&
>> +'
>
> Stray && on the last line of the test.
>
> Also, don't you want to do the 'cd' and subsequent commands inside a
> subshell so that tests added after this one won't have to worry about
> cd'ing back to the top-level?

Thanks both to you and Torsten for catching both issues, I'll fix them
in a re-roll.

>> +
>>  test_done
>> --
>> 1.8.5.4.g8639e57

--
Thomas
