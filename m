From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Sat, 12 Sep 2015 01:29:43 -0700
Message-ID: <xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
	<20150911140133.GA14311@sigill.intra.peff.net>
	<xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
	<xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
	<20150912033054.GA30431@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 10:29:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZagC1-000418-Jp
	for gcvg-git-2@plane.gmane.org; Sat, 12 Sep 2015 10:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754237AbbILI3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2015 04:29:48 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35187 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbbILI3p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2015 04:29:45 -0400
Received: by pacfv12 with SMTP id fv12so97789868pac.2
        for <git@vger.kernel.org>; Sat, 12 Sep 2015 01:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yGVVmwftuiRLElYclWJU2X6s+PQjbE02kA2oVP8bf4M=;
        b=x+siNYZN5pRCUoT+LK799YUs2a6LNvWkRlfmTR98y8zqIi1HJy6SofzIO8y6nRNpKL
         Y8cf7lwym7DrDfQS+EkkqSoDWTgX/8+qvFrXuiMvMvI31UaJ/aultLNHB0M1iXAe9QoC
         xD+6bkDMlLc8T4NmmjX5ZvVB+QjhUHBso+XFq4zfBtrSw4yRMuUstpYApvEAiumDlPu4
         ENZk9C0heZ+9lATIrQh+RjL/GyJ18cbzGnmLIVqe2SLm/B2qo3NfdgEZRBpOuuCsfvqG
         dbA5FKyaDmH5G8gowUJHE0vnAa2zGnV2GmJEmdGXyh4PVT4y5zYJ6vDxcuzX+bUyDnnn
         kgUA==
X-Received: by 10.68.172.97 with SMTP id bb1mr7419227pbc.143.1442046584845;
        Sat, 12 Sep 2015 01:29:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:b563:b427:39df:b23])
        by smtp.gmail.com with ESMTPSA id t15sm4526084pbs.10.2015.09.12.01.29.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 12 Sep 2015 01:29:44 -0700 (PDT)
In-Reply-To: <20150912033054.GA30431@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Sep 2015 23:30:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277716>

Jeff King <peff@peff.net> writes:

> Yeah, I think what is happening in this first hunk:
> ...
> is doing the right thing. It did feel a little weird to me to be munging
> the global commit objects themselves, but I guess it is fairly normal
> for git code.

Yeah, the above may be brilliant, but ...

>> diff --git a/revision.c b/revision.c
>> index af2a18e..a020a42 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -2765,7 +2765,9 @@ static void set_children(struct rev_info *revs)
>>  		struct commit *commit = l->item;
>>  		struct commit_list *p;
>>  
>> -		for (p = commit->parents; p; p = p->next)
>> +		for (p = commit->parents;
>> +		     p && !revs->first_parent_only;
>> +		     p = p->next)
>>  			add_child(revs, p->item, commit);
>>  	}
>>  }

... this is a total crap and shows that I am doubly an idiot.

The loop is a no-op when first-parent-only (the intent is to call
add-child for just the first parent), so the code is stupid and
wrong in the first place, but more importantly, the logic is utterly
confused.

The thing is, traversing first-parent chain in reverse fundamentally
is undefined.  You can fork multiple topics at the tip of 'master'
and each of the topics may be single strand of pearls, but which one
of the topics is the first-child-chain---there is no answer to that
question.

The add_child() call above is exactly that.  It is saying "record
the fact that commit is child of p->item for these p on that parents
list".  We may limit the call to record that commit C is a child of
its first parent P (and nobody else), but that does not make us
record that that P has only one child (which is C).  This loop will
be entered with another commit C' whose first parent is the same P
and when we return from the set_children() function, we will find
that P has more than one children (C and C', at least); the only
thing we ensured is that all of these recorded children have P as
their first parent.  It does not tell us which one of C's we would
want to pick when digging in reverse from P.
