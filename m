From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 10/16] fast-import: use skip_prefix for parsing input
Date: Fri, 20 Jun 2014 04:59:51 -0400
Message-ID: <CAPig+cS6MoU0zDxY9ijMZmVGH04s_7RHLNoW8UVhQ9ff1OkiDA@mail.gmail.com>
References: <20140618194117.GA22269@sigill.intra.peff.net>
	<20140618194912.GJ22622@sigill.intra.peff.net>
	<CAPig+cTgz1s_68MVT5XgTsM9j=NZnCt3tNX3wBGddEq3nWZgyw@mail.gmail.com>
	<20140620054549.GA4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 11:00:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wxufv-0005qh-R1
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jun 2014 11:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754418AbaFTI7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2014 04:59:55 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:55916 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbaFTI7x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2014 04:59:53 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so2608237yha.31
        for <git@vger.kernel.org>; Fri, 20 Jun 2014 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qMp3hTJuxTZmKrpTuzM6AWFJss4kWc/f25imL7b6sbU=;
        b=Tmm2jdXX2zOut60ZQteLBDO0xa/01vzlt+qnvbcDdtKRYbgOUPjL8VRzzIUq9q18Ih
         3ll/oLFeO7++/qSDkcQPkNOua7VYwFLmDEZXd9t7wyrY1+dty1KMnWzW9EKpzEhzxrQZ
         8l7xuA/TnsxpNdttOXVguVCnGn1EPGeHSphxwenMngI+A3NQSXxzVkzSCwpnguQnYqmZ
         dfHEf/DRIFpqrX5pq7A/FUqquMGd5tClDLwOYuhbWkz/zkoiwKjEXFIXyc1C1pTr/79w
         UlsQP3V9YFnJKtsmFYiqB4UrOnbeZ68BcsmqHKLziK4z44BHdcVgBNvgB6mwNA+kKLux
         RIQA==
X-Received: by 10.236.101.198 with SMTP id b46mr3300107yhg.68.1403254791893;
 Fri, 20 Jun 2014 01:59:51 -0700 (PDT)
Received: by 10.170.36.80 with HTTP; Fri, 20 Jun 2014 01:59:51 -0700 (PDT)
In-Reply-To: <20140620054549.GA4623@sigill.intra.peff.net>
X-Google-Sender-Auth: aTCE6bgpPAGAOVN3z1mwo-8puwY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252221>

On Fri, Jun 20, 2014 at 1:45 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 19, 2014 at 11:19:09PM -0400, Eric Sunshine wrote:
>
>> > -               if (starts_with(command_buf.buf, "M "))
>> > -                       file_change_m(b);
>> > -               else if (starts_with(command_buf.buf, "D "))
>> > -                       file_change_d(b);
>> > -               else if (starts_with(command_buf.buf, "R "))
>> > -                       file_change_cr(b, 1);
>> > -               else if (starts_with(command_buf.buf, "C "))
>> > -                       file_change_cr(b, 0);
>> > -               else if (starts_with(command_buf.buf, "N "))
>> > -                       note_change_n(b, &prev_fanout);
>> > +               const char *v;
>>
>> This declaration of 'v' shadows the 'v' added by patch 8/16 earlier in
>> the function.
>
> Thanks.  I reordered the patches before sending, so when this one was
> originally written, there was no "v" at the top-level of the function.
> I think we can just drop this interior one. The point of the short "v"
> is that it can be used as a temporary value for prefix matches, so I
> think we can just reuse the same one.

Agreed. The intended usage of 'v' is clear enough and the code simple
enough that confusion is unlikely.

> I tried compiling with -Wshadow (which I don't usually do), but we're
> not even close to compiling clean there. Some of them are legitimately
> confusing (e.g., try figuring out "end" in parse_rev_note). But others
> look just annoying (e.g., complaining that a local "usage" conflicts
> with the global function). I don't know if we want to put effort into
> being -Wshadow clean or not.

I just happened to notice the shadowing declaration while reading the
patch, but don't feel strongly about existing cases. It makes sense to
clean up confusing cases, such 'end' in parse_rev_note(), when working
on that code (just as with style cleanups), but thus far nobody has
been complaining about existing shadowed variables, so global cleanup
would likely be considered churn.
