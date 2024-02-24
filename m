Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B513FF6
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708801500; cv=none; b=EKQgEkgO92AVPqdqeSuOjveTC3NvInKEgG+fcxhRxqgglaTQYC0oB2mUfgUC3dBLiJh80TzRLCzuYp0+ufLcO6T+wsche9a5J/CMGQEW/J0B7Hk28K4/nxp0XE6gcz4vYuT8lSGbUmqx4xWgLy2Hd6Nq3w37dPpAKwAvYXa7hFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708801500; c=relaxed/simple;
	bh=IjuzTlKsquQBAvBJmSkriHPKGIoaNYEVmowJrxaZb0s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EEKmvA73ZuhfVjUmu+Eu9+ulpy6at/2fk0/SCOvepiqJ+eoegByub1ZoO39HnPx3vzaDAci6b2jwQlBkjNgzZKmK5YFRQCZq7wH0KOttE2g4bFNPlniAQqIcIa7NDuzWhw5LlF1VZyxRncgzOygU15s8zkGSPmUjApLqis+vQno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cVH06CH2; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cVH06CH2"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 60A702B3B5;
	Sat, 24 Feb 2024 14:04:57 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=I
	juzTlKsquQBAvBJmSkriHPKGIoaNYEVmowJrxaZb0s=; b=cVH06CH27vsVhmB1p
	8NgWEEadf7gWQQLiAutEwcHHOhAXJkK6jcTmvXcq59gHGgWCQx1AOQ/puozUJJay
	0bK3tmI9cOyvIOiGRF4eUmC0UM+xvWodfbr7l//nFxrek0QDbnlzFVc6SdqUBwSo
	uw5cbQd89UWGRDLUqQYNoG1xRA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 58D5B2B3B4;
	Sat, 24 Feb 2024 14:04:57 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 022A82B3B3;
	Sat, 24 Feb 2024 14:04:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFD] should "git log --graph -g" work and if so how?
Date: Sat, 24 Feb 2024 11:04:52 -0800
Message-ID: <xmqqo7c5n0ob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 97EF2A52-D347-11EE-AB52-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Outside work, I keep one repository that keeps copies of a subset of
what is available elsewhere (but that is not version controlled in
any way), and in this repository, I do either one of two operations:

 * I "fetch" the latest state of the things I keep track of from
   that "elsewhere", and then record that state as a "snapshot".

 * I update the "subset" I keep track of from that "elsewhere",
   download that new part of the subset, and then record the result
   as a commit with messages like "add 'foo'" or "drop 'bar'".

One curiosity is that I do not care too much about "snapshot"; the
latest state is often enough, so when the topmost one is a snapshot,
I may "amend" it when making a new "snapshot", instead of making two
or more consecutive "snapshot" commits (when the topmost "snapshot"
is too old, I may choose to add a new shapshot on top of it, but
let's ignore that for simplicity).

    if I am doing a snapshot
    then
	fetch what I've been tracking from "elsewhere"
	"git add ."
	if the topmost commit is an earlier "snapshot"
	then
		"git commit --amend -m 'snapshot as of ...'"
	else
		"git commit -m 'snapshot as of ...'"
	fi
    elif I am adding new things to be tracked
    then
	fetch the new part of "elsewhere"
	"git add ."
	"git commit -m 'add ...'
    fi

After I started from empty, started tracking 'foo' and then a few
days later started tracking 'bar', and then started taking snapshots
on 2024-02-22 and took one every day, I may end up with a history
that "git show-branch -g" may give me something like this:

    $ git show-branch -g5
    ! [master@{0}] (24 minutes ago) commit {amend}: snapshot as of 2024-02-24
     ! [master@{1}] (1 day ago) commit (amend): snapshot as of 2024-02-23
      ! [master@{2}] (2 days ago) commit: snapshot as of 2024-02-22
       ! [master@{3}] (3 days ago) commit: add 'bar'
        ! [master@{4}] (7 days ago) commit: add 'foo'
    -----
    +     [master@{0}] snapshot as of 2024-02-24
     +    [master@{1}] snapshot as of 2024-02-23
      +   [master@{2}] snapshot as of 2024-02-22
    ++++  [master@{3}] add 'bar'
    +++++ [master@{4}] add 'foo'

and that output is sort-of readable (if you have seen and know how
to read what show-branch produces, that is), but the command way
predates commit slabs and uses the usual object flag bits, so it is
limited to show only 25 or so commits [*1*].

Now, if I could run

    $ git log --oneline --graph -g --since=2024-02-20 --boundary

on the result, such a history might look like this:

    * snapshot as of 2024-02-24 (HEAD)
    | * snapshot as of 2024-02-23 (HEAD@{1})
    |/
    | * snapshot as of 2024-02-22 (HEAD@{2})
    |/
    * add 'bar' (HEAD~1)
    o add 'foo' (HEAD~2)

to show the same history.

Unfortunately, "--graph" and "-g" does not mix X-<.

So, the RFD is,

 (1) Should "git log" learn a trick to show a history like this in a
     readable way?  Does it have utility outside this use case of
     mine?  I am not interested in adding a new feature just for
     myself ;-)

 (2) The use case requires a solution to look at reflog entries, but
     it does not need to "walk" reflog [*2*].  Should such a feature
     still be tied to the "-g" flag, or should we want a separate
     flag?

 (3) What should the UI and the implementation look like?  "Show me
     what happened to this branch since 2024-02-20, including what
     is in reflog" that results in:

     - we first enumerate commits on the reflog of this branch that
       were made since the given date.

     - we then pretend as if all of these commits were given on the
       command line of "git log --oneline --graph", with some other
       commits that probably are ancestors of these commits marked
       as UNINTERESTING.

     may be a promising approach to go.  In the sample history
     depicted above, we would want an equivalent to

       $ git log --oneline --graph HEAD HEAD@{1} HEAD@{2} --not HEAD~2

     where the positive commits are gathered by inspecting the
     reflog for commits newer than 2024-02-20, and then list of
     negative commits (HEAD~2 in this case) is somehow computed to
     stop the usual "git log" traversal from these positive commits
     after showing all of them (and before showing other commits not
     in that initial set).

Thoughts?


[Footnotes]

 *1* It may be an interesting side project to teach show-branch to
     store the bits it uses to paint commits in commit slabs,
     instead of using the object flags, to lift this limitation.
     I'll not put the l e f t o v e r b i t s label on this item, as
     it certainly is an interesting exercise but its usefulness is
     rather dubious.

 *2* "walking" reflog stresses the fact that HEAD@{2} came
     immediately before HEAD@{1} which came immediately before
     HEAD@{0} (or HEAD, which are equivalents), but in this use
     case, it is equally (if not more) important that the snapshots
     taken on 2024-02-22, 2024-02-23, and on 2024-02-24 are more or
     less equals, with the latest one a bit more important than
     others because it is on the branch while the other ones are not
     and merely appear in the reflog.
