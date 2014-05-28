From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 26/41] walker.c: use ref transaction for ref updates
Date: Wed, 28 May 2014 13:56:33 -0700
Message-ID: <CAL=YDW=XS49hYg2HdQkP5-hX8v4D7dzEH1wP8jSPvMt6PxX-Uw@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-27-git-send-email-sahlberg@google.com>
	<20140528195645.GY12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 22:56:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpktr-0005pe-7Y
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 22:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbaE1U4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 16:56:35 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:54475 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbaE1U4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 16:56:34 -0400
Received: by mail-vc0-f182.google.com with SMTP id id10so984472vcb.13
        for <git@vger.kernel.org>; Wed, 28 May 2014 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1MtVg2stDRn+zriJpRpAr0PtvMPEC0Hbf8U3fK5kpzA=;
        b=YW3nmKQSeILdF0D7XOaToC3ZJD61E1laGZFTOkU+gb7/KzU/NK/aw+vsPGSjpyYube
         IXgZDNiWQ9+DSURGh+FD1el0O55nhF8Xlc8uWeLTem9X4I3l9AnY8TugdVAZDcFNsbqC
         Wt8FMpMKNddmp0X2WV9WPUldLl+94+/vQ3M4t4YkQ9f6/No5jtIBG3lJV6wXa/YIPTNx
         IvdB/iFXwbcqUBZfEc8/ewg4fasDNYvzODBwVIY5PyvrXKgoD0FL3aUy3jkVbm/W/0ha
         /Qs+Q1cXPv2vEJ1CJWHqt2tF7HysqJKjXLgiVgLlCdnHF+wvHDA07zgPikJO7Xdz/OYF
         /p+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1MtVg2stDRn+zriJpRpAr0PtvMPEC0Hbf8U3fK5kpzA=;
        b=Ea8MiRl6pHogTfaAVceDvrPcPylwkjTnWYibJk4D7aXTpGgdwyUAalYHqC9DsciEK+
         2Rs6D1zKW95jALwfvgvVRMJyl3iWhIAgQmh3slGGflzQ28kIXzxiWKHIGfD6nmH5KXNx
         rkqg3LU/BQ436YctcoLE33jpIr7Y+5Z44o8be3hWZIbyHPSbqd5JlAAoZOLaRi2a6dvy
         Aw+CMWbHPlWLM+/5dTppsjmSDylb76khuOOK/YKmSwn3ToZeU912PKERVMNeyn0KPNOB
         nV6jBDKUqhBejJXeHgFzmCOz99wMPGizy70gYkKLWBLTM7RZ14NlDyKZfFnJ+khaDvQn
         E7jg==
X-Gm-Message-State: ALoCoQmk5dh4W+lMXNmhLghk2IO0ar9TBBWXQqNLDSmKXC0FlxVbCsSJx6APiKh+esr1ERGEQQ4w
X-Received: by 10.220.95.204 with SMTP id e12mr2378405vcn.37.1401310593828;
 Wed, 28 May 2014 13:56:33 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 13:56:33 -0700 (PDT)
In-Reply-To: <20140528195645.GY12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250327>

On Wed, May 28, 2014 at 12:56 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Switch to using ref transactions in walker_fetch(). As part of the refactoring
>> to use ref transactions we also fix a potential memory leak where in the
>> original code if write_ref_sha1() would fail we would end up returning from
>> the function without free()ing the msg string.
>
> Sounds good.
>
>> This changes the locking slightly for walker_fetch. Previously the code would
>> lock all refs before writing them but now we do not lock the refs until the
>> commit stage.
>
> I don't think this actually changes locking in any significant way.
> (Timing changes, but that's to be expected whenever code changes.)
>
> The old contract was:
>
> You run git http-fetch with refnames passed with "-w".  http-fetch
> will overwrite the refs with their new values.
>
> The new contract is:
>
> You run git http-fetch with refnames passed with "-w".  http-fetch
> will overwrite the refs with their new values.
>
> What changed?

Timing for the locks basically.
Which means the outcome for certain races could change slightly.
But not important.

>
> [...]
>> Note that this function is only called when fetching from a remote HTTP
>> repository onto the local (most of the time single-user) repository which
>> likely means that the type of collissions that the previous locking would
>> protect against and cause the fetch to fail for to be even more rare.
>
> More to the point, while this function is used by 'git remote-http' (and
> hence by "git fetch https://foo/bar/baz"), it is only used to fetch
> objects by that code path.  The remote helper machinery handles the ref
> updates on its own (and passes NULL as the write_ref argument to the
> dumb walker).
>
> [...]
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  walker.c | 56 +++++++++++++++++++++++++++++++++-----------------------
>>  1 file changed, 33 insertions(+), 23 deletions(-)
>
> The code change looks good from a quick glance.
>
> gcc 4.6.3 doesn't seem to be smart enough to notice that 'transaction'
> is always initialized before it is used, so it (optionally) could be
> worth initializing 'transition = NULL' to work around that.
>
> So I think this just needs a simpler commit message and then it would be
> good to go.
>

Done, thanks.
