From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 2/3] diff: Let "git diff -O" read orderfile from any
 file, fail properly
Date: Tue, 17 Dec 2013 21:37:26 +0100
Message-ID: <CALWbr2zXNF-aJHHnBnW1q1yaCmWt-rmMWypBWFanTBAK1pMWiQ@mail.gmail.com>
References: <1387224586-10169-1-git-send-email-naesten@gmail.com>
	<1387224586-10169-3-git-send-email-naesten@gmail.com>
	<xmqqwqj4mqhe.fsf@gitster.dls.corp.google.com>
	<CAJYzjmd_EWcQ5OzuZBQwhkfAtdxbPbvhVxUSsh98SzMzyz=-8w@mail.gmail.com>
	<xmqqsitrmkhe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Samuel Bronson <naesten@gmail.com>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 21:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt1Ob-0007l9-Vz
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 21:37:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab3LQUh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 15:37:28 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:38967 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab3LQUh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 15:37:26 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so7456389pbc.20
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 12:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6//BS/Dfx9BuU3VQQDjRP41VjO07tFJqvDsHy9ckyQE=;
        b=PHu9GN2+ttB5NkkzyZZafWgfhL+U7uBcOaiX/B6YG+gjuT9sw9rLia78CJx69oOuBI
         B/MansZoKOgnjGslxUrrP8eIUBUCk6evoOMAWdsxImT7YDKf+xRKWIOwZst8loSUcQXX
         0jKjxRQGWwxQxryrN1GbRnulYJfS8owb35pvMVDWxKT5I/83ZS2OqqQGhSV10kbzRWX8
         oo6YdYDtnWhV7BB6G8xtSU5Hs0fc+LhwiNGXA/r46X0axszEppGKehfCtWMFkZWEwa86
         2H9d/nCa+oOF6WXY8UPsFq7w45zPLXxq4psmiQKRd/sFaxsvcxXC5luXmReMO/x2oMKB
         8tzQ==
X-Received: by 10.66.166.47 with SMTP id zd15mr29628349pab.72.1387312646223;
 Tue, 17 Dec 2013 12:37:26 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Tue, 17 Dec 2013 12:37:26 -0800 (PST)
In-Reply-To: <xmqqsitrmkhe.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239403>

On Tue, Dec 17, 2013 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Bronson <naesten@gmail.com> writes:
>
>> On Mon, Dec 16, 2013 at 4:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Samuel Bronson <naesten@gmail.com> writes:
>>>
>>>>  for i in 1 2
>>>>  do
>>>>       test_expect_success "orderfile using option ($i)" '
>>>>       git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
>>>>       test_cmp expect_$i actual
>>>>  '
>>>
>>> This funny indentation in the previous step needs to be fixed, and
>>> the added block below should match.
>>
>> Even though this results in oddly-indented --verbose output?
>>
>>>> +     rm -f order_fifo &&
>>>> +     mkfifo order_fifo &&
>>>> +     cat order_file_$i >order_fifo &
>>>> +     git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
>>>
>>> I think this part can be racy depending on which between cat and
>>> "git diff" are scheduled first, no?  Try running this test under
>>> load and I think you will see it deadlocked.
>>>
>>> Besides, the above breaks && chain; even if mkfifo breaks (hence not
>>> allowing cat to run), "git diff" will go ahead and run, no?
>>
>> Hmm.  Well, what I really wanted to put here was a "process substitution":
>>
>>     git diff -O <(cat order_file_$i) --name-only HEAD^..HEAD >actual &&
>>
>> but I did not see this feature listed in the dash(1) manpage, so I
>> assumed it wasn't allowed by POSIX.  And, having looked, I indeed
>> don't see it mentioned in POSIX either.
>>
>> I'm not terribly surprised that I screwed up the translation to FIFOs;
>> how would I really want to do it?
>
> How about not doing a fifo?

That would certainly defeat the purpose of the test, which is to test
against a fifo :-)
I'm not sure about the deadlock though. Both read and write will wait
for each other to start operating on the fifo.

You can probably fix the &&-chain by doing something like:

    mkfifo order_fifo && {
        cat order_file_$i >order_fifo &
        git diff -O order_fifo --name-only HEAD^..HEAD >actual
    } && ...

Also, "rm -f order_fifo" should probably be done in test_when_finished
rather than at the beginning of the test.

Antoine,
