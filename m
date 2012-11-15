From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: creation of empty branches
Date: Thu, 15 Nov 2012 11:04:24 +1100
Message-ID: <CAH5451=NkodCMZZ3eBnhewZBfv2h3NwEuEi7df_FGhWfovR4Jg@mail.gmail.com>
References: <CAB9Jk9CaBECT7c_M9HvCbB8mFYGvdsmq_jFW4DF4NCO8Narnmw@mail.gmail.com>
 <CAH5451mkcszgJxziKn3q3OwSDM-qQ71PtT5+UWb=PG7VYAcFyQ@mail.gmail.com> <7vmwyjan96.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 01:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYmx9-0007Jo-8r
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:05:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221Ab2KOAEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:04:46 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:45577 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412Ab2KOAEq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:04:46 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so676516qcr.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 16:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SB8U9EgWSfgUrBCy5flpJK3xKMJ9xIhLndJJFFq+03g=;
        b=zwYbstc47+dF+aQB9Fwvmu4e/JPVjnDp2luO01wVf8CWRmnmPiNl0zQRW07HE6zrcW
         hnnOLAf4zvYzP+7T+91S40z/rNYNE/I2c1jd3ARj/4y9shJnsUkqy+e4oK2AjYTisYu0
         8Bj7ZWnsTVx5Zu6FpAyXJulYWK37TAqyyUNJEu4GkoETG3UdXjmlgba1DQpj2dm+h2/J
         Fbh0uK4PlCcI4Gvuf5g45T/17cQHGqltH0kK5agtLk41a2ZK5U4KC0FBT2AJaEUudmjU
         QngDJtSsA/jmZ/1E/sevm+x24kLy8J7F+jVPBa54LF1XcZ5Q1YVa4tdO/DGxOUKl+jO/
         BFVQ==
Received: by 10.224.189.65 with SMTP id dd1mr4331475qab.79.1352937885043; Wed,
 14 Nov 2012 16:04:45 -0800 (PST)
Received: by 10.49.119.65 with HTTP; Wed, 14 Nov 2012 16:04:24 -0800 (PST)
In-Reply-To: <7vmwyjan96.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209760>

On 15 November 2012 08:27, Junio C Hamano <gitster@pobox.com> wrote:
> ... "git branch foo master" (or its
> moral equivalent "git checkout -b foo" while on master) is a wish to
> have a history that ends in 'foo' *forked* from history of 'master',
> but because you do not even have anything on 'master' yet, you
> cannot fork the history, as you explained earlier (snipped).  In
> that sense, 'empty branch' is a slight misnomer---as far as "git
> branch foo master" is concerned, the 'master' branch does not yet
> exist (and that is why we often call it an "unborn branch", not
> "empty").
>
>     fatal: cannot fork master's history that does not exist yet.
>
> would be more accurate description of the situation.

So in the situation where a start-point is an unborn branch (ie it is
referenced in HEAD) we should modify the error to show that the unborn
branch is in fact unborn. This is a good improvement I think, as it
catches this edge case and improves understanding of what an unborn
branch is. The term 'fork' is not used at all in branch's man page, so
perhaps a more consistent error message is something like

    fatal: 'master' has no history, so we cannot create a new branch from it

Also, currently 'git checkout -b' *will* rename an unborn branch which
is different from the 'git branch' behaviour. Not sure how this
behaviour can be corrected without causing a regression or introducing
potentially confusing error messages for the git branch case.

>> So explicitly, I am proposing the following behaviour changes:
>>
>> When trying to create a new branch without specifying a start point,
>> if HEAD points to an empty branch, error with a more useful message
>> that assumes the user might want to rename the empty branch.
>
> I do not think that is the right assumption in the first place.  It
> is very likely that the user does not yet know how Git works when
> she attempts to fork from a history that does not exist.  It is also
> very likely that she is expecting, after "git branch foo master"
> succeeds when 'master' is yet to be born, have two branches 'foo'
> and 'master', so that "git checkout foo" and "git checkout master"
> can be done subsequently.
>
> But that expectation is wrong, and it would help the user in the
> longer run to correct that expectation.  "We assume you wanted to
> rename 'master' to 'foo'" is a logical consequence that changing
> HEAD that points at an unborn 'master' to point at an unborn 'foo'
> is the best (or closest) thing the user can do, *if* the user
> understands that the current branch being unborn is a special state
> and there can only be one such unborn branch (that is, the current
> one).  The user who gets this error message, however, clearly does
> not understand that, so it is not a logical consequence to her at
> all.  The advice does not help her, but instead invites "No, I did
> not want to rename it, I wanted to have 'foo' without losing
> 'master'", leading to even more confusion.

I can't speak for others, but I think it is more likely that a new
user who doesn't understand git and tries to use the branch command on
a brand new repository is not trying to fork master's history, but is
rather trying to switch to a different branch. A subversion user might
want to switch from 'master' to 'trunk' as a (somewhat?) common use
case. That is the reasoning behind my recommendation to show how to
rename the branch. Furthermore, we can educate the user about unborn
branches and suggest a possible solution at the same time.

With the new error message from above, something like the following
might be nice.

    fatal: 'master' has no history, so we cannot create a new branch from it
    hint: A repository can only contain one unborn branch at a time.
    hint: To rename a branch use 'git branch -m [<old-branch>] <new-branch>'

I'm not sure about the intended syntax of hint messages but this seems
consistent.

>
>> When trying to create a new branch whilst specifying an empty branch
>> as the start point,
>>   if HEAD points to the same empty branch that is listed as the start
>> point, error with a more useful message that assumes the user might
>> want to rename the empty branch.
>>   otherwise error due to invalid ref
>
> See above (for all the other cases, too).
>

You didn't address the branch rename command 'git branch -m
[<old-branch>] <new-branch>' (or you included it with the others). I
think it is a significantly different action to creating a new branch,
and should handle unborn branches in the expected way, which is to
rename them. What are your thoughts on that?

Regards,

Andrew Ardill
