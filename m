From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/3] git-pull.sh: introduce --[no-]autostash and pull.autostash
Date: Sun, 24 Mar 2013 23:26:59 +0530
Message-ID: <CALkWK0k=jei8Z+n-4O92obQOR88FR6iFCSifVhDDS8jv37rOjA@mail.gmail.com>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
 <1363955399-13153-4-git-send-email-artagnon@gmail.com> <7vtxo374h6.fsf@alter.siamese.dyndns.org>
 <CALkWK0=oOt0teGqCjpDkerR3-t1cY=qKyK-AtoLLCz9L1-+vyw@mail.gmail.com> <7va9pt2r4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 18:57:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJpAy-0001F9-Bo
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 18:57:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753575Ab3CXR5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 13:57:20 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:33898 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab3CXR5U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 13:57:20 -0400
Received: by mail-ia0-f180.google.com with SMTP id f27so4972617iae.11
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=fvxl//n5yIJ2Jwp8cRRYp+GYe8npGdOiF64PdggKLWc=;
        b=Vd8O14Ma7NE71/pPM7JABOTlzdfXcaoE96wRFpSCSZ2BKywB+QSVMbJAhTVHc34XUT
         J64rh9YUPUYr/2Fn9SOEw2gBL9h4g64mBkD9dQIsc9WONpbgcJ0P6Xk464mT5qC8VEqn
         6MjrgjhhAtsBVXeNpYxGtaG3f0xGxMl5pLj+bEL78EyqhcJL9mLQbcN8bYiC1Uk0s6lt
         i+hY1/+pmqKREa4+hbKh7wv6yZGNxviAKrpjH7vzNRLKZ/KmuJ9f5LQ3whXGsP0B1Ztt
         Z8lwxMLsCERZQvialB+fXBBfq62WHf1BIxkVtDfMeTowDku5Z1RfIjBDOzhXnvpp2SNL
         JBMA==
X-Received: by 10.50.108.235 with SMTP id hn11mr5700170igb.107.1364147839495;
 Sun, 24 Mar 2013 10:57:19 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Sun, 24 Mar 2013 10:56:59 -0700 (PDT)
In-Reply-To: <7va9pt2r4e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218962>

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>>> +     elif test "$autostash" = false
>>>> +     then
>>>>               require_clean_work_tree "pull with rebase" "Please commit or stash them."
>>>>       fi
>>>
>>> A safety net, after you run "git stash", to validate that the
>>> added "git stash" indeed made the working tree clean, is necessary
>>> below, but there does not seem to be any.
>>
>> Um, isn't that part of the "git stash" testsuite?
>
> You should always "trust but verify" what other commands do at key
> points of the operation; and I think this "require-clean-work-tree"
> is a key precondition for this mode of operation to work correctly.
>
> Especially because you do not even bother to check the result of
> "git stash" before continuing ;-).

If you think it's enough to replicate the codepath that precedes the
actual saving in 'git stash' (which is essentially
require-clean-work-tree), I'm in agreement with you.  I thought you
were implying a wider safety net, that wouldn't even assume the basic
sanity of stash.

>>>> +if test "$autostash" = true && stash_required
>>>> +then
>>>> +     git stash
>>>> +     eval "$eval"
>>>> +     test $? = 0 && git stash pop
>>>> +else
>>>> +     eval "exec $eval"
>>>> +fi
>>>
>>> Delaying to run "git stash" as much as possible is fine, but with
>>> the above, can the user tell if something was stashed and she has
>>> to "stash pop" once she is done helping the command to resolve the
>>> conflicts, or she shouldn't run "stash pop" after she is done
>>> (because if nothing is stashed at this point, that "pop" will pop an
>>> unrelated stash)?
>>
>> I could easily tell, from the "git pull" output: if conflict, then
>> stash hasn't been applied.
>
> The question was about "git stash save".  Depending on the cleanness
> of the tree when "git pull" was started, "save" may or may not have
> been done.  After resolving a conflicted "git pull" and committing
> the result, the user does not have much clue if she needs to pop
> anything, does she?  Instead of the usual "resolve the conflicts and
> commit the result", she may need to see "resolve the conflicts,
> commit the result, *AND* UNSTASH".

Yes, good point.  Will it suffice to print a message?
