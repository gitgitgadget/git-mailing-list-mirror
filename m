From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] gc: save log from daemonized gc --auto and print it next time
Date: Thu, 17 Sep 2015 07:48:50 -0700
Message-ID: <xmqqlhc5ksod.fsf@gitster.mtv.corp.google.com>
References: <1440209546-23442-1-git-send-email-pclouds@gmail.com>
	<1442108202-25746-1-git-send-email-pclouds@gmail.com>
	<xmqq8u88ykv4.fsf@gitster.mtv.corp.google.com>
	<xmqq1te0ykaj.fsf@gitster.mtv.corp.google.com>
	<55F93646.9050709@alum.mit.edu>
	<xmqqmvwms6b1.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CMFkGRCXuMiRme=B9ijq6ydWGPz0vyb8QoEzf4Ty3FDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 16:49:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcaUc-0001Xt-Rm
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 16:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbbIQOsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 10:48:53 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34974 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbIQOsx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 10:48:53 -0400
Received: by pacfv12 with SMTP id fv12so22229465pac.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=J1cD1rAvOH4Xyo+IItBqVAmFzTPipbNYl9WuaAIJ6RY=;
        b=gRIpwRYZ0n7dO0YssmAU/3YuiwE62ezvLXy9F7mDG8iPeTKFk9vhRcupfR4a3y+qok
         I3xjCm0eSbcqPMk+5lta9yRUFgoRfwtZuaVFz7ZlwCPYguZsaXbjba9nMl5hMEjGmNWb
         H9sMIeTZxMC+yhxrlcIWXi5RgoXNfLIUIGNwWdkkLd9tQrGO8N2nUioq5hFRqc2KuVKf
         Q07jS0E4vy/6EaTIaD486N4au8Rxfs4fPc2ZYGHz1t9igUgWFOxoMld4054WKH8v3uZv
         gy5e/vvh2hhPsuhPjvDjZmiNHWVOgk5H8G6fetA2MsBpBEkIiiEAM9jSzbCkHxC8qW/t
         /UhA==
X-Received: by 10.68.249.36 with SMTP id yr4mr72186162pbc.18.1442501332649;
        Thu, 17 Sep 2015 07:48:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id qr5sm3967063pbb.26.2015.09.17.07.48.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 07:48:51 -0700 (PDT)
In-Reply-To: <CACsJy8CMFkGRCXuMiRme=B9ijq6ydWGPz0vyb8QoEzf4Ty3FDQ@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 17 Sep 2015 20:08:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278119>

Duy Nguyen <pclouds@gmail.com> writes:

> We do keep another lock before coming to opening this log file. So
> once we get here we already know nobody else will be opening the log
> file. We can simply open it the normal way, then make sure we clean it
> up at atexit().
>
>>> This doesn't seem like a common thing to want (as in, this might be the
>>> only caller), but it probably makes sense to build it into the
>>> tempfile/lockfile API nevertheless, because implementing it externally
>>> would require a lot of other code to be duplicated.
>>>
>>> Another possibility that might work (maybe without requiring changes to
>>> tempfile/lockfile): don't worry about deleting the log file if it is
>>> empty, but make observers treat an empty log file the same as an absent one.
>>
>> Probably your "don't remove and check for emptiness" approach would
>> be the simpler of the two, but I think we can go either way.
>
> People have complained to me about stray files in $GIT_DIR, so it's
> probably best that we delete empty/useless files. Although we could
> delete empty files at the beginning of the next gc instead of at
> atexit(). Let me try it out and see which is simplest.

It would be nicer if we did not have to do an extra and custom
atexit() handler.
