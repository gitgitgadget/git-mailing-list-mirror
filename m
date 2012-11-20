From: Chris Rorvick <chris@rorvick.com>
Subject: Re: [PATCH v4.1 5/5] push: update remote tags only with force
Date: Mon, 19 Nov 2012 22:43:40 -0600
Message-ID: <CAEUsAPa9fiF9cuMqRHNsQSz_CsbbvdO-eGDS9HWW3MrAYZPA8w@mail.gmail.com>
References: <1353183397-17719-6-git-send-email-chris@rorvick.com>
	<1353189237-19491-1-git-send-email-chris@rorvick.com>
	<7va9udxryf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 05:43:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tafgj-00031v-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 05:43:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab2KTEnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 23:43:43 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:60582 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719Ab2KTEnm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 23:43:42 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1542102lbb.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 20:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=/0PLBegjvwLYZZ04CeyyYY20upOeKmeQoCtuEK0eHfI=;
        b=CBYYS2QHWEoYIPMEnJnGeGmUiGZh4lD3zJVwDeekOTpCEqoGEMFYjvcaLnN1Ppiw53
         Isk4zWpVWtf1xHQhJdSJbHPqD/tTqxH4HB2uqDAobumqTVURkNOfhEORY/oSoakjyAyK
         lRtp4CttwPoQFywSAzL/+1MLYo7f+SryWDtA9W7dVs+9VuYzINlv9nY7U1tCklzymGlz
         xuexqXXpU56gAJBnM1ZuO4zGYLtpaLwori2kMjPfzt13qIdHxU4zbFvTpkjRGluYfQxE
         ofSgrYLQ87p+w/CC7/5AOYa9wchz1Bzwp2XZhob8N8exiDObt3SNJLlWXsQQMp+yECIq
         lGig==
Received: by 10.152.128.9 with SMTP id nk9mr6496240lab.17.1353386620325; Mon,
 19 Nov 2012 20:43:40 -0800 (PST)
Received: by 10.114.13.2 with HTTP; Mon, 19 Nov 2012 20:43:40 -0800 (PST)
In-Reply-To: <7va9udxryf.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: vTt0HXyKtHMgknIF2Vtf_Xe-8j0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210076>

On Mon, Nov 19, 2012 at 2:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Rorvick <chris@rorvick.com> writes:
>>  The object referenced by <src> is used to update the <dst> reference
>> -on the remote side, but by default this is only allowed if the
>> -update can fast-forward <dst>.  By having the optional leading `+`,
>> -you can tell git to update the <dst> ref even when the update is not a
>> -fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
>> -EXAMPLES below for details.
>> +on the remote side.  By default this is only allowed if the update is
>> +a branch, and then only if it can fast-forward <dst>.  By having the
>
> I can already see the next person asking "I can update refs/notes
> the same way.  The doc says it applies only to the branches.  Is
> this a bug?".

Sure, will fix.

>> diff --git a/cache.h b/cache.h
>> index f410d94..127e504 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -1004,13 +1004,14 @@ struct ref {
>>               requires_force:1,
>>               merge:1,
>>               nonfastforward:1,
>> -             is_a_tag:1,
>> +             forwardable:1,
>
> This is somewhat an unfortunate churn.  Perhaps is_a_tag could have
> started its life under its final name in the series?
>
> I am assuming that the struct members will be initialized to 0 (false),
> so everything by default is now not forwardable if somebody forgets
> to set this flag?

Yeah, this was one of a few stupid mistakes.  Previously I used
'forwardable' throughout, but that is awkward except in the last
commit since until then everything is allowed to fast-forward and the
flag is only used to output tag-specific advice.  But inverting the
meaning of the flag is dumb, and I didn't even do it right.

But, as I think you're suggesting, it probably makes more sense to use
a flag that prevents fast-forwarding when set.  So maybe
"not_forwardable", or "is_a_tag" => "not_forwardable" if you think the
renaming is a good idea.  Or maybe just "is_a_tag"?  I think the
rename is good because its meaning is more general in the last commit.

>> diff --git a/remote.c b/remote.c
>> index 44e72d6..a723f7a 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1311,14 +1311,24 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>>                *     to overwrite it; you would not know what you are losing
>>                *     otherwise.
>>                *
>> -              * (3) if both new and old are commit-ish, and new is a
>> -              *     descendant of old, it is OK.
>> +              * (3) if new is commit-ish and old is a commit, new is a
>> +              *     descendant of old, and the reference is not of the
>> +              *     refs/tags/ hierarchy it is OK.
>>                *
>>                * (4) regardless of all of the above, removing :B is
>>                *     always allowed.
>>                */
>
> I think this is unreadable.  Isn't this more like
>
>     (1.5) if the destination is inside refs/tags/ and already
>           exists, you are not allowed to overwrite it without
>           --force or +A:B notation.
>
> early in the rule set?

Yes, something like that is much better.

>> -             ref->is_a_tag = !prefixcmp(ref->name, "refs/tags/");
>> +             if (prefixcmp(ref->name, "refs/tags/")) {
>> +                     /* Additionally, disallow fast-forwarding if
>> +                      * the old object is not a commit.  This kicks
>> +                      * out annotated tags that might pass the
>> +                      * is_newer() test but dangle if the reference
>> +                      * is updated.
>> +                      */
>
> Huh?  prefixcmp() excludes refs/tags/ hierarchy. What is an
> annotated tag doing there?  Is this comment outdated???

I think the comment is accurate, although inverting the meaning of the
flag probably doesn't help the clarity of this change.

What do you mean by "there"?  Annotated tags normally are referenced
via something under refs/tags/, but they could be elsewhere, right?
So what I meant to say was: if the reference is not under refs/tags/
then the starting point has to be a commit for it to be forwardable.

I interpreted parse_object(ref->old_sha1) == NULL as the old thing not
existing (rule 1) but I'm pretty sure that was a mistake.  I should
first test it with is_null_sha1, if true then it doesn't exist.
Otherwise parse_object() returning NULL means we just don't have the
object and therefore should follow rule 2.

> Regarding the other arm of this "if (not in refs/tags/ hierarchy)",
> what happens when refs/tags/foo is a reference to a blob or a tree?
> This series declares that the point of tag is not to let people to
> move it willy-nilly, and I think it is in line with its spirit if
> you just rejected non-creation events.

Nothing under refs/tags/ is updateable and only commits are updateable
outside of that due to the new logic.  The ref_newer() call will
reject updating to blobs and trees, although that probably isn't the
right thing to do.  Previously I was ensuring both old and new objects
were commits if the ref was not under refs/tags/, but it occurred to
me that fast-forwarding from a commit to a tag might be a reasonable
thing to want to do.  But a rejected update to a blob should get the
already-exists advice, not a message suggesting a merge (which is what
you get by relying on ref_newer() to fail.)

> Also, I suspect that you do not even need to have old object locally
> when looking at refs/tags/ hierarchy.  "Do not overwrite tags" can
> be enforced by only noticing that they already have something; you
> do not know what that something actually is to prevent yourself from
> overwriting it.  You may have to update the rule (2) in remote.c
> around l.1311 for this.

Isn't it already doing this?  I think I've either confounded things
with my mistakes or I'm missing this point.

>> +test_expect_success 'push requires --force to update lightweight tag' '
>> +     mk_test heads/master &&
>> +     mk_child child1 &&
>> +     mk_child child2 &&
>> +     (
>> +             cd child1 &&
>> +             git tag Tag &&
>> +             git push ../child2 Tag &&
>
> Don't you want to make sure that another "git push ../child2 Tag" at
> this point, i.e. attempt to update Tag with the same, should succeed
> without --force?

Yes, that is clearly a good addition.

Thanks for all the feedback.  Sorry I mucked up this series a bit,
tried to get an update out too quickly I guess.

Chris
