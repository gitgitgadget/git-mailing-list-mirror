From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/5] run-command: Call get_next_task with a clean child process.
Date: Tue, 20 Oct 2015 12:07:13 -0700
Message-ID: <CAGZ79kbzVXaO+WHHfwQYJnEdQU+3kUrwcKUPKTjL1YxTev5g8Q@mail.gmail.com>
References: <1445279086-31066-1-git-send-email-sbeller@google.com>
	<1445279086-31066-3-git-send-email-sbeller@google.com>
	<xmqq61218jfd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:07:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZocFk-0003dK-FG
	for gcvg-git-2@plane.gmane.org; Tue, 20 Oct 2015 21:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbbJTTHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 15:07:16 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33698 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbJTTHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 15:07:14 -0400
Received: by yknn9 with SMTP id n9so26624067ykn.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cy18hwWpDT9e/WZrDPxZv+7o1GfOTGa45Jwzx1lJ4+w=;
        b=AohFo4h7eNvW4UuEe94Y1OWdKILvP0+Gj5RwK787kO6pzXDKNwhi3vs28gibLWNmAi
         HuUfWSi3D06xpzDwZFA4FzE6+2oBvvGe2nTlHpMdTJrE24yuW4zvioYiYyUvHFxYxzra
         z1GSLC+c1/3xchxJ63u/+I0AvWsCAiBk5GGNj827d+jq1JkMo/mcclm5sUIUr0kL4MYh
         QqZPOBedBAPQ7XbLeAAyEXzuKb7IUYuk/6uWV+2J7sJdAU86CYCs3Wr4ileh4bXe2gXR
         SgsdYNnGdTTPTCqn/PP4Mfqdcq5z6gts9ntQxa6IgyJYD4t/Iqsw1sqajkin8AzQMBhy
         7LYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cy18hwWpDT9e/WZrDPxZv+7o1GfOTGa45Jwzx1lJ4+w=;
        b=GXIKIatXVxK6DtZmmGx1Jg5FwEIyfmEFMVfTq9ECsLQJFL1nN5GxsI9KZcyXEWCkvh
         zoUnqY65ZfZX7T3cTS7XqK3It2vhcXl5WnJkPyEDBAOU1G4YTqntVfaDEiCJDXLD4CJG
         hIpMHhK6fTei8r+igjVQVHBIuMbWTAwpikVpsNKQU4H1ont6FIrCVq6API0UMCG00cJ3
         Sjr53X7zPLRLx65y3WIqlXhVIPNBn4+rtUA1Sd4GUpdqdns1nyMOYhaEN7pSANxxPZkZ
         lJlOyo634fTBj1TcB3N65/+gn2H44w6QMoBqGUd8BvtJjpUnP75Yv38KbCvejtJ4nKXN
         wD0g==
X-Gm-Message-State: ALoCoQlHk2P+58tX+ScqMY0Wy9APboLGWx3aFxRKdCRYl4DRXsh9iwjrrCZKlZBALl37Ew39mqqF
X-Received: by 10.129.155.130 with SMTP id s124mr1781383ywg.68.1445368033759;
 Tue, 20 Oct 2015 12:07:13 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 20 Oct 2015 12:07:13 -0700 (PDT)
In-Reply-To: <xmqq61218jfd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279935>

On Tue, Oct 20, 2015 at 11:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> If the `get_next_task` did not explicitly called child_process_init
>
> I locally did "If get_next_task did not explicitly call child_process_init"
>
>> and only filled in some fields, there may have been some stale data
>> in the child process. This is hard to debug and also adds a review
>> burden for each new user of that API. To improve the situation, we
>> pass only cleanly initialized child structs to the get_next_task.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Again this makes sense.
>
> Another way, which I suspect may be conceptually cleaner, would be
> to do this clean-up where pp->children[i].in_use is set to false, as
> that is where the particular task is declared to be available for
> reuse.  That location should be responsible to ensure that the task
> indeed is reusable by calling child_process_init().
>
> By the way, does child_process_init() leak old argv/env arrays, or
> have they already been cleared by calling finish_command() when we
> come to this codepath?

It does, yes. In the reroll I move the initialization to both pp_init (to init
for the first use) and to the place where in_use is set to false.

>
>>  run-command.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/run-command.c b/run-command.c
>> index 8f47c6e..b8b5747 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1010,6 +1010,8 @@ static int pp_start_one(struct parallel_processes *pp)
>>       if (i == pp->max_processes)
>>               die("BUG: bookkeeping is hard");
>>
>> +     child_process_init(&pp->children[i].process);
>> +
>>       if (!pp->get_next_task(&pp->children[i].data,
>>                              &pp->children[i].process,
>>                              &pp->children[i].err,
