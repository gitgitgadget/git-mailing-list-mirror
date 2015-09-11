From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Fri, 11 Sep 2015 12:06:27 -0700
Message-ID: <xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
	<20150911140133.GA14311@sigill.intra.peff.net>
	<xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 11 21:06:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaTep-0006TN-1m
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 21:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbbIKTGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 15:06:30 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34974 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbbIKTG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 15:06:29 -0400
Received: by pacfv12 with SMTP id fv12so83825418pac.2
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yiVLIxwbDm+b5bv30D9HdrrkN3H2h08Z18WI2BLKaiU=;
        b=qqcySyeT17VsbYqrfWghehZl8USIsYumNu1SiqRN2ZDmpmbqrQWkrHtPA8KKxSqYKE
         JCie4FzUWYTjC1Bb/41DM6jyZekmcNJagxUPCUGQE8it7WtogWaLOP4SFnoZSMVGbBKE
         rFQUxoHqExrfs0JDHurJ3NSUfdAYKzOlz4+wZKpf7i8e/SFx54WUAgxoViDfguPx7a5r
         j4bJBB8dx098ZFb8bQxHj3qkhmFgjTZFfySMTp4Du2T+aNTPT2/hKI+r7jN7MGm2udSG
         m8MGuqn1cuRqbUQithnZFK5u/wCZ21sccVjSw1BkELHpglYd+SrZDqpntftnZd+mv6iT
         10RA==
X-Received: by 10.68.103.132 with SMTP id fw4mr757599pbb.62.1441998388839;
        Fri, 11 Sep 2015 12:06:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id bz4sm1808426pbd.6.2015.09.11.12.06.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 12:06:28 -0700 (PDT)
In-Reply-To: <xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 11 Sep 2015 09:35:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277691>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I'm not too familiar with the code, but this _seems_ to work for me:
>>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 21321be..2e03d47 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -1375,6 +1375,10 @@ static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit
>>  static int num_scapegoats(struct rev_info *revs, struct commit *commit)
>>  {
>>  	struct commit_list *l = first_scapegoat(revs, commit);
>> +	if (!l)
>> +		return 0;
>> +	if (revs->first_parent_only)
>> +		return 1;
>>  	return commit_list_count(l);
>>  }
>>
>> I suspect it doesn't work at all with `--reverse`. I also have the
>> nagging feeling that this could be handled inside revision.c with
>> parent-rewriting, but I don't really know.
>
> I am not sure how well --children, which is what we use from
> revision.c, works with --first-parent flag passed to the revision
> walking machinery.  If it already does the right thing, then the
> revs.children decoration that collects all children of any given
> commit should automatically give its "sole child" (in the world
> limited to the first-parent chain) from first_scapegoat().
>
> And if it does not, perhaps that is what we would want to fix,
> i.e. making sure rev-list --first-parent --children does what
> people would expect.
> 
>> But "git blame --first-parent <file>" seems to behave sanely in git.git
>> with this.
>
> It is intresting to see that the above is the only thing necessary,
> as a naive way to try all parents would be to do:
>
> 	for (sg = first_scapegoat(...); sg; sg = sg->next)
> 		assign blame to sg;
> 	take the remainder ourselves;
>
> in which case, a better place to patch would be first_scapegoat(),
> not this function, so that we will always see zero or one element
> parent list returned from the function.
>
> But in reality, the code instead does this:
>
> 	num_sg = num_scapegoats(...);
> 	for (i = 0, sg = first_scapegoat(...);
>              i < num_sg && sg;
>              i++, sg = sg->next)
> 		assign blame to sg;
> 	take the remainder ourselves;
>
> so you do not have to touch first_scapegoat() at all.
>
> I do not offhand know if this was a sign of foresight in the
> original, or just an overly redundant programming ;-).

So here is an outline of what I had in mind when I was writing the
above.  Instead of trusting that num_scapegoats() is always used to
limit the enumeration of commit->parents, we discard the second and
subsequent parents from the commit objects, and also make sure the
later parents do not participate in the revs.children annotation, so
that the world "blame" sees truly becomes a single strand of pearls.

As usual, not even compile tested, but it feels correct ;-)



 builtin/blame.c | 9 ++++++++-
 revision.c      | 4 +++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4db01c1..bc87d9d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1366,8 +1366,15 @@ static void pass_whole_blame(struct scoreboard *sb,
  */
 static struct commit_list *first_scapegoat(struct rev_info *revs, struct commit *commit)
 {
-	if (!reverse)
+	if (!reverse) {
+		if (revs->first_parent_only &&
+		    commit->parents &&
+		    commit->parents->next) {
+			free_commit_list(commit->parents->next);
+			commit->parents->next = NULL;
+		}
 		return commit->parents;
+	}
 	return lookup_decoration(&revs->children, &commit->object);
 }
 
diff --git a/revision.c b/revision.c
index af2a18e..a020a42 100644
--- a/revision.c
+++ b/revision.c
@@ -2765,7 +2765,9 @@ static void set_children(struct rev_info *revs)
 		struct commit *commit = l->item;
 		struct commit_list *p;
 
-		for (p = commit->parents; p; p = p->next)
+		for (p = commit->parents;
+		     p && !revs->first_parent_only;
+		     p = p->next)
 			add_child(revs, p->item, commit);
 	}
 }
