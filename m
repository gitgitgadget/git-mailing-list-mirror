From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Thu, 15 Oct 2015 13:51:54 -0700
Message-ID: <xmqqfv1bhn2t.fsf@gitster.mtv.corp.google.com>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
	<561F1EE5.5070300@web.de> <1444935764.20887.1.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:52:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmpVJ-0004m6-QT
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 22:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbbJOUv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 16:51:57 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33553 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbbJOUv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 16:51:57 -0400
Received: by pabrc13 with SMTP id rc13so97598494pab.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zN8lNB98b9hQRjj7HOqPbMBVrrHanBFIrBu6To/pmhw=;
        b=Izm+Xk+nGzgVjg/7a18zcOXTco/a+bt+PYO7LzDDhrvADBqpw+TqWcZrbBLYIp9Pzc
         P5FKlsgdf0fRPmkhoN0BI+nNT0e+JeZHrfnMhV445PUyMxi6n9ZiFfCFHuGXfv6fe94u
         iHvG0CDVhE+IOZrmNtM6kWlPgHFCTgEQXgZHfP3+XV9TcDowWZcMnaLp65OO6abQzd95
         z7e16oF//gAEuJvKX2NbimPpvRT7Bh+bies0xJEPtgP06GRCkKxKmZZG1gwwZmodOyCK
         70nulw1EOR1q/oqA9vQqNFDEIK4aAl2ga5Zjkg1wjx1oB68ZswHsWEAD3bGdwML11UIM
         1/uQ==
X-Received: by 10.66.141.42 with SMTP id rl10mr12170726pab.18.1444942316669;
        Thu, 15 Oct 2015 13:51:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id ss6sm17027258pbc.74.2015.10.15.13.51.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 13:51:55 -0700 (PDT)
In-Reply-To: <1444935764.20887.1.camel@twopensource.com> (David Turner's
	message of "Thu, 15 Oct 2015 15:02:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279710>

David Turner <dturner@twopensource.com> writes:

>> > +static inline void drop_ce_ref(struct cache_entry *ce)
>> > +{
>> > +	if (ce != NULL) {
>> > +		assert(ce->ref_count >= 0);
>> 
>> Shouldn't this be "> 0" to prevent double frees?
>
> No.  If the ref_count is 1, then there is still some reference to the
> ce.  If it is 0, there is no reference to it, and the next check (< 1)
> will succeed and the ce will get freed.  
>
>> > +		if (--ce->ref_count < 1) {
>> > +			free(ce);
>> > +		}
>> > +	}
>> > +}

Hmm, but it still feels fuzzy, no?  I cannot tell from the above
exchange if a ce with ref_count==0 upon entry to this function is
supposed to have somebody pointing at it, somebody just assigned
NULL (or another pointer) to the last pointer that was pointing at
it, or what else.  If the expected calling sequence were:

	drop_ce_ref(thing->ce);
	thing->ce = NULL;

and the original thing->ce were the last reference to the cache
entry about to be freed, its refcnt is better be 1 not 0.  And when
this function decrements refcnt down to 0, the cache entry is freed.

Admittedly, if the original refcnt were 0, with signed refcnt, it
will decrement to -1 and it will be freed, too, but I do not think
that is what was intended---refcnt is initialized to 0 upon creating
an unreferenced cache entry, and set_index_entry() and friends that
store a pointer to anything calls add_ce_ref(), so I read the code
as intending to make "0 means no pointer points at it".

As far as I can tell, the only effect of this assert() that uses >=0
not >0 is to avoid triggering it on this calling sequence:

    new_ce = new_cache_entry();
    drop_ce_ref(new_ce);

that is, you create because you _might_ use it, and then later
decide not to use it (and the free() part wouldn't have worked
correctly with unsigned refcnt ;-).

By the way, the log message says "During merges, we would previously
free entries that we no longer need in the destination index.  But
those entries might also be stored in the dir_entry cache," as if
this issue were present and waiting to trigger for all merges for
all people.  Given that Linus does hundreds of merges in a day
during the merge window (and I do several dozens a day), I am quite
surprised that nobody noticed this issue.  If there is a more
specific condition that allows this bug to trigger (e.g. "dir-entry
cache is used only under such and such conditions") that the log
message does not talk about to explain why this bug was not seen
widely, it would be a good thing to add.  It is very puzzling
otherwise.
