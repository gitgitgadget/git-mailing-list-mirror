From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Default ordering of git log output
Date: Thu, 03 Sep 2015 09:43:49 -0700
Message-ID: <xmqqk2s7lagq.fsf@gitster.mtv.corp.google.com>
References: <494BA1BD-150F-45A2-BF5D-9A933D9C1344@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>,
	=?utf-8?B?0JXQstCz0LXQvdC40Lkg0JrRg9C00LXQu9C10LLRgdC60LjQuQ==?= 
	<Eugene.Kudelevsky@jetbrains.com>,
	=?utf-8?B?0KHRgtCw0YEg0JXRgNC+0YXQuNC9?= 
	<Stanislav.Erokhin@jetbrains.com>,
	=?utf-8?B?0K7Qu9C40Y8g0JHQtdC70Y/QtdCy0LA=?= 
	<julia.beliaeva@jetbrains.com>
To: Kirill Likhodedov <kirill.likhodedov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 18:43:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXXcC-0007K0-Hz
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 18:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbbICQnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 12:43:52 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36616 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbbICQnv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 12:43:51 -0400
Received: by pacwi10 with SMTP id wi10so51657042pac.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 09:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lKte94IDtahxYLQ/9Zd3g3fLaZUXV7/D/b9XVIyTPVY=;
        b=TBpK4mgPZY3NSao1MsZCrBxeK1S962WIVHiUbBZKjvzYkbvsJoaAVKoO/Aoc9x3sUs
         hhvHZDMtqMbjBx3iOv5TnYYilXLRALKfkW8bXV5oxQFXMszvHo+mtapfoXiklfjRQntc
         ejNRGnE9taY6E0oKwn24typX6Mu9obZzcjpGYwT6cZsj8TvI+/1bQ/n5WyglqR24+xkF
         QOvmFsEoUEebXHRv7mAO+yfn65hF/N8IJSgsNi4Q1Y5MKDKEsOXY7qhMJ2N9X+6HVw3r
         W4IFo+u31yAZRBEuIz7KHIkhTUmHIe9LyUeAZsdHQAqyxkMSJjKG4OsWJH2VGgzk9ieh
         /z0w==
X-Received: by 10.68.197.231 with SMTP id ix7mr70241838pbc.85.1441298631513;
        Thu, 03 Sep 2015 09:43:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id hg3sm25808629pbb.52.2015.09.03.09.43.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 09:43:50 -0700 (PDT)
In-Reply-To: <494BA1BD-150F-45A2-BF5D-9A933D9C1344@gmail.com> (Kirill
	Likhodedov's message of "Thu, 3 Sep 2015 16:50:23 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277228>

Kirill Likhodedov <kirill.likhodedov@gmail.com> writes:

> Is it intended behavior that the default git log output (without
> ordering parameters) can show parents before children?
>
> The man says:
>     Commit Ordering
>        By default, the commits are shown in reverse chronological order.
> so it tells nothing about parent-to-child relationship.

When you do not give order and when your traversal is not "limited"
(i.e. you do not specify A in "git log A..B" that tells us where the
traversal ends in topological sense), the traversal "git log" goes:

 - We put HEAD to a queue that holds commits that are further to be
   processed.

 - We pick up the youngest commit from the queue; we show it, and
   push its parents that haven't been shown to the queue.  We repeat
   this step until the queue runs out items.

Your history, when a project participant uses a broken clock to
record the committer timestamp, could look like this (topology flows
from left to right):

           1---5---6
          /   /
     2---3---4

where the labels in the illustration depict the relative order of
their committer timestamps.  Imagine your HEAD is at '6'.

So "git log" would do

    Queue       Action
    6           show 6, push 5 to the queue
    5           show 6, push 1 and 4 to the queue
    4 1         show 4, push 3 to the queue
    3 1         show 3, push 2 to the queue
    2 1         show 2; nothing pushed (as it is root)
    1           show 1; nothing is pushed (as its parent 3 has
                        already been shown)
    -empty-
