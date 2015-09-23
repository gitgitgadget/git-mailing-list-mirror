From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 06/14] run-command: add an asynchronous parallel child processor
Date: Wed, 23 Sep 2015 12:34:05 -0700
Message-ID: <xmqq7fnhx74i.fsf@gitster.mtv.corp.google.com>
References: <1442972732-12118-1-git-send-email-sbeller@google.com>
	<1442972732-12118-7-git-send-email-sbeller@google.com>
	<xmqqeghpzm0y.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYaqFRPfRORbknTyez5u0d6_BD0d5wBtAnjSkb4sUBUBA@mail.gmail.com>
	<xmqqlhbxxbai.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 21:34:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zepnx-0001Gj-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 21:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755003AbbIWTeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 15:34:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34209 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754598AbbIWTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2015 15:34:07 -0400
Received: by padhy16 with SMTP id hy16so48844364pad.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 12:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=StU9p62+22ni6jqG14p76TBWWxvt9wR1vBAVCWVwlhs=;
        b=zibwcd/uVlPNLZiwB+g/lHQ1NFDbUVY2yKvisHo3iqw84HpgKNAOw00eaf/1lcQBGv
         FUNtLkYoJPehGeCAz1lXLTpM9UDRb85ZE00JajQc2L6pkZOuhM5/i6puHOGgFCM0gSHj
         WltmBQKEnRjf/IR5Jj+sTBjaGPocDrtl7pAI+xD3f9mDGnwoET1mYdwcfnEr1MwDQTBy
         jZTReObU3L61eBQoPYMJ9GkS5YZQS5n3DjReKfo04ZsYT6VBxs/tpIiK7ERSsBIwKMi0
         git5+VVIuUxA87ecOq2UIHSYS1KBi2Sh0IABtjQHpHiFy3v+PXwpp9ZwRR7np+UYEvRD
         Qywg==
X-Received: by 10.68.109.2 with SMTP id ho2mr39736741pbb.158.1443036847250;
        Wed, 23 Sep 2015 12:34:07 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:a07c:76d3:22e9:4d3d])
        by smtp.gmail.com with ESMTPSA id gv1sm9413133pbc.38.2015.09.23.12.34.06
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 23 Sep 2015 12:34:06 -0700 (PDT)
In-Reply-To: <xmqqlhbxxbai.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 23 Sep 2015 11:04:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278507>

Junio C Hamano <gitster@pobox.com> writes:

> You are running "git fetch" that are is a lot more heavy-weight.
> Because once each of them started fully they will be network bound,
> it is likely that you would want to run more processes than you have
> core.

I thought the conclusion would be obvious, but just in case the
readers need the flow of thought completed, from the above it
follows that on a N-core box (say 8-core) you may want to run the
fetch with -j16 (or more).  If we start everything at once, the time
before one process starts to produce first meaningful response (I am
not counting the "starting command for submodule-$i" message as
"meaningful") would take twice as long under such condition even if
you have infinite network bandwidth and talking to an infinitely
fast server.

I agree that a full slow-start ramping-up is not necessary in order
to hide the start-up lag.  All you need to do is to start just one
and make sure it becomes the foreground, and give it a time alone to
make enough progress to produce an early output without getting
slowed down by system activities caused by the other background
processes in the group that start all at the same time.  And once
the foreground process starts showing its output, you can unleash
the remainder of the herd to thunder and nobody would notice as they
run all in the background.  Again, I am assuming something like "git
fetch" that takes reasonably large amount of resource and time to
start-up and tear-down.
