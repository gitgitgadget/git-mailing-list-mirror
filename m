Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749BC182
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413148; cv=none; b=AZL1HIiPN/RRn/GD56+/Zd0s6hnC9COnwJBcREaXka9MpSmH8iMcybej6klhzF2MSEWd6qSG4yTPREtlm/uMxRP9ipnTnW8lJVC0pofTfH8k5pX3p5UQ+4bSCke0C4hMGdWore2YU+JAhghnpatTw/lQRYh8K9q3drLjLbuIcd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413148; c=relaxed/simple;
	bh=3u3dEc1ZbDbrdA8QNRLXEhS3hhuGwJHiQhaLMbtPbFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awQ3IReaOfBoXZ96MGvw42iwNocRJO7o3LJUPzHG7Nu6pXnEsvKMuCOvistNmaWrlYg5Z7o/YV0sg1hkMFb4fJBF8NRpQ4zTzuliyBUnD7QoogGlxCbZqoUt6QUbh5f6JUzCMpSlctobkssRVV2W5XL9jphD+sKamos3dpq3UP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ncHJk/WZ; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ncHJk/WZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745413139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=91IfLh6s2YhG7sAU6+JePoWP9Hnez9g+cOlG7Je4IiY=;
	b=ncHJk/WZqPKZz3gJ2Iv09GGCJ6ceCM5rwrX+rhWyvTZtuhWew7Vo0yHhFPpOQ/9jPLUUd+
	bHomco9G7cZOpN42Avn6wIn6zrHSgwGlcPfpkD5LmBAb6aJN13BgxpnsnluQtP58AZSqG6
	Edjv4W+RT9owQchogSnJRtYGvzU0eDA=
From: Toon Claes <toon@iotcl.com>
To: Nico Williams <nico@cryptonector.com>, Remo Senekowitsch <remo@buenzli.dev>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Junio C Hamano <gitster@pobox.com>, Martin von Zweigbergk
 <martinvonz@google.com>, Git Mailing List <git@vger.kernel.org>, Edwin
 Kempin <ekempin@google.com>, Scott Chacon <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: How GitLab does/doesn't need change IDs (was Re: Semantics of
 change IDs)
In-Reply-To: <aAg4JR+rCDqO5ljV@ubby>
References: <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu>
 <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu>
 <Z/amMj/eg0RbXdkS@ubby>
 <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com>
 <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev>
 <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
 <aAgWytQNqtLzg2TU@ubby> <D9DLAQTMJYU6.RJLLVMQZOICK@buenzli.dev>
 <aAg4JR+rCDqO5ljV@ubby>
Date: Wed, 23 Apr 2025 14:58:49 +0200
Message-ID: <87cyd3f306.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Nico Williams <nico@cryptonector.com> writes:

> On Wed, Apr 23, 2025 at 02:25:40AM +0200, Remo Senekowitsch wrote:

>> Firstly, it only happens when you make a comment on the whole diff.
>> Then it shows you an interdiff between the version you commented on and
>> the immediate next version. (I didn't find a way to make it show the
>> interdiff between the commented-on and the _latest_ version, but that
>> seems doable implementation wise.)
>
> I suspect that's a UI design issue: how cluttered do you want the UI to
> be?  GitLab's UI is already quite cluttered.  Often I struggle to find
> the thing I want, and I use it often.

I'm not sure if you've been using Merge Requests here, but if you do you
can compare each version against another. There are two dropdowns near
the top of the "Changes" tab: "Compare <master> and <latest version>".
Here you can compare versions against the target branch and other
versions.

> I think GitHub and Gitlab both can handle ... commit ranges, can they
> not?  The problem is that then you have to find refs (or commit hashes)
> for each version you want to compare, and once again UI complexity gets
> ugly.

At GitLab we keep track of the commit IDs a branch has been (maybe only
if there is a Merge Request for that branch, I'm not sure). We can use
this information to compare versions. I think, to some people in this
thread, the use-case for Change-IDs is pretty similar: you want to tie
information about two commits together. If there is a branch, you have
this information, but in a mail-based workflow (or in Jujutsu) there is
no branch. In that case a Change-Id can fill that gap.

>> If you make a comment on a _specific commit_, the feature doesn't kick
>> in at all. GitLab just tells you that this comment was made "on an
>> outdated change in commit xyz".

As I mentioned, you might need to create a MR to retain/see this
information, I'm not entirely sure.

> The point is that GL demonstrates that these things can be done.  And I
> don't see how a change ID would have helped GL much except in cases
> where one re-does all the commits with different subject lines etc, but
> leaves the actual patches mostly the same.  Now it does happen that I
> split and squash commits, but it's rare that I completely redo them.

That's because GL stores history about a branch ref (outside the Git
object/ref database). If you don't do that, you can't. Having a
Change-Id embedded in the commit, retains that information in Git's DB.

--
Toon
