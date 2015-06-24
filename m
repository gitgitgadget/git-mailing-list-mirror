From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] apply: fix adding new files on i-t-a entries
Date: Wed, 24 Jun 2015 17:11:37 +0700
Message-ID: <CACsJy8Ap4uNi3gXV8Y+S18xtLaZ1R6DscEf7wJKjt59ZLOAJ5Q@mail.gmail.com>
References: <CACfKtTAvH7FH2AkC5hUNFEQ620gF401SNYaULLy62iE8S55-7A@mail.gmail.com>
 <1435062855-26274-1-git-send-email-pclouds@gmail.com> <xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, phiggins@google.com,
	snoksrud@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 12:12:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7hfC-0004S3-RU
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 12:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbbFXKMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 06:12:10 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:35894 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbFXKMI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 06:12:08 -0400
Received: by iecvh10 with SMTP id vh10so29958417iec.3
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 03:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Lo4nwuNG2wPjBp8EUEijWX9xZQQPOD9dB9/Q+E6U2sc=;
        b=wysimWnGgNdNdF1JPddWy0IK/Mt4FIwfK8ZmUHFk4V/LlCXPU/fyJ5r+ur4F7//O+a
         Q+h7XVWGTnsTtki8SlrFtXVenKtSSDQ3DWquNTSiSfg2bH1Mwn0oMLVmpQHhI3XwIrQf
         9+1rgVFSbjepmJ0BgyVXJFvKCYEYYgz18YUvncJcM4JpB0xZSSOob6iLubTIMGdeXKzu
         BzigGfVPaJMFqlyT9b9V2ZwHsB63FcvMpjCeX2lNLawCVaXUXMRG6apCzzT44uRzS6Qd
         y/lE15JXbcrxCrNx4RMeX4c+GfRlGzZxFohHiUW5D/ABBLvLkiz8m6Y19uiv77nbRseL
         0UYg==
X-Received: by 10.50.7.68 with SMTP id h4mr2142652iga.40.1435140727214; Wed,
 24 Jun 2015 03:12:07 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Wed, 24 Jun 2015 03:11:37 -0700 (PDT)
In-Reply-To: <xmqqoak6e5dx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272544>

On Tue, Jun 23, 2015 at 11:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This patch tightens the "exists in index" check, ignoring i-t-a
>> entries. For fixing the above problem, only the change in
>> check_to_create() is needed.
>
> And the first thing I noticed and found a bit disturbing was that
> this change (which I think is correct, and happens to match what I
> sent out earlier) was the only thing necessary to make your new test
> pass.  IOW, the other changes in this patch have no test coverage.

Because to be honest I don't understand these code well enough to know
how to trigger it :)

>> For other changes,
>>
>>  - load_current(), reporting "not exists in index" is better than "does
>>    not match index"
>
> Is that error reporting the only side effect from this change?

The only thing that I can see. If an i-t-a entry is returned, it can't
get past verify_index_match because ce_match_stat(). Hmm.. no the
on-disk version is gone, we'll get to checkout_target() where it will
"restore" the entry with an empty file. This is related to checkout
that I will continue later below.

>>  - get_current_sha1(), or actually build_fake_ancestor(), we should not
>>    add i-t-a entries to the temporary index, at least not without also
>>    adding i-t-a flag back
>
> This is part of "am" three-way fallback codepath.  I do not think
> the merge-recursive three-way merge code knows and cares about, is
> capable of handling, or would even want to deal with i-t-a entries
> in the first place, so adding an entry as i-t-a bit would not help.
> What the ultimate caller wants from us in this codepath is a tree
> object, and that is written out from the temporary index---and that
> codepath ignores i-t-a entries, so it is correct to omit them from
> the temporary index in the first place.  Unlike the previous two
> changes, I think this change deserves a new test.

Will do, after I study some more about this apply.c.

>
>>  I think I'm opening a can of worms with d95d728. There's nothing
>>  wrong with that patch per se, but with this issue popping up, I need
>>  to go over all {cache,index}_name_pos call sites and see what would be
>>  the sensible behavior when i-t-a entries are involved.
>
> Yeah, I agree that d95d728 should have been a part of a larger
> series that changes the world order, instead of a single change that
> brings inconsistency to the system.
>
> I cannot offhand convince myself that "apply" is the only casualty;
> assuming it is, I think a reasonable way forward is to keep d95d728
> and adjust "apply" to the new world order.  Otherwise, i.e. if there
> are wider fallouts from d95d728, we may instead want to temporarily
> revert it off from 'master', deal with fallouts to "apply" and other
> things, before resurrecting it.
>
> Anything that internally uses "diff-index" is suspect, I think.

Yeah that's one or two more grep runs and more reading.

> What do others think?  You seem to ...
>
>>  So far blame, rm and checkout-entry and "checkout <paths>" are on my
>>  to-think-or-fix list. But this patch can get in early to fix a real
>>  regression instead of waiting for one big series. A lot more
>>  discussions will be had before that series gets in good shape.
>
> ... think that the damage could be quite extensive, so I am inclined
> to say that we first revert d95d728 before going forward.

I'm not opposed to reverting if you think it's the safest option and I
will report back soon after grepping diff-index. But those I mentioned
above have more to do with the fact that an i-t-a entry does exist in
the index in a normal way, so reverting does not help.

Take checkout for example, when you do "git checkout -- foo" where foo
is i-t-a, the file foo on disk will be emptied because the SHA-1 in
the i-t-a entry is an empty blob, mostly to help "git diff". I think
it should behave as if foo is not i-t-a: checkout should error out
about not matching pathspec, or at least not destroy "foo" on disk. To
me, when "ce" is an i-t-a entry, only i-t-a flag and ce_name are
valid, the rest of "ce" should never be accessed.

blame.c's situation is close to check_preimage() where it may read
zero from ce_mode. It may be ok for check_preimage() to take zero as
mode, but I think this is like fixed size buffer vs strbuf again. It
works now, but if the code is reorganized or refactored, then it may
or may not work. Better be safe than sorry and avoid reading something
we should not read in the first place.

>>  builtin/apply.c       |  8 ++++----
>>  cache.h               |  2 ++
>>  read-cache.c          | 12 ++++++++++++
>>  t/t2203-add-intent.sh | 10 ++++++++++
>>  4 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index 146be97..4f813ac 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -3344,7 +3344,7 @@ static int load_current(struct image *image, struct patch *patch)
>>       if (!patch->is_new)
>>               die("BUG: patch to %s is not a creation", patch->old_name);
>>
>> -     pos = cache_name_pos(name, strlen(name));
>> +     pos = exists_in_cache(name, strlen(name));
>
> Something that is named as if it would return yes/no that returns a
> real value is not a very welcome idea.

Yeah. But I don't want the caller to call cache_name_pos again to get
"pos". If I can't find a better name, I'll probably go with
cache_name_pos_without_ita().

>> +/* This is the same as index_name_pos, except that i-t-a entries are invisible */
>> +int exists_in_index(const struct index_state *istate, const char *name, int namelen)
>> +{
>> +     int pos = index_name_stage_pos(istate, name, namelen, 0);
>> +
>> +     if (pos < 0)
>> +             return pos;
>> +     if (istate->cache[pos]->ce_flags & CE_INTENT_TO_ADD)
>> +             return -pos-1;
>
> This is a useless complexity.  Your callers cannot use the returned
> value like this:
>
>         pos = exists_in_cache(...);
>         if (pos < 0) {
>                 if (active_cache[-pos-1]->ce_flags & CE_INTENT_TO_ADD)
>                         ; /* ah it actually exists but it is i-t-a */
>                 else
>                         ; /* no it does not really exist */
>         } else {
>                 ; /* yes it is really there at pos */
>         }
>
> because they cannot tell two cases apart: (1) you do have i-t-a with
> the given name, (2) you do not have the entry but the location you
> would insert an entry with such a name is occupied by an unrelated
> entry (i.e. with a name that sorts adjacent) that happens to be
> i-t-a.

OK so either return -1 when the entry does not exist or is i-t-a and
non-negative otherwise.
-- 
Duy
