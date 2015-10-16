From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] merge: fix cache_entry use-after-free
Date: Fri, 16 Oct 2015 09:04:01 -0700
Message-ID: <xmqq1tcuhkb2.fsf@gitster.mtv.corp.google.com>
References: <1444860424-8361-1-git-send-email-dturner@twopensource.com>
	<561F1EE5.5070300@web.de> <1444935764.20887.1.camel@twopensource.com>
	<xmqqfv1bhn2t.fsf@gitster.mtv.corp.google.com>
	<1444979140.20887.19.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
	Keith McGuigan <kmcguigan@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 18:05:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn7V6-00032h-9z
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 18:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbbJPQEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 12:04:47 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36440 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbbJPQEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 12:04:04 -0400
Received: by pacfv9 with SMTP id fv9so26532564pac.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1SqjzQ/aEsQ0ampjcKFWRmPMMKrbljSwLwdxQKLtdQQ=;
        b=T6G6TU0zflMBGCReue3xZ1ylk5KN7k5Q3XD4jJdWJaLfTZD2xwfbruirOV4NapcLu8
         U7t0anUpG9dYVHg2q7T1995nvaWElMY2a/abNnSccTG0x55xAq2nigrGlM8DuhY0l7bF
         8iPAtVV/zk7Xf5xuOJaekVvCIhdVYc8XSJMqCFlntNH48+z0aOmQDBaqILsppoq0Zu9k
         pfwYAIX3wvrEkWYUybDPUFvfSwertsvUG0gF+lmB3LPXFYILgyl1HLNUv05JOoPp1JBQ
         zihbJpjYRNLUjN1F8Xd8hRO4z0mRqalAzczYY2g4OqHN2Bdw/mHq28NFHxJuUNGhvyI1
         oXeA==
X-Received: by 10.66.102.106 with SMTP id fn10mr17497387pab.156.1445011443401;
        Fri, 16 Oct 2015 09:04:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:458e:bb5:8827:32a1])
        by smtp.gmail.com with ESMTPSA id tb9sm22139961pab.13.2015.10.16.09.04.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 09:04:02 -0700 (PDT)
In-Reply-To: <1444979140.20887.19.camel@twopensource.com> (David Turner's
	message of "Fri, 16 Oct 2015 03:05:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279748>

David Turner <dturner@twopensource.com> writes:

> We also do dozens or hundreds of merges per day and only saw this quite
> rarely.  Interestingly, we could only trigger it with an alternate
> hashing function for git's hashmap implementation, and only once a
> certain bug in that implementation was *fixed*.  But that was just a
> trigger; it was certainly not the cause.  The bug would, in general,
> have caused more hash collisions due to worse mixing, but I believe it
> is possible that some particular collision would have been present in
> the non-bugged version of the code but not in the bugged version.
>
> It may have also had something to do with a case-insensitive filesystem;
> we never saw anyone reproduce it on anything but OS X, and even there it
> was quite difficult to reproduce.
>
> In short, I don't think we know why the bug was not seen widely.

It has been a long time since I looked at name-hash.c and I am fuzzy
on what the four functions (cache|index)_(file|dir)_exists are meant
for, but I have this feeling that the original premise of the patch,
"we may free a ce because we no longer use it in the index, but it
may still need to keep a reference to it in name-hash" may be wrong
in the first place.  The proposed "fix" conceptually feels wrong.

The whole point of the name-hash is so that we can detect collisions
in two names, one of which wants to have a file in one place while
the other wants to have a directory, at the same path in the index.
The pathnames and cache entries registered in the name-hash have to
be the ones that are relevant to the index in quesition.  If a new
ce will be added to the index, the name-hash will have to know about
its path (and that is what CE_HASHED bit is about).  On the other
hand, if you are going to remove an existing ce from the index, its
sub-paths should no longer prevent other cache entries to be there.

E.g. if you have "a/b", it must prevent "A" from entering the index
and the name-hash helps you to do so; when you remove "a/b", then
name-hash must now allow "A" to enter the index.  So "a/b" must be
removed from the name-hash by calling remove_name_hash() and normal
codepaths indeed do so.

I do not doubt the existence of "use-after-free bug" you observed,
but I am not convinced that refcounting is "fixing" the problem; it
smells like papering over a different bug that is the root cause of
the use-after-free.

For example, if we forget to "unhash" a ce from name-hash when we
remove a ce from the index (or after we "hashed" it, expecting to
add it to the index, but in the end decided not to add to the index,
perhaps), we would see a now-freed ce still in the name-hash.
Checking a path against the name-hash in such a state would have to
use the ce->name from that stale ce, which is a use-after-free bug.

In such a situation, isn't the real cause of the bug the fact that
the stale ce that is no longer relevant to the true index contents
still in name-hash?  The refcounting does not fix the fact that a
ce->name of a stale ce that is no longer relevant being used for D/F
collision checking.

I am not saying that I found such a codepath that forgets to unhash,
but from the overall design and purpose of the name-hash subsystem,
anything that deliberately _allows_ a stale ce that does not exist
in the index in there smells like a workaround going in a wrong
direction.
