From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/6] notes: replace pseudorefs with real refs
Date: Tue, 28 Jul 2015 15:52:17 -0700
Message-ID: <xmqqpp3bc2u6.fsf@gitster.dls.corp.google.com>
References: <1438107144-24293-1-git-send-email-dturner@twopensource.com>
	<1438107144-24293-3-git-send-email-dturner@twopensource.com>
	<xmqqpp3cds44.fsf@gitster.dls.corp.google.com>
	<xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:52:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKDjU-0002Tv-7k
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbbG1WwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:52:20 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32892 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206AbbG1WwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:52:19 -0400
Received: by padck2 with SMTP id ck2so76642799pad.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=F0cgWMfyEbN3W9TO+KxJYeSihlcixLjLNKEjo/ZTE8M=;
        b=Ok/vbk9yjjrYiSL/osHZJYwK3KPRBiveEya+9yUrQtg9lmlf+oD6UbCvnBUB8hxhBX
         APJWzeqVhhWtPtzUbvGmqkASalTxKY0ty0vIaAxBAtSGmgjQHrBC5dKUDLps+zD5s6zA
         Z5B/Ypf7IFxNspnYlByIRs2LEfHhB4HvGBhs3oOX+lkQr++/MvBHL6ilbBovzMDYra2I
         4GS1JcBe6AzcncMxKA6kBt2EERapKpDf1sMevrXqxkWxt+qGbpD0KnEtx9gDKXi3c2hU
         FyDiCimNaOJvqsvhp8AiiVsK/Y9fUvFIRWZyyQt0ue80jqxl3WPpkT0X67PWjC5a7+Aj
         YkSQ==
X-Received: by 10.66.250.226 with SMTP id zf2mr8346716pac.20.1438123939129;
        Tue, 28 Jul 2015 15:52:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id ca13sm37230091pac.25.2015.07.28.15.52.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 15:52:18 -0700 (PDT)
In-Reply-To: <CALKQrgdLC_sLkM3jyH6pnDoY+RTHr9wJR_VH6iirBWmvyHYcVA@mail.gmail.com>
	(Johan Herland's message of "Wed, 29 Jul 2015 00:38:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274865>

Johan Herland <johan@herland.net> writes:

Johan Herland <johan@herland.net> writes:

> However, in any case, notes merges are always per _repo_ and never per
> _worktree_, so this is all unrelated to the current patch/discussion
> AFAICS.

Thanks for chiming in, but I actually think you are confused.

"git merge" is always per _repo_ in the sense that the result of a
merge of a topic to the 'master' is recorded in the 'master' which
is per-repo.  In the multi-worktree world order, that does not
change.  What changes is that you could have different worktrees
that check out different branches.  Worktree A may have 'master'
checked out and do the merge there to update the tip of 'master'.
But while worktree A is doing that, worktree B may have 'next'
checked out and do an unrelated merge there.  Once worktree A leaves
'master' by checking out another branch, worktree B is free to check
out 'master' and do further merges there.  Merging into 'master' is
per _repo_, but the act of merging is per worktree.

I think merges of refs/notes/commits and refs/notes/someotherthing
works exactly the same way.  In worktree A, you may decide to merge
a notes tree refs/notes/commits with somebody else's.  It may
conflict and you may need to "lock" refs/notes/commits from being
touched by other worktrees while resolving that, but that does not
mean other worktrees cannot do a merge of refs/notes/someotherthing
at all.  The temporary area you use for merging notes, i.e. the
working tree as far as notes merge is concerned, is private to
worktree A and does not need to be seen by other worktrees.

So while you are working on merging and resolving, that intermediate
state is *NOT* per _repo_ at all.  It is at most per worktree (Yes
you could extend and have one notes_merge_ref per each refs/notes/*
ref to make it even finer grained to allow more than one notes merge
going on inside a single worktree, but I do not think it is worth
it).
