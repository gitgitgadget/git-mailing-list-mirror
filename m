From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Fri, 28 Aug 2015 00:36:35 +0900
Message-ID: <CAM9d7chUf=srU060Q4+qQ4mFBaXmRL0yQ1Ns4UeWcDj62CFoYg@mail.gmail.com>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com> <1440688825-1303-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Aug 27 17:37:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUzEa-0007Y1-0T
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 17:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbbH0Pg4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Aug 2015 11:36:56 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33558 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbH0Pgz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Aug 2015 11:36:55 -0400
Received: by igbjg10 with SMTP id jg10so19559283igb.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 08:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NxMwwOy0wv1wnVhmfQ3WG/6yICGHnSnAQvHRMDXskPc=;
        b=TkkQ/AC/ziXink3CupzspampjKFcbHi1WaksEPR4fMppHyOnF7KaAIBsZS24RHaPp/
         CKsvErjwGfZDZ2xqRp9v8fVEIgQAM+bnL2z3VFa9gzka5qzmPkGm16P5GsSeabfEfdb9
         IUMADhdKxZHAEH8rzo7Tcv0u4TOABvqusQ30yRDHSTRxyBI3cCubJQPOZNKvKB4Glglf
         9XzsLLYwnJO41hwTNz7b72AdXn9iMuxk72M0xFVd3Mzxo3089b8q1foia9/rhNfBJ9OQ
         1C4jXV7yMY2udCm5uVU9rmNshcvDH37kENskf8kZ+koqfHWEeBdEsruWiKLjF8iPz45F
         RcYA==
X-Received: by 10.50.17.9 with SMTP id k9mr10650039igd.93.1440689814973; Thu,
 27 Aug 2015 08:36:54 -0700 (PDT)
Received: by 10.107.20.5 with HTTP; Thu, 27 Aug 2015 08:36:35 -0700 (PDT)
In-Reply-To: <1440688825-1303-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276678>

Hi,

On Fri, Aug 28, 2015 at 12:20 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de>=
 wrote:
> Hi,
>
> I haven't made up my mind about this feature yet, but have a few
> comments about its implementation.

Thanks for taking your time!

>
>> diff --git a/git-stash.sh b/git-stash.sh
>> index 1d5ba7a..8432435 100755
>> --- a/git-stash.sh
>> +++ b/git-stash.sh
>> @@ -33,6 +33,12 @@ else
>>         reset_color=3D
>>  fi
>>
>> +if git config --get stash.showflag > /dev/null 2> /dev/null; then
>> +     show_flag=3D$(git config --get stash.showflag)
>> +else
>> +     show_flag=3D--stat
>> +fi
>> +
>
> Forking and executing processes are costly on some important platform=
s
> we care about, so we should strive to avoid them whenever possible.
>
>  - This hunk runs the the exact same 'git config' command twice.  Run=
 it
>    only once, perhaps something like this:
>
>      show_flag=3D$(git config --get stash.showflag || echo --stat)
>
>    (I hope there are no obscure crazy 'echo' implemtations out there
>    that might barf on the unknown option '--stat'...)

What about `echo "--stat"` then?

>
>  - It runs 'git config' in the main code path, i.e. even for subcomma=
nds
>    other than 'show'.  Run it only for 'git stash show'.
>
>  - This config setting is not relevant if there were options given on=
 the
>    command line.  Run it only if there are no options given, i.e. whe=
n
>    $FLAGS is empty.

=46air enough.  I'll resend v2.

Thanks,
Namhyung


>
>
>>  no_changes () {
>>       git diff-index --quiet --cached HEAD --ignore-submodules -- &&
>>       git diff-files --quiet --ignore-submodules &&
>> @@ -305,7 +311,7 @@ show_stash () {
>>       ALLOW_UNKNOWN_FLAGS=3Dt
>>       assert_stash_like "$@"
>>
>> -     git diff ${FLAGS:---stat} $b_commit $w_commit
>> +     git diff ${FLAGS:-${show_flag}} $b_commit $w_commit
>>  }
>>
>>  show_help () {
>> --
>> 2.5.0
