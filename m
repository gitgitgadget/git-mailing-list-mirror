From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Whether Git supports directory level access or not?
Date: Tue, 7 Jul 2015 16:03:47 -0700
Message-ID: <CA+P7+xrRd9tv=cMmz+RtOtrjMwUBVpbdR5VfNG-CVzoHenCF9A@mail.gmail.com>
References: <705bdbdc6a8195d59203bcb1f3027714@stockal.com> <CA+P7+xpqk2m2Mxv_12Mg+03GzqVa5kzVk29HAOMiW9EGpmrWww@mail.gmail.com>
 <xmqq7fqb529c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: saurabh@stockal.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 01:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCbuO-0003Pu-MX
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 01:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054AbbGGXEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 19:04:09 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33906 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbbGGXEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 19:04:06 -0400
Received: by obbkm3 with SMTP id km3so139046826obb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 16:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yzhbrL6V7RBdPJjdt+dQFZG5LRYPui7KTjjxg5/lOYw=;
        b=UkROllLFbJKkDP1z7QdRVg5oDA+VFXc5UFBJBJNoBMfA0jeMwzdVliPCwYSzH/h7v0
         i6jUjvUVMnIyjgmyCucVrtLFCHUrvFcITG8Dt1AanA++Tk92BLpiKlvI5YswkGlSWSsi
         DD8BGMLTL4g9ISHZkH1R1hYTlvL+lPj5Ppm/OA2Tjt2POMfukrm1W6KokVP0WNtDD2es
         oUx9SqA9yfFz/TeiB0TuwxHgt64VlTheohnGUXkLSZrn4igpNC7OrVmyxT9xYbr0MBK7
         6hzUdPbPqpojgBImip9xdY4h5Oiul+fn427MgiHFaTJTupLBV7aatstvsJRO9VXgsXii
         DOAg==
X-Received: by 10.202.108.142 with SMTP id h136mr6254185oic.5.1436310246392;
 Tue, 07 Jul 2015 16:04:06 -0700 (PDT)
Received: by 10.76.174.8 with HTTP; Tue, 7 Jul 2015 16:03:47 -0700 (PDT)
In-Reply-To: <xmqq7fqb529c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273615>

On Tue, Jul 7, 2015 at 10:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> However, in-repo per-directory permissions make no sense, as there
>> would be no way to generate commits.
>
> That may be the case for the current generation of Git, but I do not
> think you have to be so pessimistic.
>
> Suppose that an imaginary future version of Git allowed you to
> "hide" one directory from you.  That is:
>
>  * A commit object records "tree". "git cat-file -t HEAD^{tree}"
>    or "git ls-tree HEAD" lets you inspect its contents;
>
>  * The "hidden" directory shows up as one of the subtrees of that
>    output.  It may say
>
>      040000 tree b4006c408979a0c6261dbfaeaa36639457469ad4   hidden
>
>  * However, your repository lack b4006c40... object.  So if you did
>    "git ls-tree HEAD:hidden", you would get "no such tree object".
>
>  * This imaginary future version of Git has a new implementation of
>    the index (both on-disk and in-core) that lets you keep just the
>    "tree" entry for an unmodified directory, without having to store
>    any of the files and subdirectories in it.
>
>  * All the other machinery of this imaginary future version of Git
>    are aware of the fact that "hidden" thing is not visible, or even
>    available, to your clone of the project repository.  That means
>    "fsck" does not complain about missing object b4006c40..., "push"
>    knows it should not consider it an error that you cannot enumerate
>    and send objects that are reachable from b4006c40..., etc.
>
> With such a Git, you can modify anything outside the parts of the
> project tree that are hidden from you, and make a commit.  The tree
> recorded in a new commit object would record the same
>
>      040000 tree b4006c408979a0c6261dbfaeaa36639457469ad4   hidden
>
> for the "hidden" directory, and you can even push it back to update
> the parts for other people to see your work outside the "hidden"
> area.
>
> "All the other machinery" that would need to accomodate such a
> hidden directory would span the entire plumbing layer and
> transports.  The wire protocol would need to be updated, especially
> the part that determines what needs to be sent and received, which
> is currently purely on commit ancestry, needs to become aware of the
> paths.
>
> I am *NOT* saying that this is easy.  I'd imagine if we gather all
> the competent Gits in a room and have them work on it and doing
> nothing else for six months, we would have some system that works.
> It would be a lot of work.
>
> I think it may be worth doing in the longer term, and it will likely
> to have other benefits as side effects.
>
>  - For example, did you notice that my description above does not
>    mention "permission" even once?  Yes, that's right.  This does
>    not have to be limited to permissions.  The user may have decided
>    that the "hidden" part of that directory structure is not
>    interesting and said "git clone --exclude=hidden" when she made
>    her clone to set it up.
>
>  - Also notice that the "new implementation of the index" that
>    lazily expands subtrees does not say anythying about a directory
>    that is "hidden"---it just said "an unmodified directory" and
>    that was deliberate.  Even when you are not doing a "narrow
>    clone", keeping an untouched tree without expanding its subtrees
>    and blobs flatted into the index may make it faster when you are
>    working on a series of many small commits each of which touches
>    only a handful of files.
>
> I might agree with you that "in-repo per-directory permissions make
> no sense", but the reason to say so would not be because "there
> would be no way to generate commits".

Actually as you laid out here, it does make sense I had just assumed
you would need the tree object to actually be able to generate the
commits. It does sound like a lot of work though.

Regards,
Jake
