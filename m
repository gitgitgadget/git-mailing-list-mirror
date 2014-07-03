From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 2/7] replace: add test for --graft
Date: Thu, 3 Jul 2014 15:39:09 +0200
Message-ID: <CAP8UFD2L8wV=7dyW6ChA2Y1UddQnLMZ=b4eUvGYGQY65ndLgHA@mail.gmail.com>
References: <20140628171731.5687.30308.chriscool@tuxfamily.org>
	<20140628181117.5687.23923.chriscool@tuxfamily.org>
	<xmqqy4wbfpux.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 15:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2hEJ-0001PS-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jul 2014 15:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbaGCNjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 09:39:12 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:47514 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaGCNjK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 09:39:10 -0400
Received: by mail-vc0-f180.google.com with SMTP id im17so214471vcb.39
        for <git@vger.kernel.org>; Thu, 03 Jul 2014 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ghiZkOh/lWDpvhef6/ABOgHyjD6GAU9ZMpHZPZZNRek=;
        b=Q9MuoBpZc9VSl9eifqe1jKosd7tJekvbYOaN929JNAXoaqIU+I/NgbSAH3S4kI0IQi
         7sGCLS7QLhQDN2ny23xGwXLjeM5q/j62BnWOwQxKu63Dk5Uiq3cyFzQwEu9aYMR85Uov
         5m7gb7LOmm0DfksFJuAOPEsnjEfk1nsT6J0V5Qb9mcloHnQfSJqQflaJS2PDfteAsC5R
         6vtQzBhAXMJ2ybZYn12zchjb1ku1VvId2uSbQ//uMc9kio8p2VncWj7RfiYEIAAnVoPR
         vu5PEAtiqnhiqW55LbGI+nFRp/pnKoOYeT6pzxKNVlNWZZXjOJPCbNWb70yhiHeVy6Hk
         qAYA==
X-Received: by 10.220.114.140 with SMTP id e12mr515411vcq.37.1404394749633;
 Thu, 03 Jul 2014 06:39:09 -0700 (PDT)
Received: by 10.58.76.137 with HTTP; Thu, 3 Jul 2014 06:39:09 -0700 (PDT)
In-Reply-To: <xmqqy4wbfpux.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252859>

On Wed, Jul 2, 2014 at 10:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  t/t6050-replace.sh | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
>> index 68b3cb2..ca45a84 100755
>> --- a/t/t6050-replace.sh
>> +++ b/t/t6050-replace.sh
>> @@ -351,4 +351,16 @@ test_expect_success 'replace ref cleanup' '
>>       test -z "$(git replace)"
>>  '
>>
>> +test_expect_success '--graft with and without already replaced object' '
>> +     test $(git log --oneline | wc -l) = 7 &&
>> +     git replace --graft $HASH5 &&
>> +     test $(git log --oneline | wc -l) = 3 &&
>> +     git cat-file -p $HASH5 | test_must_fail grep parent &&
>
> Please do not run non-git command under test_must_fail.

Ok, I think I will just use the following then:

test_must_fail git rev-parse $HASH5^1

>> +     test_must_fail git replace --graft $HASH5 $HASH4 $HASH3 &&
>> +     git replace --force -g $HASH5 $HASH4 $HASH3 &&
>> +     git cat-file -p $HASH5 | grep "parent $HASH4" &&
>> +     git cat-file -p $HASH5 | grep "parent $HASH3" &&
>> +     git replace -d $HASH5
>> +'
>> +
>>  test_done
>
> For all these "git cat-file -p $commit | grep ...", I would think
> you should add "commit_has_parents" helper function to allow a bit
> more careful testing.  As written, the test will mistake a commit
> with string "parent $HASHx" anywhere, not in the header part, and
> the test does not ensure that $HASH{3,4} is the {first,second}
> parent.
>
>         commit_has_parents $HASH5 $HASH4 $HASH3
>
> would then may be implemented like:
>
>         commit_has_parents () {
>                 git cat-file commit "$1" >payload &&
>                 sed -n -e '/^$/q' -e 's/^parent //p' <payload >actual &&
>                 shift &&
>                 printf 'parent %s\n' "$@" >expect &&
>                 test_cmp expect actual
>         }

I think I'll rather use something like:

test $(git rev-parse $HASH5^1) = "$HASH4" &&
test $(git rev-parse $HASH5^2) = "$HASH3" &&
...

Thanks,
Christian.
