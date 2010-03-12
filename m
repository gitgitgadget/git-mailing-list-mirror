From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git checkout -b: unparent the new branch with -o
Date: Thu, 11 Mar 2010 22:53:11 -0800
Message-ID: <7vr5nqrpyg.fsf@alter.siamese.dyndns.org>
References: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 07:53:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpykS-0006kW-Q8
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 07:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564Ab0CLGxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 01:53:22 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753445Ab0CLGxV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 01:53:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7056CA19B4;
	Fri, 12 Mar 2010 01:53:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uyPdqB7g7weh7kYb0AksoQ0t6V8=; b=q9/gK9
	iGcXmTlHFfXqK7jBeRAAz/J38fiyzf9kkLQn9wXso4Qi/auXg4f4N18J0rVTDHHp
	xha2W41NF8M2cA2nUcSj4g/A9t29i2mrKpdDo5FOlWEPC+A22mjhNmMUXB2IWV+5
	0uBhZM9gCQt/VUApvwhlwrmvvT/qVpyDb6Q0U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nVLIaGfYwdD94YbK2x2qrVggq+CL8kSq
	Y5+4yaaU+Y0zOKtN9gS+01xwzLyKgH29uk/VRI7DyVQF49ggu9kf4XnkAWLThcuq
	3hf8jtmlxzW/UyFUp9JYe5W2bie7XUYTCiKNYznvX+3ISEfV6JGEdoUt0nfPwdHK
	T62d0pxLIsY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D5CCA19B3;
	Fri, 12 Mar 2010 01:53:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C32BA19B2; Fri, 12 Mar
 2010 01:53:13 -0500 (EST)
In-Reply-To: <1268173713-5224-1-git-send-email-erick.mattos@gmail.com> (Erick
 Mattos's message of "Tue\,  9 Mar 2010 19\:28\:33 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EF5831A2-2DA3-11DF-8209-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142024>

Erick Mattos <erick.mattos@gmail.com> writes:

> @@ -25,6 +26,10 @@ linkgit:git-branch[1] were called; in this case you can
>  use the --track or --no-track options, which will be passed to `git
>  branch`.  As a convenience, --track without `-b` implies branch
>  creation; see the description of --track below.
> +When using -b, it is possible to use the option -o to set the new branch
> +as unparented thus unrelated to the previous branch.  The new code will
> +be committed by using 'git add' and 'git commit' as if it was an initial
> +commit.

This says what the option does, but it is hard to guess why it would be a
good thing to do in the first place from the above description.

The use case in your commit log message wasn't convincing either.  If such
a new branch will be merged later, especially if the trees of the commits
in newly rooted history resemble the trees in the original history (I am
guessing that is the intended use case, as you do not seem to be removing
anything from the working tree---how is the user expected to use them by
the way?), not having a common merge base will make the merge harder, not
easier, and later examination of the history (think "bisect") also
harder.

This looks like a "because we can" feeping creaturism, without any
"because it is beneficial if users can do this for this reason"
justification.

And what it can do "because we can" doesn't look very useful, safe, nor
sane either, with this particular implementation.

> @@ -509,8 +510,13 @@ static void update_refs_for_switch(struct checkout_opts *opts,
>  	struct strbuf msg = STRBUF_INIT;
>  	const char *old_desc;
>  	if (opts->new_branch) {
> -		create_branch(old->name, opts->new_branch, new->name, 0,
> -			      opts->new_branch_log, opts->track);
> +		if (opts->new_branch_orphan) {
> +			discard_cache();
> +			remove_path(get_index_file());

I don't think we want to see "remove_path()" here.  The function is about
the files in the work tree, and not about the files under .git/.
Currently the codepath to create and write out the index is abstracted
like this:

    fd = hold_locked_index();
    ... populate the_index structure ...
    write_cache(fd);
    commit_locked_index();

and by only changing the implementation of these three functions, we could
store the index somewhere other than on the filesystem (say, database or
memcache).  By using remove_path() on the return value of get_index_file()
in a random codepath like this one, you are pre-seeding a bug for other
people who may ant to make changes like that in the future.

But the above is just an advice on the coding, assuming that what is being
coded is sane, which unfortunately is not.  You are nuking the index but
without doing anything to the working tree files.  Why?  The user manually
has to remove them?  Or re-add them?  I don't think you would want to call
discard_cache() _nor_ remove the index file here.  This is probably even
more so if you think about a case where the user is using a sparse
checkout.  Some random set of files are still in the working tree but
other files aren't, and the index used to keep track of which is what, but
you lost that information by discarding the cache.

If you are going to leave the files in the working tree intact, you should
make it the user's responsibility to run "git rm -f" after "checkout -o",
if the user wants to start from an empty index.  That would also make it
safer; a mistaken "checkout -o" would be easier to recover from by running
reset without --hard, if it does not touch the index.

By the way, the worst part of this patch is that I didn't see any safety
checks tested in the test script.  What prevents the users from typing an
extra -o by mistake, while having some changes to the index and/or the
files in the working tree?  Even if you change it not to touch the index,
it would probably make sense to make sure this "feature" is a lot harder
to invoke by mistake.  In a sane workflow you wouldn't be creating root
commits left and right.  Perhaps by not giving it a '-o' shorthand would
be a good start.

In the above I assumed (by guessing from the fact that you are not
touching files in the working tree) that the tree eventually committed by
the user on this newly rooted history would have some resemblance to the
trees in the original history.  But if -o is intended to be used for
really "starting from void" with an empty tree, then I think the option
should instead do this:

 - run an equivalent of "git rm .", which includes:

  - make sure no change is in the index relative to HEAD; otherwise error
    out.

  - make sure no change is in the working tree relative to the index;
    otherwise error out.

 - discard_cache() and write that empty index out;

 - make the HEAD dangling like you did.

That would be safe and halfway useful _if_ somebody wants to start a truly
new history from scratch, even though if you want to have an unrelated
history in your repository it would be more natural do so by fetching such
an unrelated history from an unrelated repository.

The way the patch implements is not suited for neither "starting from
void" case, nor "continuing the tree but with disjoint history" case, I
think.

> diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
> new file mode 100755
> index 0000000..7170641
> --- /dev/null
> +++ b/t/t2017-checkout-orphan.sh
> @@ -0,0 +1,50 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2010 Erick Mattos
> +#
> +
> +test_description='git checkout -b
> +
> +Tests for -o functionality.'
> +
> +. ./test-lib.sh
> +
> +TEST_FILE=foo
> +
> +test_expect_success 'Setup' '
> +	echo "initial" > "$TEST_FILE" &&

This is just style, but I find it easier to read if you have one SP before
redirect and no SP between redirect and the filename, i.e.:

	echo initial >"$TEST_FILE" &&

> +	test "alpha" = "$(git branch | sed -n "/*/s/\* //p")" &&

Don't read from "git branch" in scripts; use symbolic-ref on HEAD.
