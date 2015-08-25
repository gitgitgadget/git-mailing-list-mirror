From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] index-pack: Use the new worker pool
Date: Tue, 25 Aug 2015 13:41:27 -0700
Message-ID: <xmqqfv37xfrc.fsf@gitster.dls.corp.google.com>
References: <1440523706-23041-1-git-send-email-sbeller@google.com>
	<1440523706-23041-5-git-send-email-sbeller@google.com>
	<20150825190329.GA11271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 25 22:41:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUL2D-0005JK-7n
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 22:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755689AbbHYUl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 16:41:29 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34842 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbbHYUl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 16:41:28 -0400
Received: by pacdd16 with SMTP id dd16so134970363pac.2
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JCcuxzT0eWi+hF6YE/Zq/1ah2WnUgwhLhxlPL/l+Lng=;
        b=dF7yVr0UU3oOB2aFEyLGJ+6v0p7go9lHtJiiBjtAqJvetDe/+lrc57eKJiCYxfW+to
         cRiEg7axQZMpO28QUMVxV/KszqDErUJ6nhNk4qfOEdFh/dBcTFjp1kHFG6g+ObzqD8r4
         ACOy74T+igJmUwPXfHC7pYldsS3g6xeJYue0Uaiu5OOtjMsX+V8ltPAoMcee9u2l5WBG
         Wy+CwY96oOyrG0NIu0Gx/RX1J2chW3uWPkln/9eW/jiUbK6yJglik8LKIPA18qbSyDCb
         XfBzETt6zKDczQJn1P4tp3ktwdti6JhWv0sydPcvZhi+73ZqjN2oqmFFW12qS3UFtJo4
         cNeA==
X-Received: by 10.68.103.132 with SMTP id fw4mr60734274pbb.62.1440535288143;
        Tue, 25 Aug 2015 13:41:28 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:cdc0:fd6d:4069:6223])
        by smtp.gmail.com with ESMTPSA id s13sm22071765pdi.70.2015.08.25.13.41.27
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 25 Aug 2015 13:41:27 -0700 (PDT)
In-Reply-To: <20150825190329.GA11271@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 25 Aug 2015 15:03:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276571>

Jeff King <peff@peff.net> writes:

> On Tue, Aug 25, 2015 at 10:28:25AM -0700, Stefan Beller wrote:
>
>> By treating each object as its own task the workflow is easier to follow
>> as the function used in the worker threads doesn't need any control logic
>> any more.
>
> Have you tried running t/perf/p5302 on this?
>
> I seem to get a pretty consistent 2%-ish slowdown, both against git.git
> and linux.git. That's not a lot, but I'm wondering if there is some
> low-hanging fruit in the locking, or in the pattern of work being
> dispatched. Or it may just be noise, but it seems fairly consistent.

The pattern of work dispatch hopefully is the same, no?  add_task()
does the "append at the end" thing and next_task() picks from the
front of the queue.  The original is "we have globally N things,
so far M things have been handled, and we want a new one, so we pick
the M+1th one and do it".

The amount of memory that is used to represent a single task may be
much larger than the original, with overhead coming from job_list
structure and the doubly-linked list.  We may not be able to spin up
30 threads and throw a million tasks at them using this, because of
the overhead.  It would be more suited to handle a pattern in which
an overlord actively creates new tasks while worker threads chew
them, using the add_task/dispatch as the medium for communication
between them.
