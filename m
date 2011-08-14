From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH resend] Makefile: Use computed header dependencies if the
 compiler supports it
Date: Sun, 14 Aug 2011 21:53:24 +0200
Message-ID: <CALx8hKRBjXr44gM1JA+d=RU80pmruPV56s-G3JvViz87eJ=ajQ@mail.gmail.com>
References: <1313347512-7815-1-git-send-email-frekui@gmail.com>
	<20110814190050.GA16819@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 21:53:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsgkW-00042M-AQ
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 21:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab1HNTx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 15:53:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38168 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1HNTx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 15:53:26 -0400
Received: by fxh19 with SMTP id 19so3238336fxh.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=67o+yX4YBDTUXuhDTKETYT9Ai9QDVfrVS2TSdD5EIQA=;
        b=d4SOm0f4xp4+l/7p0sQHIpJDpLb8Ij2+ySW3zXVtWXcEP74DLykS3u2qsMVtbKmHYC
         Kgzv9vQgx7wmF/CFbfwJzIyvz2VY8qEYjJh2xywskFPqXF9lGgunkklgO4g7KRExa7bX
         ECLUAe73FfvFRACGA0eXCfCggQyjWr32lrTxM=
Received: by 10.223.68.136 with SMTP id v8mr4326157fai.54.1313351604925; Sun,
 14 Aug 2011 12:53:24 -0700 (PDT)
Received: by 10.223.124.199 with HTTP; Sun, 14 Aug 2011 12:53:24 -0700 (PDT)
In-Reply-To: <20110814190050.GA16819@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179345>

Hi Jonathan,

Thanks for your comments.

On Sun, Aug 14, 2011 at 21:00, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
>> --- a/Makefile
>> +++ b/Makefile
> [...]
>> @@ -1236,6 +1232,15 @@ endif
>> =A0ifdef CHECK_HEADER_DEPENDENCIES
>> =A0COMPUTE_HEADER_DEPENDENCIES =3D
>> =A0USE_COMPUTED_HEADER_DEPENDENCIES =3D
>> +else
>> +dep_check =3D $(shell sh -c \
>> + =A0 =A0 ': > ++empty.c; \
>> + =A0 =A0 $(CC) -c -MF /dev/null -MMD -MP ++empty.c -o /dev/null 2>&=
1; \
>> + =A0 =A0 echo $$?; \
>> + =A0 =A0 $(RM) ++empty.c')
>> +ifeq ($(dep_check),0)
>> +COMPUTE_HEADER_DEPENDENCIES=3DYesPlease
>> +endif
>
> This causes "make foo" to run gcc and create a temporary file
> unconditionally, regardless of what foo is. =A0In an ideal world:
>
> =A0- the autodetection would only happen when building targets that
> =A0 care about it

In an ideal world, yes. But I don't see a simple and maintainable
way to do it for only those targets.

> =A0- the detection would happen once (creating some file to store the
> =A0 result) and not be repeated with each invocation of "make"
>
> =A0- (maybe) there would be a way to override the detection with
> =A0 either a "yes" or "no" result, for those who really care to
> =A0 save a little time.

I have done some benchmarking (see below) and considering the
results I got, I think implementing any of these two is not worth it.

> I was about to say that the GIT_VERSION variable has some of these
> properties, but now that I check, from the point of view of the
> Makefile it doesn't. =A0./GIT-VERSION-GEN is just very fast. :)
>
> I wonder if we can make do with a faster check, like
>
> =A0 =A0 =A0 =A0$(CC) -c -MF /dev/null -MMD -MP git.c --help >/dev/nul=
l 2>&1
>
> What do you think?
>

Here are some benchmarks done with 'perf stat'. Before each invocation
of perf stat I ran a plain 'make' to make sure that everything was comp=
iled.
Note that a fully compiled source tree is the worst case when it comes =
to
the overhead of the auto-detection.

Without patch (with COMPUTE_HEADER_DEPENDENCIES=3DYes):
 Performance counter stats for 'make' (10 runs):

         1,566,393 cache-misses             #      1.557 M/sec   ( +-  =
 0.264% )
         6,428,212 cache-references         #      6.391 M/sec   ( +-  =
 0.168% )
        21,245,775 branch-misses            #      4.626 %       ( +-  =
 0.015% )
       459,268,954 branches                 #    456.585 M/sec   ( +-  =
 0.031% )
     2,594,717,999 instructions             #      1.177 IPC     ( +-  =
 0.022% )
     2,205,246,745 cycles                   #   2192.359 M/sec   ( +-  =
 0.136% )
            43,532 page-faults              #      0.043 M/sec   ( +-  =
 0.034% )
               215 CPU-migrations           #      0.000 M/sec   ( +-  =
 0.891% )
               457 context-switches         #      0.000 M/sec   ( +-  =
 0.654% )
       1005.878305 task-clock-msecs         #      1.022 CPUs    ( +-  =
 0.544% )

        0.984526665  seconds time elapsed   ( +-   0.591% )

With patch:
 Performance counter stats for 'make' (10 runs):

         1,796,342 cache-misses             #      1.732 M/sec   ( +-  =
 0.702% )
         6,929,739 cache-references         #      6.682 M/sec   ( +-  =
 0.186% )
        21,582,772 branch-misses            #      4.575 %       ( +-  =
 0.032% )
       471,783,920 branches                 #    454.934 M/sec   ( +-  =
 0.024% )
     2,662,671,428 instructions             #      1.166 IPC     ( +-  =
 0.017% )
     2,282,907,087 cycles                   #   2201.372 M/sec   ( +-  =
 0.162% )
            49,244 page-faults              #      0.047 M/sec   ( +-  =
 0.031% )
               233 CPU-migrations           #      0.000 M/sec   ( +-  =
 0.823% )
               489 context-switches         #      0.000 M/sec   ( +-  =
 0.460% )
       1037.038252 task-clock-msecs         #      1.022 CPUs    ( +-  =
 0.579% )

        1.014409177  seconds time elapsed   ( +-   0.476% )

With patch, but changed to use git.c instead of ++empty.c:
 Performance counter stats for 'make' (10 runs):

         2,125,147 cache-misses             #      1.737 M/sec   ( +-  =
 0.287% )
         9,080,043 cache-references         #      7.423 M/sec   ( +-  =
 0.185% )
        24,573,023 branch-misses            #      4.222 %       ( +-  =
 0.032% )
       582,018,515 branches                 #    475.809 M/sec   ( +-  =
 0.012% )
     3,185,328,930 instructions             #      1.165 IPC     ( +-  =
 0.009% )
     2,734,176,502 cycles                   #   2235.229 M/sec   ( +-  =
 0.122% )
            51,032 page-faults              #      0.042 M/sec   ( +-  =
 0.034% )
               227 CPU-migrations           #      0.000 M/sec   ( +-  =
 0.943% )
               515 context-switches         #      0.000 M/sec   ( +-  =
 0.351% )
       1223.219930 task-clock-msecs         #      1.019 CPUs    ( +-  =
 0.579% )

        1.200869268  seconds time elapsed   ( +-   0.555% )


So, on my machine the auto-detection logic adds a slight overhead
(0.03s, 3% in a fully compiled tree). Using git.c is slower than using
++empty.c. IMHO adding any extra complexity to lower the 0.03s
is not worth it.

- Fredrik
