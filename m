From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 12:39:53 -0700
Message-ID: <CAGZ79ka8MAKKSzXQbA+ARFynkSzB36C-4v_a5JBKooUoWsgqRA@mail.gmail.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
	<xmqqeghpzm0y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYaqFRPfRORbknTyez5u0d6_BD0d5wBtAnjSkb4sUBUBA@mail.gmail.com>
	<xmqqlhbxxbai.fsf@gitster.mtv.corp.google.com>
	<xmqq7fnhx74i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:40:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeptW-0007MA-FF
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 21:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbbIWTjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 15:39:55 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36646 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbbIWTjy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 15:39:54 -0400
Received: by ykdt18 with SMTP id t18so52457514ykd.3
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zib5j/MLzQ5K1lCm/EVNvwla9nzoixSGRAxvhT3dpV8=;
        b=AX5GEVrBhTn09Oo0XZwlKo+XWNtwBH6fjNA88iyLrUaAzlPW1LCQvYgbQCojKrFNQ5
         Nj/HGMz1Qxkue6uouFhfjdqsrAdgNT3ExdFD/4VjdiaskBlKVhccgeqJHNXk2vloL+ec
         bzBgzp1U/t1WIRuLc73HhSjWibkbV47dsuQxVr/S2/kdz2ljZjrXkQFsy3zKns7d5vdi
         Yvdquyl//fnG7uXIszT/WMJ0iix0TREnaSuq38xMJ6kWoZw9jFVEzVhN5a4TSygjfaYX
         wX5k6RzzfdOlrWrsxyuA25awKiKYF1EOTuGTnImHSWJTkq3JbqUwryE0SBfG/NeeDoUC
         Nz/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Zib5j/MLzQ5K1lCm/EVNvwla9nzoixSGRAxvhT3dpV8=;
        b=jWBTAJJwy1X9e0D0PGFuYfNkkgk1tuXfuiyMYy6rHIkNENUWEnA1W1ZEljayn8Hsd4
         aNN7iGpYJTIN3I5WmRLqETlFJP5LP4tGFwAlGRStkDeh+04N313Y2Koq6t0G/qQrODii
         EfcWMI6o1kQcDyAfO5aHPq5QYp68/x3RICixT8d5KHbLFKQSfbhCZARuNSJBXMYOI3ix
         K3oWgATIuSPGtSGtKpKP/mj6KUc2UTg4ZN1mSJjYogwlkbmDxXaG5j8JmG/4Mq1BGhZK
         zbBI00XXyE5NaGyWRg7fcXskfG6Xl8bGMi27kBuzoEApDarg/cjZPybR+PWoqCOtnZ9f
         OAlA==
X-Gm-Message-State: ALoCoQkcJpiLwT9AU9xKlMK8B0O542z0V6KoegtyAL5gLVIchzRbHIivAKbIrtHRnmC7M4M+V33S
X-Received: by 10.170.198.198 with SMTP id p189mr27720195yke.56.1443037193284;
 Wed, 23 Sep 2015 12:39:53 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Wed, 23 Sep 2015 12:39:53 -0700 (PDT)
In-Reply-To: <xmqq7fnhx74i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278508>

On Wed, Sep 23, 2015 at 12:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> You are running "git fetch" that are is a lot more heavy-weight.
>> Because once each of them started fully they will be network bound,
>> it is likely that you would want to run more processes than you have
>> core.
>
> I thought the conclusion would be obvious, but just in case the
> readers need the flow of thought completed, from the above it
> follows that on a N-core box (say 8-core) you may want to run the
> fetch with -j16 (or more).  If we start everything at once, the time
> before one process starts to produce first meaningful response (I am
> not counting the "starting command for submodule-$i" message as
> "meaningful") would take twice as long under such condition even if
> you have infinite network bandwidth and talking to an infinitely
> fast server.
>
> I agree that a full slow-start ramping-up is not necessary in order
> to hide the start-up lag.  All you need to do is to start just one
> and make sure it becomes the foreground, and give it a time alone to
> make enough progress to produce an early output without getting
> slowed down by system activities caused by the other background
> processes in the group that start all at the same time.  And once
> the foreground process starts showing its output, you can unleash
> the remainder of the herd to thunder and nobody would notice as they
> run all in the background.  Again, I am assuming something like "git
> fetch" that takes reasonably large amount of resource and time to
> start-up and tear-down.
>

I can confirm this now.

    git fetch --recurse-submodules=yes -j 400

in an submodule-ified Android tree takes very long to start putting out useful
information, but if I hardcode the SPAWN_CAP to 4 it looks pretty amazing
fast.

I'd guess we could have a reasonable default for SPAWN_CAP by

    #define SPAWN_CAP min(pp.max_processes + 1, online_cpus)

>
