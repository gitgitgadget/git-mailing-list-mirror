From: Conley Owens <cco3@android.com>
Subject: Re: [PATCH] Fallback on getpwuid if envar HOME is unset
Date: Tue, 21 Aug 2012 10:18:25 -0700
Message-ID: <CAFFUb6UypNJ-8p8Hs14+QMGeU3KSG+pQX7NJTeh3OtBoTZoO3g@mail.gmail.com>
References: <CAFFUb6WiXJ0n4NkhOQ=+mcfs+uaAo2_G6TOs7L=AuPwPVfxyMg@mail.gmail.com>
	<20120821023033.GB20271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:18:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3s6G-0007Fw-95
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 19:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758229Ab2HURS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 13:18:28 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:46592 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab2HURS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 13:18:26 -0400
Received: by mail-qa0-f53.google.com with SMTP id s11so175684qaa.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 10:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=O/Epq9s+sPnESQr9RIbnrqV6XTQEUqPiAdsTfBf1VlY=;
        b=Fqk+KefH1kHake2Y3C/fLFXBkTfhSCKMUqBoKKJOUB1XrlkvFxteZoxFBqYvwMbwlc
         9/yv+T4LdelXbthvM+5ahB8OLmcTCdEeXd3GkrvcBi9ZRtYjQOymJeh5QvAij2yR/HLV
         +h3ccudVs+KdDoMnuqz6eS0DwolVlalfzldAYU/4tmVFbXdmAZHiFxXFU1vv6kKEDvf5
         2RCehbfa/VGxEFcrM0W3NgurnFSUNxirdF0IbtKgvWMdxTIUSzuLbPPxYZdWpiKigD48
         SpSQufQ/PygNq1z3cRXhv9k+2llzAo6nZCi45A0zibEbujHrOHIWa5OuFKn/+7kQEtQ5
         Dtnw==
Received: by 10.224.101.193 with SMTP id d1mr10367728qao.20.1345569505703;
 Tue, 21 Aug 2012 10:18:25 -0700 (PDT)
Received: by 10.49.110.37 with HTTP; Tue, 21 Aug 2012 10:18:25 -0700 (PDT)
In-Reply-To: <20120821023033.GB20271@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlxZSPmqyxyEdfF81zFCNQyUaZ2J6P5g8E5sCziTuMaI1sRO7ObQcolm/hWOJAbMkRTiUL/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203972>

On Mon, Aug 20, 2012 at 7:30 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 20, 2012 at 06:28:57PM -0700, Conley Owens wrote:
>
>> From f64ba3c908b33a2ea5a5ad1f0e5800af76b82ce9 Mon Sep 17 00:00:00 2001
>> From: Conley Owens <cco3@android.com>
>> Date: Mon, 20 Aug 2012 18:23:40 -0700
>> Subject: [PATCH] Fallback on getpwuid if envar HOME is unset
>
> Please drop these lines from the message body; they are redundant with
> your email's headers.
>
> This seems sensible on the surface, but I'm a bit curious: why isn't
> $HOME set? And are there any reasons that somebody who has unset HOME
> would not want to fallback?  For example, running under Apache, HOME is
> often unset when calling CGI programs. Would it make sense for us to
> look in ~www-data/.gitconfig in that case?

I think it might, but perhaps I'm wrong.  As another example, upstart strips all
the environment variables, so if you run a job as a particular user, that user's
.gitconfig will not be read unless HOME is specified.

>
>> diff --git a/path.c b/path.c
>> index 66acd24..60affab 100644
>> --- a/path.c
>> +++ b/path.c
>> @@ -144,6 +144,11 @@ void home_config_paths(char **global, char **xdg,
>> char *file)
>>         char *to_free = NULL;
>>
>>         if (!home) {
>> +         struct passwd *pw = xgetpwuid_self();
>> +         home = pw->pw_dir;
>> +       }
>> +
>> +       if (!home) {
>>                 if (global)
>>                         *global = NULL;
>>         } else {
>
> If we do go this route, it would probably make sense to wrap this like:
>
>   const char *home_directory(void)
>   {
>           const char *dir = getenv("HOME");
>           if (!dir) {
>                   struct passwd *pw = xgetpwuid_self();
>                   dir = pw->pw_dir;
>           }
>           return dir;
>   }
>
> and then call it consistently everywhere we do getenv("HOME"). You'd
> want to double-check that each caller only uses the result for a short
> period (unlike getenv, the results of getpwuid will be overwritten at
> the next call).
>
> -Peff
