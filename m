From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/clean.c: Handle disappearing files
Date: Thu, 14 May 2015 15:14:35 -0700
Message-ID: <xmqqbnhmiz78.fsf@gitster.dls.corp.google.com>
References: <1431638200-20449-1-git-send-email-dturner@twitter.com>
	<xmqqk2waj0js.fsf@gitster.dls.corp.google.com>
	<1431640373.17436.16.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 15 00:14:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt1Os-00017h-W0
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 00:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbbENWOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 18:14:38 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38364 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422757AbbENWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 18:14:37 -0400
Received: by igbhj9 with SMTP id hj9so85462562igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IXTdl9KJRYvy3IocUDpew7s1lM52WgKKILx9QuPrQag=;
        b=k9NX2YHyrnioxDU0Nhcc+djTunSIvMB5x13okW1w4K3NnwYhAdUFF9QBwmfiSKC1A6
         DKEUeKQM70vQprshKp//S95MZWF/QLAbY4SKlE/sbbNnZI/G6HUsjLRCiQmTBZq2TyAP
         haRvVC56q4cT4gqxHRTNeeUAT/2iAuz21JKAbR9FU4O9JVT/LowEANuYLqr86KWKcWOx
         lQgopxCsFMvPLx35/cmtfzmYU3xP2XeYUXH7ZYZSz6xyDlFP5enpuaGD1HyErGM5QCkj
         t4K6v+A6/5AoMf8oLnweit+LqVYOsqO5xr91DFMqSfZyaHtFg4Eedk+DIHa9p05t4Wtd
         S06w==
X-Received: by 10.50.30.197 with SMTP id u5mr38537461igh.9.1431641677389;
        Thu, 14 May 2015 15:14:37 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id e69sm281944ioe.11.2015.05.14.15.14.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 15:14:36 -0700 (PDT)
In-Reply-To: <1431640373.17436.16.camel@ubuntu> (David Turner's message of
	"Thu, 14 May 2015 17:52:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269113>

David Turner <dturner@twopensource.com> writes:

>> For this change to be an improvement that matters, you must be
>> allowing some other process mucking around with the files in your
>> working tree when you run "git clean".  The original catches such
>> situation as an anomaly that the user would want to be aware of (and
>> investigate), but this patch essentially declares that having such a
>> random process touching your working tree from sideways is a normal
>> situation.  I do not think I am willing to make such a declaration
>> myself; I'd rather want to know why other people are touching my
>> working tree while I am working in it.
>
> Our build tool[1] stores statistics in a hidden file in the working
> tree.  After it runs, it daemonizes and uploads those stats, and then
> deletes the stats file.  Because the upload might take some time, the
> user might run git clean in the meantime.  (I think there might be some
> other deletion that happens in the background too; I haven't really
> investigated).
>
> Of course, in interactive use, very little harm is done if clean dies
> here: the user simply must notice that the clean has failed and retry
> it.  But in non-interactive use, scripts could fail.
>
> At least, I think that's what could be causing us to hit this error; I
> haven't actually done any research to see if this is true.

I find that the above argues that this patch is a bad idea.

The change sweeps the problem under the rug, killing the canary in
the mine, instead of motivating you to figure out why it is
happening to you.

Of course, scripts could choose to ignore errors from "git clean" it
runs.  At that point, the "sweeping under the rug" ugliness is not
in Git, which is better ;-).
