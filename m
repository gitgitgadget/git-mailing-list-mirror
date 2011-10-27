From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/WIP 02/11] notes-merge: use opendir/readdir instead of
 using read_directory()
Date: Thu, 27 Oct 2011 18:51:38 +1100
Message-ID: <CACsJy8C4iHffr4UYP9SvCU0OPC-LocUORwAQ492LqaV_tyvFQA@mail.gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-3-git-send-email-pclouds@gmail.com> <7vzkgo3m9b.fsf@alter.siamese.dyndns.org>
 <CACsJy8CocoAiVx_PeaaX1oRZvmzfj9-z9JLJkE5unSRVtpGkNA@mail.gmail.com> <7vmxcn3b8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 09:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJKl6-0004l9-Mk
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 09:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab1J0HwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 03:52:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60786 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab1J0HwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 03:52:09 -0400
Received: by faan17 with SMTP id n17so2340760faa.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zKPyEa3CDYqsiNmFIcErrUZsE33cSW6a5xvy/FLrIq8=;
        b=xjhc5GpeyEiHLW6BPqr4EiWsnuZuR+4dOX1qiJRhrZPq05PJUuGP8/zNS1iFaC/MoH
         GJBaTjQT8Gx+QzK0fAJdLr0aurwWWsb+KYxUEVcBptufqoPaBVoHqZsbwFA3JArm9F9q
         OazAsWN48Bo6EumKODQVF1gedq6z1fNiGlr9U=
Received: by 10.223.1.137 with SMTP id 9mr15862572faf.19.1319701928089; Thu,
 27 Oct 2011 00:52:08 -0700 (PDT)
Received: by 10.223.113.143 with HTTP; Thu, 27 Oct 2011 00:51:38 -0700 (PDT)
In-Reply-To: <7vmxcn3b8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184288>

On Thu, Oct 27, 2011 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Current read_directory() treats given path separately from contents
>> inside the path. If the given path has ".git", it's ok (but it'll stop
>> at .git if during tree recursion). The new read_directory() does not
>> make this exception, so when note-merge call
>> read_directory(".git/NOTES_MERGE_WORKTREE"), read_directory() sees
>> ".git" and stops immediately, assuming it's a gitlink.
>
> When read_directory("where/ever") is called, what kind of paths does it
> collect? Do the paths the function collects share "where/ever" as their
> common prefix? I thought it collects the paths relative to whatever
> top-level directory given to the function, so that "where/ever" could be
> anything.

Correct. But read_directory() takes pathspec now so naturally it does
not treat "where/ever" a common prefix anymore. So it has to open(".")
and starts from there. Even current code does not trust "where/ever"
completely. treat_leading_path() may dismiss "where/ever" if it's
excluded by .gitignore.

> Why does it even have to look at the given path in the first place and
> make a decision heavier than "can I opendir() and read from it"?

Because opendir("wh*/*r") may fail.

> In other
> words, if you see read_directory("some/thing/.git/more/stuff") and find a
> substring ".git/" in there, what "magic" gitlink handling does the code
> have to do?

"some/thing/.git" can be considered a new entry in index, so it should
stop traversing at ".git". But because "some/thing/.git" does not
exacly match "some/thing/.git/more/stuff", it is filtered out.

git-add deals with this case especially in order to avoid accidentally
replace "some/thing/.git" in index with "some/thing/.git/more/stuff".
But I feel it should be handled by read_directory(), not git-add.

> I do not think it matters for _this_ particular case, but I can for
> example imagine an alternative implementation of a merge that uses
> temporary working tree somewhere other than the main working tree, and one
> of the natural "temporary" places such a feature in the future may want to
> use is inside .git/ somewhere. If you are planning to close the door by
> breaking the behaviour of read_directory(".git/some_where") for such
> callers with this series, we need to be aware of it, and that is why I am
> not satisfied by your explanation.

Maybe I should step back a bit. Instead of treating any input to
read_directory() as pathspec, callers may provide two sets: a prefix
set and a pathspec set. read_directory() starts from the prefix set
without any checks, then descends in using pathspec.

But then what about the "if (treat_one_path(..) == path_ignored)" in
treat_leading_path()? Remove it?
-- 
Duy
