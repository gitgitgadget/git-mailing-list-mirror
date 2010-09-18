From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: [PATCH v3 2/4] convert: fix normalization of foreign idents
Date: Sun, 19 Sep 2010 00:38:04 +0200
Message-ID: <yf9eicq1xv7.fsf@chiyo.mc.pp.se>
References: <cover.1284820251.git.marcus@mc.pp.se>
	<b56d7f50198f63a810b304ae77043f58a240f743.1284820251.git.marcus@mc.pp.se>
	<7v8w2yzqkc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 19 00:38:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ox62z-0002xY-81
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 00:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab0IRWiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 18:38:12 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:47079 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804Ab0IRWiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 18:38:11 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id D71F6F2CB;
	Sun, 19 Sep 2010 00:38:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1284849486; bh=iLJy/51DZB3NmyTOjWGzp1Htw788wktwGsoo9rcVjfE=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QRR/wn3zZ7MP5vtMqn5+qUxpBGPBJUoujnh17
	RM+0iXD0HgzYA4bFc+vSMGhv5AU05U6omO+hJyo5l6kJIP1s+afUL7ZFLPDqkbEMzqM
	rD5RsEBunfhSICXaFbp5n9TgvNFs5SIFKMrJ/OxjA0bH37p2BARgKkI6u0hKSvwcg6U
	=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <marcus@mc.pp.se>)
	id 1Ox62n-0002mB-Ch; Sun, 19 Sep 2010 00:38:05 +0200
In-Reply-To: <7v8w2yzqkc.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat, 18 Sep 2010 14:31:47 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156479>


Hi Junio.

Junio C Hamano <gitster@pobox.com> writes:

>> There is however one case where we want ident_to_git() to normalize
>> the tag to $Id$ despite the asymmetry...
>
> I'd actually think that is a bad idea.  The user _can_ choose to do so by
> removing the stale part from '$Id: obsolate garbage$", of course.

Yes, but it's easy to miss doing so.  And having two versions with the
same ident would be bad.  Furthermore, I couldn't think of a use case
where you want to use idents (as indicated by setting the "ident"
attribute), and do _not_ want stale data removed.


> Or we can always normalize, which _might_ turn out to be a better
> solution.

I'm not quite sure I understand what you mean by "always normalize" here.
Does this mean reverting the original "foreign ident" change, which is
what's preserving these idents on checkout?


[...]
> In order to apply a patch to a file in the working tree, we first need to
> read it, and this codepath is the place to do so.  The file in the working
> tree may be "smudged" (in the sense of smudge/clean filter) and we "clean"
> it so that we can compare and update with what we read from the patch (the
                    ^^^^^^^
> patch text is expected to be always "clean").
>
> We don't check "safe-crlf", as it can "die" if it is allowed to when
> check_safe_clrf() finds things it does not like.
>
> We expect to write the result out to the working tree, and at that point
> we will run convert_to_working_tree().  The result can also be added to
> the index after we are done.  The resulting index may be used to create
> the next commit.  Why "for compare" and not "for commit"?

I believe you answered that question yourself above.  ;-)

The file will be converted for commit once you add and commit the
result that was written to the working tree.  That happens in
index_mem(), not here.


> If you get a patch to a file that contains a line with an ident, either as
> a context or old line.  Both your working tree file and your index would
> have "$Id: stale garbage$".
>
> A patch may have
>
>  - "$Id: stale garbage$" (made against the identical foreign source),
>  - "$Id: updated garbage$" (made against an updated foreign source), or
>  - "$Id$": (made against a conversion to git done elsewhere).
>
> By telling git not to normalize "$Id: stale garbage$" you have, aren't you
> making the patch made not to apply 2 out of 3 above cases, especially if
> it came from your git friends (the last one)?

But by normalizing it, it would just be two of the other cases where
the patch does not apply, no?

By not normalizing it, a patch made against the head of a clone of the
same repository would apply at least.

Or am I missing something here?


> This patch doesn't touch "apply --cached" at all, which introduces yet
> more unnecessary inconsistency.  If you made changes to the index through
> that codepath, shouldn't the resulting object lose the $Id: stale garbage$
> somewhere before it is made into the next commit?

Foreign idents should always be removed by a commit which alters the
file in any other way, so there might be additional handling needed
for this case, I'll have to take a closer look at it.


> My gut feeling is that this kind of complications aren't worth it.  If we
> were to address the $Id$ issue, I wonder if we can fix it the other way
> around, by making both directions always convert (i.e. ident_to_worktree()
> and ident_to_git()); the end result of such a change feels much simpler to
> explain to the users.

Well, that's how it worked before 07814d9.


>> +enum normalize_mode {
>> +        NORMALIZE_FOR_COMPARE = 0,
>> +	NORMALIZE_FOR_COMMIT = 1,
>> +};
>
> Funny use of whitespaces.

Yes, it seems one of the lines got 8 spaces and the other one a tab.
Not intentional.


>> @@ -797,5 +810,5 @@ int renormalize_buffer(const char *path, const char *src, size_t len, struct str
>>  		src = dst->buf;
>>  		len = dst->len;
>>  	}
>> -	return ret | convert_to_git(path, src, len, dst, CHECKS_DISALLOWED);
>> +	return ret | convert_to_git(path, src, len, dst, CHECKS_DISALLOWED, NORMALIZE_FOR_COMPARE);
>
> This is called from merge operation to read from the object store, and
> apply double-conversion (first from git to working tree and then back to
> git).  But the result is written out as an object and hopefully be
> recorded as a merge commit.  Why "for compare"?  We would want a normalized
> result, no?

Ok, this was a new function and I didn't fully understand its purpose.
If the resulting buffer is written as an object, then "for commit"
should be used, yes.


>> @@ -2375,7 +2375,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
>>  		/*
>>  		 * Convert from working tree format to canonical git format
>>  		 */
>> -		if (convert_to_git(s->path, s->data, s->size, &buf, CHECKS_ALLOWED)) {
>> +		if (convert_to_git(s->path, s->data, s->size, &buf, CHECKS_ALLOWED, NORMALIZE_FOR_COMPARE)) {
>
> This feels wrong.  This is a "read-only" access just like combine-diff and
> blame one.  I think CHECKS_ALLOWED is probably a bug in the original.
> There is no reason to complain against what you haven't added.

Yes, I was also a bit curious about this one.  If it is indeed a bug,
it probably ought to be fixed independently of this patch series.


> *2* That is the kind of option that specifies what it _means_, not what or
> how it does, I suggested you to think about in the first round of review.
> "Do we allow checks?" wasn't the kind of a meaningful option I was hoping
> to see; we would want the code to clarify _why_ we allow or forego checks
> at individual callsites.

Well, maybe it was a little unrealistic to hope that someone new to
the codebase should be able to discern exactly what you guys were
thinking when you wrote a particular piece of code...  ;-)


  // Marcus
