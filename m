From: Patrick Palka <patrick@parcs.ath.cx>
Subject: Re: [PATCH] Improve contrib/diff-highlight to highlight
 unevenly-sized hunks
Date: Thu, 18 Jun 2015 12:28:58 -0400
Message-ID: <CA+C-WL-CC9o13Rxrr+mKw+vbx=aEJmguLnwMwO=fE-JPJ2DqEg@mail.gmail.com>
References: <1434388853-23915-1-git-send-email-patrick@parcs.ath.cx> <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 18:29:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5cgv-0001dS-CA
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 18:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbbFRQ3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 12:29:21 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33348 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbbFRQ3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 12:29:19 -0400
Received: by oiyy130 with SMTP id y130so44301402oiy.0
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 09:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=10ao/CMAYeDL+jjWZRBx8VRy80GJCsZRL2k0pZmCMFw=;
        b=QMGNrzRDkS17O6Cry3xAoDKJporwgkFem6Gta6CzsAZZsETYPA6RUbm7eWWkmhYClw
         S/yzJIFFKzKTM1dAhkQlIRjHk8/oTFlRZHeYBoNBN8pPBPn+UOPYPdcJid036BRaqANE
         3ym5nEYfCfmDG5noGCCT5SYXKKTxO67EI8wNL7l6KMONm4t21Es3vDeURYGCn1gtJpSp
         jCmuo7GKc3cNQXka08yqz89jKq1U+XEKh4Ymyj0fUnBuEkSnlpLrhxlXNuL2RxwEY2MU
         5Kw8LT2HH+/YGsnt1MdGotwz6D1bRmb2r2RG7zAvzCiEWRb/dwJM+UnvSR1EnhtDTn4j
         y9EQ==
X-Gm-Message-State: ALoCoQm9FNpF6gQ44GgsyRpmKGN/q4ih7CSNEQwxkO4yXjpHcK8pM+VdHZpy2R6QHrkIKBXVKhMt
X-Received: by 10.182.42.131 with SMTP id o3mr9778712obl.59.1434644958699;
 Thu, 18 Jun 2015 09:29:18 -0700 (PDT)
Received: by 10.182.96.167 with HTTP; Thu, 18 Jun 2015 09:28:58 -0700 (PDT)
X-Originating-IP: [67.83.172.216]
In-Reply-To: <xmqqwpz1f22b.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272023>

On Thu, Jun 18, 2015 at 11:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Patrick Palka <patrick@parcs.ath.cx> writes:
>
>> Currently the diff-highlight script does not try to highlight hunks that
>> have different numbers of removed/added lines.  But we can be a little
>> smarter than that, without introducing much magic and complexity.
>>
>> In the case of unevenly-sized hunks, we could still highlight the first
>> few (lexicographical) add/remove pairs.  It is not uncommon for hunks to
>> have common "prefixes", and in such a case this change is very useful
>> for spotting differences.
>>
>> Signed-off-by: Patrick Palka <patrick@parcs.ath.cx>
>> ---
>
> Patrick, "git shortlog --no-merges contrib/diff-highlight/" is your
> friend to see who may be able to give you a good feedback.

Sorry about that.  I admit the sending of this patch was rushed for no
good reason.

>
> Jeff, what do you think?
>
> I have this nagging feeling that it is just as likely that two
> uneven hunks align at the top as they align at the bottom, so while
> this might not hurt it may not be the right approach for a better
> solution, in the sense that when somebody really wants to do a
> better solution, this change and the original code may need to be
> ripped out and redone from scratch.

Hmm, maybe. I stuck with assuming hunks are top-aligned because it
required less code to implement :)

The benefits of a simple dumb solution like assuming hunks align at
the top or bottom is that it remains very easy to visually match up
each highlighted deleted slice with its corresponding highlighted
added slice. If we start matching up similar lines or something like
that then it seems we would have to mostly forsake this benefit.  A
stupid algorithm in this case is nice because its output is
predictable.

A direct improvement upon this patch that would not require redoing
the whole script from scratch would be to first to calculate the
highlighting assuming the hunk aligns at the top, then to calculate
the highlighting assuming the hunk aligns at the bottom, and to pick
out of the two the highlighting with the least "noise".  Though we
would still be out of luck if the hunk is more complicated than being
top-aligned or bottom-aligned.

By the way, what would it take to get something like this script into
git proper?  It is IMHO immensely useful even in its current form, yet
because it's not baked into the application hardly anybody knows about
it.

>
>>  contrib/diff-highlight/diff-highlight | 26 +++++++++++++++++---------
>>  1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
>> index ffefc31..0dfbebd 100755
>> --- a/contrib/diff-highlight/diff-highlight
>> +++ b/contrib/diff-highlight/diff-highlight
>> @@ -88,22 +88,30 @@ sub show_hunk {
>>               return;
>>       }
>>
>> -     # If we have mismatched numbers of lines on each side, we could try to
>> -     # be clever and match up similar lines. But for now we are simple and
>> -     # stupid, and only handle multi-line hunks that remove and add the same
>> -     # number of lines.
>> -     if (@$a != @$b) {
>> -             print @$a, @$b;
>> -             return;
>> -     }
>> +     # We match up the first MIN(a, b) lines on each side.
>> +     my $c = @$a < @$b ? @$a : @$b;
>>
>> +     # Highlight each pair, and print each removed line of that pair.
>>       my @queue;
>> -     for (my $i = 0; $i < @$a; $i++) {
>> +     for (my $i = 0; $i < $c; $i++) {
>>               my ($rm, $add) = highlight_pair($a->[$i], $b->[$i]);
>>               print $rm;
>>               push @queue, $add;
>>       }
>> +
>> +     # Print the remaining unmatched removed lines of the hunk.
>> +     for (my $i = $c; $i < @$a; $i++) {
>> +             print $a->[$i];
>> +     }
>> +
>> +     # Print the added lines of each highlighted pair.
>>       print @queue;
>> +
>> +     # Print the remaining unmatched added lines of the hunk.
>> +     for (my $i = $c; $i < @$b; $i++) {
>> +             print $b->[$i];
>> +     }
>> +
>>  }
>>
>>  sub highlight_pair {
