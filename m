From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/9] Pass directory indicator to match_pathspec_item()
Date: Sat, 25 Jan 2014 11:24:11 +0700
Message-ID: <CACsJy8Aj8EnDD5Qk=VStpDXTAV-WOh_utmiY+qXGyCwoXpQHog@mail.gmail.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
 <1390570836-20394-1-git-send-email-pclouds@gmail.com> <1390570836-20394-7-git-send-email-pclouds@gmail.com>
 <CAPig+cRW5Fz62Qk22qiUo85jmqVK0Hvbb6v2GxK7V+wS+S8_qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	pawel.sikora@agmk.net, Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Jan 25 05:24:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6und-0005NP-0i
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jan 2014 05:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbaAYEYm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 23:24:42 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:54937 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbaAYEYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 23:24:42 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so4982117qaq.11
        for <git@vger.kernel.org>; Fri, 24 Jan 2014 20:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=HHk7CGfVu6GGfKJkYbP/T2sm32/H1aNzBfsezZt77dk=;
        b=GM1g9T3rqbHxoyqpPYEbzTxHk1ksERCQtgIlQrbZrhZEf2I/ClOQCYTQ6hZwQwfkCR
         XE9HfGFaoteijNZwyZVjO//cOXtXJgBKIoPQyLqk5zs9zetGZpui8EVIfVdoWwDi4EHw
         sTqubG7LxaFkQ8df6dAEbyX8kXge0OZxOC5yyBfZY38hUvlWwzk75iQZ8p2o4TXU2Dyo
         yyKMHH3tnXwHWb+g9kU/9gAB6lJWvRhwgjAvmGSgcVc1n5jihZVzPCuPgPpl2/ljcu19
         MaVCZKd+QyBnPeGtV9cEfqNjvQ9QOiQRkRE1eO5aWTePv2Ug4RUTQJT7T7m9vVmQQ6uD
         PCSw==
X-Received: by 10.229.10.197 with SMTP id q5mr25792682qcq.15.1390623881362;
 Fri, 24 Jan 2014 20:24:41 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Fri, 24 Jan 2014 20:24:11 -0800 (PST)
In-Reply-To: <CAPig+cRW5Fz62Qk22qiUo85jmqVK0Hvbb6v2GxK7V+wS+S8_qw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241061>

On Sat, Jan 25, 2014 at 4:22 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Fri, Jan 24, 2014 at 8:40 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> diff --git a/t/t4010-diff-pathspec.sh b/t/t4010-diff-pathspec.sh
>> index af5134b..167af53 100755
>> --- a/t/t4010-diff-pathspec.sh
>> +++ b/t/t4010-diff-pathspec.sh
>> @@ -110,4 +110,21 @@ test_expect_success 'diff-tree -r with wildcard=
' '
>>         test_cmp expected result
>>  '
>>
>> +test_expect_success 'setup submodules' '
>> +       test_tick &&

Also the test_tick here. I thought I would need to match SHA-1 but I
did not and still forgot to take this line out.

>> +       git init submod &&
>> +       ( cd submod && test_commit first; ) &&
>
> Unnecessary semicolon might confuse the reader into thinking somethin=
g
> unusual is going on here.
>
>> +       git add submod &&
>> +       git commit -m first &&
>> +       ( cd submod && test_commit second; ) &&
>
> Ditto.
>
>> +       git add submod &&
>> +       git commit -m second
>> +'
>> +
>> +test_expect_success 'diff-cache ignores trailing slash on submodule=
 path' '
>> +       git diff --name-only HEAD^ submod >expect &&
>> +       git diff --name-only HEAD^ submod/ >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>>  test_done



--=20
Duy
