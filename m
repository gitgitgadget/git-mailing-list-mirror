Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8F20E3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="f3BYweLi"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCF4BC
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 19:03:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 235B91A27B;
	Mon, 23 Oct 2023 22:03:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xNwLJ0IRXsVzpfPqqOMjrN6ZR7b8Ta0IgUNNQu
	INqxY=; b=f3BYweLiqS9iTrubTQNyUTTLKDo1mQxzaMoJ9jbhPTD+FTtQsHpfKs
	GSUY64ryZkaSMfX2+yPfUXJqieGL/t2DQ87MZ9T9cb7ScmldWvISuyS2mC+GQ+Ls
	iwcePdB91pJFz0u1KaTMDdUW1OAUGgIzxMs0+ow2hOP1BXgJSzEto=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1CDE51A27A;
	Mon, 23 Oct 2023 22:03:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8CCAC1A279;
	Mon, 23 Oct 2023 22:03:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacob Stopak <jacob@initialcommit.io>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
In-Reply-To: <62164acf4a787042dbb6e5abe212559b@manjaro.org> (Dragan Simic's
	message of "Tue, 24 Oct 2023 03:10:25 +0200")
References: <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
	<5fac8607a3c270e06fd610551d7403c7@manjaro.org> <ZTT5uI5Hm1+n0Agx@ugly>
	<58a6a25a7b2eb82c21d9b87143033cef@manjaro.org> <ZTZQZhtTxvGT/s81@ugly>
	<bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
	<ZTatzlzCkPOW3Rn7.jacob@initialcommit.io> <ZTa4iqe0lqn/Yg5L@ugly>
	<ZTbJiIkIyXwWK8JP.jacob@initialcommit.io> <ZTbVY7Nf+DTYqHky@ugly>
	<ZTb/HeILRHnZjaz6.jacob@initialcommit.io>
	<62164acf4a787042dbb6e5abe212559b@manjaro.org>
Date: Mon, 23 Oct 2023 19:03:20 -0700
Message-ID: <xmqqil6w6al3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 81FD7D44-7211-11EE-9027-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> IMHO, it would be the best to simply implement support for
> "<command>.verbose = table" in the git configuration, similarly to how
> we already have "commit.verbose = true".  That way tables could be
> enabled per command, according to the user's preferences, regardless
> of performing dry runs or not.

I think the "use more verbose report format to help relatively
inexperienced folks, in exchange for spending more screen real
estate" is a good direction to think about this thing.

I am not personally interested in adding such support all that much
myself, but one piece of advice I can offer those who are interested
is not to be too deeply attached to the word "table".

It may be that "git status" (not "status -s" [*] but the current
version for human consumption) shows "paths with changes to be
committed (i.e. changes added to the index exist)" and "paths with
changes you could add to the index (i.e. changes yet to be added to
the index exist)" in a separate list, and Jacob may have found that
it gives a more understandable view into the states of each path if
the output is turned 90-degrees and the changes are shown in a
tabular form.  But "table" in this example is merely an
implementation detail of one presentation that is easier to
understand for "git status", and calling it "table" and making it a
word in the vocabulary of <command>.verbose is like a tail wagging
the dog.  We want to convey to the users that the option is about
"with extra verbosity, the user is buying a bit more clarity", not
necessarily "use tabular form no matter what".

For some of the commands, tabular presentation might not even be the
presentation form that is the easiest to understand to novices.  For
example, I just pushed out today's integration result to some of my
repositories, and "git push" output looks like so:

To github.com:gitster/git.git
 + 5cb4030332...7dc6f5ada8 ak/color-decorate-symbols -> ak/colo...
 + a71066b71b...c80a646458 jch -> jch (forced update)
 + 89a1ffc6a4...416cdf7260 seen -> seen (forced update)
 + 7ff160463b...2c610ca9ff tb/merge-tree-write-pack -> tb/merge...
   2e3b7b2460..57243409ad  refs/notes/amlog -> refs/notes/amlog

This is already "tabular" and gives enough information to tell me
which ones did not get updated (e.g., I do not see 'next' there) and
which ones are forced ('jch' and 'seen' are usually forced and I'll
notice that I may have made mistakes if they are not).  But a
hypothetical presentation that is easier for novices to read may
show "git log --oneline --graph old...new" (or some abbreviated form
of it) between the old and new tips of the affected branches.  At
that point, calling the improved output as "table" would make little
sense.

For commands that Jacob found it easier to explain in tabular form,
like "git add", it is very possible that two years down the road,
another Jacob comes around and proposes a different presentation
that is even easier for novices to understand, and it may not be a
tabular form.

So be very careful when choosing what to call this new thing, and
avoid naming it after the implementation details (e.g., in what
particular shape the data gets presented) that may turn out not to
be the most important part of the concept.

[Footnote]

 * FWIW, "git status -s" is a tabular presentation.  Maybe we can
   add a more verbose form of "-s" and be done with it for the
   command?
