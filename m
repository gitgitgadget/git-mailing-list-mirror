From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t3404: preserve test_tick state across short SHA-1
 collision test
Date: Sun, 25 Aug 2013 03:53:56 -0400
Message-ID: <CAPig+cSns+_mOMRVRv2Kqb3vHNQGoE4NGZ3ELu7y3pQ57VqPXw@mail.gmail.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
	<1377112378-45511-2-git-send-email-sunshine@sunshineco.com>
	<20130825055550.GN2882@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 09:54:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDV99-0002r3-B5
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 09:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab3HYHx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 03:53:58 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:62748 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071Ab3HYHx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 03:53:57 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so1526336lab.24
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PaxoKHNcfraDxjszw02xvuptGaBVQCFK1XG8yF2cO+0=;
        b=RHJf3gQwcjLlsne4V5s+oY7o3BCoAYX+ZZNjLpkLN9iw7bcYVUh0XQTSWYBvLjzZvH
         JUn5wGb0mfbIOw1hVw/FajkfyHc2prx0qcaLBCN7PCZf/Ay+qipX4iINesOfMJG7RPbw
         wWHGsmVcP+DGv16y+Ms+4l/KEPAK7gMSR1HGnlKFQ5oFb1hOuviYXVKPyWdRDHqci+14
         QYe76KxRUi84W4XdtUAUDGKWIi1vOoJ6eOZ77fB3Do6vCJysmLp8yztCRxjvvQY9K8Kh
         P++KdI9Qpi0QAcNayBQZB3WzKVPJ8t+btUHPkN2grAgkXVIoYjpgwUJqzWmHFDeJlzBl
         C8Nw==
X-Received: by 10.152.37.41 with SMTP id v9mr7946148laj.9.1377417236499; Sun,
 25 Aug 2013 00:53:56 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 25 Aug 2013 00:53:56 -0700 (PDT)
In-Reply-To: <20130825055550.GN2882@elie.Belkin>
X-Google-Sender-Auth: TTyulZdZykRdnyQNMhHmyNbmyOM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232934>

On Sun, Aug 25, 2013 at 1:55 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Eric Sunshine wrote:
>
>> The short SHA-1 collision test requires carefully crafted commits in
>> order to ensure a collision at rebase time.
>
> Yeah, this breaks the usual rule that tests should be independent
> of hashing function.  But it's the best we can do, I think.
>
> [...]
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -994,17 +994,23 @@ test_expect_success 'short SHA-1 setup' '
>>       test_when_finished "git checkout master" &&
>>       git checkout --orphan collide &&
>>       git rm -rf . &&
>> +     (
>>       unset test_tick &&
>>       test_commit collide1 collide &&
>>       test_commit --notick collide2 collide &&
>>       test_commit --notick "collide3 115158b5" collide collide3 collide3
>> +     )
>
> Would be clearer if the code in a subshell were indented:
>
>         (
>                 unset test_tick &&
>                 test_commit ...
>         )

I considered it, but decided against it for a couple reasons:

* In this script, there already is a mix between the two styles:
indented vs. unindented.

* In this particular patch, the test_commit line creating commit3
wrapped beyond 80 columns when indented.

In v2 of the series (for which you also made the same observation),
the collide3 test_commit line is shorter, so I could have indented,
however, I left it alone since nobody complained about it (and because
there already is the mix of styles). Should this be worth a re-roll?

> [...]
>>  test_expect_success 'short SHA-1 collide' '
>>       test_when_finished "reset_rebase && git checkout master" &&
>>       git checkout collide &&
>> +     (
>> +     unset test_tick &&
>> +     test_tick &&
>>       FAKE_COMMIT_MESSAGE="collide2 815200e" \
>>       FAKE_LINES="reword 1 2" git rebase -i HEAD~2
>> +     )
>
> Likewise.
>
> Hope that helps,
> Jonathan
