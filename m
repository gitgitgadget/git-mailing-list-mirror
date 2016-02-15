From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 14/25] shallow.c: implement a generic shallow boundary
 finder based on rev-list
Date: Mon, 15 Feb 2016 15:00:15 +0700
Message-ID: <CACsJy8CjnD-f-fyizQ6DE6ik5vYQqYq+R-YSEJ7XZ9XTHEH1Tg@mail.gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
 <1454576641-29615-15-git-send-email-pclouds@gmail.com> <xmqqvb5y7vuj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:01:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVE5S-00076h-Ka
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 09:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbcBOIAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 03:00:47 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36288 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbcBOIAq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 03:00:46 -0500
Received: by mail-lf0-f65.google.com with SMTP id h198so6920097lfh.3
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 00:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FTn2PsYcavx04tfpMmwiuG8doWFgWye4BBewkELOU3A=;
        b=GpsaotkhmxJdLGrLPxsKmopivrupwSYucRdeMThI2zK6cqpmFS9QMubAP0jEfvDvfa
         fY45pA8MY4OhLtBvP13/B+grmmaKJzglFZXaUvcKJZs7PmuaXf6CvFt/y3QwM7mCPdE8
         HM4QEok2fOsP+N6AIUpclVnpqLxsMOIH/prZIxSeChrLdRk25G3BVNfOVlv4ZJ8n7jDG
         ttNS24dNxSHfa5QojzLXcgvjHsuG0imkITXxDFubxUlEsu/nqDG2OIFzsTKY5mZHwPOw
         3IWn+D+zPM1SYc0wXiTtT60U3/WuOJ4IHM31q0YENOu5J8t0a3A8AX/HdNJZdULwTd1J
         tdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=FTn2PsYcavx04tfpMmwiuG8doWFgWye4BBewkELOU3A=;
        b=CM1+wGbhqsGixY6Tr8Han4hZCZzLOOC/d+PtVYOuRTI2SAsdVtQmlyXA+Q+afeofPD
         9IWXo4QUc8tds0wndq01HJVtMSmn0iOaI6PjhMxZUQ4UJizFkP4H4oGAGGeiH6G0lz7Z
         qMdD01qAXkgfdLqfSox6bQqlzS+08HK92ej2FT5vQqnb5Hz/T4cUxAWlFA9B/ObAiAK5
         sZH4J8FpN7/a5qrvTKc4nte2bJmQRJxdkLSXLeazhWr/zr9wnLx2IHL4JPBrqCgNyaDE
         VdzmST7N69sSVmp/CZ+eNyiSMjH1+QHqfk6VHbXB9imv/NOUuCptCwKsCzvYvWP4P6El
         YSrw==
X-Gm-Message-State: AG10YOQ89yKXk+EHgHxopV7bmPAGLP+/T8WkbQIkRhrRqY3kG28THNEDIlqPekd03igSmAUFGIzoPxw2dZbUtw==
X-Received: by 10.25.4.7 with SMTP id 7mr5961817lfe.45.1455523244887; Mon, 15
 Feb 2016 00:00:44 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 15 Feb 2016 00:00:15 -0800 (PST)
In-Reply-To: <xmqqvb5y7vuj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286178>

On Tue, Feb 9, 2016 at 4:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     is_repository_shallow(); /* make sure shallows are read */
>> +
>> +     init_revisions(&revs, NULL);
>> +     save_commit_buffer = 0;
>> +     setup_revisions(ac, av, &revs, NULL);
>> +
>> +     /* Mark all reachable commits as NOT_SHALLOW */
>> +     if (prepare_revision_walk(&revs))
>> +             die("revision walk setup failed");
>> +     traverse_commit_list(&revs, show_commit, NULL, &not_shallow_flag);
>> +
>> +     /*
>> +      * mark border commits SHALLOW + NOT_SHALLOW.
>> +      * We cannot clear NOT_SHALLOW right now. Imagine border
>> +      * commit A is processed first, then commit B, whose parent is
>> +      * A, later. If NOT_SHALLOW on A is cleared at step 1, B
>> +      * itself is considered border at step 2, which is incorrect.
>> +      */
>> +     nr = get_max_object_index();
>> +     for (i = 0; i < nr; i++) {
>
> I'd really like not to see a loop over 0..get_max_object_index().
> Are there many codepaths that peek into the in-core entire object
> store already?

You started it with check_non_tip(). At least that's how I know about
this loop. But I think that's the only code path, not counting this.

> Would it work equally well to keep track of the
> commits discovered in show_commit() to use as the set of commits
> you need to visit in this second pass?

We can't do this in show_commit. In this loop, we check
not_shallow_flag of parent commits. If one parent commit is not
show_commit'd yet, the flag is not set and we may incorrectly think
this is a border commit. The only way to avoid going through the
entire in-core object database is keeping a new commit_list and go
through it here. Which way is preferred?

>> +             struct object *o = get_indexed_object(i);
>> +             struct commit *c = (struct commit *)o;
>> +
>> +             if (!o || o->type != OBJ_COMMIT ||
>> +                 !(o->flags & not_shallow_flag))
>> +                     continue;
>> +
>> +             if (parse_commit(c))
>> +                     die("unable to parse commit %s",
>> +                         oid_to_hex(&c->object.oid));
>> +
>> +             for (p = c->parents; p; p = p->next)
>> +                     if (!(p->item->object.flags & not_shallow_flag)) {
>> +                             o->flags |= shallow_flag;
>> +                             commit_list_insert(c, &result);
>> +                             break;
>> +                     }
>> +     }
-- 
Duy
