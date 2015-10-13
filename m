From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Tue, 13 Oct 2015 00:32:56 -0700
Message-ID: <xmqqzizn9qaf.fsf@gitster.mtv.corp.google.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
	<xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 09:33:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlu51-0001TB-4h
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 09:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbbJMHc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 03:32:59 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36736 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbbJMHc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 03:32:58 -0400
Received: by pacex6 with SMTP id ex6so13187268pac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gjbiemhWRD7YMIacMFkpWOrkmL4+Dg3WJoKnccd1ED8=;
        b=GHvX6ExYT5KBBE+gcrvtrqtLZpeEHyw40r7Fw3I6/yHSGDqOW1FL73umcbZO5+6RTM
         jc0obmy5a07Y4xIerA57sYHfrpqY5VH3+gAf4CkOV5qlwfSMFT+ewcodCqA3+XMv+ti6
         N0CvgSOSKWUacBPD5DBugDFM1/9Rgqs2T6nZSDlp36HhiDc6s1YnpwAJ/Qj65NBcrHmG
         QtdohX8RxMWZUtpD3PRDznJVXlYS4XWaxN7x2cdzLCevyo7eSNOASfQG0Ijoe37S9wMx
         mX50F3Ps03JM75DDmWofcKrJPM1tzSu0xeo7/0fItPjy4gmK6yVYSucU7bVL1ls6QW08
         Tf4w==
X-Received: by 10.66.227.72 with SMTP id ry8mr40096592pac.105.1444721578049;
        Tue, 13 Oct 2015 00:32:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:495:58e7:6a27:bf4d])
        by smtp.gmail.com with ESMTPSA id dd4sm2014913pbb.52.2015.10.13.00.32.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 00:32:57 -0700 (PDT)
In-Reply-To: <CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
	(Stefan Beller's message of "Mon, 12 Oct 2015 16:31:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279484>

Stefan Beller <sbeller@google.com> writes:

>> The parallel_process API could learn a new "verbose" feature that it
>> by itself shows some messages like
>>
>>     "processing the 'frotz' job with N tasks"
>>     "M tasks finished (N still running)"
>
> I know what to fill in for M and N, 'frotz' is a bit unclear to me.

At least I don't know what M and N should be, and I'm curious how
you'll define them.  See below.

>> in the output stream from strategic places.  For example, the first
>> message will come at the end of pp_init(), and the second message
>> will be appended at the end of buffered output of a task that has
>> just been finished.  Once you have something like that, you could
>> check for them in a test in t/.
>>
>> Just a thought.
>
> I like that thought. :)


A few more random thoughts:

 * The only thing you could rely on if you were to use the above in
   your tests is the one from pp_init() that declares how many
   processes the machinery is going to use.  M/N will be unstable,
   depending on the scheduling order (e.g. the foreground process
   may take a lot of time to finish, while many other processes
   finish first).

 * Every time the foreground process (i.e. the one whose output is
   tee-ed to the overall output from the machinery) finishes, you
   can emit "M tasks finished (N still running)", but I am not sure
   what M should be.  It is debatable how to account for background
   processes that have already completed but whose output haven't
   been shown.

   One school of thought that is in line with the "pretend as if the
   background tasks are started immediately after the foreground
   task finishes, and they run at infinite speed and produce output
   in no time" idea, on which the "queue output from the background
   processes and emit at once in order to avoid intermixing" design
   was based on, would be not to include them in M (i.e. finished
   ones), because their output haven't been emitted and we are
   pretending that they haven't even been started.  If you take this
   approach, you however may have to include them in N (i.e. still
   running), but that would likely bump N beyond the maximum number
   of simultaneous processes.

   The other school of thought would of course tell the truth and
   include the number of finished background processes in M, as they
   have finished already in the reality.  This will not risk showing
   N that is beyond the maximum, but your first "progress" output
   might say "3 tasks finished", which will make it look odd in a
   different way.
