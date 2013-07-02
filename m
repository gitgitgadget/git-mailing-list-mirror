From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 2/4] contrib: contacts: add support for multiple patches
Date: Tue, 2 Jul 2013 04:52:51 -0400
Message-ID: <CAPig+cTO2vMg1Feb+3WGa=h89r-xAF=zpG9fxvDwR0HaUJK=jg@mail.gmail.com>
References: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
	<1372590512-21341-3-git-send-email-sunshine@sunshineco.com>
	<7v7ghaglmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 10:53:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtwKb-0006Z5-8g
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 10:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360Ab3GBIw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 04:52:56 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44222 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab3GBIww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 04:52:52 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so11626782ieb.16
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 01:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=o8XKNItKTdTnObKPjUCzjPk9NJne6QsLdhcUwi83lWo=;
        b=JpEwoIBzGH39yKUSoV0tJsqXdqkJGT4A8fUPU57gPgtvsr/Mzofzg3wnWSd9Yhq9MR
         wO8Rl5hf8PPDxHjdCWpowvfJdUNfPnS+S4SIpCjxWfNLU4dt4SLs1PnikFVoZQt5QSAH
         uYgx6D77sT5tQA0Y6y3AeR2PDG2dTTIgP0T9gzPFoBOdONgCdlurZWmQyjP/2VFohkGh
         bsqco73KbzDeo8O5nRz6qya8AO6QRBuPw7/zMR4MiRk479/76qbgUGhVjyuRlFiRtQKz
         9sHP48//5dEXDmmiS3er/1izDZ0TqYua7XF76rWcTu6/kpXMS6koRYRajUuC24h73kaN
         CiXg==
X-Received: by 10.50.61.236 with SMTP id t12mr18950450igr.46.1372755171832;
 Tue, 02 Jul 2013 01:52:51 -0700 (PDT)
Received: by 10.64.86.164 with HTTP; Tue, 2 Jul 2013 01:52:51 -0700 (PDT)
In-Reply-To: <7v7ghaglmx.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: P5b0Yzf-OCeu5UJT0dYSyu0hgCs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229378>

On Mon, Jul 1, 2013 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Accept multiple patch files rather than only one. For example:
>>
>>   % git contacts feature/*.patch
>>
>> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
>
>> @@ -93,6 +96,7 @@ sub commits_from_patch {
>>       while (<$f>) {
>>               if (/^From ($id_rx) /o) {
>>                       $id = $1;
>> +                     $seen{$id} = 1;
>>                       last;
>>               }
>>       }
>
> This looks less useful than it could be.
>
>         $ git format-patch --stdout -4 >P.mbox
>         $ git contacts P.mbox
>
> would have the same number of patches but in a single file.
>
> Wouldn't it be more useful to do something like
>
>         $id = undef;
>         while (<$f>) {
>                 if (/^From ([0-9a-f]{40}) Mon Sep 17 00:00:00 2001$/) {
>                         # beginning of a patch
>                         $id = $1;
>                 }
>                 next if (!defined $id);
>                 # inline the body of scan_hunks here...
>                 if (m{^--- (a/.*|/dev/null)$}) {
>                         $source = ...
>                 } elsif (/^@@ -(\d+)...) {
>                         get_blame();
>                 }
>         }

Good point. It did not occur to me that a single file might contain
multiple patches. Felipe's script handled this case correctly.

>> @@ -100,10 +104,8 @@ sub commits_from_patch {
>>       close $f;
>>  }
>>
>> -exit 1 unless @ARGV == 1;
>> -
>>  my %commits;
>> -commits_from_patch(\%commits, $ARGV[0]);
>> +commits_from_patch(\%commits, $_) for (@ARGV);
>
> This change does not seem to account for an invocation without any
> argument.  Perhaps write it like so to make it more readable?
>
>         if (!@ARGV) {
>                 die "No input file?\n";
>         }
>
>         for (@ARGV) {
>                 commits_from_patch(\%commits, $_);
>         }

Emitting a diagnostic about missing input makes sense.
