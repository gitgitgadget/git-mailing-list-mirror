From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT v2 12/29] "guilt header": more robust header selection.
Date: Fri, 16 May 2014 11:51:37 +0200
Message-ID: <CAP=KgsRmmmUOoasPGpJ12RRBXQxu07FbELHbQw38-=DM6MfW3w@mail.gmail.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
	<1400013065-27919-13-git-send-email-cederp@opera.com>
	<20140515224658.GA1334@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri May 16 11:51:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlEnn-0000cx-VI
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 11:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbaEPJvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 05:51:39 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:50967 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaEPJvi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 05:51:38 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so2280619ieb.13
        for <git@vger.kernel.org>; Fri, 16 May 2014 02:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=q5wueQLn6BeYhoVJjl+3bLNmYZGC45bqnfWHDLX3iE4=;
        b=NKD60ciUmmxpyjMlBY0y39ZSJLxw7lZ0q5p+T3gIW05zF3oG3OWnjxkTqZMKLHpAFg
         WRHpIOd1Kgs49xEvCnXkuFd89JpCatYGw3CttLEYkdkmwzDTSnWusFUE5FTB5n8QvLz6
         jTLB+7ILT7rK7zXxMFsC/fH/UYFTvU89Q0rEOLHO4WcZmo2cxXdf0H4rciGRJRv8vGAA
         OUAYhRQtlNG9eJrLdmuPEp3a1HzcS2DQCQ5/W9cqwq5yo9Oo8g4Z56lw/vlz5/jfN1fv
         HKFVQ8qDyZupINxqBIYm/wB/dntcCWzpPDXg09733ejXkXybA1469V80uz2+1P4vqtj7
         wFiA==
X-Gm-Message-State: ALoCoQkOW89klI55A0VClgQqj7Vcv8gf2ErLR5BNABFCnlBxEDXKOUlXCYagLo0qS5CySBex8fJ4
X-Received: by 10.42.30.71 with SMTP id u7mr15664679icc.20.1400233897862; Fri,
 16 May 2014 02:51:37 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Fri, 16 May 2014 02:51:37 -0700 (PDT)
In-Reply-To: <20140515224658.GA1334@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249289>

On Fri, May 16, 2014 at 12:46 AM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Tue, May 13, 2014 at 10:30:48PM +0200, Per Cederqvist wrote:
>> If you run something like "guilt header '.*'" the command would crash,
>> because the grep comand that tries to ensure that the patch exist
>> would detect a match, but the later code expected the match to be
>> exact.
>>
>> Fixed by comparing exact strings.
>>
>> And as a creeping feature "guilt header" will now try to use the
>> supplied patch name as an unachored regexp if no exact match was
>> found.  If the regexp yields a unique match, it is used; if more than
>> one patch matches, the names of all patches are listed and the command
>> fails.  (Exercise left to the reader: generalized this so that "guilt
>> push" also accepts a unique regular expression.)
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  guilt-header | 28 +++++++++++++++++++++++++---
>>  1 file changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/guilt-header b/guilt-header
>> index 41e00cc..4701b31 100755
>> --- a/guilt-header
>> +++ b/guilt-header
>> @@ -45,10 +45,32 @@ esac
>>  [ -z "$patch" ] && die "No patches applied."
>>
>>  # check that patch exists in the series
>> -ret=`get_full_series | grep -e "^$patch\$" | wc -l`
>> -if [ $ret -eq 0 ]; then
>> -     die "Patch $patch is not in the series"
>> +full_series=`get_tmp_file series`
>> +get_full_series > "$full_series"
>> +found_patch=
>> +while read x; do
>> +     if [ "$x" = "$patch" ]; then
>> +             found_patch="$patch"
>> +             break
>> +     fi
>> +done < "$full_series"
>
> We have to use a temp file instead of a 'get_full_series | while read x; do ...'
> because that'd create a subshell, correct?

Yes. Also (and probably less importantly) we sometimes need to run grep on
the same output (see the creation of TMP_MATCHES below) and it would
be a bit wasteful to run get_full_series twice. (The assumption is that it is
cheaper to create a temp file than to recompute the value. I have not measured
this, though.)

>> +if [ -z "$found_patch" ]; then
>> +     TMP_MATCHES=`get_tmp_file series`
>> +     grep "$patch" < "$full_series" > "$TMP_MATCHES"
>> +     nr=`wc -l < $TMP_MATCHES`
>> +     if [ $nr -gt 1 ]; then
>> +             echo "$patch does not uniquely identify a patch. Did you mean any of these?" >&2
>> +             sed 's/^/  /' "$TMP_MATCHES" >&2
>> +             rm -f "$TMP_MATCHES"
>> +             exit 1
>> +     elif [ $nr -eq 0 ]; then
>> +             rm -f "$TMP_MATCHES"
>> +             die "Patch $patch is not in the series"
>> +     fi
>> +     found_patch=`cat $TMP_MATCHES`
>> +     rm -f "$TMP_MATCHES"
>>  fi
>> +patch="$found_patch"
>
> Do we not delete $full_series?

Good catch. Will fix in the next version of the series.

I'll also rename the variable $TMP_FULL_SERIES to adhere
to the apparent coding style. (But I will not fix guilt-patchbomb
that uses $dir as a temporary variable.)

    /ceder

>>
>>  # FIXME: warn if we're editing an applied patch
>>
>> --
>> 1.8.3.1
>>
>
> --
> OpenIndiana ibdm: 8 cores, 12 GB RAM
