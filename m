From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] modernize t7300
Date: Mon, 7 Dec 2015 17:46:00 -0500
Message-ID: <CAPig+cQOW69-YNaVvqaVYyNt6cT-u92a=i0V6YufnVEmYHy3LA@mail.gmail.com>
References: <CAPig+cRa31uriO4qkZUydooNx0V+dNrUgFvTUxoLL9gCjq9AHQ@mail.gmail.com>
	<1449413906-23256-1-git-send-email-rouzier@gmail.com>
	<xmqq610alyy5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: James <rouzier@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:46:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a64Xn-0000G4-EY
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 23:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbbLGWqD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 17:46:03 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35762 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756102AbbLGWqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 17:46:01 -0500
Received: by vkha189 with SMTP id a189so1270367vkh.2
        for <git@vger.kernel.org>; Mon, 07 Dec 2015 14:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EpM8vP0tBY0sCW5zw0n/owX37mFs4y/5zKlQCyescA0=;
        b=tdrsdynEwJeyiG+o5xuMQ8o91iM5Njv58Dmn5Tiw8f5htsZQogqPQ1Iwws7PehrGVY
         zFkAzczQuxvIVZ5R8UdFSiMM5SOJHMsXT7hY3XAFuocBNxYp9R6agr0zxvTqvijmv4wf
         cAjcsSAmRtSbbFc/54uYraG7jN90NOrOMalD4MU07auHyAphDxLGR5VT02gIrMFG9uth
         OuOjJeQfarQ54EO8Bmxxh4KQrbLbDgbj3QLqIxH4t4DFrbZbV00s0FNjCK+bmT6MYZG6
         LNVpqfdMGKv13ZoW8bdZxij4V4hAB+EYUGn/iXtrSRBww0sgY3i2BPtdTJmTjIO6KZNJ
         Z5wg==
X-Received: by 10.31.134.3 with SMTP id i3mr273444vkd.14.1449528360731; Mon,
 07 Dec 2015 14:46:00 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 7 Dec 2015 14:46:00 -0800 (PST)
In-Reply-To: <xmqq610alyy5.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: DS15mHUzK2kXutQ47uaGsdcV2tk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282135>

On Mon, Dec 7, 2015 at 4:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> James <rouzier@gmail.com> writes:
>> @@ -46,15 +46,15 @@ test_expect_success 'git clean' '
>>       mkdir -p build docs &&
>>       touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>>       git clean &&
>> -     test -f Makefile &&
>> -     test -f README &&
>> -     test -f src/part1.c &&
>> -     test -f src/part2.c &&
>> -     test ! -f a.out &&
>> -     test ! -f src/part3.c &&
>> -     test -f docs/manual.txt &&
>> -     test -f obj.o &&
>> -     test -f build/lib.so
>> +     test_path_is_file Makefile &&
>> +     test_path_is_file README &&
>> +     test_path_is_file src/part1.c &&
>> +     test_path_is_file src/part2.c &&
>> +     test_path_is_missing a.out &&
>> +     test_path_is_missing src/part3.c &&
>> +     test_path_is_file docs/manual.txt &&
>> +     test_path_is_file obj.o &&
>> +     test_path_is_file build/lib.so
>
> The verbosity of this conversion makes me wonder if we want to have
> "test_paths_are_files" and "test_paths_are_missing".  For that
> matter, this test does not really care about the distinction between
> files and directories (e.g. some tests said "test ! -d docs" and
> would have passed if there were a 'docs' regular file, but what we
> really care about is the path 'docs' is _gone_), so what we want may
> be test_paths_exist and test_paths_are_missing.  With that, the
> above hunk would become
>
>         test_paths_exist Makefile README src/part1.c src/part2.c \
>                 obj.o build/lib.so &&
>         test_paths_are_missing a.out src/part3.c
>
> I dunno.

Alternately, update test_path_foo() functions to accept multiple
pathnames, or is that too ugly?
