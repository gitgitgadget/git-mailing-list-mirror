From: Tamas Csabina <tcsabina@gmail.com>
Subject: Re: slow process of post-receive script on a remote (samba) share
Date: Thu, 13 Jun 2013 15:47:32 +0200
Message-ID: <CAH+Cn14neoV9eXqBAj6_MPXTXK00S=-MnBYs20gaBLZ7YjL00Q@mail.gmail.com>
References: <CAH+Cn14TLpR1KT+3GND2Zmb8tDmFBP7AWpyrT7nVeMFw6V7FGA@mail.gmail.com>
	<87li6eqk2a.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 13 15:47:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un7sI-0000mL-7H
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 15:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323Ab3FMNrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 09:47:33 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:54769 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab3FMNrd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 09:47:33 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so15000990obb.33
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 06:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y+9NuPp40Z75RY+44Rjfv2vBoebYmMs1xKReif0zmG8=;
        b=FGYgbL6h2SiB6tJHgQWfZupY55lnknDVVVCpqpy6cER/PlZaUUQI0M3B6BDFYYXYJ4
         cKxFs4M1/5R5Acxc/D6O0U5TeThR1hgnC9B5sk8etxpiwIt3q9ArJUt7/Jj8+TKpHnbG
         DpRZxp2grN5qFytsY2PgGGVuqkXNEk39CfERSTlf43IIlvv2wYUXTYFgTp3SrfnMcwaw
         oGpnhXNnEHLgStg7XOUm4jDL5pfnL2OvzOhDDtgNgcd5u3XGcJwDt8fEzPoElGkpMcmN
         Ntm28O8LP1mGhAV+a7YaAa+DuBDenb8KOoimMaukd9Q4FjwTstF9E1ulAeK9UGlUsTa8
         pocQ==
X-Received: by 10.60.135.134 with SMTP id ps6mr705761oeb.114.1371131252594;
 Thu, 13 Jun 2013 06:47:32 -0700 (PDT)
Received: by 10.76.110.71 with HTTP; Thu, 13 Jun 2013 06:47:32 -0700 (PDT)
In-Reply-To: <87li6eqk2a.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227737>

Hi Thomas,

Thanks for the reply.
The script is a bash script, just to mention.

Meanwhile I`ve figured it out that the sluggish post-receive execution
was due to a (mis)-configuration in the samba share where the remote
repository is hosted. These are:
oplocks = No
level2 oplocks = No

Removing these from the share`s section in the smb.conf solved the
issue, and the push process is taking up around 4 seconds, which I
think is reliable.


Now, do I have to worry about allowing oplocks on the remote
repository from the git point of view? Thinking about concurrent push
operations from different developers?


Tamas


On 13 June 2013 14:19, Thomas Rast <trast@inf.ethz.ch> wrote:
> Tamas Csabina <tcsabina@gmail.com> writes:
>
>> I am using Git bash from version 1.8.3.msysgit.0, on a Windows 7x64 PC.
>> I have an issue with executing git push if I have a post-receive
>> script configured.
>> The content of the script is not really important, as if I have a
>> script that contains only commented out lines (around 70 lines), my
>> git push command is delayed with around 5 seconds.
>>
>>
>> I`ve tested the script on another PC and it is working fine. No delay
>> at all. So there are some issues on my PC regarding how git processes
>> remote scripts.
>>
>> I took a wireshark trace with 2 scenarios on my PC:
>>
>>  1. just execute `cat <path_to_the_script>\post-receive` command in the git bash
>>  2. did a `real` git push
>>
>> Results of the wireshark traces shows:
>>
>>  1. Read AndX Request, FID: 0x228f, 1024 bytes at offset 0 (1024 bytes
>> at time, always)
>>  2. Read AndX Request, FID: 0x21c9, 1 byte at offset 0 (1 byte, always)
>>
>> Conclusion:
>> git push command reads the post-receive script in 1 byte chunks, which
>> dramatically slows down the execution process.
>
> git doesn't read the script; the interpreter does.  In the case of a
> script, the interpreter is specified in the #! line at the top; in the
> case of a binary executable, it is specified within the executable (and
> for linux, is usually /lib/ld-linux.so.2).
>
> Exactly the same should happen if you run the hook manually, so you can
> try that to debug it.
>
> Note also that Weird Things(tm) relating to SIGPIPE may happen if you
> don't read your input.  Even if you are only fooling around for testing,
> a post-receive hook must consume its input, e.g., by discarding it with
> 'cat >/dev/null'.
>
> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
