From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [GSOC] Git Configuration API improvements
Date: Sat, 15 Mar 2014 22:00:29 +0530
Message-ID: <CAOLa=ZTJOMSQnhT0RsdgGHcm61isYy==tbCGWz_PVZRBQj8wWw@mail.gmail.com>
References: <CAOLa=ZSKDg9DKxTRMy4yWW7=ZHcudGmK4guYmaP2okxH8Q044Q@mail.gmail.com>
 <vpqsiqovleu.fsf@anie.imag.fr> <CAOLa=ZQwrtvoBWEra-p9wwFmYBZqcz75a9R0qm7bv2g7UCJn4A@mail.gmail.com>
 <20140314043141.GC31906@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 17:30:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOrU7-00068m-Ed
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 17:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755608AbaCOQav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 12:30:51 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:61278 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbaCOQau (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 12:30:50 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so3937766pab.4
        for <git@vger.kernel.org>; Sat, 15 Mar 2014 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dzPL+/+ltKZI0zsegxChWqfs9KDb2mOug706QKAmEFk=;
        b=MMVaMguM3fP+LqKglvXCi8q60/lpgMXmLe8mLIp1D0tKSjrwJd0Akn0YYTbeBauC8N
         uRIS7S97O3AeIYdryTqzmuubBUrza5f3lDq9akjvLlUEgilPc7qJ7+kLrDmkVorIL1v4
         C05mWy/orqqseCMl1DRZy+iMjQxlNnfgAP3H5Kzzqv/naSSw9Gjhv62KFxHnCyJenHvs
         LO7lSvv3EYFf+nUCXMTAxpsci076LAnsSm9bq0hF7wRSbTqIf6113i8J4QaekqTmk6qO
         yFUrEnQp3yQ0zlY1q1ZGpg6oITHW+TrdD/3K4l93Nkq9lv5iVlLJJr3ZObHetyp1g1+B
         j8sg==
X-Received: by 10.66.66.66 with SMTP id d2mr15931768pat.80.1394901049666; Sat,
 15 Mar 2014 09:30:49 -0700 (PDT)
Received: by 10.68.189.2 with HTTP; Sat, 15 Mar 2014 09:30:29 -0700 (PDT)
In-Reply-To: <20140314043141.GC31906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244158>

On Fri, Mar 14, 2014 at 10:01 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 11, 2014 at 09:49:33PM +0530, karthik nayak wrote:
>
>> On Tue, Mar 11, 2014 at 8:21 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> > karthik nayak <karthik.188@gmail.com> writes:
>> >
>> >> Currently we have multiple invocation of git_config() in an
>> >> individual invocation of git() which is not efficient. Also, it is
>> >> hard to implement new features,
>> >
>> > I think efficiency is not a real concern here. Config files are small
>> > and easy to parse, so parsing them multiple times isn't really
>> > noticeable from the performance point of view.
>> >
>> > OTOH, the extensibility is a real concern, and that should be the main
>> > motivation for the project.
>>
>> Thanks. I understand what you mean. extensibility is the main motivation of the
>> project, i think that by implementing the cache system we can fix the
>> small problems
>> (reappearing of headers while setting and unsetting configs) and also
>> implement new features
>> like to unset a config easily.
>
> I think the most interesting part of the config idea is turning the
> fetching of config variables "inside out".
>
> That is, right now we turn control over to the config code, which
> invokes our callbacks. So we see all variables in sequence, and pick out
> the ones that are interesting.  We implement precedence with a "last one
> wins" technique where we keep overwriting a variable with subsequent
> config options.
>
> This can lead to difficult ordering situations, such as when a config
> option _might_ be respected based on another factor (e.g., the presence
> of a command line option, as in the status.branch option).
>
> It also means that it's impossible to tell after the fact whether a
> value was set explicitly on the command line, by config, or if we are
> using a system default. Most of the time this doesn't matter, but there
> are a few cases where we care, and we end up having to manually manage
> a separate flag in each case.
>
> By the phrase "inside out" above, I mean that we could read all config,
> and then fetch individual values as we need them. We do need to care
> about efficiency here, but only insofar as we don't cause any
> regressions (that is, the current system is fine speed-wise, we just
> need to make sure that we do not create new problems by calling a slow
> lookup in a tight loop or anything like that).
>
> -Peff

Hello Jeff,
Like you said yes, this will be a complete "inside out" change. Thanks
for summing it up, really helpful.
Currently i am going through the code and understanding how it works currently.
Simultaneously working on the proposal[1], would be great to have your
feedback on that.
Thanks,
Karthik

[1] https://gist.github.com/KarthikNayak/98569dd34326f7e6813a
