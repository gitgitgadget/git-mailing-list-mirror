From: Eugene Letuchy <eletuchy@gmail.com>
Subject: Re: [PATCH] Make git blame date output format configurable, a la git 
	log
Date: Fri, 20 Feb 2009 08:13:34 -0800
Message-ID: <fbb390660902200813h2455eak4e72144c7c491ef9@mail.gmail.com>
References: <1235136252-29649-1-git-send-email-eletuchy@gmail.com>
	 <20090220142730.GA32751@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, marius@trolltech.com,
	Eugene Letuchy <eugene@facebook.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:15:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaY21-0006K2-BE
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbZBTQNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbZBTQNj
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:13:39 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:50330 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791AbZBTQNg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 11:13:36 -0500
Received: by bwz5 with SMTP id 5so2712532bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 08:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/rQo55zzSUWF2l6sXQhQoOPL4TrZUm0I/kMjdNikoFI=;
        b=q2IqJl9BQi0/0cDCidsKO15c2MM4SxnEyTVope0f/M0AKbk1gauIg0Y7pGJl461iV1
         F850LYUW303epobI5p0nmbE04lNoDO9o07l3NGEtNX+jytwNREiildL+lTlpyOmXqupF
         IOVwnXCQsA6OfZqK/S6yIPGzQbCJeiEMunPqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YMQJDGLRUjx9GKXnqdBFnbnobeWEwGerotaVywjBSmvxwErWDnhbgJGzrTWpGCJC5n
         IbsLEI7BRAMa+jIMyScLwrmWCrTa+g6fEmPnKxUP+0oKNrc7gncvQ8J1SPDAjGA00Id2
         CoeIzcHZTuDqsejaoAab4O3GqceO3vRg9rJDE=
Received: by 10.181.218.10 with SMTP id v10mr335512bkq.2.1235146414441; Fri, 
	20 Feb 2009 08:13:34 -0800 (PST)
In-Reply-To: <20090220142730.GA32751@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110856>

Thanks for the feedback. Comments inline.

On Fri, Feb 20, 2009 at 6:27 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 20, 2009 at 05:24:12AM -0800, eletuchy@gmail.com wrote:
>
>>  - git config value blame.date that expects one of the git log date
>>    formats ({relative,local,default,iso,rfc,short})
>
> OK. I was concerned that this might muck with scripts, but it looks like
> the --porcelain and --incremental codepaths are properly unaffected.
> Good.
>
>>  - git blame command line option --date-format expects one of the git
>>    log date formats ({relative,local,default,iso,rfc,short})
>
> Why not --date= ?
>
> It is currently accepted by the revision option parsing, but not used;
> you would just need to pull the value from revs.date_mode instead of
> adding a new option.
>

Good call. I can change to using --date instead of --date-format. It
wasn't clear that this was an unused option.  For parity with
log.date, config blame.date still makes sense, right?

>> The tests pass. The mailmap test needed to be modified to expect iso
>> formatted blames rather than the new "default".
>
> So there are actually two changes here:
>
>  1. support specifying date format
>
>  2. changing the default date format
>
> I think (1) is a good change, but it should definitely not be lumped in
> with (2), as people might like one and not the other (and I happen not
> to like (2)).
>

What about consistency with all git-rev-list clients?

>
> All of that being said, I think there are two code issues to be dealt
> with:
>
>  1. There seems to be a bug. With your patch, running a simple test
>     like:
>
>       git blame --date-format=relative wt-status.c
>
>     gives me relative output on some lines, and not on others. E.g.,
>     the first 10 lines are:
>
> 85023577 (Junio C Hamano      Tue Dec 19 14:34:12 2006 -0800   1) #include "cache.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   2) #include "wt-status.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   3) #include "color.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   4) #include "object.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   5) #include "dir.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   6) #include "commit.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   7) #include "diff.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   8) #include "revision.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400   9) #include "diffcore.h"
> a734d0b1 (Dmitry Potapov      12 months ago  10) #include "quote.h"
> ac8d5afc (Ping Yin            10 months ago  11) #include "run-command.h"
> b6975ab5 (Junio C Hamano      8 months ago  12) #include "remote.h"
> c91f0d92 (Jeff King           Fri Sep 8 04:05:34 2006 -0400  13)
>

According to date.c comments, this is a "feature" of DATE_RELATIVE:
                /* Say months for the past 12 months or so */
                if (diff < 360) {
                        snprintf(timebuf, sizeof(timebuf), "%lu months
ago", (diff + 15) / 30);
                        return timebuf;
                }
                /* Else fall back on absolute format.. */

A single line fixes that to be a bit more logical:
-               /* Else fall back on absolute format.. */
+               /* Else fall back to the short format */
+                mode = DATE_SHORT;

but i think that's a separate commit, no?

>  2. As you can see in the output above, there are potential alignment
>     issues. The original date format had a fixed width, whereas
>     arbitrary date formats can be variable. Obviously the mixture of
>     relative and ISO dates makes it much worse, but even within an ISO
>     date there are problems (e.g., "19" versus "8").
>

I have a patch to fix the alignment issues: it figures out the max
width of each date format and memsets in that number of spaces in
format_time. Is it better to submit that as a separate commit, or send
a revised patch?

The output is as follows:

> ./git blame --date=relative wt-status.c | head -10
85023577 (Junio C Hamano      2006-12-19       1) #include "cache.h"
c91f0d92 (Jeff King           2006-09-08       2) #include "wt-status.h"
c91f0d92 (Jeff King           2006-09-08       3) #include "color.h"
c91f0d92 (Jeff King           2006-09-08       4) #include "object.h"
c91f0d92 (Jeff King           2006-09-08       5) #include "dir.h"
c91f0d92 (Jeff King           2006-09-08       6) #include "commit.h"
c91f0d92 (Jeff King           2006-09-08       7) #include "diff.h"
c91f0d92 (Jeff King           2006-09-08       8) #include "revision.h"
c91f0d92 (Jeff King           2006-09-08       9) #include "diffcore.h"
a734d0b1 (Dmitry Potapov      12 months ago   10) #include "quote.h"

> -Peff
>



-- 
Eugene
