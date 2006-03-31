From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC 2/2] Make path-limiting be incremental when possible.
Date: Thu, 30 Mar 2006 23:02:24 -0800
Message-ID: <7vr74jw0zj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603301648530.27203@g5.osdl.org>
	<Pine.LNX.4.64.0603301652531.27203@g5.osdl.org>
	<7vr74jxhp3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603302225160.27203@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 31 09:02:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPDeQ-0000qo-Rr
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 09:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWCaHC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 02:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWCaHC1
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 02:02:27 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:19099 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750824AbWCaHC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 02:02:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331070226.KBGC17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 31 Mar 2006 02:02:26 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603302225160.27203@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 30 Mar 2006 22:42:26 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18221>

Linus Torvalds <torvalds@osdl.org> writes:

> So the following is wrong:
>
>> diff --git a/revision.c b/revision.c
>> index 0e3f074..a55c0d1 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -404,10 +404,6 @@ static void limit_list(struct rev_info *
>>  		list = list->next;
>>  		free(entry);
>>  
>> -		if (revs->max_age != -1 && (commit->date < revs->max_age))
>> -			obj->flags |= UNINTERESTING;
>> -		if (revs->unpacked && has_sha1_pack(obj->sha1))
>> -			obj->flags |= UNINTERESTING;
>>  		add_parents_to_list(revs, commit, &list);
>>  		if (obj->flags & UNINTERESTING) {
>>  			mark_parents_uninteresting(commit);
>...
> ..but the later part of the patch looks fine (modulo testing, of course):
>
>> @@ -786,7 +773,9 @@ struct commit *get_revision(struct rev_i
>>  		if (revs->min_age != -1 && (commit->date > revs->min_age))
>>  			continue;
>>  		if (revs->max_age != -1 && (commit->date < revs->max_age))
>> -			return NULL;
>> +			continue;
>> +		if (revs->unpacked && has_sha1_pack(commit->object.sha1))
>> +			continue;

OK, so let's say I agree with you that --unpacked and --since
are "stop early" rules.  I fully agree with that from usability
and implementation point of view, but I now wonder if the
"output filter" in get_revision() and "stop early" in limit_list()
would do the same thing.  That is, if we are _otherwise_
limited, limit_list() would use them for "stop early" rule, but
if we end up not calling limit_list() we would simply filter
them and keep going (which is what my patch did for both
timestamp and packedness), or we could also stop there.

I am not sure which one is correct, but I suspect whichever we
do in get_revision() we would get inconsistent results between a
case where we call limit_list() and we do not.  That is, the set
of commits we are going to show when --(topo|date)-order is
given and not given can be different.  Is this acceptable?

I would say, from the implementation point of view, it should be
tolerated, but...
