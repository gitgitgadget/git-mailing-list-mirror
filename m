From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/7] reset: use "unpack_trees()" directly instead of
 "git read-tree"
Date: Sat, 12 Dec 2009 13:46:04 -0800
Message-ID: <7vocm3n9wj.fsf@alter.siamese.dyndns.org>
References: <20091212042042.3930.54783.chriscool@tuxfamily.org>
 <20091212043259.3930.82570.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:29:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdHM-0005Q8-3f
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933435AbZLMB2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933427AbZLMB2o
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:28:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46423 "HELO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933390AbZLMB2m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:28:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF470A62A3;
	Sat, 12 Dec 2009 16:46:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=64RT70B7b0KT4Ut57JbDV18eL5I=; b=EQFOcphx7rdnjZ8eodQvSi3
	yTXmgMUj2hSuReCVbWIomjcYRYoVxbWNoc08O4JoGGrZbjV8dqPslSL9uiMjC5/Z
	UUu5Q2YLH4mwg/jsw+rnoBz+lfBsPgiNkisbqEGOHLq7YKIC1x9jtDGf6qWXvfhD
	LwomV2AAGEulb5VsRysg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=M2s9vP9ve81ttS7CiJh02Z/rQvXIrwLCr9sHMyyEjVwvO35Dt
	cBGiNS/1/7V4qJ1ivAjOG0RUIcXvfH454FHiQO/jImWncBxVz0BaLy467K/DNbKq
	T0trUvuxQhWDBCmAcxr9nNjKvjcDcGYqX3ahz4gl3o6V2pSEEhVP+LgLGc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 45E2EA62A1;
	Sat, 12 Dec 2009 16:46:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C54F3A62A0; Sat, 12 Dec 2009
 16:46:05 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C8B1BA6E-E767-11DE-9456-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135142>

Christian Couder <chriscool@tuxfamily.org> writes:

> As Daniel Barkalow found, there is a difference between this new
> version and the old one. The old version gives an error for
> "git reset --merge" with unmerged entries and the new version does
> not. But this can be seen as a bug fix,...

I sense that there is one crucial sentence missing here for a reader to
judge the "can be seen as a bug fix" claim.  Instead of giving an error
and stopping, what _does_ this version do?  If it ran "rm -rf" on the
entire work tree instead of giving an error, it wouldn't be a bugfix, for
example ;-)

> In fact there is still an error with unmerge entries if we reset
> the unmerge entries to the same state as HEAD. So the bug is not
> completely fixed.

"If we reset to HEAD then it is a bug"---and what the patch actually does
is...?

I agree with the analysis in the log message of 9e8ecea (Add 'merge' mode
to 'git reset', 2008-12-01):

    If the index has unmerged entries, "--merge" will currently simply
    refuse to reset ("you need to resolve your current index first").
    You'll need to use "--hard" or similar in this case.

    This is sad, because normally a unmerged index means that the working
    tree file should have matched the source tree, so the correct action
    is likely to make --merge reset such a path to the target (like --hard),
    regardless of dirty state in-tree or in-index.

If I have a local change that I know is unrelated to a merge I am
going to do, I can imagine I'd work like this:

    $ git pull some-where
    ... Some paths conflict, others merge cleanly and update
    ... the index, but the overall change looks horrible, and
    ... I decide to discard the whole thing.
    $ git reset --merge HEAD

In this case HEAD is the target.  Similarly, if I have a local change that
I know is unrelated to a series of patches I am applying:

    $ git am -3 topic.mbox
    ... A few patches apply cleanly, and then the series fail
    ... with conflict.  The overall change looks horrible, and
    ... I decide to discard the whole thing.
    $ git reset --merge @{3.minutes.ago}

In this case, the target is the commit that I was at before starting to
apply the series---i.e. different from HEAD.

In either case, because "merge" (triggered by "pull") and "am -3" honor
the promise with the user that:

 (1) no mergy (aka "integration") command stuffs an unmerged entry to an
     index that is dirty with respect to HEAD (this should also apply to
     "cherry-pick" and "rebase -m/-i" even though the last one is often
     stricter than it is absolutely necessary); and

 (2) every mergy command verifies that the index entry and the path in the
     work tree do not have any local change before they are updated by it;

resetting can safely overwrite both the index entry and the path in the
work tree with contents taken from the commit we are switching to.

The updated test seems to be testing that "reset --merge HEAD^" does make
the index match the target, but it only checks "is there _any_ change",
and does not even test "which path kept the change and which path got
cloberred".

Ideally it should test "Is the change what we expect to have?  Did we keep
what we should have kept, instead of clobbering? Did we discard the
changes to the path that the failed merge cloberred?", all of the three.

> diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> index 8190da1..6afaf73 100755
> --- a/t/t7110-reset-merge.sh
> +++ b/t/t7110-reset-merge.sh
> @@ -79,10 +79,12 @@ test_expect_success 'setup 2 different branches' '
>       git commit -a -m "change in branch2"
>  '
>  
> -test_expect_success '"reset --merge HEAD^" fails with pending merge' '
> +test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
>       test_must_fail git merge branch1 &&
> -     test_must_fail git reset --merge HEAD^ &&
> -     git reset --hard HEAD
> +     git reset --merge HEAD^ &&
> +     test -z "$(git diff --cached)" &&
> +     test -n "$(git diff)" &&
> +     git reset --hard HEAD@{1}
>  '
>  
>  test_expect_success '"reset --merge HEAD" fails with pending merge' '
> -- 
> 1.6.6.rc1.8.gd33ec
