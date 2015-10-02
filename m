From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 0/8] fetch submodules in parallel
Date: Fri, 02 Oct 2015 11:48:18 -0700
Message-ID: <xmqqeghd5cp9.fsf@gitster.mtv.corp.google.com>
References: <1443664456-1307-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, ramsay@ramsayjones.plus.com,
	jacob.keller@gmail.com, peff@peff.net, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 20:48:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi5Nc-0008RF-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 20:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbbJBSsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 14:48:22 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35892 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbbJBSsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 14:48:20 -0400
Received: by pablk4 with SMTP id lk4so112772708pab.3
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 11:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5+YCLffxcJsSZpLa2Z0B13vKo6LRiuvZgt2+dXRFHgg=;
        b=co3AfC9dHJ2JgoG6Hcs/HOHpPNtqbrw0+URG5f1Q0dndiOnmF0653+/6kFXya6yrw8
         GhJJBRfzIHsCQZvOYaJkRhziczHiJ1Gc6V2RrQulNJjCeJMVkab4X4I7Iq4vR0zMD40Q
         B1547SNRr6Iuse24faSS9SzngGGFMORG9QRsPM4l2KZbXhmJDFpA8uyzCzKyPgVRUffu
         fOyYSimuweyvtpR4desk/gvmJCCuWxty1CQv11RPLuKnhEeR+aUB+zMJGjoFwvriMPBi
         4OMhzPvwsbVmbdysY/+Cuumxvop+xL4Uv2Lk/ohEwRtpG36ucap9lq/fbGHUXES9cia8
         bDjw==
X-Received: by 10.68.139.194 with SMTP id ra2mr22219875pbb.6.1443811700550;
        Fri, 02 Oct 2015 11:48:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id li11sm13329564pab.43.2015.10.02.11.48.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 11:48:19 -0700 (PDT)
In-Reply-To: <1443664456-1307-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 30 Sep 2015 18:54:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278938>

Stefan Beller <sbeller@google.com> writes:

> * renamed return_value_fn to task_finished_fn

It made interdiff noisier but I think it gives us a good end result.

> * the main loop of the parallel processing was first adapted to Junios suggestion,
>   but Jonathan pointed out more improvements.  We can get rid of `no_more_task`
>   completely as `if (!pp->nr_processes)` as the exit condition is sufficient.
>   (pp->nr_processes is modified only when starting or reaping a child, so we will
>   capture the whole output of each subprocess even in case of a quick shutdown)

Interesting.  The original motivation for "no-more-task" check was
that even when we are no longer running anything (i.e. everybody
finished) we may get a new task from next_task(), and the condition
to "break" out of the loop could be placed anywhere in that loop
(e.g. after we wait and cull the finished tasks, or even in the
outermost while(1) condition).

But you can take advantage of the specific placement of the check;
it is after the part that spawns new tasks and before the part that
culls the existing tasks, so not having any running task at that
point is sufficient condition.

Will replace what was queued.

Thanks.
