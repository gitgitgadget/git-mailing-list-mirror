From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Another squash on run-command: add an asynchronous parallel child processor
Date: Thu, 24 Sep 2015 18:08:36 -0700
Message-ID: <xmqq4mijuwyz.fsf@gitster.mtv.corp.google.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
	<1443129187-18572-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 03:09:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfHVT-0002MV-Ql
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 03:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbbIYBIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 21:08:39 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36213 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbIYBIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 21:08:38 -0400
Received: by pacgz1 with SMTP id gz1so6109193pac.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 18:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/Mji3XeyU6F7cxUki+Uzp5zDPuDVIPXt55IaRxJZfDQ=;
        b=rdqUwqdNI7VycJUi4asijkLMOXCZiaSMvlAp2MsKRCxAVsO3XHfIehg9vnFaJ4rTfF
         yu/FsH6Do64y++tGQFCX0sh+uTOSorjSIvHqdWxtkc17Qxc5C+E9KdBy2jOZCIrLk0K2
         u49LyOaQAFjbjqT3hnTHtRt086FETtudNIe/VEr6/S5GDRn1g4oa+CCbMnaqvwtGIhlJ
         ONYBFAJ0QWZ/KN+j0wr05iOnulEhmzBMe6/pClWHx+k9hQ97o3pxY1VDPeBV97//wvgB
         QtZUJe4BS2Lu0Np7prIGQhhHEVQPWUEz8YM8yrU6211FrWSZ3ZTT9rlyOo6Os3bROZY+
         FlCA==
X-Received: by 10.68.68.167 with SMTP id x7mr3374676pbt.140.1443143317873;
        Thu, 24 Sep 2015 18:08:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:9c11:78a0:634d:a891])
        by smtp.gmail.com with ESMTPSA id y5sm678896pbt.77.2015.09.24.18.08.36
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 24 Sep 2015 18:08:37 -0700 (PDT)
In-Reply-To: <1443129187-18572-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Thu, 24 Sep 2015 14:13:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278643>

Stefan Beller <sbeller@google.com> writes:

>  * If you do not die() in start_failure_fn or return_value_fn, you
>    don't want to write to stderr directly as you would destroy the fine
>    ordering of the processes output. So make the err strbuf available in
>    both these functions, and make sure the strbuf is appended to the
>    buffered output in both cases.

Another thing I noticed after re-reading the above is that we shared
the thinking that dying in these is _the_ normal thing to do and
continuing is an advanced and/or wierd setting.

And I think it is wrong.  Suppose after spawning 15 tasks and while
they are still running, you start the 16th one and it fails to stop.
If your start-failure called die() to kill the controller, what
happens to the 15 tasks that are already running?

I think two sensible choices that start-failure and return-value can
make are

 (1) This one task failed, but that is OK.  Please let the other
     tasks run [*1*].

 (2) There is something seriously wrong with the whole world and I
     declare an emergency.  Please kill the other ones and exit.

Dying in these callbacks do not achieve neither.  Perhaps make these
two functions return bool (or enum if you already know a third
sensible option, but otherwise bool is fine and the person who
discovers the need for the third will turn it into enum) to signal
which one of these two behaviours it wants?

And the default handlers should stop dying, of course.


[Footnote]

*1* Because start-failure gets pp, it can even leave a note in it to
    ask the next invocation of get-next to retry it if it chooses
    to.  At this point in the design cycle, all we need to do is to
    make sure that kind of advanced usage is possible with this
    parallel-run-command API.
