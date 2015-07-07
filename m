From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Whether Git supports directory level access or not?
Date: Tue, 07 Jul 2015 10:03:11 -0700
Message-ID: <xmqq7fqb529c.fsf@gitster.dls.corp.google.com>
References: <705bdbdc6a8195d59203bcb1f3027714@stockal.com>
	<CA+P7+xpqk2m2Mxv_12Mg+03GzqVa5kzVk29HAOMiW9EGpmrWww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: saurabh@stockal.com, git@vger.kernel.org
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 19:03:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCWHE-0002G3-Tt
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 19:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbbGGRDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 13:03:15 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34325 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbbGGRDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 13:03:13 -0400
Received: by iebmu5 with SMTP id mu5so138293433ieb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=5K9yoCm5ARevJampRAg9A5PSXr9PLvOve2nvraWKIlQ=;
        b=f0tqrrl9vZIUu6fYIfJlcrJztjUFoP6GdA7izBaH37DA3rEQ9zN3IyTT+6BON1QI1Q
         8H01nNy6oTTzNJotqWj75g5DBZxXWGxeI9PFiXlcSD8APAA4lX+iRaew9i+Mq/tWXRL6
         0/40ht/HNCqB2V+OaEQ5X+QmWTa7fuj0Tzi4CrPK/XRsb5YbHUdQV7m8HMvzKLiPFKlf
         nl8vt0MJUxvDCBjlYVOsdi7pBb5/avz0h7Vz5CXjJRjVZFhq6Rgq+Dtl/f6QH3EqWOps
         IeAq+qEmr5Hi7OUDNkXGZT6ShCS8CO2wbehBce1/RQxgvAWpmMNifQofRk0kPXBQhwJO
         oVEw==
X-Received: by 10.50.137.100 with SMTP id qh4mr49995629igb.1.1436288592921;
        Tue, 07 Jul 2015 10:03:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by mx.google.com with ESMTPSA id a139sm14978663ioa.14.2015.07.07.10.03.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 10:03:12 -0700 (PDT)
In-Reply-To: <CA+P7+xpqk2m2Mxv_12Mg+03GzqVa5kzVk29HAOMiW9EGpmrWww@mail.gmail.com>
	(Jacob Keller's message of "Tue, 7 Jul 2015 00:20:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273588>

Jacob Keller <jacob.keller@gmail.com> writes:

> However, in-repo per-directory permissions make no sense, as there
> would be no way to generate commits.

That may be the case for the current generation of Git, but I do not
think you have to be so pessimistic.

Suppose that an imaginary future version of Git allowed you to
"hide" one directory from you.  That is:

 * A commit object records "tree". "git cat-file -t HEAD^{tree}"
   or "git ls-tree HEAD" lets you inspect its contents;

 * The "hidden" directory shows up as one of the subtrees of that
   output.  It may say

     040000 tree b4006c408979a0c6261dbfaeaa36639457469ad4   hidden

 * However, your repository lack b4006c40... object.  So if you did
   "git ls-tree HEAD:hidden", you would get "no such tree object".

 * This imaginary future version of Git has a new implementation of
   the index (both on-disk and in-core) that lets you keep just the
   "tree" entry for an unmodified directory, without having to store
   any of the files and subdirectories in it.

 * All the other machinery of this imaginary future version of Git
   are aware of the fact that "hidden" thing is not visible, or even
   available, to your clone of the project repository.  That means
   "fsck" does not complain about missing object b4006c40..., "push"
   knows it should not consider it an error that you cannot enumerate
   and send objects that are reachable from b4006c40..., etc.

With such a Git, you can modify anything outside the parts of the
project tree that are hidden from you, and make a commit.  The tree
recorded in a new commit object would record the same

     040000 tree b4006c408979a0c6261dbfaeaa36639457469ad4   hidden

for the "hidden" directory, and you can even push it back to update
the parts for other people to see your work outside the "hidden"
area.

"All the other machinery" that would need to accomodate such a
hidden directory would span the entire plumbing layer and
transports.  The wire protocol would need to be updated, especially
the part that determines what needs to be sent and received, which
is currently purely on commit ancestry, needs to become aware of the
paths.

I am *NOT* saying that this is easy.  I'd imagine if we gather all
the competent Gits in a room and have them work on it and doing
nothing else for six months, we would have some system that works.
It would be a lot of work.

I think it may be worth doing in the longer term, and it will likely
to have other benefits as side effects.

 - For example, did you notice that my description above does not
   mention "permission" even once?  Yes, that's right.  This does
   not have to be limited to permissions.  The user may have decided
   that the "hidden" part of that directory structure is not
   interesting and said "git clone --exclude=hidden" when she made
   her clone to set it up.

 - Also notice that the "new implementation of the index" that
   lazily expands subtrees does not say anythying about a directory
   that is "hidden"---it just said "an unmodified directory" and
   that was deliberate.  Even when you are not doing a "narrow
   clone", keeping an untouched tree without expanding its subtrees
   and blobs flatted into the index may make it faster when you are
   working on a series of many small commits each of which touches
   only a handful of files.

I might agree with you that "in-repo per-directory permissions make
no sense", but the reason to say so would not be because "there
would be no way to generate commits".
