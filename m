From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Mon, 14 Dec 2015 13:18:25 +0100
Message-ID: <CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 13:18:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8S5I-0003w9-9c
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 13:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbbLNMS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 07:18:28 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36485 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbbLNMS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 07:18:27 -0500
Received: by lbblt2 with SMTP id lt2so105657467lbb.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wcWuIl+uQi0YgOPHAbkervg/VJ+krcgTHbWeEDquWrE=;
        b=LGRv3FLk4KimqoMxLLog0hGgB/P/cFoPt6mpSTMWr8zg4kOpiKcyAXbxlPsrIlWbtR
         upkD0J9PijxrtkUL1tgVl5QgoUjZ2A+4TBCihyTwQEQzYW8kYFWjKhXKaP3BvoLlJxHV
         vkJd/GQfOAhvool+2lG0nBn1p6TggwD9fcW+q1Mua8XI7jOm+68hbXAhcuPBjg+Wjcm4
         waSbPc08U5KUb/t+Qh8R92NW4tirfD1tAmbVI3gonkXzPfyhZISwEhtfOQIoCRNLQ823
         w6UStlDhGJ6mIk+7M96+kZDOdfku6WMZj+CpPFbCTrUI+AAFx4R6qixOuRXgrOWrH1x+
         V+Qg==
X-Received: by 10.112.184.45 with SMTP id er13mr12939361lbc.133.1450095505504;
 Mon, 14 Dec 2015 04:18:25 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Mon, 14 Dec 2015 04:18:25 -0800 (PST)
In-Reply-To: <xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282355>

On Tue, Dec 8, 2015 at 11:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> When we know that mtime is fully supported by the environment, we
>>> might want the untracked cache to be always used by default without
>>> any mtime test or kernel version check being performed.
>>>
>>> Also when we know that mtime is not supported by the environment,
>>> for example because the repo is shared over a network file system,
>>> then we might want 'git update-index --untracked-cache' to fail
>>> immediately instead of preforming tests (because it might work on
>>> some systems using the repo over the network file system but not
>>> others).
>>> ...
>> The logic in this paragraph is fuzzy to me.  Shouldn't the config
>> give a sensible default, that is overriden by command line options?

The problem is that "git update-index --[no-|force-]untracked-cache"
is not just changing things for the duration of the current command.
It is in fact changing the configuration of the repository, because it
is adding the UC (untracked cache) in the index and saving the index,
which will persist the use of the UC for the following commands.

So it is very different from something like "git status
--no-untracked-cache" that would perform a "git status" without using
the UC.

In fact "git update-index --[no-|force-]untracked-cache" is very bad
because it means that two repositories can be configured differently
even if they have the same config files.

>> I agree that it is insane to do a runtime check when the user says
>> "update-index --untracked-cache" to enable it, as the user _knows_
>> that enabling it would help (or the user _knows_ that she wants to
>> play with it).  Similarly, shouldn't the config be ignored when the
>> user says "update-index --no-untracked-cache" (hence removing the
>> untracked cache from the resulting index no matter the config is set
>> to)?  ...
>
> As I think about this more, it really seems to me that we shouldn't
> need to make this configuration variable that special.  Because I
> think it is a *BUG* in the current implementation to do the runtime
> check even when the user explicitly tells us to use untracked-cache,
> I'd imagine something along the lines of the following would be a
> lot simpler, easier to understand and a generally more useful
> bugfix:
>
>  1 Add one boolean configuration variable, core.untrackedCache, that
>    defaults to 'false'.
>
>  2 When creating an index file in an empty repository, enable the
>    untracked cache in the index (even without the user runninng
>    "update-index --untracked-cache") iff the configuration is set to
>    'true'.  No runtime check necessary.

I guess this means that when cloning a repo, it would not use the UC
unless either "git -c core.untrackedCache=true clone ..." is used, or
core.untrackedCache is set in the global config.

>  3 When working on an existing index file, unless the operation is
>    "update-index --[no-]untracked-cache", keep the current setting,
>    regardless of this configuration variable.  No runtime check
>    necessary.
>
>  4 "update-index --[no-]untracked-cache" should enable or disable
>    the untracked cache as the user tells us, regardless of the
>    configuration variable.  No runtime check necessary.

If you want only some repos to use the UC, you will set
core.untrackedCache in the repo config. Then after cloning such a
repo, you will copy the config file, and this will not be enough to
enable the UC. The original repo will use the UC but the cloned one
will not, and you might wonder why is "git status" slower in the
cloned repo despite the machines and the config being the same for
both repos?

And if you have set core.untrackedCache in the global config when you
clone, UC is enabled, but if you have just set it in the repo config
after the clone, it is not enabled.

This is quite bad in my opinion.

Also think about system administrators who have a lot of machines with
lots of repos everywhere on these machines and just upgrade Git from
let's say v2.4.0 to v2.8.0. They find out that using UC git status
will be faster and want to provide that to the machine's users knowing
that they only use recent Linux machines where mtime works well.
Shouldn't it be nice if they could just enable core.untrackedCache in
the global config files without having to also cd into every repo and
use "git update-index --untracked-cache" there?

If we consider that "git update-index --[no-|force-]untracked-cache"
should not have been created in the first place, and that the good
mechanism for this is a config variable, and that maybe "git
update-index --[no-|force-]untracked-cache" should just be deprecated,
then the important thing is to make the core.untrackedCache config
variable work in the best possible way.

> It is OK to then add an "auto-detect" on top of the above, that
> would only affect the second bullet point, like so:
>
>  2a When creating an index file in an empty repository, if the
>     configuration is set to 'auto', do the lengthy runtime check and
>     enable the untracked cache in the index (even without the user
>     runninng "update-index --untracked-cache").
>
> without changing any other in the first 4-bullet list.
>
> Am I missing some other requirements?

It is more about what is a good way to use this feature?

"git update-index --[no-|force-]untracked-cache" is a bad way, so
let's make it easy for people to not use it at all.

If people can just set core.untrackedCache in an existing repo without
the need to use "git update-index --untracked-cache" afterwards to
really enable it, and without having to remember to use it again after
cloning (supposing core.untrackedCache is not set globally where they
clone), it is just simpler, and as an added benefit we can deprecate
"git update-index --[no-|force-]untracked-cache".

Thanks,
Christian.
