From: Christian Couder <christian.couder@gmail.com>
Subject: Rebase performance
Date: Wed, 24 Feb 2016 23:09:12 +0100
Message-ID: <CAP8UFD0p1kvk2B0kkc-M9dm+H-Bmam=OrE99VwQx=KCETFEjcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 23:09:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYhcW-00015v-5T
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 23:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758095AbcBXWJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:09:16 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34570 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894AbcBXWJP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:09:15 -0500
Received: by mail-lf0-f51.google.com with SMTP id j78so21335746lfb.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=ZB/UHRdkyjbZT1hMAP7LiB6zKVRC+PFAdC54qClFHf0=;
        b=v93/Tnt1hX2aNoHj/Eek23UO6SnB+rhECk1qBo/2VvU1nSnp+IY6Hq0VVnZFS7gPiA
         6RhCRkoY7vaoPsHuIsL7zyRqQV4lE4affOzmKnLJAPm5Xp9RKGdl1lgkyXVpLPa3Bwpm
         18jjWEhnG2R4lON4uxdxt1kpKArmPuPTCh/idtT/VmpwYhTpdUIVbmQEQ3Nzjr/80aIz
         UlalWGLj11OafUrL9HmJqtdx3Nwf+gTn2uUAuNHAss7z4zxZHso/FJWz67RjjiIA3tLn
         wya47J3cgowwNtSa/UBgm+BVjvuZ/k/6fxaqm4OEBi/19+iRJX+R+pbzr6LmpMM8BcL5
         V6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=ZB/UHRdkyjbZT1hMAP7LiB6zKVRC+PFAdC54qClFHf0=;
        b=BGfDT/gILicXksGoqYnhdW/jnjsviqqioH8ZfuNYZJ8B45u9xuFVTpsajPuWz3g7AQ
         jWTbQAGp+uO0SXLCYRE69ANQSGlKcJP9HRy6FBZt34NsB6/QlIRUHZnW90k8IhFejxrq
         pNSwPS4o33nIwUnkk2V94cYVsbexJqT7U4kxLRqzZb3MrQ/ulU/sKZ8hqFy+hfE1QePp
         RsuIxm6aRmt/jujKBlzgNgrzXF2wofYw7lJK1u++aJ5I2aCKmfTr63hzvSz5NMj7xXzs
         CJJuhTVwFSEiooxDt34Q2RO/gQ7cm5KzUXJ8H229T33i4Coo/BONVVWDHj0SAI1jDhbo
         vC4Q==
X-Gm-Message-State: AG10YORbo7JUuAbH1Lvyb+xFILF8CHxsa26G2lPT1siIbXVuhgHc3O6qY5+uqsvfApcnKSvgoUycOYyoMqAtSQ==
X-Received: by 10.25.155.72 with SMTP id d69mr12473678lfe.134.1456351752549;
 Wed, 24 Feb 2016 14:09:12 -0800 (PST)
Received: by 10.25.152.199 with HTTP; Wed, 24 Feb 2016 14:09:12 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287236>

Hi,

Using GIT_TRACE_PERFORMANCE it looks like a lot of time in a regular
rebase is spent in run_apply() in builtin/am.c. This function first
sets up a 'struct child_process cp' to launch "git apply" on a patch
and then uses run_command(&cp) to actually launch the "git apply".
Then this function calls discard_cache() and read_cache_from() to get
the index created by the "git apply".

On a Linux server with many CPUs and many cores on each CPU, it is
strange because the same rebase of 13 commits on a big repo is
significantly slower than on a laptop (typically around 9 seconds
versus 6 seconds). Both the server and the laptop have that has SSD
storage.

It appears that the server is trying to run the "git apply" processes
on different cores or cpus perhaps to try to spread the load on many
of its cores. Anyway adding something like "taskset -c 7" in front of
the "git rebase..." command, when launching it on the server, speeds
it up, so that it takes around the same amount of time as it does on
the laptop (6 seconds). "taskset -c 7" is just asking Linux to run a
process and its children on core number 7, and it appears that doing
that results in a much better cpu (or core) cache usage which explains
the speed up.

If there was a config option called maybe "rebase.taskset" or
"rebase.setcpuaffinity" that could be set to ask the OS for all the
rebase child processes to be run on the same core, people who run many
rebases on big repos on big servers as we do at Booking.com could
easily benefit from a nice speed up.

Technically the option may make git-rebase--am.sh call "git am" using
"taskset" (if taskset is available on the current OS).

Another possibility would be to libify the "git apply" functionality
and then to use the libified "git apply" in run_apply() instead of
launching a separate "git apply" process. One benefit from this is
that we could probably get rid of the read_cache_from() call at the
end of run_apply() and this would likely further speed up things. Also
avoiding to launch separate processes might be a win especially on
Windows.

Suggestions?

Thanks,
Christian.
