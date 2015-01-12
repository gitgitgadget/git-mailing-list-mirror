From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Mon, 12 Jan 2015 14:55:30 -0800
Message-ID: <xmqqzj9n623h.fsf@gitster.dls.corp.google.com>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
	<xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Lukas Fleischer <git@cryptocrack.de>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:55:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAntb-0007uL-Gb
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 23:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbbALWzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 17:55:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751389AbbALWze (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 17:55:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E4EC12F399;
	Mon, 12 Jan 2015 17:55:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WAioWz0vFaDLgGEVULQl8R7Ao9s=; b=xup4Uk
	v+Hg9ZFAiqAJJo+eC2CtyroHJfUVJczQ5tr7LHgFZa9ZptRr3S8e6iGQ7oh6jLL/
	g7Flsvi0em7NUBGmt6me2ANqpGjr+XIlSeOzEFH5yd2/+38f+MEfiNnqVb6IJF/+
	+wFbN6I/0iNauhwJX2RYIDB8Zz21335DzxHcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MItpeBs4AMWHAldJeuifufJN+FNxjOdk
	BsNOkeJiVM7LUoSzzhBUHIVUy1h3a+aq5EIWE4yA8ZIxHM1iJyUSSvQTnQmYUbu+
	DXOxC6wRvv7bnRcirZasnJJyydUEKyXLRJbxB9jzulXo78DJ2VC2Idvk8lr+DjhG
	TOM5fEg5QYs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D833D2F398;
	Mon, 12 Jan 2015 17:55:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 65C342F397;
	Mon, 12 Jan 2015 17:55:32 -0500 (EST)
In-Reply-To: <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 12 Jan 2015 11:08:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CB2352C-9AAE-11E4-B1FB-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262299>

Junio C Hamano <gitster@pobox.com> writes:

> Lukas Fleischer <git@cryptocrack.de> writes:
>
>> The helper functions prepare_final() and prepare_initial() return a
>> pointer to a string that is a member of an object in the revs->pending
>> array. This array is later rebuilt when running prepare_revision_walk()
>> which potentially transforms the pointer target into a bogus string. Fix
>> this by maintaining a copy of the original string.
>>
>> Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
>> ---
>> The bug manifests when running `git blame HEAD^ -- nonexistent.file`.
>
> Before 1da1e07c (clean up name allocation in prepare_revision_walk,
> 2014-10-15), these strings used to be non-volatile; they were instead
> leaked more or less deliberately.  But these days, these strings are
> cleared, so your patch is absolutely the right thing to do.
>
> Thanks for catching and fixing.  This fix needs to go to the 2.2.x
> maintenance track.

Sigh, but not so fast.

With the patch applied on top of 1da1e07c (or the result merged to
'next' for that matter), I see test breakages in many places "git
blame" is used, e.g. t7010.  Did you run the test suite?

This is because it is perfectly normal for prepare_final() to return
NULL.  Unconditionally running xstrdup() would of course fail.

>> Note that I could have reduced code churn a little by moving the
>> xstrdup() invocations to the call sites. However, I think that the
>> return value of these functions should not depend on the consistency of
>> a volatile data structure. On the other hand, you might also argue that
>> there currently are only two call sites and that the functions are
>> marked static, so if you prefer the less intrusive version, please let
>> me know.
>
> FWIW, I agree that this can be argued either way.
>
> If we had a common low-level API that is used by short-term users to
> grab these names, it would be reasonable to make it the callers'
> responsibility to strdup() the return values for safekeeping if they
> want to keep using them long after the function returns.  But I
> agree that prepare_final/prepare_initial are not such a low-level
> common API functions.  I do not care too much about who does the
> strdup(), either the callers of prepare_* or the callee.
>
>>
>>  builtin/blame.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 303e217..34d6f4f 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -2390,7 +2390,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
>>  	return commit;
>>  }
>>  
>> -static const char *prepare_final(struct scoreboard *sb)
>> +static char *prepare_final(struct scoreboard *sb)
>>  {
>>  	int i;
>>  	const char *final_commit_name = NULL;
>> @@ -2415,10 +2415,10 @@ static const char *prepare_final(struct scoreboard *sb)
>>  		sb->final = (struct commit *) obj;
>>  		final_commit_name = revs->pending.objects[i].name;
>>  	}
>> -	return final_commit_name;
>> +	return xstrdup(final_commit_name);
>>  }
>>  
>> -static const char *prepare_initial(struct scoreboard *sb)
>> +static char *prepare_initial(struct scoreboard *sb)
>>  {
>>  	int i;
>>  	const char *final_commit_name = NULL;
>> @@ -2445,7 +2445,7 @@ static const char *prepare_initial(struct scoreboard *sb)
>>  	}
>>  	if (!final_commit_name)
>>  		die("No commit to dig down to?");
>> -	return final_commit_name;
>> +	return xstrdup(final_commit_name);
>>  }
>>  
>>  static int blame_copy_callback(const struct option *option, const char *arg, int unset)
>> @@ -2489,7 +2489,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>>  	struct origin *o;
>>  	struct blame_entry *ent = NULL;
>>  	long dashdash_pos, lno;
>> -	const char *final_commit_name = NULL;
>> +	char *final_commit_name = NULL;
>>  	enum object_type type;
>>  
>>  	static struct string_list range_list;
>> @@ -2786,6 +2786,8 @@ parse_done:
>>  
>>  	assign_blame(&sb, opt);
>>  
>> +	free(final_commit_name);
>> +
>>  	if (incremental)
>>  		return 0;
