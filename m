From: Danny Lin <danny0838@gmail.com>
Subject: Re: [PATCH] contrib/subtree: fix linefeeds trimming for cmd_split()
Date: Wed, 6 May 2015 17:57:53 +0800
Message-ID: <CAMbsUu6=U92TRo-UeOL1qtaTipMQFzD+m+wM7sn1o-AjD6LJBw@mail.gmail.com>
References: <CAMbsUu6xZrMu_jrV=jR4XNLf1UXLApBiAWJiWJuKRb4xN90QJQ@mail.gmail.com>
	<xmqq4mnqet5d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 11:58:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ypw5Z-0004uq-G8
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 11:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbbEFJ54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 05:57:56 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:34722 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbEFJ5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 05:57:53 -0400
Received: by qcyk17 with SMTP id k17so1816252qcy.1
        for <git@vger.kernel.org>; Wed, 06 May 2015 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H6cG9RP3pmEeRsQqBKXAqNeNRWijs3byX7bjT0Gpsd8=;
        b=kGrzwkrh4Wd6hf3IX3fhYc5P5NCbH9AGwkg9xQCPuOmWbm/mI0zDdFKPFtT3vUjQI2
         DZO0NkGf9rjbmzoace4KVv95ddmVl0gOlK9+IYVUf89YDidhkmCqIzXf30s4mezz2Hlr
         MBZa8WODSOkgoHx7xLGiDz9V6RhZVUt07FuDR6T/7G4qwp+BPeSUQ5Vtpoz3UkZeUVaR
         n5oGRLTryYapFXcqCprvrUMAJYAPITfmVXXfxOzRgHRltklvoe9WvIJ//zOO6HdcGvFV
         5bIvaGA5hVE2W0YD6PNS/ffwagNPyzcf7myDtaptUVv0o9w6RjwHGYxXhW92EF/KTweB
         DXzg==
X-Received: by 10.140.40.137 with SMTP id x9mr38129635qgx.75.1430906273229;
 Wed, 06 May 2015 02:57:53 -0700 (PDT)
Received: by 10.140.98.145 with HTTP; Wed, 6 May 2015 02:57:53 -0700 (PDT)
In-Reply-To: <xmqq4mnqet5d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268464>

Thank you for clearifying this. It seems that it's my terminal
trimming the <CR> from the source code.

If I run a script file with:
echo -n "Hello, world1<CR>"
echo -n "Hello, world2<CR>"
echo -n "Hello, world3<CR>"
echo -n "Hello, world4<CR>"

I get this on the screen:
Hello, world1Hello, world2Hello, world3Hello, world4

If I run with:
printf "Hello, world1\r"
printf "Hello, world2\r"
printf "Hello, world3\r"
printf "Hello, world4\r"

I get this on the screen:
Hello, world4

I don't see a problem in 'git fetch' or 'git checkout'

Maybe using printf is the way to go?

2015-05-06 3:11 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Danny Lin <danny0838@gmail.com> writes:
>
>>> I think this was written knowing that "say" is merely a thin wrapper
>>> of "echo" (which is a bad manner but happens to be correct) and
>>> assuming that everybody's "echo" understands "-n" (which is not a
>>> good assumption) to implement "progress display" that shows the "N
>>> out of M done" output over and over on the same physical line.
>>>
>>> So,... contrary to your "makes no sense" claim, what it tries to do
>>> makes perfect sense to me, even though its execution seems somewhat
>>> poor.
>>>
>> The original version has a CR (yes, it's CR, not LF) at the end of the
>> "say -n" string, which is weird. If it's meant to print a linefeed, we should
>> remove the CR and use "say". If it's meant not to print a linefeed, we still
>> should remove the CR.
>
> Neither.  It is meant to print a carriage-return, i.e. "go back to
> the left-most column on the same line, without feeding a new line to
> the terminal (causing the output to scroll-up by one line)".
>
> It sounds to me that your terminal is not supporting carriage-return
> in a way everybody else expects it to?  It is not just this script,
> but all the progress output we generate use CR for that purpose.
>
> Do you see a similar "garbled" output from say "git fetch" or "git
> checkout" that takes more than a few hundred milliseconds?
>
>
