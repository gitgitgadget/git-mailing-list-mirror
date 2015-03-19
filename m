From: Stephen Morton <stephen.c.morton@gmail.com>
Subject: Re: Slow git pushes: sitting 1 minute in pack-objects
Date: Thu, 19 Mar 2015 16:31:36 -0400
Message-ID: <CAH8BJxErCMk1JQMMKm9_j4bckB7bEVB+r28_zYovE=pe1nUa_Q@mail.gmail.com>
References: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
	<20150309075302.GB31866@peff.net>
	<CAH8BJxHQnMkXq1J_wMi2KktTH5uHjj+vd69ihXuYGRfq9cOt=g@mail.gmail.com>
	<20150316221532.GA16679@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:31:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYh6Z-0001W9-D4
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbCSUbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:31:38 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34819 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbbCSUbh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:31:37 -0400
Received: by wibdy8 with SMTP id dy8so639168wib.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IepTnPcyq+Op2DwRBVftf494tSyc7zRmw4o63t8nspE=;
        b=AZI7qHg40S5Fc3rz3he65kYjbCH/dOu/yHXcbqIZX+QBu2PYuJJNv50CndyIWP4ep5
         gt3P5Pu3Z9aPCBYh9cW0RCFqR7UvLGgVKmoIhF+XxjVVzvj5ilptmuRFHbvqUgipqbn1
         Rlm0Rqh9H1XCLLGLGaRh8uJnk8iT0cJhGAfWFj6OkU+Cgz5CodvLxP0CzvLasxMZZCnX
         FpJFnaj+Y948qZfxf240y5T9CwV3p+6+lnCrm/bAgNglu9j1K3N+mpd5M4ocox7FwloL
         YxeJqboYEtYKwJd4Qk9/5u506r+S1tZsfJDbXCWk4zZF9oKJ5dNev/+dERw8nVCgskWF
         Al1w==
X-Received: by 10.194.179.194 with SMTP id di2mr153142869wjc.4.1426797096194;
 Thu, 19 Mar 2015 13:31:36 -0700 (PDT)
Received: by 10.194.159.98 with HTTP; Thu, 19 Mar 2015 13:31:36 -0700 (PDT)
In-Reply-To: <20150316221532.GA16679@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265825>

On Mon, Mar 16, 2015 at 6:15 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 09, 2015 at 09:37:25PM -0400, Stephen Morton wrote:
>
>> 3. Not sure how long this part takes. It takes 1/3 - 1/2 of the time
>> when straced, but I think it's much less, as little as 10s when not
>> straced.
>> It then reads a bunch of what look like objects from filehandle 0
>> (presumably stdin, read from the remote end?)
>> It then tries to lstat() these filenames in .git/<sha1>
>> ./git/refs/<sha1>, .git/heads/<sha>, etc. It always fails ENOENT.
>> It fails some 120,000 times. This could be a problem. Though I haven't
>> checked to see if this happens on a fast push on another machine.
>
> Hmm. The "push" process must feed the set of object boundaries to
> "pack-objects" so it knows what to pack (i.e., what we want to send, and
> what the other side has).
>
> 120,000 is an awfully large number of objects to be pass there, though.
> Does the repo you are pushing to by any chance have an extremely large
> number of refs (e.g., on the order of 120K tags)?


No. There are on the order of 9,500 refs (mostly tags) but nowhere near 120k.



>
> Can you try building git with this patch which would tell us more about
> where those objects are coming from?


    <patch snipped>

> Those are all rather blunt debugging methods, but hopefully it can get
> us a sense of where the time is going.
>
> -Peff


Thanks Peff,


I haven't tried your patch, but I tried to backtrack a bit and
double-check that the problem always happened in a fresh clone with no
other modifications.

It did _not_ happen in a new clone --a push took just 5s -- and I
think the culprit could have been "repack.writebitmaps=true". Although
I had thought writebitmaps was not originally enabled, I now suspect
that it was. Let me follow up on that first, before I recompile git
with your changes.


Thanks again, I really appreciate the help.

Steve
