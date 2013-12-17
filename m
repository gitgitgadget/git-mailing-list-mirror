From: Samuel Bronson <naesten@gmail.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any
 file, fail properly
Date: Tue, 17 Dec 2013 00:03:29 -0500
Message-ID: <CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 06:03:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsmog-0006Rd-L7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 06:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab3LQFDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 00:03:31 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:51851 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab3LQFDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 00:03:30 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so5835349obc.2
        for <git@vger.kernel.org>; Mon, 16 Dec 2013 21:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iPiqn560zixvyGaRNZ39SRAHA8xjIu/wfE6CB82uhWE=;
        b=brsLL3OwGWfhyEBQBdJa1BgWv4WtyXlV/NdbHIptJgGGyVGLiwcskRIO26o1QrsVWN
         XHFbYWCnwZRUU6TRAKj792xPkH8JMmPdBrjHka2QX5LUEt/t8uCahJtV1LMiWgTzWTT+
         fx9AlazMyRLnMapqAcAmiaDq++maeb4wrDVbPZLEXcz4PEW2acbNQnlFCQROCaeVPhVL
         ubcxl09xAXC/hMOLH9uikONO6hwAtWBTaTakOVMhTdaOUrV7Aruqat2iC07d7JF1jGuG
         17Nznw2JcmUJA4UxKvR6uC6LL6uuJilpLGKM3y++vx7u1M3v5t66WpIl6hKooVqRU9xk
         lPLA==
X-Received: by 10.182.44.167 with SMTP id f7mr14395891obm.3.1387256609397;
 Mon, 16 Dec 2013 21:03:29 -0800 (PST)
Received: by 10.182.135.3 with HTTP; Mon, 16 Dec 2013 21:03:29 -0800 (PST)
In-Reply-To: <xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239375>

On Mon, Dec 16, 2013 at 4:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Bronson <naesten@gmail.com> writes:
>
>>  for i in 1 2
>>  do
>>       test_expect_success "orderfile using option ($i)" '
>>       git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
>>       test_cmp expect_$i actual
>>  '
>
> This funny indentation in the previous step needs to be fixed, and
> the added block below should match.

Even though this results in oddly-indented --verbose output?

>> +     rm -f order_fifo &&
>> +     mkfifo order_fifo &&
>> +     cat order_file_$i >order_fifo &
>> +     git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
>
> I think this part can be racy depending on which between cat and
> "git diff" are scheduled first, no?  Try running this test under
> load and I think you will see it deadlocked.
>
> Besides, the above breaks && chain; even if mkfifo breaks (hence not
> allowing cat to run), "git diff" will go ahead and run, no?

Hmm.  Well, what I really wanted to put here was a "process substitution":

    git diff -O <(cat order_file_$i) --name-only HEAD^..HEAD >actual &&

but I did not see this feature listed in the dash(1) manpage, so I
assumed it wasn't allowed by POSIX.  And, having looked, I indeed
don't see it mentioned in POSIX either.

I'm not terribly surprised that I screwed up the translation to FIFOs;
how would I really want to do it?
