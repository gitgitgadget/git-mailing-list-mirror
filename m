From: Yurii Shevtsov <ungetch@gmail.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file"
 DWIM better.
Date: Mon, 16 Mar 2015 18:23:49 +0200
Message-ID: <CAHLaBNJxRx9jkNHCM+djq7KEZBV2n5PFZN0-UUtzhO=ikR+Kuw@mail.gmail.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
	<vpq1tkq5fsw.fsf@anie.imag.fr>
	<xmqqr3spsir2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 17:23:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXXo2-0003ub-9q
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 17:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935504AbbCPQXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 12:23:52 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36749 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935498AbbCPQXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 12:23:50 -0400
Received: by obdfc2 with SMTP id fc2so39733675obd.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 09:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vHk/emRhHbtOvwIdamBI6k4WT/ODPoyAIPQ3+klq5To=;
        b=VmwOEeZBSy9hK9KXIuDIuDmAHKksAmTtHoriQlPSWDz+KtTHXlJD5mGZBSY2zJb07T
         82Nb/+aklyNFjJQ09DqmeL4MdbktCatxDcqVlNVpiNdAhkGZKKKaGIQfeem+CLXlTXRo
         AGBID+u+gcpKFP+BuFopqoNzXJAzMsMGMhoLjyYfsAaIE9hElZxtyJgdazbEPBtePaZ/
         aRqKNi+REOywvY9Ii8ZxDPmFtOjI4kk3YHY8KOpgfpKEJvgVYbHdcW/UhP6Hj+Fjkc6p
         wAiPEkmPneHBwUTdOnwvD/g4s1XLmxPwGi2gYJAUwrslegN3gkZjW1xDTXmvh7YrCVWh
         Z99w==
X-Received: by 10.202.215.131 with SMTP id o125mr14813619oig.109.1426523029545;
 Mon, 16 Mar 2015 09:23:49 -0700 (PDT)
Received: by 10.76.10.170 with HTTP; Mon, 16 Mar 2015 09:23:49 -0700 (PDT)
In-Reply-To: <xmqqr3spsir2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265573>

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> --- a/diff-no-index.c
>>> +++ b/diff-no-index.c
>>> @@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
>>>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>>>                 return -1;
>>>
>>> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
>>> -               return error("file/directory conflict: %s, %s", name1, name2);
>>
>> I'm surprised to see this error message totally go away. The idea of the
>> microproject was to DWIM (do what I mean) better, but the dwim should
>> apply only when $directory/$file actually exists. Otherwise, the error
>> message should actually be raised.
>
> I actually think this check, when we really fixed "diff --no-index"
> to work sensibly, should go away and be replaced with something
> sensible.  As it stands now, even before we think about dwimming
> "diff D/ F" into "diff D/F F", a simple formulation like this will
> error out.
>
>     $ mkdir -p a/sub b
>     $ touch a/file b/file b/sub a/sub/file
>     $ git diff --no-index a b
>     error: file/directory conflict: a/sub, b/sub
>
> Admittedly, that is how ordinary "diff -r" works, but I am not sure
> if we want to emulate that aspect of GNU diff.  If the old tree a
> has a directory 'sub' with 'file' under it (i.e. a/sub/file) where
> the new tree has a file at 'sub', then the recursive diff can show
> the removal of sub/file and creation of sub, no?  That is what we
> show for normal "git diff".
>
> But I _think_ fixing that is way outside the scope of GSoC Micro.
>
> And patching this function, because it is recursively called from
> within it, to "dwim" is simply wrong.  When we see a/sub that is a
> directory and b/sub that is a file, we do *NOT* want to rewrite the
> comparison to comparison between a/sub/sub and b/sub.
>
> What needs to be fixed for the Micro is the top-level call to
> queue_diff() that is made blindly between paths[0] and paths[1]
> without checking what kind of things these are.

So you want me to convert args ("diff D/ F" into "diff D/F F") before
calling queue_diff()? But why? queue_diff() already check args' types
and decides which comparison to do. If I understood you right, it
would require calling get_mode() in diff_no_index(), while get_mode()
will be called again in queue_diff().
